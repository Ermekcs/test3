-- MySQL dump 10.13  Distrib 5.1.63, for debian-linux-gnu (i686)
--
-- Host: 192.168.0.65    Database: champ
-- ------------------------------------------------------
-- Server version	5.1.66-0ubuntu0.11.10.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `champs`
--

DROP TABLE IF EXISTS `champs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `champs` (
  `champ_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `champion` int(11) DEFAULT NULL,
  `finalist` int(11) DEFAULT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`champ_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `champs`
--

LOCK TABLES `champs` WRITE;
/*!40000 ALTER TABLE `champs` DISABLE KEYS */;
INSERT INTO `champs` VALUES (1,'Tournament #1','2012-09-13 02:13:54','2012-09-13 02:19:23',7,1,1),(2,'Tournament #2','2012-09-13 02:26:48','2012-09-13 02:39:06',13,2,1),(3,'Tournament #3','2012-09-13 02:51:01','2012-09-21 14:06:51',7,5,1),(4,'Tournament #4','2012-10-26 18:47:08','2012-10-29 14:37:40',10,1,1),(5,'Tournament #5','2012-10-29 14:44:28',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `champs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  `point1` int(11) DEFAULT NULL,
  `point2` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `played_date` datetime DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `player1` (`player1`,`player2`)
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,1,9,5,11,4,1,NULL),(2,1,9,8,11,5,1,NULL),(3,1,5,8,11,4,1,NULL),(4,2,7,15,11,0,1,NULL),(5,2,7,12,10,11,1,NULL),(6,2,15,12,4,11,1,NULL),(7,3,1,16,11,8,1,NULL),(8,3,1,13,11,7,1,NULL),(9,3,1,2,5,11,1,NULL),(10,3,16,13,11,10,1,NULL),(11,3,16,2,7,11,1,NULL),(12,3,13,2,8,11,1,NULL),(13,4,6,14,8,11,1,NULL),(14,4,6,10,11,6,1,NULL),(15,4,6,3,11,7,1,NULL),(16,4,14,10,11,6,1,NULL),(17,4,14,3,11,9,1,NULL),(18,4,10,3,9,11,1,NULL),(19,5,9,1,6,11,1,NULL),(20,7,2,5,11,4,1,NULL),(21,6,12,6,8,11,1,NULL),(22,8,14,7,6,11,1,NULL),(23,9,1,6,11,5,1,NULL),(24,10,2,7,8,11,1,NULL),(25,11,1,7,7,11,1,NULL),(26,0,7,13,0,0,0,NULL),(27,12,3,15,11,6,1,NULL),(28,12,3,6,4,11,1,NULL),(29,12,3,17,8,11,1,NULL),(30,12,15,6,10,11,1,NULL),(31,12,15,17,0,11,1,NULL),(32,12,6,17,5,11,1,NULL),(33,13,1,9,11,6,1,NULL),(34,13,1,10,10,11,1,NULL),(35,13,1,2,11,9,1,NULL),(36,13,9,10,8,11,1,NULL),(37,13,9,2,5,11,1,NULL),(38,13,10,2,7,11,1,NULL),(39,14,12,13,5,11,1,NULL),(40,14,12,7,7,11,1,NULL),(41,14,12,8,11,0,1,NULL),(42,14,13,7,10,11,1,NULL),(43,14,13,8,11,0,1,NULL),(44,14,7,8,11,2,1,NULL),(45,15,14,11,11,0,1,NULL),(46,15,14,16,11,2,1,NULL),(47,15,14,5,11,6,1,NULL),(48,15,11,16,0,11,1,NULL),(49,15,11,5,0,11,1,NULL),(50,15,16,5,8,11,1,NULL),(51,16,17,13,8,11,1,NULL),(52,18,7,6,11,8,1,NULL),(53,17,1,5,11,9,1,NULL),(54,19,14,2,6,11,1,NULL),(55,20,13,1,11,6,1,NULL),(56,21,7,2,6,11,1,NULL),(57,22,13,2,11,8,1,NULL),(58,23,7,9,11,9,1,NULL),(59,23,7,2,11,7,1,'2012-09-21 10:31:29'),(60,23,7,15,11,0,1,'2012-09-21 10:31:37'),(61,23,9,2,10,11,1,'2012-09-21 10:31:54'),(62,23,9,15,11,3,1,'2012-09-21 10:31:47'),(63,23,2,15,11,8,1,'2012-09-21 10:32:00'),(64,24,10,8,11,0,1,'2012-09-21 10:32:17'),(65,24,10,11,11,0,1,'2012-09-21 10:32:20'),(66,24,10,16,9,11,1,NULL),(67,24,8,11,0,11,1,'2012-09-21 10:32:23'),(68,24,8,16,0,11,1,'2012-09-21 10:32:27'),(69,24,11,16,4,11,1,'2012-09-21 10:32:33'),(70,25,13,17,11,6,1,'2012-09-21 10:33:14'),(71,25,13,3,11,7,1,'2012-09-21 10:33:16'),(72,25,13,5,8,11,1,NULL),(73,25,17,3,11,6,1,'2012-09-21 10:33:25'),(74,25,17,5,0,11,1,'2012-09-21 10:33:38'),(75,25,3,5,5,11,1,'2012-09-21 10:33:47'),(76,26,1,14,11,5,1,NULL),(77,26,1,12,11,5,1,NULL),(78,26,1,6,11,8,1,'2012-09-21 10:33:59'),(79,26,14,12,11,6,1,'2012-09-21 10:34:08'),(80,26,14,6,11,4,1,'2012-09-21 10:34:13'),(81,26,12,6,11,5,1,'2012-09-21 10:34:18'),(82,27,7,13,11,10,1,'2012-09-21 10:34:40'),(83,29,5,2,11,2,1,'2012-09-21 10:34:52'),(84,28,16,14,9,11,1,'2012-09-21 14:04:05'),(85,30,1,10,11,5,1,'2012-09-21 10:34:57'),(86,31,7,14,11,6,1,'2012-09-21 14:04:15'),(87,32,5,1,11,10,1,'2012-09-21 14:04:25'),(88,33,7,5,11,3,1,'2012-09-21 14:06:51'),(89,34,10,13,11,7,1,'2012-10-26 18:47:48'),(90,34,10,1,9,11,1,'2012-10-26 18:47:53'),(91,34,13,1,8,11,1,'2012-10-26 18:47:53'),(92,35,9,8,11,2,1,'2012-10-26 18:48:26'),(93,35,9,15,11,3,1,'2012-10-26 18:48:27'),(94,35,8,15,11,8,1,'2012-10-26 18:48:33'),(95,36,2,12,11,8,1,'2012-10-26 18:49:48'),(96,36,2,3,11,9,1,'2012-10-26 18:49:50'),(97,36,12,3,11,9,1,'2012-10-26 18:49:52'),(98,37,7,5,9,11,1,'2012-10-26 18:50:14'),(99,37,7,14,8,11,1,'2012-10-26 18:50:17'),(100,37,7,17,9,11,1,'2012-10-26 18:50:18'),(101,37,5,14,4,11,1,'2012-10-26 18:50:48'),(102,37,5,17,8,11,1,'2012-10-26 18:50:35'),(103,37,14,17,11,4,1,'2012-10-26 18:50:37'),(104,38,1,12,11,4,1,NULL),(105,40,2,10,7,11,1,NULL),(106,39,9,17,6,11,1,NULL),(107,41,14,8,11,2,1,NULL),(108,42,1,17,11,5,1,NULL),(109,43,10,14,11,6,1,NULL),(110,44,1,10,6,11,1,NULL),(111,45,12,15,NULL,NULL,0,NULL),(112,45,12,3,NULL,NULL,0,NULL),(113,45,15,3,NULL,NULL,0,NULL),(114,46,17,10,NULL,NULL,0,NULL),(115,46,17,5,NULL,NULL,0,NULL),(116,46,10,5,NULL,NULL,0,NULL),(117,47,14,8,NULL,NULL,0,NULL),(118,47,14,9,NULL,NULL,0,NULL),(119,47,14,2,NULL,NULL,0,NULL),(120,47,8,9,NULL,NULL,0,NULL),(121,47,8,2,NULL,NULL,0,NULL),(122,47,9,2,NULL,NULL,0,NULL),(123,48,1,13,NULL,NULL,0,NULL),(124,48,1,6,NULL,NULL,0,NULL),(125,48,1,7,NULL,NULL,0,NULL),(126,48,13,6,NULL,NULL,0,NULL),(127,48,13,7,NULL,NULL,0,NULL),(128,48,6,7,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_players`
--

DROP TABLE IF EXISTS `group_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_players` (
  `group_player_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `won` int(11) DEFAULT '0',
  `lost` int(11) DEFAULT '0',
  `goal_for` int(11) NOT NULL DEFAULT '0',
  `goal_against` int(11) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT NULL,
  `qualified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_player_id`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_players`
--

LOCK TABLES `group_players` WRITE;
/*!40000 ALTER TABLE `group_players` DISABLE KEYS */;
INSERT INTO `group_players` VALUES (1,1,9,2,0,22,9,1,1),(2,1,5,1,1,15,15,2,1),(3,1,8,0,2,9,22,3,0),(4,2,7,1,1,21,11,2,1),(5,2,15,0,2,4,22,3,0),(6,2,12,2,0,22,14,1,1),(7,3,1,2,1,27,26,2,1),(8,3,16,1,2,26,32,3,0),(9,3,13,0,3,25,33,4,0),(10,3,2,3,0,33,20,1,1),(11,4,6,2,1,30,24,2,1),(12,4,14,3,0,33,23,1,1),(13,4,10,0,3,21,33,4,0),(14,4,3,1,2,27,31,3,0),(15,5,9,0,1,6,11,2,0),(16,5,1,1,0,11,6,1,1),(17,7,2,1,0,11,4,1,1),(18,7,5,0,1,4,11,2,0),(19,6,12,0,1,8,11,2,0),(20,6,6,1,0,11,8,1,1),(21,8,14,0,1,6,11,2,0),(22,8,7,1,0,11,6,1,1),(23,9,1,1,0,11,5,1,1),(24,9,6,0,1,5,11,2,0),(25,10,2,0,1,8,11,2,0),(26,10,7,1,0,11,8,1,1),(27,11,1,0,1,7,11,2,0),(28,11,7,1,0,11,7,1,1),(31,12,3,1,2,23,28,3,0),(32,12,15,0,3,16,33,4,0),(33,12,6,2,1,27,25,2,1),(34,12,17,3,0,33,13,1,1),(35,13,1,2,1,32,26,1,1),(36,13,9,0,3,19,33,4,0),(37,13,10,2,1,29,29,3,0),(38,13,2,2,1,31,23,2,1),(39,14,12,1,2,23,22,3,0),(40,14,13,2,1,32,16,2,1),(41,14,7,3,0,33,19,1,1),(42,14,8,0,3,2,33,4,0),(43,15,14,3,0,33,8,1,1),(44,15,11,0,3,0,33,4,0),(45,15,16,1,2,21,22,3,0),(46,15,5,2,1,28,19,2,1),(47,16,17,0,1,8,11,2,0),(48,16,13,1,0,11,8,1,1),(49,18,7,1,0,11,8,1,1),(50,18,6,0,1,8,11,2,0),(51,17,1,1,0,11,9,1,1),(52,17,5,0,1,9,11,2,0),(53,19,14,0,1,6,11,2,0),(54,19,2,1,0,11,6,1,1),(55,20,13,1,0,11,6,1,1),(56,20,1,0,1,6,11,2,0),(57,21,7,0,1,6,11,2,0),(58,21,2,1,0,11,6,1,1),(59,22,13,1,0,11,8,1,1),(60,22,2,0,1,8,11,2,0),(61,23,7,3,0,33,16,1,1),(62,23,9,1,2,30,25,3,0),(63,23,2,2,1,29,29,2,1),(64,23,15,0,3,11,33,4,0),(65,24,10,2,1,31,11,2,1),(66,24,8,0,3,0,33,4,0),(67,24,11,1,2,15,22,3,0),(68,24,16,3,0,33,13,1,1),(69,25,13,2,1,30,24,2,1),(70,25,17,1,2,17,28,3,0),(71,25,3,0,3,18,33,4,0),(72,25,5,3,0,33,13,1,1),(73,26,1,3,0,33,18,1,1),(74,26,14,2,1,27,21,2,1),(75,26,12,1,2,22,27,3,0),(76,26,6,0,3,17,33,4,0),(77,27,7,1,0,11,10,1,1),(78,27,13,0,1,10,11,2,0),(79,29,5,1,0,11,2,1,1),(80,29,2,0,1,2,11,2,0),(81,28,16,0,1,9,11,2,0),(82,28,14,1,0,11,9,1,1),(83,30,1,1,0,11,5,1,1),(84,30,10,0,1,5,11,2,0),(85,31,7,1,0,11,6,1,1),(86,31,14,0,1,6,11,2,0),(87,32,5,1,0,11,10,1,1),(88,32,1,0,1,10,11,2,0),(89,33,7,1,0,11,3,1,1),(90,33,5,0,1,3,11,2,0),(91,34,10,1,1,20,18,2,1),(92,34,13,0,2,15,22,3,0),(93,34,1,2,0,22,17,1,1),(94,35,9,2,0,22,5,1,1),(95,35,8,1,1,13,19,2,1),(96,35,15,0,2,11,22,3,0),(97,36,2,2,0,22,17,1,1),(98,36,12,1,1,19,20,2,1),(99,36,3,0,2,18,22,3,0),(100,37,7,0,3,26,33,4,0),(101,37,5,1,2,23,31,3,0),(102,37,14,3,0,33,16,1,1),(103,37,17,2,1,26,28,2,1),(104,38,1,1,0,11,4,1,1),(105,38,12,0,1,4,11,2,0),(106,40,2,0,1,7,11,2,0),(107,40,10,1,0,11,7,1,1),(108,39,9,0,1,6,11,2,0),(109,39,17,1,0,11,6,1,1),(110,41,14,1,0,11,2,1,1),(111,41,8,0,1,2,11,2,0),(112,42,1,1,0,11,5,1,1),(113,42,17,0,1,5,11,2,0),(114,43,10,1,0,11,6,1,1),(115,43,14,0,1,6,11,2,0),(116,44,1,0,1,6,11,2,0),(117,44,10,1,0,11,6,1,1),(118,45,12,0,0,0,0,NULL,0),(119,45,15,0,0,0,0,NULL,0),(120,45,3,0,0,0,0,NULL,0),(121,46,17,0,0,0,0,NULL,0),(122,46,10,0,0,0,0,NULL,0),(123,46,5,0,0,0,0,NULL,0),(124,47,14,0,0,0,0,NULL,0),(125,47,8,0,0,0,0,NULL,0),(126,47,9,0,0,0,0,NULL,0),(127,47,2,0,0,0,0,NULL,0),(128,48,1,0,0,0,0,NULL,0),(129,48,13,0,0,0,0,NULL,0),(130,48,6,0,0,0,0,NULL,0),(131,48,7,0,0,0,0,NULL,0);
/*!40000 ALTER TABLE `group_players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `champ_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `target_id1` int(11) DEFAULT NULL,
  `target_id2` int(11) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `playoff` tinyint(1) NOT NULL DEFAULT '0',
  `final` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,1,'A',NULL,NULL,0,0,0),(2,1,'B',NULL,NULL,0,0,0),(3,1,'C',NULL,NULL,0,0,0),(4,1,'D',NULL,NULL,0,0,0),(5,1,'1',1,3,1,1,0),(6,1,'2',2,4,1,1,0),(7,1,'3',3,1,1,1,0),(8,1,'4',4,2,1,1,0),(9,1,'1',5,6,2,1,0),(10,1,'2',7,8,2,1,0),(11,1,'1',9,10,3,1,1),(12,2,'A',NULL,NULL,0,0,0),(13,2,'B',NULL,NULL,0,0,0),(14,2,'C',NULL,NULL,0,0,0),(15,2,'D',NULL,NULL,0,0,0),(16,2,'1',12,14,1,1,0),(17,2,'2',13,15,1,1,0),(18,2,'3',14,12,1,1,0),(19,2,'4',15,13,1,1,0),(20,2,'1',16,17,2,1,0),(21,2,'2',18,19,2,1,0),(22,2,'1',20,21,3,1,1),(23,3,'A',NULL,NULL,0,0,0),(24,3,'B',NULL,NULL,0,0,0),(25,3,'C',NULL,NULL,0,0,0),(26,3,'D',NULL,NULL,0,0,0),(27,3,'1',23,25,1,1,0),(28,3,'2',24,26,1,1,0),(29,3,'3',25,23,1,1,0),(30,3,'4',26,24,1,1,0),(31,3,'1',27,28,2,1,0),(32,3,'2',29,30,2,1,0),(33,3,'1',31,32,3,1,1),(34,4,'A',NULL,NULL,0,0,0),(35,4,'B',NULL,NULL,0,0,0),(36,4,'C',NULL,NULL,0,0,0),(37,4,'D',NULL,NULL,0,0,0),(38,4,'1',34,36,1,1,0),(39,4,'2',35,37,1,1,0),(40,4,'3',36,34,1,1,0),(41,4,'4',37,35,1,1,0),(42,4,'1',38,39,2,1,0),(43,4,'2',40,41,2,1,0),(44,4,'1',42,43,3,1,1),(45,5,'A',NULL,NULL,0,0,0),(46,5,'B',NULL,NULL,0,0,0),(47,5,'C',NULL,NULL,0,0,0),(48,5,'D',NULL,NULL,0,0,0),(49,5,'1',45,47,1,1,0),(50,5,'2',46,48,1,1,0),(51,5,'3',47,45,1,1,0),(52,5,'4',48,46,1,1,0),(53,5,'1',49,50,2,1,0),(54,5,'3',51,52,2,1,0),(55,5,'1',53,54,3,1,1);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `player_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Ermek',1),(2,'Eldar',1),(3,'Munara',1),(4,'Taalay',1),(5,'Ratbek',1),(6,'Alex',1),(7,'Asker',1),(8,'Kirill',1),(9,'Ulan',1),(10,'Michael',1),(11,'Oleg',1),(12,'Ravshan',1),(13,'Ulik',1),(14,'Adilet',1),(15,'Nurmat',1),(16,'Bekbolot',0),(17,'Aybat',1);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-11-12  9:55:44
