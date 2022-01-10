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

#pragma once

#include "ItemEnchantmentMgr.h"
#include "ByteBuffer.h"
#include "ObjectGuid.h"
#include "Utilities/LinkedReference/RefManager.h"
#include "SharedDefines.h"

#include <map>
#include <vector>

constexpr auto MAX_NR_LOOT_ITEMS{ 16 };  // The client cannot show more than 16 items total
constexpr auto MAX_NR_QUEST_ITEMS{ 32 }; // Unrelated to the number of quest items shown, just for reserve

enum PermissionTypes
{
    ALL_PERMISSION              = 0,
    GROUP_PERMISSION            = 1,
    MASTER_PERMISSION           = 2,
    ROUND_ROBIN_PERMISSION      = 3,
    OWNER_PERMISSION            = 4,
    NONE_PERMISSION             = 5,
};

enum LootType
{
    LOOT_CORPSE                 = 1,
    LOOT_PICKPOCKETING          = 2,
    LOOT_FISHING                = 3,
    LOOT_DISENCHANTING          = 4,
                                                            // ignored always by client
    LOOT_SKINNING               = 6,                        // unsupported by client, sending LOOT_PICKPOCKETING instead

    LOOT_FISHINGHOLE            = 20,                       // unsupported by client, sending LOOT_FISHING instead
    LOOT_FISHING_FAIL           = 21,                       // unsupported by client, sending LOOT_FISHING instead
    LOOT_INSIGNIA               = 22                        // unsupported by client, sending LOOT_CORPSE instead
};

enum LootSlotType
{
    LOOT_SLOT_TYPE_ALLOW_LOOT   = 0,                        // player can loot the item.
    LOOT_SLOT_TYPE_ROLL_ONGOING = 1,                        // roll is ongoing. player cannot loot.
    LOOT_SLOT_TYPE_MASTER       = 2,                        // item can only be distributed by group loot master.
    LOOT_SLOT_TYPE_LOCKED       = 3,                        // item is shown in red. player cannot loot.
    LOOT_SLOT_TYPE_OWNER        = 4,                        // ignore binding confirmation and etc, for single player looting
    MAX_LOOT_SLOT_TYPE,
};

class Player;
class WorldObject;
class LootStore;
struct Loot;

struct LootStoreItem
{
    uint32  itemid;                                         // id of the item
    float   chance;                                         // always positive, chance to drop for both quest and non-quest items, chance to be used for refs
    int32   mincountOrRef;                                  // mincount for drop items (positive) or minus referenced TemplateleId (negative)
    uint8   group       :7;
    bool    needs_quest :1;                                 // quest drop (negative ChanceOrQuestChance in DB)
    uint8   maxcount    :8;                                 // max drop count for the item (mincountOrRef positive) or Ref multiplicator (mincountOrRef negative)
    uint16  conditionId :16;                                // additional loot condition Id

    // Constructor, converting ChanceOrQuestChance -> (chance, needs_quest)
    // displayid is filled in IsValid() which must be called after
    LootStoreItem(uint32 _itemid, float _chanceOrQuestChance, int8 _group, uint16 _conditionId, int32 _mincountOrRef, uint8 _maxcount)
        : itemid(_itemid), chance(fabs(_chanceOrQuestChance)), mincountOrRef(_mincountOrRef),
        group(_group), needs_quest(_chanceOrQuestChance < 0), maxcount(_maxcount), conditionId(_conditionId)
         {}

    bool Roll(const bool rate) const;                               // Checks if the entry takes it's chance (at loot generation)
    bool IsValid(LootStore const& store, const uint32 entry) const; // Checks correctness of values
    bool AllowedForTeam(Loot const& loot) const;                    // Checks item group compatibility
};

typedef std::set<uint32> AllowedLooterSet;

