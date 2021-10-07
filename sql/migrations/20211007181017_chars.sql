DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20211007181017');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20211007181017');
-- Add your query below.

ALTER TABLE `characters`
	ADD COLUMN `allow_export` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' AFTER `world_phase_mask`;

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
