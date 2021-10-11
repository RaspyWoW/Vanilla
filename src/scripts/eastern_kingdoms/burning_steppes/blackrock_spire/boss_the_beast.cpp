/* Copyright (C) 2006 - 2010 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "scriptPCH.h"

struct boss_thebeastAI : public ScriptedAI
{
    boss_thebeastAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        Reset();
    }

    static constexpr uint32 AURA_IMMOLATE = 15506;
    static constexpr uint32 SPELL_FLAMEBREAK = 16785;
    static constexpr uint32 SPELL_TERRIFYINGROAR = 14100;
    static constexpr uint32 SPELL_BERSERKER_CHARGE = 16636;
    static constexpr uint32 SPELL_FIREBALL = 16788;
    static constexpr uint32 SPELL_FIREBLAST = 14144;
    static constexpr uint32 SPELL_SUMMON_FINKLE = 16710;

    uint32 m_uiFlamebreakTimer;
    uint32 m_uiTerrifyingRoarTimer;
    uint32 m_uiBeserkerChargeTimer;
    uint32 m_uiFireballTimer;
    uint32 m_uiFireBlastTimer;
    uint32 m_uiLeashCheckTimer;
    bool m_bSummoned;
    bool m_bPulledByPet;

    void Reset() override
    {
        m_uiFlamebreakTimer = urand(8000, 12000);
        m_uiTerrifyingRoarTimer = 13000;
        m_uiBeserkerChargeTimer = 0;
        m_uiFireballTimer = 10000;
        m_uiFireBlastTimer = urand(8000, 11000);
        m_uiLeashCheckTimer = 5000;
        m_bSummoned = false;
        m_bPulledByPet = false;
    }

    void EnterCombat(Unit* pUnit) override
    {
        // Prevent exploit where pet can run through the wall and pull the boss.
        if (Unit* pOwner = pUnit->GetOwner())
            if (!pOwner->IsWithinLOSInMap(m_creature))
                m_bPulledByPet = true;
    }

    void LeashIfOutOfCombatArea(uint32 uiDiff)
    {
        if (m_uiLeashCheckTimer < uiDiff)
            m_uiLeashCheckTimer = 3500;
        else
        {
            m_uiLeashCheckTimer -= uiDiff;
            return;
        }

        if (m_bPulledByPet || (m_creature->GetPositionZ() > 120.0f || m_creature->GetPositionZ() < 100.0f))
        {
            EnterEvadeMode();
            return;
        }
    }

    void SpellHit(Unit* pCaster, SpellEntry const* pSpell) override
    {
        if (pSpell->Effect[0] == SPELL_EFFECT_SKINNING)
            pCaster->CastSpell(pCaster, SPELL_SUMMON_FINKLE, true);
    }

    void UpdateAI(uint32 const uiDiff) override
    {
        if (!m_creature->HasAura(AURA_IMMOLATE))
            m_creature->CastSpell(m_creature, AURA_IMMOLATE, true);

        // Return since we have no target
        if (!m_creature->SelectHostileTarget() || !m_creature->GetVictim())
            return;

        // Prevent exploit
        LeashIfOutOfCombatArea(uiDiff);

        // Flamebreak
        if (m_uiFlamebreakTimer < uiDiff)
        {
            if (DoCastSpellIfCan(m_creature, SPELL_FLAMEBREAK) == CAST_OK)
                m_uiFlamebreakTimer = urand(14000, 20000);
        }
        else
            m_uiFlamebreakTimer -= uiDiff;

        // Terrifying Roar
        if (m_uiTerrifyingRoarTimer < uiDiff)
        {
            if (DoCastSpellIfCan(m_creature, SPELL_TERRIFYINGROAR) == CAST_OK)
                m_uiTerrifyingRoarTimer = urand(16000, 18000);
        }
        else
            m_uiTerrifyingRoarTimer -= uiDiff;

        // Berserker Charge
        if (m_uiBeserkerChargeTimer <= uiDiff)
        {
            Unit* pTarget = m_creature->SelectAttackingTarget(ATTACKING_TARGET_RANDOM, 1);
            if (m_uiBeserkerChargeTimer == 0) pTarget = m_creature->GetVictim();

            if (DoCastSpellIfCan(pTarget, SPELL_BERSERKER_CHARGE) == CAST_OK)
                m_uiBeserkerChargeTimer = urand(15000, 20000);
        }
        else
            m_uiBeserkerChargeTimer -= uiDiff;

        // Fireball
        if (m_uiFireballTimer < uiDiff)
        {
            if (Unit* pTarget = m_creature->SelectAttackingTarget(ATTACKING_TARGET_RANDOM, 1))
            {
                if (DoCastSpellIfCan(pTarget, SPELL_FIREBALL) == CAST_OK)
                    m_uiFireballTimer = urand(10000, 12000);
            }
        }
        else
            m_uiFireballTimer -= uiDiff;

        if (m_uiFireBlastTimer < uiDiff)
        {
            if (Unit* pTarget = m_creature->GetVictim())
            {
                if (DoCastSpellIfCan(pTarget, SPELL_FIREBLAST) == CAST_OK)
                    m_uiFireBlastTimer = urand(14000, 20000);
            }
        }
        else
            m_uiFireBlastTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_thebeast(Creature* pCreature)
{
    return new boss_thebeastAI(pCreature);
}

void AddSC_boss_thebeast()
{
    Script* newscript;
    newscript = new Script;
    newscript->Name = "boss_the_beast";
    newscript->GetAI = &GetAI_boss_thebeast;
    newscript->RegisterSelf();
}