struct LootItem
{
    uint32  itemid;
    int32   randomPropertyId;
    uint16  conditionId       :16;                          // allow compiler pack structure
    uint8   count             : 8;
    bool    is_looted         : 1;
    bool    is_blocked        : 1;
    bool    freeforall        : 1;                          // free for all
    bool    is_underthreshold : 1;
    bool    is_counted        : 1;
    bool    needs_quest       : 1;                          // quest drop
    ObjectGuid lootOwner; // Roll winner player guid, in case of full inventory

    // Constructor, copies most fields from LootStoreItem, generates random count and random suffixes/properties
    // Should be called for non-reference LootStoreItem entries only (mincountOrRef > 0)
    explicit LootItem(LootStoreItem const& li);

    LootItem(const uint32 itemid_, const uint32 count_, const int32 randomPropertyId_ = 0);

    // Basic checks for player/item compatibility - if false no chance to see the item in the loot
    bool AllowedForPlayer(Player const* player, WorldObject const* lootTarget) const;
    LootSlotType GetSlotTypeForSharedLoot(PermissionTypes const permission, Player* viewer, WorldObject const* lootTarget, const bool condition_ok = false) const;
};

typedef std::vector<LootItem> LootItemList;

struct QuestItem
{
    uint8 index; // Position in quest_items;
    bool is_looted;

    QuestItem()
        : index(0), is_looted(false) {}

    QuestItem(uint8 _index, bool _islooted = false)
        : index(_index), is_looted(_islooted) {}
};

class LootTemplate;

typedef std::vector<QuestItem> QuestItemList;
typedef std::map<uint32, QuestItemList *> QuestItemMap;
typedef std::vector<LootStoreItem> LootStoreItemList;
typedef std::unordered_map<uint32, LootTemplate*> LootTemplateMap;

typedef std::set<uint32> LootIdSet;

class LootStore
{
    public:
        explicit LootStore(char const* name, char const* entryName, bool ratesAllowed)
            : m_name(name), m_entryName(entryName), m_ratesAllowed(ratesAllowed) {}
        virtual ~LootStore() { Clear(); }

        void Verify() const;

        void LoadAndCollectLootIds(LootIdSet& ids_set);
        void CheckLootRefs(LootIdSet* ref_set = nullptr) const; // Check existence reference and remove it from ref_set
        void ReportUnusedIds(LootIdSet const& ids_set) const;
        void ReportNotExistedId(const uint32 id) const;

        bool HaveLootFor(uint32 loot_id) const { return m_LootTemplates.find(loot_id) != m_LootTemplates.end(); }
        bool HaveQuestLootFor(const uint32 loot_id) const;
        bool HaveQuestLootForPlayer(const uint32 loot_id,Player* player) const;

        LootTemplate const* GetLootFor(const uint32 loot_id) const;

        char const* GetName() const { return m_name; }
        char const* GetEntryName() const { return m_entryName; }
        bool IsRatesAllowed() const { return m_ratesAllowed; }

    protected:
        void LoadLootTable();
        void Clear();

    private:
        LootTemplateMap m_LootTemplates;
        char const* m_name;
        char const* m_entryName;
        bool m_ratesAllowed;
};

class LootTemplate
{
    class  LootGroup; // A set of loot definitions for items (refs are not allowed inside)
    typedef std::vector<LootGroup> LootGroups;

    public:
        // Adds an entry to the group (at loading stage)
        void AddEntry(LootStoreItem& item);
        // Rolls for every item in the template and adds the rolled items the the loot
        void Process(Loot& loot, LootStore const& store, const bool rate, const uint8 GroupId = 0) const;

        // True if template includes at least 1 quest drop entry
        bool HasQuestDrop(LootTemplateMap const& store, const uint8 GroupId = 0) const;
        // True if template includes at least 1 quest drop for an active quest of the player
        bool HasQuestDropForPlayer(LootTemplateMap const& store, Player const* player, const uint8 GroupId = 0) const;

        // Checks integrity of the template
        void Verify(LootStore const& store, const uint32 Id) const;
        void CheckLootRefs(LootIdSet* ref_set) const;
    private:
        LootStoreItemList Entries; // Not grouped only
        LootGroups        Groups;  // Groups have own (optimised) processing, grouped entries go there
};

