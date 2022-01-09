DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20220109172840');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20220109172840');
-- Add your query below.

-- Allow players to die at the end of In Dreams.
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (6305, 25, 0, 80, 0, 0, 0);
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (6609, 33, 69, 5944, 0, 0, 0, 0, 0, 0, 0, 0, 6611, 6305, 5944, 0, 0, 0, 0, 0, 'In Dreams: Update Map Event Condition');

-- Creature 915
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4659 AND `id` = 1;

-- Creature 916
UPDATE `gossip_menu` SET `text_id` = 4834 WHERE `entry` = 4676 AND `text_id` = 4835;
UPDATE `gossip_menu_option` SET `option_text` = 'I\'m lookin\' for rogue trainin\'.', `option_broadcast_text` = 7490 WHERE `menu_id` = 4676 AND `id` = 0;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4676 AND `id` = 1;

-- Creature 917
UPDATE `gossip_menu` SET `text_id` = 878 WHERE `entry` = 381 AND `text_id` = 4795;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 381 AND `id` = 1;

-- Creature 918
UPDATE `gossip_menu` SET `text_id` = 5993 WHERE `entry` = 4502 AND `text_id` = 5996;

-- Creature 1411
DELETE FROM `gossip_menu` WHERE `entry` = 4658 AND `text_id` = 5996;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4658 AND `id` = 4;

-- Creature 1234
UPDATE `gossip_menu` SET `condition_id` = 100 WHERE `entry` = 410 AND `text_id` = 907;
UPDATE `gossip_menu` SET `condition_id` = 101 WHERE `entry` = 410 AND `text_id` = 4797;
DELETE FROM `gossip_menu` WHERE `entry` = 410 AND `text_id` = 4795;
UPDATE `gossip_menu_option` SET `option_broadcast_text` = 2929, `option_text` = 'Good day to you, Hogral! I seek training.' WHERE `menu_id` = 410 AND `id` = 0;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 410 AND `id` = 1;

-- Creature 2122
-- Creature 2130
DELETE FROM `gossip_menu` WHERE `entry` = 85 AND `text_id` = 5996;
DELETE FROM `gossip_menu_option` WHERE `menu_id`= 85 AND `id` = 4;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 85 AND `id` = 1;

-- Creature 3155
-- Creature 3170
DELETE FROM `gossip_menu` WHERE `entry` = 141 AND `text_id` = 5996;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 141 AND `id` = 4;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 141 AND `id` = 1;

-- Creature 3328
UPDATE `gossip_menu` SET `text_id` = 5993 WHERE `entry` = 4513 AND `text_id` = 5996;

-- Creature 3401
UPDATE `gossip_menu` SET `text_id` = 5993 WHERE `entry` = 521 AND `text_id` = 5996;
UPDATE `gossip_menu_option` SET `option_broadcast_text` = 3143, `option_text` = 'I require training, sir!' WHERE `menu_id` = 521 AND `id` = 0;

-- Creature 3594
UPDATE `gossip_menu` SET `text_id`=4794 WHERE `entry`=4690 && `text_id`=4796;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 4690 AND `id` = 1;

-- Creature 3599
UPDATE `gossip_menu` SET `text_id`=934 WHERE `entry`=436 && `text_id`=4794;
UPDATE `gossip_menu` SET `text_id`=4794 WHERE `entry`=436 && `text_id`=4793;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 436 AND `id` = 1;

-- Creature 4163
UPDATE `gossip_menu` SET `text_id`=4795 WHERE `entry`=4576 && `text_id`=4794;
UPDATE `gossip_menu` SET `text_id`=4794 WHERE `entry`=4576 && `text_id`=4793;

-- Creature 4214
UPDATE `creature_template` SET `gossip_menu_id` = 4577 WHERE `entry` = 4214;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(4577, 4793, 0, 101),
(4577, 4795, 0, 100),
(4577, 5996, 0, 198),
(4577, 8255, 0, 461),
(4577, 8283, 0, 459),
(4577, 8285, 0, 454),
(4577, 8291, 0, 458),
(4577, 8296, 0, 460),
(4577, 8298, 0, 455);

INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_broadcast_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `box_broadcast_text`, `condition_id`) VALUES
(4577, 0, 3, 'I seek training.', 7478, 5, 16, 0, 0, 0, 0, 0, '', 0, 0),
(4577, 1, 0, 'I wish to unlearn my talents.', 8271, 1, 1, 4461, 0, 0, 0, 0, '', 0, 136),
(4577, 4, 0, '<Take the letter>', 8548, 1, 1, -1, 0, 16, 0, 0, '', 0, 198),
(4577, 9, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 410, 0, 0, NULL, 0, 462),
(4577, 10, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 411, 0, 0, NULL, 0, 461);

-- Creature 4215
UPDATE `creature_template` SET `gossip_menu_id` = 4575 WHERE `entry` = 4215;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(4575, 4793, 0, 101),
(4575, 4795, 0, 100),
(4575, 5996, 0, 198),
(4575, 8255, 0, 461),
(4575, 8283, 0, 459),
(4575, 8285, 0, 454),
(4575, 8291, 0, 458),
(4575, 8296, 0, 460),
(4575, 8298, 0, 455);

INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_broadcast_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `box_broadcast_text`, `condition_id`) VALUES
(4575, 0, 3, 'I seek training.', 7478, 5, 16, 0, 0, 0, 0, 0, '', 0, 0),
(4575, 1, 0, 'I wish to unlearn my talents.', 8271, 1, 1, 4461, 0, 0, 0, 0, '', 0, 136),
(4575, 4, 0, '<Take the letter>', 8548, 1, 1, -1, 0, 16, 0, 0, '', 0, 198),
(4575, 9, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 410, 0, 0, NULL, 0, 462),
(4575, 10, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 411, 0, 0, NULL, 0, 461);

-- Creature 4582
UPDATE `gossip_menu` SET `text_id` = 5993 WHERE `entry` = 4542 AND `text_id` = 5996;
UPDATE `gossip_menu_option` SET `option_broadcast_text` = 2548, `option_text` = 'I would like to train.' WHERE `menu_id` = 4542 AND `id` = 0;

-- Creature 4584
UPDATE `gossip_menu_option` SET `option_broadcast_text` = 2548, `option_text` = 'I would like to train.' WHERE `menu_id` = 4541 AND `id` = 0;

-- Creature 5165
UPDATE `gossip_menu` SET `text_id` = 5993 WHERE `entry` = 411 AND `text_id` = 5996;

-- Creature 5166
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(4562, 5993, 0, 198);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_broadcast_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `box_broadcast_text`, `condition_id`) VALUES
(4562, 4, 0, '<Take the letter>', 8548, 1, 1, -1, 0, 16, 0, 0, '', 0, 198);

-- Creature 5167
UPDATE `gossip_menu` SET `text_id` = 5993 WHERE `entry` = 4561 AND `text_id` = 5996;

-- Creature 13283
DELETE FROM `gossip_menu` WHERE  `entry` = 5061 AND `text_id` = 5996;
DELETE FROM `gossip_menu_option` WHERE `menu_id` = 5061 AND `id` = 2;

-- Remove orphaned game event creature data rows.
DELETE FROM `game_event_creature_data` WHERE `guid` IN (94926, 94927, 94928, 91688, 91637, 91622, 91633, 91629, 91624, 91634, 91628, 91623, 94920, 91689, 91625, 91636, 94919, 91632, 91626, 60007, 79676);

-- Acolyte Magaz 
-- Add Missing Default Gossip And Add Condition To 3591
UPDATE `gossip_menu` SET `condition_id` = 1803 WHERE `entry` = 2912 AND `text_id` = 3591;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(2912, 3586, 0, 0);

-- Acolyte Wytula
-- Add Missing Default Gossip And Add Condition To 3592
UPDATE `gossip_menu` SET `condition_id` = 1803 WHERE `entry` = 2913 AND `text_id` = 3592;
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(2913, 3587, 0, 0);

-- Menara Voidrender
-- Gossip Text 3299 Should Become Default Gossip Once Quest 4786 Is Complete But Should Be Overrided By Gossip 3594 Only When Quest 1799 Is Accepted/Incomplete And Quest 4962 Or 4963 Is Not Complete/Accepted
UPDATE `gossip_menu` SET `condition_id` = 4788 WHERE `entry` = 2603 AND `text_id` = 3299;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (4786, 8, 4786, 0, 0, 0, 0);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (4787, -3, 1803, 0, 0, 0, 0);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (4788, -1, 4786, 4787, 0, 0, 0);

-- Gossip Text 3594 Should Show When Quest 1799 Is Accepted/Incomplete And Quest 4962 Or 4963 Is Not Complete/Accepted
UPDATE `gossip_menu` SET `condition_id` = 1803 WHERE `entry` = 2603 AND `text_id` = 3594;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1799, 9, 1799, 1, 0, 0, 0);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1800, 9, 4962, 0, 0, 0, 1);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1801, 9, 4963, 0, 0, 0, 1);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1802, -1, 1800, 1801, 0, 0, 0);
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1803, -1, 1799, 1802, 0, 0, 0);

