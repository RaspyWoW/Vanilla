// RaspyWoW - Vanilla

#include "scriptPCH.h"

struct boss_lord_incendiusAI : public ScriptedAI
{
    boss_lord_incendiusAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        Reset();
    }

    static constexpr uint32 SPELL_CURSE_ELEMENTAL_LORD = 26977;
    static constexpr uint32 SPELL_FIERY_BURST = 13900;
    static constexpr uint32 SPELL_MIGHTY_BLOW = 14099;
    static constexpr uint32 SPELL_FIRE_STORM = 13899;

    uint32 m_uiCurseTimer;
    uint32 m_uiFieryBurstTimer;
    uint32 m_uiMightyBlowTimer;
    uint32 m_uiFireStormTimer;
    uint32 m_uiLeashCheckTimer;
    bool m_bPulledByPet;
    bool m_bSummoned;

    void Reset() override
    {
        m_uiCurseTimer = 2500;
        m_uiFieryBurstTimer = 8000;
        m_uiMightyBlowTimer = 13000;
        m_uiFireStormTimer = 14000;
        m_uiLeashCheckTimer = 5000;
        m_bSummoned = false;
        m_bPulledByPet = false;
    }

    void EnterCombat(Unit* pUnit) override
    {
        // Prevent exploit where pet can run through the wall and pull the boss
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

        if (m_bPulledByPet || (m_creature->GetPositionZ() > -68.0f || m_creature->GetPositionZ() < -72.0f))
        {
            EnterEvadeMode();
            return;
        }
    }

    void UpdateAI(uint32 const uiDiff) override
    {
        // Return since we have no target
        if (!m_creature->SelectHostileTarget() || !m_creature->GetVictim())
            return;

        // Prevent exploit
        LeashIfOutOfCombatArea(uiDiff);

        // Curse
        if (m_uiCurseTimer < uiDiff)
        {
            DoCastSpellIfCan(m_creature, SPELL_CURSE_ELEMENTAL_LORD);
            m_uiCurseTimer = urand(20000, 28000);
        }
        else
            m_uiCurseTimer -= uiDiff;

        // Fiery Burst
        if (m_uiFieryBurstTimer < uiDiff)
        {
            DoCastSpellIfCan(m_creature->GetVictim(), SPELL_FIERY_BURST);
            m_uiFieryBurstTimer = urand(9000, 16000);
        }
        else
            m_uiFieryBurstTimer -= uiDiff;

        // Mighty Blow
        if (m_uiMightyBlowTimer < uiDiff)
        {
            if (Unit* target = m_creature->SelectAttackingTarget(ATTACKING_TARGET_RANDOM, 0))
                DoCastSpellIfCan(target, SPELL_MIGHTY_BLOW);

            m_uiMightyBlowTimer = urand(18000, 24000);
        }
        else
            m_uiMightyBlowTimer -= uiDiff;

        // Fire Storm
        if (m_uiFireStormTimer < uiDiff)
        {
            if (Unit* target = m_creature->SelectAttackingTarget(ATTACKING_TARGET_RANDOM, 0))
                DoCastSpellIfCan(target, SPELL_FIRE_STORM);

            m_uiFireStormTimer = urand(11000, 14000);
        }
        else
            m_uiFireStormTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_lord_incendius(Creature* pCreature)
{
    return new boss_lord_incendiusAI(pCreature);
}

void AddSC_boss_lord_incendius()
{
    Script* newscript;
    newscript = new Script;
    newscript->Name = "boss_lord_incendius";
    newscript->GetAI = &GetAI_boss_lord_incendius;
    newscript->RegisterSelf();
}
