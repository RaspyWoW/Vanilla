DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20211011160709');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20211011160709');
-- Add your query below.

-- Add vendor menu option to innkeeper grosk
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 1290;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `Option_Broadcast_Text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `Box_Broadcast_Text`, `condition_id`) VALUES 
(1290, 0, 0, "Trick or Treat!", 10693, 1, 1, -1, 0, 342, 0, 0, "", 0, 164),
(1290, 1, 5, "Make this inn your home.", 2822, 8, 128, 0, 0, 0, 0, 0, "", 0, 0),
(1290, 2, 0, "Does that heart mean you're looking for love?", 11823, 1, 1, 5110, 0, 0, 0, 0, "", 0, 440),
(1290, 3, 1, "Let me browse your seasonal fare.", 8786, 3, 4, 2, 0, 0, 0, 0, "", 0, 440),
(1290, 4, 1, "I want to browse your goods.", 3370, 3, 4, 1, 0, 0, 0, 0, "", 0, 0),
(1290, 5, 0, "Tell me about dungeons I could explore.", 9882, 1, 1, 6029, 0, 0, 0, 0, "", 0, 4500);

-- Remove Spell list from Lord Incendius
DELETE FROM `creature_spells` WHERE `entry` = 90170;
UPDATE `creature_template` SET `spell_list_id` = 0 WHERE `entry` = 9017;

-- Assign C++ script
UPDATE `creature_template` SET `script_name` = 'boss_lord_incendius' WHERE `entry` = 9017;

-- Remove custom gobjects on GM-Island
DELETE FROM `gameobject` WHERE `guid` IN
(
    314065, -- Horde Postbox
    230922, -- Alliance Postbox
    399540, -- Stranglevine
    399536, -- Stranglevine
    399539, -- Stranglevine
    399537, -- Stranglevine
    399538, -- Stranglevine
    240937, -- Wooden Bench
    240938, -- Wooden Chair
    3996125 -- Neutral Mailbox
);

-- Remove custom NPCs on GM-Island
DELETE FROM `creature` WHERE `guid` IN
(
    301267, -- Wild Buck
    301269, -- Hawk Owl
    301268, -- Hawk Owl
    301769, -- Rabbit
    301768, -- Rabbit
    301767, -- Rabbit
    301266  -- Huge Toad
);

-- Fix https://github.com/the-hyjal-project/bugtracker/issues/146
DELETE FROM `creature` WHERE `guid` BETWEEN 305010 AND 305012;
INSERT INTO `creature` (`guid`, `id`, `id2`, `id3`, `id4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `patch_min`, `patch_max`) VALUES
(305010, 947, 0, 0, 0, 0, -9122.52, -3230.09, 101.094, 3.42862, 46800, 54000, 0, 100, 0, 0, 0, 0, 0, 10),
(305011, 947, 0, 0, 0, 0, -9266.35, -3313.16, 150.142, 2.21127, 46800, 54000, 0, 100, 0, 0, 0, 0, 0, 10),
(305012, 947, 0, 0, 0, 0, -9396.52, -3361.68, 88.3186, 5.47852, 46800, 54000, 0, 100, 0, 0, 0, 0, 0, 10);
DELETE FROM `pool_template` WHERE `entry` = 45000;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(45000, 1, 'NPC Rohh the Silent');
DELETE FROM `pool_creature` WHERE `guid` = 28480;
DELETE FROM `pool_creature` WHERE `guid` BETWEEN 305010 AND 305012;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`, `flags`, `patch_min`, `patch_max`) VALUES
(28480, 45000, 0, 'NPC Rohh the Silent', 0, 0, 10),
(305010, 45000, 0, 'NPC Rohh the Silent', 0, 0, 10),
(305011, 45000, 0, 'NPC Rohh the Silent', 0, 0, 10),
(305012, 45000, 0, 'NPC Rohh the Silent', 0, 0, 10);

-- Fix https://github.com/the-hyjal-project/bugtracker/issues/109
DELETE FROM `creature` WHERE `guid` BETWEEN 305013 AND 305015;
INSERT INTO `creature` (`guid`, `id`, `id2`, `id3`, `id4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `patch_min`, `patch_max`) VALUES
(305013, 4015, 0, 0, 0, 1, 1368.95, 1063.37, 164.661, 5.52912, 5400, 19800, 5, 100, 0, 1, 0, 0, 0, 10),
(305014, 4015, 0, 0, 0, 1, 1628.43, 901.035, 123.295, 1.36651, 5400, 19800, 5, 100, 0, 1, 0, 0, 0, 10),
(305015, 4015, 0, 0, 0, 1, 1501.59, 655.063, 141.462, 1.60996, 5400, 19800, 5, 100, 0, 1, 0, 0, 0, 10);
DELETE FROM `pool_template` WHERE `entry` = 45001;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(45001, 1, 'NPC Pridewing Patriarch');
DELETE FROM `pool_creature` WHERE `guid` = 29981;
DELETE FROM `pool_creature` WHERE `guid` BETWEEN 305013 AND 305015;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`, `flags`, `patch_min`, `patch_max`) VALUES
(29981, 45001, 0, 'NPC Pridewing Patriarch', 0, 0, 10),
(305013, 45001, 0, 'NPC Pridewing Patriarch', 0, 0, 10),
(305014, 45001, 0, 'NPC Pridewing Patriarch', 0, 0, 10),
(305015, 45001, 0, 'NPC Pridewing Patriarch', 0, 0, 10);

-- Fix ERROR:Spell 6346 listed in `spell_proc_event` has exactly same proc flags as in spell.dbc, field value redundant
DELETE FROM `spell_proc_event` WHERE `entry` = 6346;

-- Add missing fishs to wetlands coast
DELETE FROM `fishing_loot_template` WHERE `entry` = 298 AND `item` = 6358;
DELETE FROM `fishing_loot_template` WHERE `entry` = 150 AND `item` = 6358;
INSERT INTO `fishing_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`) VALUES
('298', '6358', '14.23', '1'),
('150', '6358', '12.761', '1');

-- Allow Fireguard destroyers in brd to swim in lava
UPDATE `creature_template` SET `inhabit_type`='3' WHERE  `entry` = 8911 AND `patch` = 0;

-- Mailbox at bloodvenom post doesn't exist in vanilla
DELETE FROM `gameobject` WHERE `id` = 187260;

-- Artist Renfray should always be visible according to allakhzam comments
UPDATE `creature_template` SET `auras`='0' WHERE `entry` = 11936 AND `patch` = 0;

-- Mudrock Tortoise - Add skinning loot
DELETE FROM `skinning_loot_template` WHERE `entry` = 4396;
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`, `patch_min`, `patch_max`) VALUES
(4396, 4234, 76.643, 0, 1, 1, 0, 0, 10),
(4396, 4235, 2.613, 0, 1, 1, 0, 0, 10),
(4396, 4304, 20.735, 0, 1, 1, 0, 0, 10),
(4396, 8167, 24.478, 0, 1, 1, 0, 0, 10);
UPDATE `creature_template` SET `unit_flags`='32768', `skinning_loot_id`='4396' WHERE  `entry`=4396 AND `patch`=0;

