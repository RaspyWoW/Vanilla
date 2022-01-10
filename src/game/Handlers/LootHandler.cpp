/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2009-2011 MaNGOSZero <https://github.com/mangos/zero>
 * Copyright (C) 2011-2016 Nostalrius <https://nostalrius.org>
 * Copyright (C) 2016-2017 Elysium Project <https://github.com/elysium-project>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "Common.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "Log.h"
#include "Corpse.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "Player.h"
#include "ObjectAccessor.h"
#include "ObjectGuid.h"
#include "WorldSession.h"
#include "LootMgr.h"
#include "Object.h"
#include "Group.h"
#include "World.h"
#include "ScriptMgr.h"
#include "Util.h"
#include "Anticheat.h"

void WorldSession::HandleAutostoreLootItemOpcode(WorldPacket& recv_data)
{
    DEBUG_LOG("WORLD: CMSG_AUTOSTORE_LOOT_ITEM");
    Player *player = GetPlayer();
    ObjectGuid lguid = player->GetLootGuid();
    Loot *loot;
    uint8 lootSlot;
    Item* pItem = nullptr;

    recv_data >> lootSlot;

    if (lguid.IsEmpty())
        return;

    switch (lguid.GetHigh())
    {
        case HIGHGUID_GAMEOBJECT:
        {
            GameObject* go = player->GetMap()->GetGameObject(lguid);

            // Not check distance for GO in case owned GO (fishing bobber case, for example) or Fishing hole GO
            if (!go || ((go->GetOwnerGuid() != _player->GetObjectGuid() && go->GetGoType() != GAMEOBJECT_TYPE_FISHINGHOLE) && !go->IsWithinDistInMap(_player, INTERACTION_DISTANCE)))
            {
                player->SendLootRelease(lguid);
                return;
            }

            loot = &go->loot;
            break;
        }
        case HIGHGUID_ITEM:
        {
            pItem = player->GetItemByGuid(lguid);

            if (!pItem || !pItem->HasGeneratedLoot())
            {
                player->SendLootRelease(lguid);
                return;
            }

            loot = &pItem->loot;
            break;
        }
        case HIGHGUID_CORPSE:
        {
            Corpse* bones = player->GetMap()->GetCorpse(lguid);
            if (!bones)
            {
                player->SendLootRelease(lguid);
                return;
            }

            loot = &bones->loot;
            break;
        }
        case HIGHGUID_UNIT:
        {
            Creature* pCreature = GetPlayer()->GetMap()->GetCreature(lguid);

            const bool ok_loot = pCreature && pCreature->IsAlive() == (player->GetClass() == CLASS_ROGUE && pCreature->lootForPickPocketed);

            if (!ok_loot || !pCreature->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
            {
                player->SendLootRelease(lguid);
                return;
            }

            loot = &pCreature->loot;
            break;
        }
        default:
        {
            DEBUG_LOG("%s is unsupported for looting. (%s)", lguid.GetString().c_str(), player->GetObjectGuid().GetString().c_str());
            return;
        }
    }

    QuestItem* qitem = nullptr;
    QuestItem* ffaitem = nullptr;
    QuestItem* conditem = nullptr;

    LootItem* item = loot->LootItemInSlot(lootSlot, player->GetGUIDLow(), &qitem, &ffaitem, &conditem);

    if (!item)
    {
        player->SendEquipError(EQUIP_ERR_ALREADY_LOOTED, nullptr, nullptr);
        return;
    }

    if (!item->AllowedForPlayer(player, loot->GetLootTarget()))
    {
        player->SendLootRelease(lguid);
        return;
    }

    // Questitems use the blocked field for other purposes
    if (!qitem && item->is_blocked)
    {
        player->SendLootRelease(lguid);
        return;
    }

    if (pItem)
        pItem->SetLootState(ITEM_LOOT_CHANGED);

    ItemPosCountVec dest;
    InventoryResult const msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item->itemid, item->count);
    if (msg == EQUIP_ERR_OK)
    {
        Item* newitem = player->StoreNewItem(dest, item->itemid, true, item->randomPropertyId);
        if (!newitem)
        {
            sLog.outInfo("Unable to store loot item #%u from %s !", item->itemid, lguid.GetString().c_str());
            return;
        }

        if (qitem)
        {
            qitem->is_looted = true;
            // Freeforall is 1 if everyone's supposed to get the quest item.
            if (item->freeforall || loot->GetPlayerQuestItems().size() == 1)
                player->SendNotifyLootItemRemoved(lootSlot);
            else
                loot->NotifyQuestItemRemoved(qitem->index);
        }
        else if (ffaitem)
        {
            // Freeforall case, notify only one player of the removal
            ffaitem->is_looted = true;
            player->SendNotifyLootItemRemoved(lootSlot);
        }
        else if (conditem)
        {
            // Not freeforall, notify everyone
            conditem->is_looted = true;
            loot->NotifyItemRemoved(lootSlot);
        }
        else
            loot->NotifyItemRemoved(lootSlot);

        // If only one person is supposed to loot the item, then set it to looted
        if (!item->freeforall)
            item->is_looted = true;

        --loot->unlootedCount;

        sLog.out(LOG_LOOTS, "%s loots %ux%u [loot from %s]", _player->GetShortDescription().c_str(), item->count, item->itemid, lguid.GetString().c_str());
        player->SendNewItem(newitem, uint32(item->count), false, false, true);
        player->OnReceivedItem(newitem);
    }
    else
        player->SendEquipError(msg, nullptr, nullptr, item->itemid);
}