-- Add Start Script to Quest 4786
UPDATE `quest_template` SET `StartScript` = 4786, `SpecialFlags` = 2 WHERE `entry` = 4786;
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (4786, 0, 4, 147, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - Modify Flags');
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (4786, 1, 15, 16633, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - Cast Spell');
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (4786, 9, 7, 4786, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - Complete Quest');
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (4786, 10, 4, 147, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - Modify Flags');

-- Add Missing Aura
UPDATE `creature_template` SET `auras` = '16606' WHERE `entry` = 10718;

-- Remove Unused Scripts
DELETE FROM `creature_ai_events` WHERE `creature_id` = 10718;
DELETE FROM `creature_ai_scripts` WHERE `id` IN (1071801, 1071802, 1071803, 1071804, 1071805, 1071806);

-- Nixx Sprocketspring
INSERT INTO `gossip_menu` (`entry`, `text_id`, `condition_id`) VALUES
(1469, 2133, 1367);
UPDATE `gossip_menu_option` SET `option_text` = 'Access secret goblin engineering schemata!', `option_broadcast_text` = 4551 WHERE `menu_id` = 1469 AND `id` = 0;

-- Vazario Linkgrease
UPDATE `gossip_menu_option` SET `option_text` = 'Access secret goblin engineering schemata!', `option_broadcast_text` = 4553 WHERE `menu_id` = 1465 AND `id` = 0;

-- Tinkmaster Overspark
INSERT INTO `gossip_menu` (`entry`, `text_id`, `condition_id`) VALUES
(1468, 2134, 1368);

-- Tinkmaster Overspark and Oglethorpe Obnoticus
UPDATE `gossip_menu_option` SET `option_text` = 'Access secret gnome engineering schemata!', `option_broadcast_text` = 4553 WHERE `menu_id` IN (1467, 1468) AND `id` = 0;

-- Remove Sleep Immunity From Sunken Temple Dragonkin
UPDATE `creature_template` SET `mechanic_immune_mask` = 0 WHERE `entry` IN (5283, 5277, 8319, 5280);

-- Add Missing Lordaeron Citizen Spawns
UPDATE `creature_template` SET `faction` = 7, `speed_walk`=1.11111, `speed_run`=1.14286, `base_attack_time`=2000, `auras` = '4986' WHERE `entry` = 3617;
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `wander_distance`, `movement_type`, `spawntimesecsmin`, `spawntimesecsmax`) VALUES 
(24984, 3617, 0, 1797.82, 254.586, 59.9184, 3.4656, 20, 1, 360, 480),
(24985, 3617, 0, 1787.47, 212.02, 59.8791, 2.13044, 20, 1, 360, 480),
(24986, 3617, 0, 1823.82, 253.429, 60.1046, 1.3174, 20, 1, 360, 480),
(24987, 3617, 0, 1833.97, 227.639, 60.4755, 2.84386, 20, 1, 360, 480),
(24988, 3617, 0, 1803.08, 194.758, 70.483, 0.430935, 20, 1, 360, 480),
(24989, 3617, 0, 1828.78, 211.968, 60.4395, 3.32554, 20, 1, 360, 480),
(24990, 3617, 0, 1804.37, 287.465, 70.483, 6.19455, 20, 1, 360, 480),
(24991, 3617, 0, 1764.58, 288.231, 70.483, 5.67045, 20, 1, 360, 480),
(24992, 3617, 0, 1823.76, 264.217, 60.0994, 5.08934, 20, 1, 360, 480),
(24993, 3617, 0, 1783.84, 229.072, 59.5855, 0.0549958, 20, 1, 360, 480),
(24994, 3617, 0, 1780.76, 248.196, 59.967, 3.885, 20, 1, 360, 480),
(24995, 3617, 0, 1833.44, 250.056, 59.8788, 2.75905, 20, 1, 360, 480),
(24996, 3617, 0, 1805.76, 223.951, 60.4227, 2.87473, 20, 1, 360, 480);

-- Add Scripts to Quest Stones of Binding (credit cmangos)
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(15216, 0, 9, 443, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stones of Binding : Stone of East Binding - Respawn Gameobject'),
(16598, 0, 9, 444, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stones of Binding : Stone of Outer Binding - Respawn Gameobject'),
(15398, 0, 9, 445, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stones of Binding : Stone of West Binding - Respawn Gameobject');

INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(651, 0, 9, 446, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stones of Binding : Stone of Inner Binding - Respawn Gameobject');
UPDATE `quest_template` SET `CompleteScript` = 651 WHERE `entry` = 651;

INSERT INTO `gameobject` (`guid`, `id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`) VALUES 
(30236, 2870, -846.38556, -3268.444, 78.038246, 2.8099754, -62, -62),
(30237, 2870, -1351.0742,-2740.2263, 59.40781, 4.520403, -62, -62),
(30238, 2870, -855.4827, -1783.2532, 39.629177, 4.3109655, -62, -62),
(30239, 2870, -1510.17, -2171.2039, 17.2624, 4.34587, -62, -62);

-- Add Scripts to Quest The Lost Fragments (credit cmangos)
INSERT INTO `quest_start_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(692, 0, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.2935, 0, 'The Lost Fragments : Theldurin - Set Orientation'),
(692, 0, 1, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Emote'),
(692, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3004, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Talk'),
(692, 4, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1.04719, 0, 'The Lost Fragments : Theldurin - Set Orientation');

INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(692, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 870, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Talk'),
(692, 4, 28, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Set Stand State'),
(692, 4, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.18879, 0, 'The Lost Fragments : Theldurin - Set Orientation'),
(692, 6, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Set Stand State'),
(692, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 871, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Talk'),
(692, 10, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.168656, 0, 'The Lost Fragments : Theldurin - Set Orientation'),
(692, 10, 19, 0, 0, 0, 0, 0, 0, 0, 0, 1911, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Set Equipment'),
(692, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 872, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Talk'),
(692, 13, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Emote'),
(692, 16, 19, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lost Fragments : Theldurin - Set Equipment');

UPDATE `quest_template` SET `CompleteScript` = 692, `StartScript` = 692 WHERE `entry` = 692;

-- A Dark Threat Looms
UPDATE `quest_template` SET `CompleteScript` = 283 WHERE `entry` = 283;
INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (283, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 546, 0, 0, 0, 0, 0, 0, 0, 0, 'A Dark Threat Looms: Chief Engineer Hinderweir VII - Talk');
UPDATE `broadcast_text` SET `chat_type` = 6 WHERE `entry` = 546;

-- The Brokering of Peace Alliance
INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(8484, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11308, 0, 0, 0, 0, 0, 0, 0, 0, 'The Brokering of Peace: King Magni Bronzebeard - Talk');
UPDATE `quest_template` SET `CompleteScript` = 8484 WHERE `entry` = 8484;
UPDATE `broadcast_text` SET `chat_type` = 6 WHERE `entry` = 11308;

-- The Brokering of Peace Horde
INSERT INTO `quest_end_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(8485, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11307, 0, 0, 0, 0, 0, 0, 0, 0, 'The Brokering of Peace: Thrall - Talk');
UPDATE `quest_template` SET `CompleteScript` = 8485 WHERE `entry` = 8485;
UPDATE `broadcast_text` SET `chat_type` = 6 WHERE `entry` = 11307;

-- Remove Old Event Data
DELETE FROM `creature` WHERE `guid` IN (SELECT `guid` FROM `game_event_creature` WHERE `event` = 153);
DELETE FROM `game_event` WHERE `entry` = 153;
DELETE FROM `game_event_creature` WHERE `event` = 153;
DELETE FROM `creature_groups` WHERE `leader_guid` = 301764;
DELETE FROM `creature_movement_scripts` WHERE `id` = 14;
DELETE FROM `creature_movement` WHERE  `id` IN (301764, 301765, 301761, 301763, 301762);

-- Misc
UPDATE `creature` SET `spawn_flags` = 1 WHERE `guid` = 15322;
UPDATE `game_event` SET `description` = 'Southshore Assassins', `occurence`='120', `length`='35' WHERE `entry`=152;
UPDATE `creature_template` SET `movement_type` = 0, `faction` = 108, `npc_flags` = 0, `ai_name` = '', `auras`='1785 3616' WHERE `entry` = 2434;
DELETE FROM `creature_ai_scripts` WHERE `id` = 243401;
DELETE FROM `creature_ai_events` WHERE `creature_id` = 2434;
UPDATE `creature` SET `position_x` = -576.589, `position_y` = -555.617, `position_z` = 33.4733, `spawntimesecsmin` = 2100, `spawntimesecsmax` = 2100 WHERE `id` = 2435;
UPDATE `broadcast_text` SET `chat_type` = 2 WHERE `entry` = 623;

-- Events List for Farmer Kent
UPDATE `creature_template` SET `ai_name` = 'EventAI' WHERE `entry`=2436;
INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (243601, 2436, 0, 4, 0, 100, 0, 0, 0, 0, 0, 243601, 0, 0, 'Farmer Kent - Talk on Aggro');
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243601, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 628, 627, 0, 0, 0, 0, 0, 0, 0, 'Farmer Kent - Talk');

-- Events List for Southshore Crier
DELETE FROM `creature_ai_events` WHERE `creature_id`=2435;
DELETE FROM `creature_ai_scripts` WHERE `id` IN (243502, 243503, 243504);
INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
(243501, 2435, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 243501, 0, 0, 'Southshore Crier - Yell on Spawn');

-- Main script
DELETE FROM `creature_movement` WHERE `id` = 301755;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(2435, 1, -576.589, -555.617, 33.4733, 100, 0, 0, 11),
(2435, 2, -576.589, -555.617, 33.4733, 100, 0, 0, 11),
(2435, 3, -584.442, -565.827, 32.8548, 100, 0, 0, 0),
(2435, 4, -590.498, -573.355, 32.4334, 100, 0, 0, 0),
(2435, 5, -627.736, -566.756, 27.9208, 100, 0, 0, 0),
(2435, 6, -652.486, -561.351, 26.2017, 100, 0, 0, 0),
(2435, 7, -668.636, -562.703, 25.3622, 100, 0, 0, 0),
(2435, 8, -680.996, -566.52, 25.2009, 100, 0, 0, 0),
(2435, 9, -693.22, -569.418, 24.4536, 100, 0, 0, 0),
(2435, 10, -723.958, -551.954, 20.5542, 100, 0, 0, 0),
(2435, 11, -764.897, -546.37, 17.9831, 100, 0, 0, 0),
(2435, 12, -809.579, -528.999, 15.3876, 100, 0, 0, 0),
(2435, 13, -821.22, -524.994, 13.8281, 100, 0, 0, 0),
(2435, 14, -856.326, -532.717, 9.74993, 100, 30000, 5, 243501);

DELETE FROM `creature_movement_scripts` WHERE `id`=243501;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 620, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text'),
(243501, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 621, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243511, -1, 9, -787.574, -504.358, 18.9435, 5.79449, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243510, -1, 9, -787.598, -505.655, 18.9435, 6.05629, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243512, -1, 9, -726.914, -575.805, 25.4761, 4.03917, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243512, -1, 9, -726.371, -574.912, 25.5261, 4.16828, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243505, -1, 9, -877.416, -574.223, 11.5033, 1.0821, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243504, -1, 9, -874.746, -573.897, 11.6758, 2.28638, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243509, -1, 9, -817.583, -505.381, 15.2609, 3.03687, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243508, -1, 9, -818.436, -503.501, 15.3768, 3.71755, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243503, -1, 9, -850.748, -561.89, 11.6908, 3.14159, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243502, -1, 9, -852.268, -560.181, 11.6908, 3.82227, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243507, -1, 9, -863.394, -494.436, 13.4375, 5.53269, 0, 'Summon Creature Southshore Guard'),
(243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 0, 243506, -1, 9, -863.81, -496.398, 13.4382, 5.34071, 0, 'Summon Creature Southshore Guard'),
(243501, 21, 15, 2596, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Cast Spell Touch of the Black Claw'),
(243501, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 626, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text'),
(243501, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 623, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243513, -1, 9, -775.028, -681.441, 10.5779, 0.763972, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243513, -1, 9, -774.61, -682.655, 10.2871, 0.20944, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243514, -1, 9, -874.898, -543.902, 8.1009, 2.6314, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243514, -1, 9, -874.686, -543.904, 8.11303, 2.65715, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243515, -1, 9, -722.296, -626.843, 21.2373, 4.2949, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243515, -1, 9, -722.225, -627.343, 21.2852, 5.99603, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243516, -1, 9, -863.397, -420.184, 12.1807, 5.33287, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243516, -1, 9, -862.454, -416.289, 12.1807, 3.79291, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243517, -1, 9, -757.291, -425, 20.5991, 4.43955, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243517, -1, 9, -759.857, -421.127, 20.7913, 3.24438, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243518, -1, 9, -830.498, -675.663, 11.4526, 1.83392, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243518, -1, 9, -832.882, -666.844, 12.3942, 1.82468, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243519, -1, 9, -775.546, -441.894, 21.8413, 0.456332, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243519, -1, 9, -781.113, -441.065, 21.0467, 2.06222, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243520, -1, 9, -879.583, -506.974, 12.0944, 4.32519, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243520, -1, 9, -879.434, -507.08, 12.0944, 1.861, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243521, -1, 9, -863.649, -538.335, 8.72452, 0.311862, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243521, -1, 9, -860.799, -537.438, 9.01221, 0.313721, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243522, -1, 9, -864.073, -420.33, 12.208, 5.61996, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243522, -1, 9, -862.443, -418.923, 12.1787, 5.51524, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243523, -1, 9, -826.355, -514.603, 13.2019, 3.24146, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243523, -1, 9, -826.566, -514.741, 13.1909, 3.22376, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243524, -1, 9, -772.994, -529.219, 20.8964, 5.34041, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243524, -1, 9, -773.472, -526.871, 21.3032, 4.91285, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243525, -1, 9, -915.314, -416.524, 8.04292, 5.74213, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243525, -1, 9, -915.724, -418.445, 7.44239, 4.92183, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243526, -1, 9, -776.995, -681.734, 10.645, 1.14385, 0, 'Summon Creature Shadowy Assassin'),
(243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 0, 243526, -1, 9, -769.896, -676.539, 11.8627, 0.92749, 0, 'Summon Creature Shadowy Assassin'),
(243501, 27, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Despawn Creature');

-- Spawn Scripts and Waypoints for Creature Southshore Guards
DELETE FROM `generic_scripts` WHERE `id`=243502;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243502, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243502, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(238601, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 611, 612, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Speak');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243502, 1, -852.268, -560.181, 11.6908, 100, 0, 0, 11),
(243502, 2, -852.268, -560.181, 11.6908, 100, 0, 0, 238601),
(243502, 3, -849.097, -544.966, 11.1183, 100, 0, 0, 0),
(243502, 4, -870.534, -538.675, 8.21938, 100, 0, 0, 0),
(243502, 5, -902.927, -544.349, 6.87962, 100, 0, 0, 0),
(243502, 6, -900.795, -545.331, 6.87962, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243503;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243503, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243503, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243503, 1, -850.748, -561.89, 11.6908, 100, 0, 0, 11),
(243503, 2, -852.268, -560.181, 11.6916, 100, 0, 0, 0),
(243503, 3, -849.385, -552, 11.6751, 100, 0, 0, 0),
(243503, 4, -866.533, -538.207, 8.49329, 100, 0, 0, 0),
(243503, 5, -885.609, -542.527, 7.21792, 100, 0, 0, 0),
(243503, 6, -897.598, -544.321, 6.87962, 100, 0, 0, 0),
(243503, 7, -902.318, -544.345, 6.87962, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243504;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243504, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243504, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243504, 1, -874.746, -573.897, 11.6758, 100, 0, 0, 11),
(243504, 2, -878.976, -614.334, 6.35845, 100, 0, 0, 0),
(243504, 3, -867.666, -629.993, 7.5186, 100, 0, 0, 0),
(243504, 4, -867.149, -645.85, 10.1492, 100, 0, 0, 0),
(243504, 5, -843.583, -645.406, 16.4311, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243505;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243505, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243505, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243505, 1, -877.416, -574.223, 11.5033, 100, 0, 0, 11),
(243505, 2, -874.746, -573.897, 11.5886, 100, 0, 0, 0),
(243505, 3, -880.854, -580.928, 10.979, 100, 0, 0, 0),
(243505, 4, -879.883, -593.102, 9.9001, 100,0, 0, 0),
(243505, 5, -879.029, -612.981, 6.19609, 100, 0, 0, 0),
(243505, 6, -870.367, -626.243, 6.61821, 100, 0, 0, 0),
(243505, 7, -841.871, -640.051, 16.0813, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243506;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243506, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243506, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243506, 1, -863.81, -496.398, 13.4382, 100, 0, 0, 11),
(243506, 2, -863.81, -496.398, 13.4382, 100, 0, 0, 238601),
(243506, 3, -860.563, -520.896, 10.9899, 100, 0, 0, 0),
(243506, 4, -830.389, -520.065, 12.4591, 100, 0, 0, 0),
(243506, 5, -833.688, -496.637, 16.5962, 100, 0, 0, 0),
(243506, 6, -840.332, -462.552, 11.3648, 100, 0, 0, 0),
(243506, 7, -860.812, -449.905, 11.5171, 100, 0, 0, 0),
(243506, 8, -876.748, -424.008, 10.6959, 100, 0, 0, 0),
(243506, 9, -880.01, -417.176, 10.6465, 100, 0, 0, 0),
(243506, 10, -880.184, -419.371, 10.3621, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243507;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243507, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243507, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243507, 1, -863.394, -494.436, 13.4375, 100, 0, 0, 11),
(243507, 2, -863.81, -496.398, 13.3538, 100, 0, 0, 0),
(243507, 3, -860.937, -513.684, 11.06, 100, 0, 0, 0),
(243507, 4, -858.475, -524.878, 10.5119, 100, 0, 0, 0),
(243507, 5, -846.201, -526.387, 11.0783, 100, 0, 0, 0),
(243507, 6, -830.803, -517.105, 12.6693, 100, 0, 0, 0),
(243507, 7, -835.686, -485.885, 14.7551, 100, 0, 0, 0),
(243507, 8, -838.85, -470.139, 12.0356, 100, 0, 0, 0),
(243507, 9, -861.375, -429.504, 11.5338, 100, 0, 0, 0),
(243507, 10, -873.529, -420.94, 11.4227, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243508;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243508, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243508, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243508, 1, -818.436, -503.501, 15.3768, 100, 0, 0, 11),
(243508, 2, -811.192, -524.215, 15.4196, 100, 0, 0, 0),
(243508, 3, -806.47, -510.165, 17.7401, 100, 0, 0, 0),
(243508, 4, -796.442, -477.976, 17.3567, 100, 0, 0, 0),
(243508, 5, -801.218, -460.606, 16.3138, 100, 0, 0, 0),
(243508, 6, -801.012, -446.868, 17.879, 100, 0, 0, 0),
(243508, 7, -794.068, -432.563, 19.2965, 100, 0, 0, 0),
(243508, 8, -791.534, -432.07, 19.6855, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243509;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243509, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243509, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243509, 1, -817.583, -505.381, 15.2609, 100, 0, 0, 11),
(243509, 2, -818.436, -503.501, 15.3109, 100, 0, 0, 0),
(243509, 3, -839.998, -531.01, 11.9814, 100, 0, 0, 0),
(243509, 4, -797.96, -539.399, 16.3528, 100, 0, 0, 0),
(243509, 5, -809.075, -517.918, 16.528, 100, 0, 0, 0),
(243509, 6, -796.521, -471.88, 16.6262, 100, 0, 0, 0),
(243509, 7, -785.893, -449.136, 22.1255, 100, 0, 0, 0),
(243509, 8, -796.634, -433.713, 18.7880, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243510;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243510, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243510, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243510, 1, -787.598, -505.655, 18.9435, 100, 0, 0, 11),
(243510, 2, -782.269, -509.026, 18.8601, 100, 0, 0, 0),
(243510, 3, -788.217, -517.664, 17.7153, 100, 0, 0, 0),
(243510, 4, -799.213, -527.854, 16.7172, 100, 0, 0, 0),
(243510, 5, -797.417, -534.636, 16.543, 100, 0, 0, 0),
(243510, 6, -784.416, -541.493, 18.103, 100, 0, 0, 0),
(243510, 7, -763.778, -545.218, 17.9648, 100, 0, 0, 0),
(243510, 8, -744.096, -534.273, 20.9565, 100, 0, 0, 0),
(243510, 9, -733.027, -533.149, 22.9293, 100, 0, 0, 0),
(243510, 10, -734.124, -532.319, 22.8824, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243511;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243511, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 243511, 0, 0, 0, 0, 0, 0, 0, 'Southshore Guard - Start Waypoints');
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(243511, 1, -787.574, -504.358, 18.9435, 100, 0, 0, 11),
(243511, 2, -784.115, -504.936, 18.8601, 100, 0, 0, 0),
(243511, 3, -782.467, -506.788, 18.8601, 100, 0, 0, 0),
(243511, 4, -782.93, -509.986, 18.8601, 100, 0, 0, 0),
(243511, 5, -788.478, -519.886, 17.7153, 100, 0, 0, 0),
(243511, 6, -792.481, -523.073, 17.7153, 100, 0, 0, 0),
(243511, 7, -795.157, -525.552, 17.5903, 100, 0, 0, 0),
(243511, 8, -801.297, -529.666, 16.3253, 100, 0, 0, 0),
(243511, 9, -800.868, -537.284, 16.0442, 100, 0, 0, 0),
(243511, 10, -795.949, -542.03, 16.4988, 100, 0, 0, 0),
(243511, 11, -788.061, -540.549, 17.6655, 100, 0, 0, 0),
(243511, 12, -783.011, -541.309, 18.1272, 100, 0, 0, 0),
(243511, 13, -776.883, -544.343, 18.0454, 100, 0, 0, 0),
(243511, 14, -768.136, -544.278, 17.9197, 100, 0, 0, 0),
(243511, 15, -760.135, -545.786, 18.2148, 100, 0, 0, 0),
(243511, 16, -753.148, -540.885, 18.996, 100, 0, 0, 0),
(243511, 17, -747.062, -535.458, 20.3122, 100, 0, 0, 0),
(243511, 18, -739.572, -531.611, 22.0098, 100, 0, 0, 0),
(243511, 19, -733.662, -533.042, 22.878, 100, 2100000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id`=243512;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243512, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Southshore Guard - Set Movement Type');

-- Spawn Scripts for Creature Shadowy Assassin
DELETE FROM `creature_movement_template` WHERE `entry` = 2434;
INSERT INTO `creature_movement_template` (`entry`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(2434, 1, -856.004, -529.716, 10.1312, 100, 0, 0, 0),
(2434, 2, -860.056, -516.084, 11.1381, 100, 0, 0, 0),
(2434, 3, -861.821, -497.294, 13.3546, 100, 0, 0, 0),
(2434, 4, -863.06, -492.887, 13.3547, 100, 0, 0, 0),
(2434, 5, -875.937, -484.004, 13.3554, 100, 0, 0, 0),
(2434, 6, -864.933, -476.367, 13.3554, 100, 600000, 3, 0);

DELETE FROM `generic_scripts` WHERE `id` BETWEEN 243513 AND 243526;
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243517, 180, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243518, 360, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243519, 540, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243520, 720, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243521, 900, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243522, 1080, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243523, 1260, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243524, 1440, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243525, 1620, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243526, 1800, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Start Waypoints'),
(243513, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243514, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243515, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243516, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243517, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243518, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243519, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243520, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243521, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243522, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243523, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243524, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243525, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type'),
(243526, 0, 20, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Set Movement Type');

-- Magistrate Henry Maleb Alive
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (2434, 20, 2276, 300, 0, 0, 2);
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243513, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243514, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243515, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243516, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243517, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243518, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243519, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243520, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243521, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243522, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243523, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243524, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243525, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk'),
(243526, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 2434, 'Shadowy Assassin - Talk');

-- Magistrate Henry Maleb Dead
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (2435, 20, 2276, 300, 1, 0, 2);
INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243513, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243514, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243515, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243516, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243517, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243518, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243519, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243520, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243521, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243522, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243523, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243524, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243525, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk'),
(243526, 2040, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 2435, 'Shadowy Assassin - Talk');

INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243513, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243514, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243515, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243516, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243517, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243518, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243519, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243520, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243521, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243522, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243523, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243524, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243525, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object'),
(243526, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 'Shadowy Assassin - Make Active Object');

-- Use Summon Flag To Set Active Object
DELETE FROM `creature_movement_scripts` WHERE `id`=243501;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 620, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 621, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243506, -1, 9, -863.81, -496.398, 13.4382, 5.34071, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243507, -1, 9, -863.394, -494.436, 13.4375, 5.53269, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243502, -1, 9, -852.268, -560.181, 11.6908, 3.82227, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243503, -1, 9, -850.748, -561.89, 11.6908, 3.14159, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243508, -1, 9, -818.436, -503.501, 15.3768, 3.71755, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243509, -1, 9, -817.583, -505.381, 15.2609, 3.03687, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243504, -1, 9, -874.746, -573.897, 11.6758, 2.28638, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243505, -1, 9, -877.416, -574.223, 11.5033, 1.0821, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243512, -1, 9, -726.371, -574.912, 25.5261, 4.16828, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243512, -1, 9, -726.914, -575.805, 25.4761, 4.03917, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243510, -1, 9, -787.598, -505.655, 18.9435, 6.05629, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 8, 10, 2386, 2100000, 0, 0, 0, 0, 0, 0, 2, 243511, -1, 9, -787.574, -504.358, 18.9435, 5.79449, 0, 'Summon Creature Southshore Guard');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 623, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 626, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Say Text');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 21, 15, 2596, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Cast Spell Touch of the Black Claw');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243520, -1, 9, -879.434, -507.08, 12.0944, 1.861, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243521, -1, 9, -863.649, -538.335, 8.72452, 0.311862, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243521, -1, 9, -860.799, -537.438, 9.01221, 0.313721, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243522, -1, 9, -864.073, -420.33, 12.208, 5.61996, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243522, -1, 9, -862.443, -418.923, 12.1787, 5.51524, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243523, -1, 9, -826.355, -514.603, 13.2019, 3.24146, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243523, -1, 9, -826.566, -514.741, 13.1909, 3.22376, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243524, -1, 9, -772.994, -529.219, 20.8964, 5.34041, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243524, -1, 9, -773.472, -526.871, 21.3032, 4.91285, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243525, -1, 9, -915.314, -416.524, 8.04292, 5.74213, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243525, -1, 9, -915.724, -418.445, 7.44239, 4.92183, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243526, -1, 9, -776.995, -681.734, 10.645, 1.14385, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243526, -1, 9, -769.896, -676.539, 11.8627, 0.92749, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243520, -1, 9, -879.583, -506.974, 12.0944, 4.32519, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243519, -1, 9, -781.113, -441.065, 21.0467, 2.06222, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243513, -1, 9, -775.028, -681.441, 10.5779, 0.763972, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243513, -1, 9, -774.61, -682.655, 10.2871, 0.20944, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243514, -1, 9, -874.898, -543.902, 8.1009, 2.6314, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243514, -1, 9, -874.686, -543.904, 8.11303, 2.65715, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243515, -1, 9, -722.296, -626.843, 21.2373, 4.2949, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243515, -1, 9, -722.225, -627.343, 21.2852, 5.99603, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243516, -1, 9, -863.397, -420.184, 12.1807, 5.33287, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243516, -1, 9, -862.454, -416.289, 12.1807, 3.79291, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243517, -1, 9, -757.291, -425, 20.5991, 4.43955, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243517, -1, 9, -759.857, -421.127, 20.7913, 3.24438, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243518, -1, 9, -830.498, -675.663, 11.4526, 1.83392, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243518, -1, 9, -832.882, -666.844, 12.3942, 1.82468, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 22, 10, 2434, 2100000, 0, 0, 0, 0, 0, 0, 2, 243519, -1, 9, -775.546, -441.894, 21.8413, 0.456332, 0, 'Summon Creature Shadowy Assassin');
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (243501, 27, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Southshore Crier - Despawn Creature');
DELETE FROM `generic_scripts` WHERE `id` BETWEEN 243513 AND 243526 AND `command` = 21;

-- Move Talk Commands To Creature Movement Scripts
DELETE FROM `generic_scripts` WHERE `id` BETWEEN 243513 AND 243526 AND `command` = 0;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243501, 2040, 68, 243527, 2, 2434, 500, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 2434, 'Southshore Crier - Start Script For All'),
(243501, 2040, 68, 243528, 2, 2434, 500, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 2435, 'Southshore Crier - Start Script For All');

INSERT INTO `generic_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(243527, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 633, 634, 635, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Talk'),
(243528, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 630, 631, 632, 0, 0, 0, 0, 0, 0, 'Shadowy Assassin - Talk');

-- Update chat type for texts.
UPDATE `broadcast_text` SET `chat_type`=1 WHERE `entry` IN (1452, 1517, 1518, 1522, 2124, 8240);

-- Correct creature data.
UPDATE `creature_template` SET `ai_name`='EventAI' WHERE `entry` IN (4419, 4252, 4251);
UPDATE `creature_template` SET `flags_extra`=33554434 WHERE `entry` IN (4507); 
UPDATE `creature` SET `spawn_flags`=1 WHERE `guid` IN (21680, 21682, 21681, 21549, 21145); -- Make them active or the script fails like on Classic ERA.
UPDATE `creature_template` SET `auras`=NULL WHERE `entry` IN (4252, 4251); -- Auras are applied every 5 seconds anyway.
UPDATE `creature_template` SET `speed_run`=2.79286 WHERE `entry` IN (4252, 4251); -- This is the original speed of the racer, maybe the sniffed creature_template shows a different speed but that depends on the aura they have.

-- Events list for Gnome Racer
DELETE FROM `creature_ai_events` WHERE `creature_id`=4252;
INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
(425201, 4252, 0, 1, 1, 100, 3, 5000, 5000, 5000, 5000, 425201, 425202, 425203, 'Mirage Race: Gnome Racer - Apply Random Speed Aura');

-- Events list for Goblin Racer
DELETE FROM `creature_ai_events` WHERE `creature_id`=4251;
INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
(425101, 4251, 0, 1, 1, 100, 3, 5000, 5000, 5000, 5000, 425201, 425202, 425203, 'Mirage Race: Goblin Racer - Apply Random Speed Aura');

DELETE FROM `creature_ai_scripts` WHERE `id`=425201;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425201, 0, 15, 6601, 34, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Random Aura: Cast Spell Salt Flats Racer Slow');
DELETE FROM `creature_ai_scripts` WHERE `id`=425202;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425202, 0, 15, 6602, 34, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Random Aura: Cast Spell Salt Flats Racer Normal');
DELETE FROM `creature_ai_scripts` WHERE `id`=425203;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425203, 0, 15, 6600, 34, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Random Aura: Cast Spell Salt Flats Racer Speed');

-- Events list for Race Master Kronkrider
DELETE FROM `creature_ai_events` WHERE `creature_id`=4419;
INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
(441901, 4419, 0, 1, 0, 100, 1, 1080000, 1080000, 1080000, 1080000, 441901, 0, 0, 'Mirage Race: Race Master Kronkrider - Yelling 2 minutes'),
(441902, 4419, 0, 1, 0, 100, 1, 1200000, 1200000, 1080000, 1080000, 441902, 0, 0, 'Mirage Race: Race Master Kronkrider - Yelling 1 minute'),
(441903, 4419, 0, 1, 0, 100, 1, 1260000, 1260000, 1080000, 1080000, 441903, 0, 0, 'Mirage Race: Race Master Kronkrider - Start Script on Fobeed to Start Race'),
(441904, 4419, 0, 1, 0, 100, 1, 1258000, 1258000, 1080000, 1080000, 441904, 0, 0, 'Mirage Race: Race Master Kronkrider - Start Script on Daisy to Emote');

DELETE FROM `creature_ai_scripts` WHERE `id`=441901;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(441901, 0, 0, 0, 0, 0, 0, 0, 21585, 0, 9, 2, 1655, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Gnome Pit Boss  - Say Text'),
(441901, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8240, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Race Master Kronkrider - Say Text');

DELETE FROM `creature_ai_scripts` WHERE `id`=441902;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(441902, 0, 0, 60, 3, 0, 0, 0, 21680, 0, 9, 2, 0, 4241, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Goblin Racer - Move to start position'),
(441902, 0, 0, 60, 3, 0, 0, 0, 21682, 0, 9, 2, 0, 4242, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Gnome Racer  - Move to start position'),
(441902, 0, 0, 60, 3, 0, 0, 0, 21681, 0, 9, 2, 0, 4507, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Move to start position'),
(441902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1452, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Race Master Kronkrider - Say Text');

DELETE FROM `creature_ai_scripts` WHERE `id`=441903;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(441903, 0, 0, 60, 3, 0, 0, 0, 21682, 0, 9, 2, 0, 4252, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Gnome Racer - Start Waypoints'),
(441903, 0, 0, 60, 3, 0, 0, 0, 21680, 0, 9, 2, 0, 4251, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Goblin Racer - Start Waypoints'),
(441903, 0, 0, 0, 0, 0, 0, 0, 21145, 0, 9, 2, 2124, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Fobeed - Say Text'),
(441903, 0, 0, 1, 36, 0, 0, 0, 21681, 0, 9, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Emote OneShotAttack1H');

DELETE FROM `creature_ai_scripts` WHERE `id`=441904;
INSERT INTO `creature_ai_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(441904, 0, 39, 2168101, 0, 0, 0, 21681, 0, 9, 2, 100, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Start Script to Play Emotes');

-- Daisy emotes
DELETE FROM `generic_scripts` WHERE `id`=2168101;
INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(2168101, 0, 0, 1, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Emote OneShotWaveNoSheathe (70)'),
(2168101, 5, 0, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6.24828, 0, 'Mirage Race: Daisy - Change Orientation'),
(2168101, 7, 0, 1, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Emote OneShotCheerNoSheathe (71)'),
(2168101, 7, 0, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Set Sheath State to Unarmed'),
(2168101, 9, 0, 60, 3, 0, 0, 0, 0, 0, 0, 0, 0, 4508, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Run Back to Camp'),
(2168101, 10, 0, 1, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Emote OneShotCheer (4)');

-- Daisy Change sheath
DELETE FROM `creature_movement_scripts` WHERE `id`=450704;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(450704, 0, 51, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Daisy - Set Sheath State to Melee');

-- Daisy orientation after waypoints
DELETE FROM `creature_movement_scripts` WHERE `id`=450705;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(450705, 1, 35, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.14159, 0, 'Mirage Race: Daisy - Set Orientation');

-- Cast Salt Flats Racer Speed
DELETE FROM `creature_movement_scripts` WHERE `id`=425201;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425201, 0, 0, 15, 6602, 2, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Goblin or Gnomish Racer - Cast Salt Flats Racer Normal'),
(425201, 5, 0, 44, 1, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Goblin or Gnomish Racer - Set Phase to 1');

-- Fobeed yells after 1 round
DELETE FROM `creature_movement_scripts` WHERE `id`=425202;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425202, 0, 0, 0, 0, 0, 0, 0, 21145, 0, 9, 3, 1517, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Fobeed - Yell After First Lap');

-- Race Master Kronkrider Goblin win!
DELETE FROM `creature_movement_scripts` WHERE `id`=425205;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425205, 0, 0, 61, 4419, 300, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Goblin Finished:  Start Ending Game Event'),
(425205, 0, 1, 0, 0, 0, 0, 0, 21549, 0, 9, 2, 1522, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Goblin Finished:  Race Master Kronkrider - Yell Text');

-- Race Master Kronkrider Goblin win!
DELETE FROM `creature_movement_scripts` WHERE `id`=425206;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425206, 0, 0, 61, 4419, 300, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Gnome Finished:  Start Ending Game Event'),
(425206, 0, 1, 0, 0, 0, 0, 0, 21549, 0, 9, 2, 1518, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race Gnome Finished:  Race Master Kronkrider - Yell Text');

-- Prevent racers from applying speed auras once the event is over.
DELETE FROM `creature_movement_scripts` WHERE `id`=425207;
INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(425207, 0, 0, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mirage Race: Goblin or Gnomish Racer - Set Phase to 0');

-- Daisy runs to the start Position
DELETE FROM `creature_movement_special` WHERE `id`=4507;
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(4507, 1, -6199.950195, -3927.719971, -58.657001, 100.000000, 0, 0.000000, 0),
(4507, 2, -6185.709961, -3926.020020, -58.657001, 100.000000, 0, 0.000000, 0),
(4507, 3, -6183.350098, -3917.530029, -58.782001, 100.000000, 0, 0.000000, 0),
(4507, 4, -6179.439941, -3902.909912, -60.032001, 100.000000, 0, 0.000000, 450704),
(4507, 5, -6178.939941, -3901.570068, -60.067101, 100.000000, 0, 0.000000, 450705);

-- Daisy runs back to the camp
DELETE FROM `creature_movement_special` WHERE `id`=4508;
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(4508, 1, -6210.669922, -3909.889893, -60.344799, 100.000000, 0, 0.000000, 0),
(4508, 2, -6221.080078, -3930.320068, -58.719799, 100.000000, 0, 0.000000, 0);

-- Goblin Racer to the start Position
DELETE FROM `creature_movement_special` WHERE `id`=4241;
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(4241, 1, -6237.240234, -3917.989990, -59.258099, 100.000000, 0, 0.000000, 13), -- walking
(4241, 2, -6257.910156, -3921.560059, -58.729599, 100.000000, 0, 0.000000, 0),
(4241, 3, -6277.290039, -3923.429932, -58.739300, 100.000000, 0, 0.000000, 0),
(4241, 4, -6285.640137, -3908.280029, -62.364300, 100.000000, 0, 0.000000, 0),
(4241, 5, -6265.839844, -3904.729980, -61.938499, 100.000000, 0, 0.000000, 0),
(4241, 6, -6236.060059, -3906.439941, -60.604599, 100.000000, 0, 0.000000, 0),
(4241, 7, -6202.140137, -3906.530029, -60.219799, 100.000000, 0, 0.000000, 11); -- running

-- Gnome Racer to the start Position
DELETE FROM `creature_movement_special` WHERE `id`=4242;
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(4242, 1, -6209.330078, -3869.939941, -58.493801, 100.000000, 0, 0.000000, 13), -- walking
(4242, 2, -6225.089844, -3885.040039, -58.862598, 100.000000, 0, 0.000000, 0),
(4242, 3, -6250.220215, -3883.010010, -59.253201, 100.000000, 0, 0.000000, 0),
(4242, 4, -6269.910156, -3876.899902, -58.739300, 100.000000, 0, 0.000000, 0),
(4242, 5, -6289.490234, -3876.360107, -58.739300, 100.000000, 0, 0.000000, 0),
(4242, 6, -6294.500000, -3887.939941, -61.835701, 100.000000, 0, 0.000000, 0),
(4242, 7, -6274.609863, -3902.090088, -62.129700, 100.000000, 0, 0.000000, 0),
(4242, 8, -6260.160156, -3899.000000, -61.511501, 100.000000, 0, 0.000000, 0),
(4242, 9, -6249.899902, -3897.959961, -61.104599, 100.000000, 0, 0.000000, 0),
(4242, 10, -6233.859863, -3898.100098, -60.479599, 100.000000, 0, 0.000000, 0),
(4242, 11, -6223.339844, -3897.280029, -60.469799, 100.000000, 0, 0.000000, 0),
(4242, 12, -6200.759766, -3897.639893, -60.219799, 100.000000, 0, 0.000000, 11); -- running

-- Goblin Racer race waypoints
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(4251, 1, -6133.25, -3905.81, -59.842, 100, 0, 0.000000, 425201), -- Casting speed normal
(4251, 2, -6100.07, -3903.81, -59.717, 100, 0, 0.000000, 0),
(4251, 3, -6066.56, -3890.28, -59.795, 100, 0, 0.000000, 0),
(4251, 4, -6033.41, -3874.38, -59.9739, 100, 0, 0.000000, 0),
(4251, 5, -6000.01, -3857.21, -60.4537, 100, 0, 0.000000, 0),
(4251, 6, -5966.54, -3844.55, -60.6732, 100, 0, 0.000000, 0),
(4251, 7, -5933.4, -3824.23, -60.2982, 100, 0, 0.000000, 0),
(4251, 8, -5900.04, -3804.14, -59.6029, 100, 0, 0.000000, 0),
(4251, 9, -5866.87, -3793.61, -59.9385, 100, 0, 0.000000, 0),
(4251, 10, -5833.32, -3785.51, -61.0959, 100, 0, 0.000000, 0),
(4251, 11, -5799.98, -3787.21, -61.3648, 100, 0, 0.000000, 0),
(4251, 12, -5766.63, -3789.59, -61.7069, 100, 0, 0.000000, 0),
(4251, 13, -5733.34, -3797.22, -60.1085, 100, 0, 0.000000, 0),
(4251, 14, -5700.21, -3818.07, -61.6014, 100, 0, 0.000000, 0),
(4251, 15, -5685.05, -3833.11, -62.2498, 100, 0, 0.000000, 0),
(4251, 16, -5667.55, -3866.56, -62.115, 100, 0, 0.000000, 0),
(4251, 17, -5657.73, -3900, -61.5334, 100, 0, 0.000000, 0),
(4251, 18, -5653.18, -3933.22, -61.2834, 100, 0, 0.000000, 0),
(4251, 19, -5652.29, -3966.78, -61.0573, 100, 0, 0.000000, 0),
(4251, 20, -5650.53, -3999.94, -61.0573, 100, 0, 0.000000, 0),
(4251, 21, -5649.08, -4033.48, -61.0075, 100, 0, 0.000000, 0),
(4251, 22, -5648.3, -4066.6, -61.1325, 100, 0, 0.000000, 0),
(4251, 23, -5652.44, -4099.81, -61.3576, 100, 0, 0.000000, 0),
(4251, 24, -5671.46, -4133.38, -61.5347, 100, 0, 0.000000, 0),
(4251, 25, -5700.07, -4163.42, -60.3869, 100, 0, 0.000000, 0),
(4251, 26, -5733.37, -4176.76, -61.1795, 100, 0, 0.000000, 0),
(4251, 27, -5766.62, -4185.85, -61.4295, 100, 0, 0.000000, 0),
(4251, 28, -5800.16, -4191.41, -61.2359, 100, 0, 0.000000, 0),
(4251, 29, -5833.34, -4195.89, -62.0493, 100, 0, 0.000000, 0),
(4251, 30, -5866.64, -4196.89, -62.5493, 100, 0, 0.000000, 0),
(4251, 31, -5900.04, -4198.67, -62.8084, 100, 0, 0.000000, 0),
(4251, 32, -5933.33, -4199.23, -62.4698, 100, 0, 0.000000, 0),
(4251, 33, -5966.7, -4198.22, -62.1368, 100, 0, 0.000000, 0),
(4251, 34, -6000.16, -4197.21, -62.3337, 100, 0, 0.000000, 0),
(4251, 35, -6033.43, -4192.26, -62.5678, 100, 0, 0.000000, 0),
(4251, 36, -6066.48, -4187.53, -62.4428, 100, 0, 0.000000, 0),
(4251, 37, -6099.93, -4185.41, -62.1514, 100, 0, 0.000000, 0),
(4251, 38, -6133.35, -4185.92, -62.2596, 100, 0, 0.000000, 0),
(4251, 39, -6166.59, -4185.99, -61.6346, 100, 0, 0.000000, 0),
(4251, 40, -6199.97, -4193.5, -61.6038, 100, 0, 0.000000, 0),
(4251, 41, -6233.26, -4199.52, -61.5478, 100, 0, 0.000000, 0),
(4251, 42, -6266.7, -4207.48, -61.4769, 100, 0, 0.000000, 0),
(4251, 43, -6299.9, -4213.6, -61.1764, 100, 0, 0.000000, 0),
(4251, 44, -6333.38, -4215.57, -62.9005, 100, 0, 0.000000, 0),
(4251, 45, -6366.73, -4201.02, -61.1156, 100, 0, 0.000000, 0),
(4251, 46, -6384.84, -4186.21, -62.0015, 100, 0, 0.000000, 0),
(4251, 47, -6399.94, -4166.67, -62.8765, 100, 0, 0.000000, 0),
(4251, 48, -6414.76, -4133.3, -63.8719, 100, 0, 0.000000, 0),
(4251, 49, -6423.5, -4099.96, -63.7193, 100, 0, 0.000000, 0),
(4251, 50, -6429.27, -4066.76, -63.3443, 100, 0, 0.000000, 0),
(4251, 51, -6431.57, -4033.34, -63.0729, 100, 0, 0.000000, 0),
(4251, 52, -6430.09, -3999.91, -62.7196, 100, 0, 0.000000, 0),
(4251, 53, -6424.76, -3966.61, -62.7063, 100, 0, 0.000000, 0),
(4251, 54, -6414.58, -3943.41, -62.4563, 100, 0, 0.000000, 0),
(4251, 55, -6399.93, -3921.42, -61.8507, 100, 0, 0.000000, 0),
(4251, 56, -6366.61, -3906.05, -62.0885, 100, 0, 0.000000, 0),
(4251, 57, -6333.58, -3904.51, -62.4635, 100, 0, 0.000000, 0),
(4251, 58, -6300.12, -3902.57, -62.9893, 100, 0, 0.000000, 0),
(4251, 59, -6266.81, -3903.56, -61.7393, 100, 0, 0.000000, 0),
(4251, 60, -6233.3, -3899.03, -60.4698, 100, 0, 0.000000, 0),
(4251, 61, -6199.96, -3902.02, -60.157, 100, 0, 0.000000, 425202), -- Second turn begins
(4251, 62, -6166.72, -3901.35, -59.907, 100, 0, 0.000000, 0),
(4251, 63, -6133.35, -3901.26, -59.805, 100, 0, 0.000000, 0),
(4251, 64, -6100, -3899.35, -59.9679, 100, 0, 0.000000, 0),
(4251, 65, -6066.71, -3885.39, -60.0929, 100, 0, 0.000000, 0),
(4251, 66, -6033.36, -3869.34, -60.2654, 100, 0, 0.000000, 0),
(4251, 67, -6000.08, -3852.77, -60.4537, 100, 0, 0.000000, 0),
(4251, 68, -5966.72, -3840.43, -60.6262, 100, 0, 0.000000, 0),
(4251, 69, -5933.36, -3819.05, -60.1732, 100, 0, 0.000000, 0),
(4251, 70, -5900.03, -3799.97, -59.5531, 100, 0, 0.000000, 0),
(4251, 71, -5866.73, -3788.14, -60.109, 100, 0, 0.000000, 0),
(4251, 72, -5833.23, -3780.58, -61.1572, 100, 0, 0.000000, 0),
(4251, 73, -5800.01, -3781.26, -61.4072, 100, 0, 0.000000, 0),
(4251, 74, -5766.64, -3784.14, -61.5871, 100, 0, 0.000000, 0),
(4251, 75, -5733.32, -3792.87, -60.6395, 100, 0, 0.000000, 0),
(4251, 76, -5699.85, -3809.45, -61.1524, 100, 0, 0.000000, 0),
(4251, 77, -5677.42, -3833.19, -62.2948, 100, 0, 0.000000, 0),
(4251, 78, -5661.52, -3866.65, -61.8848, 100, 0, 0.000000, 0),
(4251, 79, -5652.25, -3900.14, -61.5334, 100, 0, 0.000000, 0),
(4251, 80, -5648.28, -3933.37, -61.1612, 100, 0, 0.000000, 0),
(4251, 81, -5648.34, -3966.84, -61.0573, 100, 0, 0.000000, 0),
(4251, 82, -5646.43, -3999.94, -61.0573, 100, 0, 0.000000, 0),
(4251, 83, -5644.9, -4033.34, -61.0075, 100, 0, 0.000000, 0),
(4251, 84, -5644.26, -4066.68, -61.2326, 100, 0, 0.000000, 0),
(4251, 85, -5648.3, -4099.86, -61.3576, 100, 0, 0.000000, 0),
(4251, 86, -5666.31, -4133.83, -61.4967, 100, 0, 0.000000, 0),
(4251, 87, -5696.92, -4166.7, -60.3329, 100, 0, 0.000000, 0),
(4251, 88, -5733.32, -4183.08, -61.4814, 100, 0, 0.000000, 0),
(4251, 89, -5766.7, -4191.44, -61.4497, 100, 0, 0.000000, 0),
(4251, 90, -5800.08, -4196.07, -61.2359, 100, 0, 0.000000, 0),
(4251, 91, -5833.32, -4200.6, -61.9859, 100, 0, 0.000000, 0),
(4251, 92, -5866.61, -4201.61, -62.5493, 100, 0, 0.000000, 0),
(4251, 93, -5899.97, -4203.64, -62.7825, 100, 0, 0.000000, 0),
(4251, 94, -5933.19, -4203.1, -62.5584, 100, 0, 0.000000, 0),
(4251, 95, -5966.68, -4203.19, -62.1368, 100, 0, 0.000000, 0),
(4251, 96, -6000.1, -4202.21, -62.3337, 100, 0, 0.000000, 0),
(4251, 97, -6033.48, -4197.92, -62.5678, 100, 0, 0.000000, 0),
(4251, 98, -6066.75, -4192.29, -62.2764, 100, 0, 0.000000, 0),
(4251, 99, -6099.97, -4190.12, -62.1514, 100, 0, 0.000000, 0),
(4251, 100,-6133.44, -4189.88, -62.2596, 100, 0, 0.000000, 0),
(4251, 101,-6166.76, -4189.73, -61.6038, 100, 0, 0.000000, 0),
(4251, 102,-6200.1, -4197.17, -61.5478, 100, 0, 0.000000, 0),
(4251, 103,-6233.42, -4204.05, -61.6202, 100, 0, 0.000000, 0),
(4251, 104,-6266.59, -4212.86, -61.4417, 100, 0, 0.000000, 0),
(4251, 105,-6300, -4219.36, -61.2755, 100, 0, 0.000000, 0),
(4251, 106,-6333.35, -4220.82, -62.9005, 100, 0, 0.000000, 0),
(4251, 107,-6377.85, -4199.63, -60.1673, 100, 0, 0.000000, 0),
(4251, 108,-6405.17, -4166.73, -63.0259, 100, 0, 0.000000, 0),
(4251, 109,-6421.51, -4133.32, -63.8106, 100, 0, 0.000000, 0),
(4251, 110,-6430.2, -4099.91, -63.7193, 100, 0, 0.000000, 0),
(4251, 111, -6435.36, -4066.73, -63.3589, 100, 0, 0.000000, 0),
(4251, 112, -6436.64, -4033.47, -63.0729, 100, 0, 0.000000, 0),
(4251, 113, -6435.22, -3999.96, -62.7196, 100, 0, 0.000000, 0),
(4251, 114, -6429.99, -3966.67, -62.7196, 100, 0, 0.000000, 0),
(4251, 115, -6414.23, -3933.37, -62.3313, 100, 0, 0.000000, 0),
(4251, 116, -6400.06, -3915.15, -61.7405, 100, 0, 0.000000, 0),
(4251, 117, -6366.74, -3901.17, -62.0463, 100, 0, 0.000000, 0),
(4251, 118, -6333.31, -3900.23, -62.429, 100, 0, 0.000000, 0),
(4251, 119, -6300.08, -3898.47, -62.9893, 100, 0, 0.000000, 0),
(4251, 120, -6266.67, -3898.97, -61.7393, 100, 0, 0.000000, 0),
(4251, 121, -6233.27, -3904.18, -60.4698, 100, 0, 0.000000, 13), -- Turn on walking
(4251, 122, -6195.02, -3906.6, -60.157, 100, 0, 0.000000, 425205), -- Goblin win
(4251, 123, -6166.91, -3905.76, -59.907, 100, 31000, 0.000000, 425207), -- Waiting position
(4251, 124, -6135.35, -3905.65, -59.805, 100, 0, 0.000000, 0), -- Return to camp
(4251, 125, -6123.58, -3901.43, -59.842, 100, 0, 0.000000, 0),
(4251, 126, -6116.44, -3888.03, -59.7954, 100, 0, 0.000000, 0),
(4251, 127, -6118.94, -3869.72, -58.6704, 100, 0, 0.000000, 0),
(4251, 128, -6144.71, -3851.75, -58.6251, 100, 0, 0.000000, 0),
(4251, 129, -6161.11, -3846.33, -58.6251, 100, 0, 0.000000, 0),
(4251, 130, -6184, -3850.08, -58.6251, 100, 0, 0.000000, 0),
(4251, 131, -6206.26, -3868.64, -58.7198, 100, 0, 0.000000, 0),
(4251, 132, -6225.77, -3882.67, -58.7198, 100, 0, 0.000000, 0),
(4251, 133, -6249.51, -3884.4, -59.5523, 100, 0, 0.000000, 0),
(4251, 134, -6269.09, -3883.56, -59.6353, 100, 0, 0.000000, 0),
(4251, 135, -6285.3, -3889.27, -62.0386, 100, 0, 0.000000, 0),
(4251, 136, -6293.79, -3902.07, -62.6817, 100, 0, 0.000000, 0),
(4251, 137, -6286.1, -3919.24, -59.1211, 100, 0, 0.000000, 0),
(4251, 138, -6267.81, -3937.63, -58.6251, 100, 0, 0.000000, 0),
(4251, 139, -6245.65, -3944.6, -58.6251, 100, 0, 0.000000, 0),
(4251, 140, -6225.51, -3941.11, -58.6251, 100, 0, 0.000000, 0); -- Parking position

-- Gnome Racer race waypoints
INSERT INTO `creature_movement_special` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES
(4252, 1, -6133.35, -3901.42, -59.805, 100, 0, 0.000000, 425201), -- Casting speed normal
(4252, 2, -6099.91, -3898.46, -59.9679, 100, 0, 0.000000, 0),
(4252, 3, -6066.67, -3884.78, -60.0929, 100, 0, 0.000000, 0),
(4252, 4, -6033.31, -3869.67, -60.2968, 100, 0, 0.000000, 0),
(4252, 5, -5999.87, -3851.73, -60.5012, 100, 0, 0.000000, 0),
(4252, 6, -5966.71, -3839.65, -60.6262, 100, 0, 0.000000, 0),
(4252, 7, -5933.39, -3820.98, -60.2982, 100, 0, 0.000000, 0),
(4252, 8, -5900.05, -3802.45, -59.6029, 100, 0, 0.000000, 0),
(4252, 9, -5866.5, -3788.73, -60.0765, 100, 0, 0.000000, 0),
(4252, 10, -5833.29, -3780.37, -61.1572, 100, 0, 0.000000, 0),
(4252, 11, -5800.03, -3781.42, -61.4072, 100, 0, 0.000000, 0),
(4252, 12, -5766.65, -3784.51, -61.5871, 100, 0, 0.000000, 0),
(4252, 13, -5733.2, -3793.67, -60.5443, 100, 0, 0.000000, 0),
(4252, 14, -5704.73, -3808.7, -61.2264, 100, 0, 0.000000, 0),
(4252, 15, -5677.43, -3833.24, -62.3016, 100, 0, 0.000000, 0),
(4252, 16, -5659.16, -3866.41, -61.9129, 100, 0, 0.000000, 0),
(4252, 17, -5651.55, -3900.01, -61.5334, 100, 0, 0.000000, 0),
(4252, 18, -5648.71, -3933.15, -61.2834, 100, 0, 0.000000, 0),
(4252, 19, -5647.5, -3966.49, -61.1612, 100, 0, 0.000000, 0),
(4252, 20, -5646.72, -4000.02, -61.0257, 100, 0, 0.000000, 0),
(4252, 21, -5645.38, -4033.45, -61.0075, 100, 0, 0.000000, 0),
(4252, 22, -5644.54, -4066.71, -61.2326, 100, 0, 0.000000, 0),
(4252, 23, -5649.04, -4100.04, -61.3591, 100, 0, 0.000000, 0),
(4252, 24, -5666.61, -4133.28, -61.4841, 100, 0, 0.000000, 0),
(4252, 25, -5680.22, -4152.24, -61.0347, 100, 0, 0.000000, 0),
(4252, 26, -5697.58, -4166.75, -60.4064, 100, 0, 0.000000, 0),
(4252, 27, -5716.81, -4178.95, -60.9487, 100, 0, 0.000000, 0),
(4252, 28, -5733.38, -4183.49, -61.3045, 100, 0, 0.000000, 0),
(4252, 29, -5766.69, -4191.3, -61.4497, 100, 0, 0.000000, 0),
(4252, 30, -5799.91, -4196, -61.1997, 100, 0, 0.000000, 0),
(4252, 31, -5833.25, -4199.12, -61.9859, 100, 0, 0.000000, 0),
(4252, 32, -5866.74, -4200.56, -62.6575, 100, 0, 0.000000, 0),
(4252, 33, -5900.13, -4202.18, -62.8084, 100, 0, 0.000000, 0),
(4252, 34, -5933.39, -4203.65, -62.4698, 100, 0, 0.000000, 0),
(4252, 35, -5966.55, -4204.89, -62.2198, 100, 0, 0.000000, 0),
(4252, 36, -5999.96, -4202.42, -62.2618, 100, 0, 0.000000, 0),
(4252, 37, -6033.31, -4196.95, -62.4587, 100, 0, 0.000000, 0),
(4252, 38, -6066.54, -4192.04, -62.27, 100, 0, 0.000000, 0),
(4252, 39, -6099.97, -4189.74, -62.1514, 100, 0, 0.000000, 0),
(4252, 40, -6133.38, -4188.98, -62.2596, 100, 0, 0.000000, 0),
(4252, 41, -6166.59, -4190.83, -61.6346, 100, 0, 0.000000, 0),
(4252, 42, -6200.08, -4196.06, -61.5478, 100, 0, 0.000000, 0),
(4252, 43, -6233.44, -4204.91, -61.6202, 100, 0, 0.000000, 0),
(4252, 44, -6266.61, -4214.26, -61.4398, 100, 0, 0.000000, 0),
(4252, 45, -6299.99, -4218.57, -61.1661, 100, 0, 0.000000, 0),
(4252, 46, -6366.58, -4207.5, -60.4598, 100, 0, 0.000000, 0),
(4252, 47, -6388.47, -4189.56, -61.2745, 100, 0, 0.000000, 0),
(4252, 48, -6421.38, -4133.46, -63.8622, 100, 0, 0.000000, 0),
(4252, 49, -6430.24, -4099.87, -63.7193, 100, 0, 0.000000, 0),
(4252, 50, -6435.72, -4066.49, -63.3229, 100, 0, 0.000000, 0),
(4252, 51, -6437.34, -4033.31, -63.0019, 100, 0, 0.000000, 0),
(4252, 52, -6434.35, -3999.77, -62.7196, 100, 0, 0.000000, 0),
(4252, 53, -6428.75, -3966.57, -62.7063, 100, 0, 0.000000, 0),
(4252, 54, -6413.36, -3933.6, -62.3313, 100, 0, 0.000000, 0),
(4252, 55, -6395.58, -3912.14, -61.5463, 100, 0, 0.000000, 0),
(4252, 56, -6366.69, -3902.2, -62.0463, 100, 0, 0.000000, 0),
(4252, 57, -6333.17, -3901.06, -62.4463, 100, 0, 0.000000, 0),
(4252, 58, -6299.98, -3898.26, -62.9893, 100, 0, 0.000000, 0),
(4252, 59, -6266.57, -3898.37, -61.7296, 100, 0, 0.000000, 0),
(4252, 60, -6233.34, -3905.97, -60.4796, 100, 0, 0.000000, 0),
(4252, 61, -6200.01, -3906.2, -60.2198, 100, 0, 0.000000, 425202), -- Second turn begins
(4252, 62, -6166.75, -3906.33, -59.907, 100, 0, 0.000000, 0),
(4252, 63, -6133.25, -3905.49, -59.842, 100, 0, 0.000000, 0),
(4252, 64, -6100.07, -3901.82, -59.717, 100, 0, 0.000000, 0),
(4252, 65, -6066.59, -3888.51, -60.0101, 100, 0, 0.000000, 0),
(4252, 66, -6033.25, -3873.88, -60.1191, 100, 0, 0.000000, 0),
(4252, 67, -5999.97, -3856.45, -60.5012, 100, 0, 0.000000, 0),
(4252, 68, -5966.69, -3843.97, -60.6262, 100, 0, 0.000000, 0),
(4252, 69, -5933.33, -3823.99, -60.2279, 100, 0, 0.000000, 0),
(4252, 70, -5900, -3806.01, -59.4796, 100, 0, 0.000000, 0),
(4252, 71, -5866.72, -3794.04, -59.8861, 100, 0, 0.000000, 0),
(4252, 72, -5833.33, -3785.03, -61.0765, 100, 0, 0.000000, 0),
(4252, 73, -5800.06, -3786.57, -61.2822, 100, 0, 0.000000, 0),
(4252, 74, -5766.56, -3790.04, -61.6447, 100, 0, 0.000000, 0),
(4252, 75, -5733.28, -3798.53, -59.9039, 100, 0, 0.000000, 0),
(4252, 76, -5707.86, -3812.45, -61.1522, 100, 0, 0.000000, 0),
(4252, 77, -5684.59, -3833.43, -62.24, 100, 0, 0.000000, 0),
(4252, 78, -5666.18, -3866.69, -62.0178, 100, 0, 0.000000, 0),
(4252, 79, -5658.49, -3900.12, -61.5334, 100, 0, 0.000000, 0),
(4252, 80, -5654.3, -3933.39, -61.1612, 100, 0, 0.000000, 0),
(4252, 81, -5653.73, -3966.71, -61.0573, 100, 0, 0.000000, 0),
(4252, 82, -5651.99, -4000.03, -61.0257, 100, 0, 0.000000, 0),
(4252, 83, -5649.12, -4033.43, -61.0075, 100, 0, 0.000000, 0),
(4252, 84, -5649.73, -4066.72, -61.2326, 100, 0, 0.000000, 0),
(4252, 85, -5653.35, -4099.68, -61.3576, 100, 0, 0.000000, 0),
(4252, 86, -5670.12, -4130.07, -61.5094, 100, 0, 0.000000, 0),
(4252, 87, -5681.78, -4147.25, -61.4097, 100, 0, 0.000000, 0),
(4252, 88, -5699.9, -4162.49, -60.3479, 100, 0, 0.000000, 0),
(4252, 89, -5715.94, -4172.07, -60.6601, 100, 0, 0.000000, 0),
(4252, 90, -5733.38, -4176.66, -61.1795, 100, 0, 0.000000, 0),
(4252, 91, -5766.69, -4185.95, -61.4497, 100, 0, 0.000000, 0),
(4252, 92, -5799.98, -4191.15, -61.1997, 100, 0, 0.000000, 0),
(4252, 93, -5833.27, -4195.06, -61.9859, 100, 0, 0.000000, 0),
(4252, 94, -5866.67, -4196.83, -62.6575, 100, 0, 0.000000, 0),
(4252, 95, -5900.02, -4198.79, -62.8084, 100, 0, 0.000000, 0),
(4252, 96, -5933.07, -4199.55, -62.5584, 100, 0, 0.000000, 0),
(4252, 97, -5966.77, -4199.54, -62.1368, 100, 0, 0.000000, 0),
(4252, 98, -5999.79, -4197.45, -62.2618, 100, 0, 0.000000, 0),
(4252, 99, -6033.2, -4191.87, -62.4587, 100, 0, 0.000000, 0),
(4252, 100, -6066.62, -4186.7, -62.2612, 100, 0, 0.000000, 0),
(4252, 101, -6100.1, -4185.15, -62.1614, 100, 0, 0.000000, 0),
(4252, 102, -6133.3, -4184.84, -62.228, 100, 0, 0.000000, 0),
(4252, 103, -6166.84, -4186.29, -61.6038, 100, 0, 0.000000, 0),
(4252, 104, -6199.87, -4192.75, -61.6038, 100, 0, 0.000000, 0),
(4252, 105, -6233.3, -4200.09, -61.5623, 100, 0, 0.000000, 0),
(4252, 106, -6266.83, -4209.08, -61.4769, 100, 0, 0.000000, 0),
(4252, 107, -6333.61, -4215.17, -62.9005, 100, 0, 0.000000, 0),
(4252, 108, -6366.72, -4200.08, -61.1156, 100, 0, 0.000000, 0),
(4252, 109, -6397.83, -4166.61, -62.8611, 100, 0, 0.000000, 0),
(4252, 110, -6415.05, -4133.32, -63.8719, 100, 0, 0.000000, 0),
(4252, 111, -6423.85, -4100, -63.7469, 100, 0, 0.000000, 0),
(4252, 112, -6430.66, -4066.52, -63.3229, 100, 0, 0.000000, 0),
(4252, 113, -6432.58, -4033.32, -63.0019, 100, 0, 0.000000, 0),
(4252, 114, -6430.55, -4000.06, -62.7519, 100, 0, 0.000000, 0),
(4252, 115, -6424.67, -3966.6, -62.7063, 100, 0, 0.000000, 0),
(4252, 116, -6409.12, -3933.43, -62.3313, 100, 0, 0.000000, 0),
(4252, 117, -6392.96, -3915.75, -61.5463, 100, 0, 0.000000, 0),
(4252, 118, -6366.69, -3906.5, -62.0463, 100, 0, 0.000000, 0),
(4252, 119, -6333.17, -3904.83, -62.6143, 100, 0, 0.000000, 0),
(4252, 120, -6300.04, -3902.83, -62.9893, 100, 0, 0.000000, 0),
(4252, 121, -6266.62, -3902.6, -61.7296, 100, 0, 0.000000, 0),
(4252, 122, -6233.63, -3898.84, -60.4796, 100, 0, 0.000000, 13), -- Turn on walking
(4252, 123, -6193.93, -3899.92, -60.157, 100, 0, 0.000000, 425206), -- Gnome wins
(4252, 124, -6166.57, -3896.82, -59.805, 100, 30000, 0.000000, 425207), -- Waiting position
(4252, 125, -6133.96, -3895.67, -59.805, 100, 0, 0.000000, 0), -- Return to camp
(4252, 126, -6124.58, -3890.32, -59.4468, 100, 0, 0.000000, 0),
(4252, 127, -6120.73, -3863.32, -58.6251, 100, 0, 0.000000, 0),
(4252, 128, -6130.06, -3844.84, -58.6251, 100, 0, 0.000000, 0),
(4252, 129, -6149.06, -3828.92, -58.6251, 100, 0, 0.000000, 0),
(4252, 130, -6168.33, -3815.06, -58.6251, 100, 0, 0.000000, 0),
(4252, 131, -6190.14, -3811.94, -58.6251, 100, 0, 0.000000, 0),
(4252, 132, -6204.73, -3819.14, -58.6251, 100, 0, 0.000000, 0),
(4252, 133, -6212.5, -3830.33, -58.6251, 100, 0, 0.000000, 0),
(4252, 134, -6213.92, -3839.95, -58.6251, 100, 0, 0.000000, 0),
(4252, 135, -6213.07, -3849.85, -58.6251, 100, 0, 0.000000, 0); -- Parking position

UPDATE `gameobject_template` SET `script_name`='' WHERE `entry` = 179879;

-- Add Orb of Command Gossip (credit cmangos)
INSERT INTO `gossip_menu` (`entry`, `text_id`, `script_id`, `condition_id`) VALUES
(6001, 7154, 0, 0),
(6001, 7155, 0, 300);

INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_broadcast_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `box_broadcast_text`, `condition_id`) VALUES
(6001, 0, 0, '<Place my hand on the orb.>', 9859, 1, 1, -1, 0, 6001, 0, 0, NULL, 0, 300);

INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(6001, 0, 15, 23460, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orb of Command - Cast Spell');

INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES
(300, 8, 7761, 0, 0, 0, 0);

-- Correct targets for spell Teleport to Blackwing Lair DND.
UPDATE `spell_target_position` SET `target_position_x`=-7666.46, `target_position_y`=-1103.08, `target_position_z`=399.679, `target_orientation`=1, `build_min`=4449 WHERE `id`=23460;
INSERT INTO `spell_effect_mod` (`Id`, `EffectIndex`, `EffectImplicitTargetA`, `EffectImplicitTargetB`, `Comment`) VALUES (23460, 0, 25, 17, 'Teleport to Blackwing Lair: Fix Targets');

-- Correct targets for spell Teleport to Molten Core DND.
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`, `build_min`, `build_max`) VALUES (25139, 409, 1080, -483, -108, 1, 4878, 5875);
INSERT INTO `spell_effect_mod` (`Id`, `EffectIndex`, `EffectImplicitTargetA`, `EffectImplicitTargetB`, `Comment`) VALUES (25139, 0, 25, 17, 'Teleport to Molten Core: Fix Targets');

-- Update Lothos Riftwaker's gossip script to use correct teleport spell.
DELETE FROM `gossip_scripts` WHERE `id`=5750;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(5750, 0, 15, 25139, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lothos Riftwaker - Teleport Target to Molten Core');

-- Correct drop chance: [Recipe: Succulent Pork Ribs] https://classic.wowhead.com/item=2700/recipe-succulent-pork-ribs
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=0.3 WHERE`item`=2700 AND `entry`=1164;
-- Grizlak
DELETE FROM `creature_loot_template` WHERE `item`=2700 AND `entry`=1425;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`, `patch_min`, `patch_max`) VALUES
(1425,2700,0.3,0,1,1,0,0,10);
-- Mo'grosh Enforcer, Mo'grosh Brute, Mo'grosh Shaman, Dark Iron Sapper
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=0.2 WHERE`item`=2700 AND `entry` IN (1179, 1180, 1181, 1222);

-- Correct drop chance: [A Letter to Yvette] https://classic.wowhead.com/item=2839/a-letter-to-yvette
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=4 WHERE `item`=2839 AND `entry`=1522;           -- Darkeye Bonecaster
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=3 WHERE `item`=2839 AND `entry` IN (1520,1523); -- Rattlecage Soldier, Cracked Skull Soldier

DELETE FROM `creature_loot_template` WHERE `item`=2839 AND `entry` IN (1664,1770,1548,1537,1530,1532);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`, `patch_min`, `patch_max`) VALUES
(1664,2839,0.12,0,1,1,2,0,10), -- Captain Vachon - A Letter to Yvette
(1770,2839,0.05,0,1,1,2,0,10), -- Moonrage Darkrunner - A Letter to Yvette
(1548,2839,0.01,0,1,1,2,0,10), -- Cursed Darkhound - A Letter to Yvette
(1537,2839,0.01,0,1,1,2,0,10), -- Scarlet Zealot - A Letter to Yvette
(1530,2839,0.01,0,1,1,2,0,10), -- Rotting Ancestor - A Letter to Yvette
(1532,2839,0.01,0,1,1,2,0,10); -- Wandering Spirit - A Letter to Yvette

-- Correct drop chance: [Westfall Deed] https://classic.wowhead.com/item=1972/westfall-deed
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=4 WHERE `item`=1972 AND `entry` IN (6866,6846);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=3 WHERE `item`=1972 AND `entry` IN (116,474,880,6927);

-- Correct drop chance: [Gold Pickup Schedule] https://classic.wowhead.com/item=1307/gold-pickup-schedule
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=86 WHERE `item`=1307 AND `entry`=100;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=3 WHERE `item`=1307 AND `entry` IN (478,97);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=1.9 WHERE `item`=1307 AND `entry`=448;

-- Correct drop chance: [Unrefined Ore Sample] https://classic.wowhead.com/quest=1153/a-new-ore-sample
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-53 WHERE `item`=5842 AND `entry`=4116;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-48 WHERE `item`=5842 AND `entry`=4113;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-18 WHERE `item`=5842 AND `entry`=14427;

-- Correct drop chance: [Flayed Demon Skin] https://classic.wowhead.com/item=20310/flayed-demon-skin
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=5 WHERE `item`=20310 AND `entry` IN (4664,4663);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=3 WHERE `item`=20310 AND `entry` IN (4666,4665,4705);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=1.8 WHERE `item`=20310 AND `entry` IN (4668,4667);
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=1.4 WHERE `item`=20310 AND `entry`=13019;

-- Correct drop chance of Wavethrasher Scales.
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-20 WHERE `item`=20087 && `entry`=6347;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-25 WHERE `item`=20087 && `entry`=6348;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE `item`=20087 && `entry`=6349;

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