-- Remove patch restrictions from stationery items. These items are required for mails with GM, AH scroll or valentines icons.
DELETE FROM `forbidden_items` WHERE `entry` IN (18154, 21140, 22058);
UPDATE `item_template` SET `patch`=0 WHERE `entry` IN (18154, 21140, 22058);

-- https://github.com/the-hyjal-project/bugtracker/issues/135
-- Started as a fix for flavour text however many things are off from original for this whole fight. Several things fixed to make it blizzlike.
-- Creature Templates
DELETE FROM `creature_template` WHERE `entry` = 988007 AND `patch` = 0;
INSERT INTO `creature_template` (`entry`, `patch`, `display_id1`, `display_id2`, `display_id3`, `display_id4`, `display_scale1`, `display_scale2`, `display_scale3`, `display_scale4`, `display_probability1`, `display_probability2`, `display_probability3`, `display_probability4`, `display_total_probability`, `mount_display_id`, `name`, `subname`, `gossip_menu_id`, `level_min`, `level_max`, `health_min`, `health_max`, `mana_min`, `mana_max`, `armor`, `faction`, `npc_flags`, `speed_walk`, `speed_run`, `detection_range`, `call_for_help_range`, `leash_range`, `rank`, `xp_multiplier`, `dmg_min`, `dmg_max`, `dmg_school`, `attack_power`, `dmg_multiplier`, `base_attack_time`, `ranged_attack_time`, `unit_class`, `unit_flags`, `dynamic_flags`, `beast_family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `ranged_dmg_min`, `ranged_dmg_max`, `ranged_attack_power`, `type`, `type_flags`, `loot_id`, `pickpocket_loot_id`, `skinning_loot_id`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `spell_id1`, `spell_id2`, `spell_id3`, `spell_id4`, `spell_list_id`, `pet_spell_list_id`, `auras`, `gold_min`, `gold_max`, `ai_name`, `movement_type`, `inhabit_type`, `civilian`, `racial_leader`, `regeneration`, `equipment_id`, `trainer_id`, `vendor_id`, `mechanic_immune_mask`, `school_immune_mask`, `flags_extra`, `script_name`) VALUES
(988007, 0, 262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Firebeam NPC - Ring of Fire', NULL, 0, 63, 63, 9999, 9999, 99999, 99999, 68, 35, 0, 1, 1.14286, 20, 5, 0, 3, 1, 11, 11, 0, 290, 1, 1800, 1900, 1, 0, 0, 0, 0, 0, 0, 0, 387.6, 532.95, 100, 1, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, NULL, 222, 1110, '', 0, 3, 0, 0, 3, 0, 0, 0, 2147483648, 0, 32898, '');

-- Creature locations
DELETE FROM `creature` WHERE `guid` BETWEEN 302710 AND 302713;
INSERT INTO `creature` (`guid`, `id`, `id2`, `id3`, `id4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `patch_min`, `patch_max`) VALUES
(302710, 988007, 0, 0, 0, 230, 600.917, -225.796, -52.5982, 4.91037, 25, 25, 0, 100, 100, 0, 0, 0, 0, 10),
(302711, 988007, 0, 0, 0, 230, 611.324, -223.015, -52.5978, 4.96064, 25, 25, 0, 100, 100, 0, 0, 0, 0, 10),
(302712, 988007, 0, 0, 0, 230, 633.706, -184.458, -52.6079, 0.34329, 25, 25, 0, 100, 100, 0, 0, 0, 0, 10),
(302713, 988007, 0, 0, 0, 230, 630.935, -174.106, -52.6077, 0.34329, 25, 25, 0, 100, 100, 0, 0, 0, 0, 10);