//=====================================================

class LootValidatorRef : public Reference<Loot, LootValidatorRef>
{
    public:
        LootValidatorRef() {}
        void targetObjectDestroyLink() override {}
        void sourceObjectDestroyLink() override {}
};

//=====================================================

class LootValidatorRefManager : public RefManager<Loot, LootValidatorRef>
{
    public:
        typedef LinkedListHead::Iterator< LootValidatorRef > iterator;

        LootValidatorRef* getFirst() { return (LootValidatorRef*)RefManager<Loot, LootValidatorRef>::getFirst(); }
        LootValidatorRef* getLast() { return (LootValidatorRef*)RefManager<Loot, LootValidatorRef>::getLast(); }

        iterator begin() { return iterator(getFirst()); }
        iterator end() { return iterator(nullptr); }
        iterator rbegin() { return iterator(getLast()); }
        iterator rend() { return iterator(nullptr); }
};

//=====================================================
struct LootView;

ByteBuffer& operator<<(ByteBuffer& b, LootItem const& li);
ByteBuffer& operator<<(ByteBuffer& b, LootView const& lv);

struct Loot
{
    friend ByteBuffer& operator<<(ByteBuffer& b, LootView const& lv);

    QuestItemMap const& GetPlayerQuestItems() const { return m_playerQuestItems; }
    QuestItemMap const& GetPlayerFFAItems() const { return m_playerFFAItems; }
    QuestItemMap const& GetPlayerNonQuestNonFFAConditionalItems() const { return m_playerNonQuestNonFFAConditionalItems; }

    bool m_personal;
    LootItemList items;
    uint32 gold;
    uint8 unlootedCount;
    uint64 roundRobinPlayer;
    LootType loot_type; // Required for for proper item loot finish (store internal loot types in different from 3.x version, in fact this meaning that it send same loot types for interesting cases like 3.x version code, skip pre-3.x client loot type limitaitons)

    Loot(WorldObject const* lootTarget, uint32 _gold = 0) :
        m_personal(false),
        gold(_gold),
        unlootedCount(0),
        roundRobinPlayer(0),
        loot_type(LOOT_CORPSE),
        m_lootTarget(lootTarget),
        m_groupTeam(TEAM_CROSSFACTION),
        m_hasFFAQuestItems(false)
    {
    }
    ~Loot() { clear(); }

    // If loot becomes invalid this reference is used to inform the listener
    void addLootValidatorRef(LootValidatorRef* pLootValidatorRef)
    {
        m_LootValidatorRefManager.insertFirst(pLootValidatorRef);
    }

    void clear(const bool clearQuestItems = true)
    {
        if (clearQuestItems)
        {
            for (const auto& itr : m_playerQuestItems)
                delete itr.second;

            m_playerQuestItems.clear();
            m_questItems.clear();
        }

        for (const auto& itr : m_playerFFAItems)
            delete itr.second;

        m_playerFFAItems.clear();

        for (const auto& itr : m_playerNonQuestNonFFAConditionalItems)
            delete itr.second;

        m_playerNonQuestNonFFAConditionalItems.clear();

        m_playersLooting.clear();
        items.clear();
        gold = 0;
        unlootedCount = 0;
        m_LootValidatorRefManager.clearReferences();
        roundRobinPlayer = 0;
        m_allowedLooters.clear();
        m_personal = true;
        m_groupTeam = TEAM_CROSSFACTION;
        m_hasFFAQuestItems = false;
    }

    void leaveOnlyQuestItems()
    {
       clear(false);
    }

    bool empty() const { return items.empty() && m_questItems.empty() && gold == 0; }
    bool isLooted() const { return gold == 0 && unlootedCount == 0; }
    bool HasFFAQuestItems() const { return m_hasFFAQuestItems; }