void WorldSession::HandleLootMoneyOpcode(WorldPacket& /*recv_data*/)
{
    DEBUG_LOG("WORLD: CMSG_LOOT_MONEY");

    Player* player = GetPlayer();
    if (!player || !player->IsInWorld())
        return;

    ObjectGuid guid = player->GetLootGuid();
    if (!guid)
        return;

    Loot *pLoot = nullptr;
    Item* pItem = nullptr;
    bool shareMoneyWithGroup = true;

    switch (guid.GetHigh())
    {
        case HIGHGUID_GAMEOBJECT:
        {
            GameObject* pGameObject = GetPlayer()->GetMap()->GetGameObject(guid);

            // Not check distance for GO in case owned GO (fishing bobber case, for example)
            if (pGameObject && (pGameObject->GetOwnerGuid() == _player->GetObjectGuid() || pGameObject->IsWithinDistInMap(_player, INTERACTION_DISTANCE)))
                pLoot = &pGameObject->loot;

            break;
        }
        case HIGHGUID_CORPSE: // Remove insignia ONLY in BG
        {
            Corpse* bones = _player->GetMap()->GetCorpse(guid);

            if (bones && bones->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
                pLoot = &bones->loot;

            break;
        }
        case HIGHGUID_ITEM:
        {
            pItem = GetPlayer()->GetItemByGuid(guid);
            if (!pItem || !pItem->HasGeneratedLoot())
                return;

            pLoot = &pItem->loot;
            shareMoneyWithGroup = false;
            break;
        }
        case HIGHGUID_UNIT:
        {
            Creature* pCreature = GetPlayer()->GetMap()->GetCreature(guid);

            if (player->GetClass() == CLASS_ROGUE && pCreature && pCreature->lootForPickPocketed)
                shareMoneyWithGroup = false;

            const bool ok_loot = pCreature && pCreature->IsAlive() == (player->GetClass() == CLASS_ROGUE && pCreature->lootForPickPocketed);
            if (ok_loot && pCreature->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
                pLoot = &pCreature->loot;

            break;
        }
        default: // Unlootable type
            return;
    }

    if (pLoot)
    {
        pLoot->NotifyMoneyRemoved();

        if (shareMoneyWithGroup && player->GetGroup()) // Item can be looted only single player
        {
            Group* group = player->GetGroup();

            std::vector<Player*> playersNear;
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* playerGroup = itr->getSource();
                if (!playerGroup)
                    continue;

                if (player->IsWithinLootXPDist(playerGroup))
                    playersNear.push_back(playerGroup);
            }

            const uint32 money_per_player = uint32((pLoot->gold) / (playersNear.size()));
            for (const auto i : playersNear)
            {
                i->LootMoney(money_per_player, pLoot);
                WorldPacket data(SMSG_LOOT_MONEY_NOTIFY, 4);
                data << uint32(money_per_player);
                i->GetSession()->SendPacket(&data);
            }
        }
        else
            player->LootMoney(pLoot->gold, pLoot);

        pLoot->gold = 0;

        if (pItem)
            pItem->SetLootState(ITEM_LOOT_CHANGED);
    }
}

void WorldSession::HandleLootOpcode(WorldPacket& recv_data)
{
    DEBUG_LOG("WORLD: CMSG_LOOT");

    ObjectGuid guid;
    recv_data >> guid;

    if (!guid.IsAnyTypeCreature() && !guid.IsPlayer() && !guid.IsCorpse())
    {
        ProcessAnticheatAction("ItemsCheck", "CMSG_LOOT on non-unit guid", CHEAT_ACTION_LOG);
        return;
    }

    // Check possible cheat
    if (!_player->IsAlive())
        return;

    if (!_player->IsInWorld())
        return;

    if (_player->IsNonMeleeSpellCasted())
        _player->InterruptNonMeleeSpells(false);

    GetPlayer()->SendLoot(guid, LOOT_CORPSE);
}

void WorldSession::HandleLootReleaseOpcode(WorldPacket& recv_data)
{
    DEBUG_LOG("WORLD: CMSG_LOOT_RELEASE");

    // Cheaters can modify lguid to prevent correct apply loot release code and re-loot use internal stored guid
    recv_data.read_skip<uint64>(); // guid;

    if (ObjectGuid lootGuid = GetPlayer()->GetLootGuid())
        DoLootRelease(lootGuid);
}

void WorldSession::DoLootRelease(ObjectGuid const lguid)
{
    Player* player = GetPlayer();
    Loot* loot;

    player->SetLootGuid(ObjectGuid());

    // For disenchanted items first show loot as removed before release
    if (lguid.GetHigh() != HIGHGUID_ITEM)
        player->SendLootRelease(lguid);

    player->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_LOOTING);

    if (!player->IsInWorld())
        return;

    switch (lguid.GetHigh())
    {
        case HIGHGUID_GAMEOBJECT:
        {
            GameObject* go = player->GetMap()->GetGameObject(lguid);
            if (!go)
                return;

            loot = &go->loot;

            // Don't despawn temporarily spawned chests that contain group wide quest items.
            if (loot->HasFFAQuestItems() && !go->isSpawnedByDefault() && go->GetGoType() == GAMEOBJECT_TYPE_CHEST)
            {
                go->SetLootState(GO_READY);
                break;
            }

            if (go->GetGoType() == GAMEOBJECT_TYPE_DOOR)
            {
                // Locked doors are opened with spelleffect openlock, prevent remove its as looted
                go->UseDoorOrButton();
                if (go->AI())
                    go->AI()->OnUse(player);
            }
            else if (loot->isLooted() || go->GetGoType() == GAMEOBJECT_TYPE_FISHINGNODE)
            {
                // GO is mineral vein? so it is not removed after its looted
                if (go->GetGoType() == GAMEOBJECT_TYPE_CHEST)
                {
                    const uint32 go_min = go->GetGOInfo()->chest.minSuccessOpens;
                    const uint32 go_max = go->GetGOInfo()->chest.maxSuccessOpens;

                    // Trigger loot events
                    if (go->GetGOInfo()->chest.eventId)
                    {
                        DEBUG_LOG("Chest ScriptStart id %u for GO %u", go->GetGOInfo()->chest.eventId, go->GetGUIDLow());

                        if (!sScriptMgr.OnProcessEvent(go->GetGOInfo()->chest.eventId, _player, go, true))
                            go->GetMap()->ScriptsStart(sEventScripts, go->GetGOInfo()->chest.eventId, _player->GetObjectGuid(), go->GetObjectGuid());
                    }

                    // Only vein pass this check
                    if (go_min != 0 && go_max > go_min)
                    {
                        const float amount_rate = sWorld.getConfig(CONFIG_FLOAT_RATE_MINING_AMOUNT);
                        const float min_amount = go_min * amount_rate;
                        const float max_amount = go_max * amount_rate;

                        go->AddUse();
                        const float uses = float(go->GetUseCount());

                        if (uses < max_amount)
                        {
                            if (uses >= min_amount)
                            {
                                const float chance_rate = sWorld.getConfig(CONFIG_FLOAT_RATE_MINING_NEXT);

                                int32 ReqValue = 175;
                                LockEntry const* lockInfo = sLockStore.LookupEntry(go->GetGOInfo()->chest.lockId);

                                if (lockInfo)
                                    ReqValue = lockInfo->Skill[0];

                                const float skill = float(player->GetSkillValue(SKILL_MINING)) / (ReqValue + 25);
                                const double chance = pow(0.8 * chance_rate, 4 * (1 / double(max_amount)) * double(uses));

                                if (roll_chance_f(float(100.0f * chance + skill)))
                                    go->SetLootState(GO_READY);
                                else // Not have more uses
                                    go->SetLootState(GO_JUST_DEACTIVATED);
                            }
                            else // 100% chance until min uses
                                go->SetLootState(GO_READY);
                        }
                        else // Max uses already
                            go->SetLootState(GO_JUST_DEACTIVATED);
                    }
                    else // Not vein
                        go->SetLootState(GO_JUST_DEACTIVATED);
                }
                else if (go->GetGoType() == GAMEOBJECT_TYPE_FISHINGHOLE)
                {
                    // The fishing hole used once more
                    go->AddUse(); // If the max usage is reached, will be despawned at next tick

                    if (go->GetUseCount() >= urand(go->GetGOInfo()->fishinghole.minSuccessOpens, go->GetGOInfo()->fishinghole.maxSuccessOpens))
                        go->SetLootState(GO_JUST_DEACTIVATED);
                    else
                        go->SetLootState(GO_READY);
                }
                else // Not chest (or vein/herb/etc)
                    go->SetLootState(GO_JUST_DEACTIVATED);

                loot->clear();
            }
            else
                // Not fully looted object
                go->SetLootState(GO_ACTIVATED);

            break;
        }
        case HIGHGUID_CORPSE: // ONLY remove insignia at BG
        {
            Corpse* corpse = _player->GetMap()->GetCorpse(lguid);
            if (!corpse)
                return;

            loot = &corpse->loot;

            if (loot->isLooted())
            {
                loot->clear();
                corpse->RemoveFlag(CORPSE_FIELD_DYNAMIC_FLAGS, CORPSE_DYNFLAG_LOOTABLE);
            }

            corpse->ForceValuesUpdateAtIndex(CORPSE_DYNFLAG_LOOTABLE);
            corpse->ExecuteDelayedActions();
            break;
        }
        case HIGHGUID_ITEM:
        {
            Item *pItem = player->GetItemByGuid(lguid);
            if (!pItem)
                return;

            switch (pItem->loot.loot_type)
            {
                // Temporary loot, auto loot move
                case LOOT_DISENCHANTING:
                {
                    if (!pItem->loot.isLooted())
                        player->AutoStoreLoot(pItem->loot); // Can be lost if no space

                    pItem->loot.clear();
                    pItem->SetLootState(ITEM_LOOT_REMOVED);
                    player->DestroyItem(pItem->GetBagSlot(), pItem->GetSlot(), true);
                    break;
                }
                default: // Normal persistence loot
                {
                    // Must be destroyed only if no loot
                    if (pItem->loot.isLooted() && !pItem->IsBag())
                    {
                        pItem->SetLootState(ITEM_LOOT_REMOVED);
                        player->DestroyItem(pItem->GetBagSlot(), pItem->GetSlot(), true);
                    }
                    break;
                }
            }

            player->SendLootRelease(lguid);
            return; // Item can be looted only single player
        }
        case HIGHGUID_UNIT:
        {
            Creature* creature = player->GetMap()->GetCreature(lguid);
            if (!creature)
                return;

            loot = &creature->loot;

            if (loot->isLooted())
            {
                // Skip pickpocketing loot for speed, skinning timer reduction is no-op in fact
                if (!creature->IsAlive())
                    creature->AllLootRemovedFromCorpse();

                creature->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                loot->clear();
            }
            else
            {
                // If the round robin player release, reset it.
                if (player->GetGUID() == loot->roundRobinPlayer)
                {
                    if (Group* group = player->GetGroup())
                    {
                        if (group->GetLootMethod() != MASTER_LOOT)
                        {
                            loot->roundRobinPlayer = 0;
                            group->SendLooter(creature, nullptr);

                            // Force update of dynamic flags, otherwise other group's players still not able to loot.
                            creature->ForceValuesUpdateAtIndex(UNIT_DYNAMIC_FLAGS);
                        }
                    }
                    else
                        loot->roundRobinPlayer = 0;
                }
            }
            break;
        }
        default:
        {
            DEBUG_LOG("%s is unsupported for looting.", lguid.GetString().c_str());
            return;
        }
    }

    // Player is not looking at loot list, he doesn't need to see updates on the loot list
    loot->RemoveLooter(player->GetObjectGuid());
}