-- Bugfix: https://github.com/the-hyjal-project/bugtracker/issues/91
-- Remove https://classic.wowhead.com/item=5516/threshadon-fang from general shared NPC loot table
DELETE FROM `creature_loot_template` WHERE `entry` = 30037 AND `item` = 5516;

-- Only reward xp/gold on initial quests of Cenarion Plant Salve - repeatables reward 0.
UPDATE `quest_template` SET `RewXP`= 4200, `RewMoneyMaxLevel`=25200 WHERE `entry` IN (4103, 4104, 4105, 4106, 4107, 5882, 5883, 5884, 5885, 5886);
UPDATE `quest_template` SET `RewXP`= 0, `RewMoneyMaxLevel`=0 WHERE `entry` IN (4108, 4109, 4110, 4111, 4112, 5887, 5888, 5889, 5890, 5891);

-- Startup fixes
DELETE FROM `spell_threat` WHERE `entry` = 25898;
UPDATE `creature_template` SET `auras`='' WHERE `entry` = 11936;
UPDATE `gameobject` SET `patch_min`='5' WHERE `guid` = 20463;
DELETE FROM `creature_ai_events` WHERE `id` = 1308201;

-- Adds the "no initial aggro" flag to arcane missiles
-- https://github.com/the-hyjal-project/bugtracker/issues/441
INSERT INTO `spell_mod` (`Id`, `AttributesEx3`) VALUES
(5143, 131072),
(5144, 131072),
(5145, 131072),
(8416, 131072),
(8417, 131072),
(10211, 131072),
(10212, 131072),
(25345, 131072);

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