    void NotifyItemRemoved(const uint8 lootIndex);
    void NotifyQuestItemRemoved(const uint8 questIndex);
    void NotifyMoneyRemoved();
    void AddLooter(ObjectGuid guid) { m_playersLooting.insert(guid); }
    void RemoveLooter(ObjectGuid guid) { m_playersLooting.erase(guid); }
    bool HasPlayersLooting() const { return !m_playersLooting.empty(); }

    void GenerateMoneyLoot(const uint32 minAmount, const uint32 maxAmount);
    bool FillLoot(const uint32 loot_id, LootStore const& store, Player* loot_owner, const bool personal, const bool noEmptyError = false, WorldObject const* looted = nullptr);

    // Inserts the item into the loot (called by LootTemplate processors)
    void AddItem(LootStoreItem const& item);

    LootItem* LootItemInSlot(const uint32 lootslot, const uint32 playerGuid, QuestItem** qitem = nullptr, QuestItem** ffaitem = nullptr, QuestItem** conditem = nullptr);
    uint32 GetMaxSlotInLootFor(const uint32 playerGuid) const;

    WorldObject const* GetLootTarget() const { return m_lootTarget; }

    // TrinityCore
    bool HasItemFor(Player* player) const;
    bool HasOverThresholdItem() const;
    bool IsAllowedLooter(ObjectGuid const guid, const bool doPersonalCheck = true) const;
    bool IsOriginalLooter(ObjectGuid guid) { return IsAllowedLooter(guid, false); }

    void FillNotNormalLootFor(Player* player);

    uint32 GetTeam() const { return m_groupTeam; }
    void SetTeam(Team team) { m_groupTeam = team; }

    LootItemList m_questItems;
    QuestItemMap m_playerQuestItems;
    QuestItemMap m_playerFFAItems;
    QuestItemMap m_playerNonQuestNonFFAConditionalItems;

private:
    QuestItemList* FillFFALoot(Player* player);
    QuestItemList* FillQuestLoot(Player* player);
    QuestItemList* FillNonQuestNonFFAConditionalLoot(Player* player);

    typedef std::set<ObjectGuid> PlayersLooting;
    PlayersLooting m_playersLooting;

    // All rolls are registered here. They need to know, when the loot is not valid anymore
    LootValidatorRefManager m_LootValidatorRefManager;
    std::vector<ObjectGuid> m_allowedLooters;

    // What is looted
    WorldObject const* m_lootTarget;
    Team m_groupTeam;
    bool m_hasFFAQuestItems;
};

struct LootView
{
    Loot &loot;
    Player* viewer;
    PermissionTypes permission;
    LootView(Loot &_loot, Player* _viewer,PermissionTypes _permission = ALL_PERMISSION)
        : loot(_loot), viewer(_viewer), permission(_permission) {}
};

extern LootStore LootTemplates_Creature;
extern LootStore LootTemplates_Fishing;
extern LootStore LootTemplates_Gameobject;
extern LootStore LootTemplates_Item;
extern LootStore LootTemplates_Mail;
extern LootStore LootTemplates_Pickpocketing;
extern LootStore LootTemplates_Skinning;
extern LootStore LootTemplates_Disenchant;
extern LootStore LootTemplates_Reference;

void LoadLootTemplates_Creature();
void LoadLootTemplates_Fishing();
void LoadLootTemplates_Gameobject();
void LoadLootTemplates_Item();
void LoadLootTemplates_Mail();
void LoadLootTemplates_Pickpocketing();
void LoadLootTemplates_Skinning();
void LoadLootTemplates_Disenchant();

void LoadLootTemplates_Reference();

inline void LoadLootTables()
{
    LoadLootTemplates_Creature();
    LoadLootTemplates_Fishing();
    LoadLootTemplates_Gameobject();
    LoadLootTemplates_Item();
    LoadLootTemplates_Mail();
    LoadLootTemplates_Pickpocketing();
    LoadLootTemplates_Skinning();
    LoadLootTemplates_Disenchant();

    LoadLootTemplates_Reference();
}
