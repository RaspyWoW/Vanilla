DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20211010185216');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20211010185216');
-- Add your query below.

CREATE TABLE `whisper_targets` (
  `account` int(11) unsigned NOT NULL,
  `target_guid` int(11) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  UNIQUE KEY `account_target` (`account`,`target_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
