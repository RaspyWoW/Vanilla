
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `instance_creature_kills`
--

DROP TABLE IF EXISTS `instance_creature_kills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_creature_kills` (
  `mapId` int(10) unsigned NOT NULL COMMENT 'MapId to where creature exist',
  `creatureEntry` int(10) unsigned NOT NULL COMMENT 'entry of the creature who performed the kill',
  `spellEntry` int(10) NOT NULL COMMENT 'entry of spell which did the kill. 0 for melee or unknown',
  `count` int(10) unsigned NOT NULL COMMENT 'number of kills',
  PRIMARY KEY (`mapId`,`creatureEntry`,`spellEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='creatures killing players statistics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_creature_kills`
--

LOCK TABLES `instance_creature_kills` WRITE;
/*!40000 ALTER TABLE `instance_creature_kills` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_creature_kills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_custom_counters`
--

DROP TABLE IF EXISTS `instance_custom_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_custom_counters` (
  `index` int(10) unsigned NOT NULL COMMENT 'index as defined in InstanceStatistics.h',
  `count` int(10) unsigned NOT NULL COMMENT 'counter',
  PRIMARY KEY (`index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='custom counters for instance statistics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_custom_counters`
--

LOCK TABLES `instance_custom_counters` WRITE;
/*!40000 ALTER TABLE `instance_custom_counters` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_custom_counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_wipes`
--

DROP TABLE IF EXISTS `instance_wipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_wipes` (
  `mapId` int(10) unsigned NOT NULL COMMENT 'MapId to where creature exist',
  `creatureEntry` int(10) unsigned NOT NULL COMMENT 'creature which the wipe occured against',
  `count` int(10) unsigned NOT NULL COMMENT 'number of wipes',
  PRIMARY KEY (`mapId`,`creatureEntry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='players wiping against creatures statistics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_wipes`
--

LOCK TABLES `instance_wipes` WRITE;
/*!40000 ALTER TABLE `instance_wipes` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_wipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_battleground`
--

DROP TABLE IF EXISTS `logs_battleground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_battleground` (
  `time` timestamp NULL DEFAULT current_timestamp(),
  `bgid` int(11) DEFAULT NULL,
  `bgtype` int(11) DEFAULT NULL,
  `bgteamcount` int(11) DEFAULT NULL,
  `bgduration` int(11) DEFAULT NULL,
  `playerGuid` int(11) DEFAULT NULL,
  `team` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `honorBonus` int(11) DEFAULT NULL,
  `honorableKills` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_battleground`
--

LOCK TABLES `logs_battleground` WRITE;
/*!40000 ALTER TABLE `logs_battleground` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_battleground` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_behavior`
--

DROP TABLE IF EXISTS `logs_behavior`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_behavior` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` int(10) unsigned NOT NULL,
  `detection` varchar(255) NOT NULL,
  `data` varchar(255) NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_behavior`
--

LOCK TABLES `logs_behavior` WRITE;
/*!40000 ALTER TABLE `logs_behavior` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_behavior` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_characters`
--

DROP TABLE IF EXISTS `logs_characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_characters` (
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('LostSocket','Create','Delete','Login','Logout','') NOT NULL DEFAULT '',
  `guid` int(11) NOT NULL DEFAULT 0,
  `account` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(255) NOT NULL DEFAULT '',
  `clientHash` varchar(255) NOT NULL DEFAULT '',
  KEY `guid` (`guid`),
  KEY `ip` (`ip`),
  KEY `clientHash` (`clientHash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_characters`
--

LOCK TABLES `logs_characters` WRITE;
/*!40000 ALTER TABLE `logs_characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_chat`
--

DROP TABLE IF EXISTS `logs_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_chat` (
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('Say','Whisp','Group','Guild','Officer','Raid','BG','Chan','') NOT NULL DEFAULT '',
  `guid` int(11) NOT NULL DEFAULT 0,
  `target` int(11) NOT NULL DEFAULT 0,
  `channelId` int(11) NOT NULL DEFAULT 0,
  `channelName` varchar(255) NOT NULL DEFAULT '',
  `message` varchar(255) NOT NULL DEFAULT '',
  KEY `guid` (`guid`),
  KEY `target` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_chat`
--

LOCK TABLES `logs_chat` WRITE;
/*!40000 ALTER TABLE `logs_chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_movement`
--

DROP TABLE IF EXISTS `logs_movement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_movement` (
  `account` int(10) unsigned NOT NULL,
  `guid` int(10) unsigned NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `map` int(10) unsigned NOT NULL,
  `desyncMs` int(11) NOT NULL,
  `desyncDist` float NOT NULL,
  `cheats` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_movement`
--

LOCK TABLES `logs_movement` WRITE;
/*!40000 ALTER TABLE `logs_movement` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_movement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_spamdetect`
--

DROP TABLE IF EXISTS `logs_spamdetect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_spamdetect` (
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accountId` int(11) DEFAULT 0,
  `guid` int(11) NOT NULL DEFAULT 0,
  `message` varchar(255) NOT NULL DEFAULT '',
  `reason` varchar(255) NOT NULL DEFAULT '',
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_spamdetect`
--

LOCK TABLES `logs_spamdetect` WRITE;
/*!40000 ALTER TABLE `logs_spamdetect` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_spamdetect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_trade`
--

DROP TABLE IF EXISTS `logs_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_trade` (
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('AuctionBid','AuctionBuyout','SellItem','GM','Mail','QuestMaxLevel','Quest','Loot','Trade','') NOT NULL DEFAULT '',
  `sender` int(11) unsigned NOT NULL DEFAULT 0,
  `senderType` int(11) unsigned NOT NULL DEFAULT 0,
  `senderEntry` int(11) unsigned NOT NULL DEFAULT 0,
  `receiver` int(11) unsigned NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL DEFAULT 0,
  `data` int(11) NOT NULL DEFAULT 0,
  KEY `sender` (`sender`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_trade`
--

LOCK TABLES `logs_trade` WRITE;
/*!40000 ALTER TABLE `logs_trade` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_transactions`
--

DROP TABLE IF EXISTS `logs_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_transactions` (
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('Bid','Buyout','PlaceAuction','Trade','Mail','MailCOD') DEFAULT NULL,
  `guid1` int(11) unsigned NOT NULL DEFAULT 0,
  `money1` int(11) unsigned NOT NULL DEFAULT 0,
  `spell1` int(11) unsigned NOT NULL DEFAULT 0,
  `items1` varchar(255) NOT NULL DEFAULT '',
  `guid2` int(11) unsigned NOT NULL DEFAULT 0,
  `money2` int(11) unsigned NOT NULL DEFAULT 0,
  `spell2` int(11) unsigned NOT NULL DEFAULT 0,
  `items2` varchar(255) NOT NULL DEFAULT '',
  KEY `guid2` (`guid2`),
  KEY `guid1` (`guid1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_transactions`
--

LOCK TABLES `logs_transactions` WRITE;
/*!40000 ALTER TABLE `logs_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_trashcharacters`
--

DROP TABLE IF EXISTS `logs_trashcharacters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_trashcharacters` (
  `guid` int(10) unsigned NOT NULL,
  `data` varchar(255) NOT NULL,
  `cluster` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_trashcharacters`
--

LOCK TABLES `logs_trashcharacters` WRITE;
/*!40000 ALTER TABLE `logs_trashcharacters` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_trashcharacters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs_warden`
--

DROP TABLE IF EXISTS `logs_warden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs_warden` (
  `entry` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log entry ID',
  `check` smallint(5) unsigned NOT NULL COMMENT 'Failed Warden check ID',
  `action` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Action taken (enum WardenActions)',
  `account` int(11) unsigned NOT NULL COMMENT 'Account ID',
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Player GUID',
  `map` int(11) unsigned DEFAULT NULL COMMENT 'Map ID',
  `position_x` float DEFAULT NULL COMMENT 'Player position X',
  `position_y` float DEFAULT NULL COMMENT 'Player position Y',
  `position_z` float DEFAULT NULL COMMENT 'Player position Z',
  `date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date of the log entry',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Warden log of failed checks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs_warden`
--

LOCK TABLES `logs_warden` WRITE;
/*!40000 ALTER TABLE `logs_warden` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_warden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smartlog_creature`
--

DROP TABLE IF EXISTS `smartlog_creature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartlog_creature` (
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` enum('Death','LongCombat','ScriptInfo','') NOT NULL DEFAULT '',
  `entry` int(11) NOT NULL DEFAULT 0,
  `guid` int(11) NOT NULL DEFAULT 0,
  `specifier` varchar(255) NOT NULL DEFAULT '',
  `combatTime` int(11) NOT NULL DEFAULT 0,
  `content` varchar(255) NOT NULL DEFAULT '',
  KEY `entry` (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartlog_creature`
--

LOCK TABLES `smartlog_creature` WRITE;
/*!40000 ALTER TABLE `smartlog_creature` DISABLE KEYS */;
/*!40000 ALTER TABLE `smartlog_creature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_fingerprint_usage`
--

DROP TABLE IF EXISTS `system_fingerprint_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_fingerprint_usage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fingerprint` int(10) unsigned NOT NULL,
  `account` int(10) unsigned NOT NULL,
  `ip` varchar(16) NOT NULL,
  `realm` int(10) unsigned NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `architecture` varchar(16) DEFAULT NULL,
  `cputype` varchar(64) DEFAULT NULL,
  `activecpus` int(10) unsigned DEFAULT NULL,
  `totalcpus` int(10) unsigned DEFAULT NULL,
  `pagesize` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fingerprint` (`fingerprint`),
  KEY `account` (`account`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_fingerprint_usage`
--

LOCK TABLES `system_fingerprint_usage` WRITE;
/*!40000 ALTER TABLE `system_fingerprint_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_fingerprint_usage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