void WorldSession::HandleLootMasterGiveOpcode(WorldPacket& recv_data)
{
    uint8 slotid;
    ObjectGuid lootguid;
    ObjectGuid target_playerguid;

    recv_data >> lootguid >> slotid >> target_playerguid;

    if (!_player->GetGroup() || _player->GetGroup()->GetLootMethod() != MASTER_LOOT || _player->GetGroup()->GetLooterGuid() != _player->GetObjectGuid())
    {
        _player->SendLootRelease(GetPlayer()->GetLootGuid());
        return;
    }

    Player* target = ObjectAccessor::FindPlayer(target_playerguid);
    if (!target || !target->IsInWorld())
        return;

    // No loot for a player on another map, or not in the raid.
    if (!_player->IsInRaidWith(target) || !_player->IsInMap(target))
        return;

    DEBUG_LOG("WorldSession::HandleLootMasterGiveOpcode (CMSG_LOOT_MASTER_GIVE, 0x02A3) Target = %s [%s].", target_playerguid.GetString().c_str(), target->GetName());

    if (_player->GetLootGuid() != lootguid)
        return;

    Loot *pLoot = nullptr;

    if (lootguid.IsCreature())
    {
        Creature* creature = GetPlayer()->GetMap()->GetCreature(lootguid);
        if (!creature)
            return;

        if (!_player->IsAtGroupRewardDistance(creature))
            return;

        pLoot = &creature->loot;
    }
    else if (lootguid.IsGameObject())
    {
        GameObject* go = GetPlayer()->GetMap()->GetGameObject(lootguid);
        if (!go)
            return;

        if (!_player->IsAtGroupRewardDistance(go))
            return;

        pLoot = &go->loot;
    }
    else
        return;

    if (slotid >= pLoot->items.size())
    {
        DEBUG_LOG("AutoLootItem: Player %s might be using a hack! (slot %d, size %lu)", GetPlayer()->GetName(), slotid, (unsigned long)pLoot->items.size());
        return;
    }

    LootItem& item = pLoot->items[slotid];

    ItemPosCountVec dest;
    InventoryResult const msg = target->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item.itemid, item.count);
    if (msg != EQUIP_ERR_OK)
    {
        target->SendEquipError(msg, nullptr, nullptr, item.itemid);

        // Send duplicate of error massage to master looter
        _player->SendEquipError(msg, nullptr, nullptr, item.itemid);
        return;
    }

    // Now move item from loot to target inventory
    if (Item* newitem = target->StoreNewItem(dest, item.itemid, true, item.randomPropertyId))
    {
        sLog.out(LOG_LOOTS, "Master loot %s gives %ux%u to %s [loot from %s]", _player->GetShortDescription().c_str(), item.count, item.itemid, target->GetShortDescription().c_str(), lootguid.GetString().c_str());
        target->SendNewItem(newitem, uint32(item.count), false, false, true);
        target->OnReceivedItem(newitem);
    }

    // Mark as looted
    item.count = 0;
    item.is_looted = true;

    pLoot->NotifyItemRemoved(slotid);
    --pLoot->unlootedCount;
}
