-- MySQL dump 10.13  Distrib 5.1.51, for Win32 (ia32)
--
-- Host: localhost    Database: tennisfinals
-- ------------------------------------------------------
-- Server version	5.1.51-community

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
-- Table structure for table `final`
--

DROP TABLE IF EXISTS `final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `final` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playerid` int(11) DEFAULT NULL,
  `opponentid` int(11) DEFAULT NULL,
  `isvictory` tinyint(1) DEFAULT NULL,
  `event` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `surface` varchar(30) DEFAULT NULL,
  `isoutdoor` tinyint(1) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `locationid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `playerid` (`playerid`),
  KEY `opponentid` (`opponentid`),
  KEY `locationid` (`locationid`),
  CONSTRAINT `final_ibfk_1` FOREIGN KEY (`playerid`) REFERENCES `player` (`id`),
  CONSTRAINT `final_ibfk_2` FOREIGN KEY (`opponentid`) REFERENCES `player` (`id`),
  CONSTRAINT `final_ibfk_3` FOREIGN KEY (`locationid`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final`
--

LOCK TABLES `final` WRITE;
/*!40000 ALTER TABLE `final` DISABLE KEYS */;
INSERT INTO `final` VALUES (1,1,2,0,'Marseille',NULL,'carpet',0,67,'2000-02-13',1),(2,1,3,0,'Basel',NULL,'carpet',0,34,'2000-10-29',2),(3,1,4,1,'Milan',NULL,'carpet',0,27,'2001-02-04',3),(4,1,5,0,'Rotterdam',NULL,'hard',0,23,'2001-02-25',4),(5,1,6,0,'Basel',NULL,'carpet',0,13,'2001-10-28',2),(6,1,7,1,'Sydney',NULL,'hard',1,13,'2002-01-13',5),(7,1,8,0,'Milan',NULL,'carpet',0,13,'2002-02-03',3),(8,1,9,0,'Miami','Masters','hard',1,14,'2002-03-31',6),(9,1,43,1,'Hamburg','Masters','clay',1,14,'2002-05-19',7),(10,1,10,1,'Vienna',NULL,'hard',0,13,'2002-10-13',8),(11,1,11,1,'Marseille',NULL,'hard',0,6,'2003-02-16',1),(12,1,10,1,'Dubai',NULL,'hard',1,5,'2003-03-02',9),(13,1,12,1,'Munich',NULL,'clay',1,5,'2003-05-04',10),(14,1,13,0,'Rome','Masters','clay',1,5,'2003-05-11',11),(15,1,14,1,'Halle',NULL,'grass',1,5,'2003-06-15',12),(16,1,15,1,'Wimbledon','Grand Slam','grass',1,5,'2003-07-06',13),(17,1,10,0,'Gstaad',NULL,'clay',1,3,'2003-07-13',14),(18,1,16,1,'Vienna',NULL,'hard',0,3,'2003-10-12',8),(19,1,9,1,'Championships','Championships','hard',1,3,'2003-11-16',15),(20,1,43,1,'Australian Open','Grand Slam','hard',1,2,'2004-02-01',16),(21,1,17,1,'Dubai',NULL,'hard',1,1,'2004-03-07',9),(22,1,6,1,'Indian Wells','Masters','hard',1,1,'2004-03-21',17),(23,1,18,1,'Hamburg','Masters','clay',1,1,'2004-05-16',7),(24,1,19,1,'Halle',NULL,'grass',1,1,'2004-06-13',12),(25,1,20,1,'Wimbledon','Grand Slam','grass',1,1,'2004-07-04',13),(26,1,21,1,'Gstaad',NULL,'clay',1,1,'2004-07-11',14),(27,1,20,1,'Toronto','Masters','hard',1,1,'2004-08-01',18),(28,1,22,1,'US Open','Grand Slam','hard',1,1,'2004-09-12',19),(29,1,20,1,'Bangkok',NULL,'hard',0,1,'2004-10-03',20),(30,1,22,1,'Championships','Championships','hard',1,1,'2004-11-21',15),(31,1,23,1,'Doha',NULL,'hard',1,1,'2005-01-09',21),(32,1,23,1,'Rotterdam',NULL,'hard',0,1,'2005-02-20',4),(33,1,23,1,'Dubai',NULL,'hard',1,1,'2005-02-27',9),(34,1,22,1,'Indian Wells','Masters','hard',1,1,'2005-03-20',17),(35,1,24,1,'Miami','Masters','hard',1,1,'2005-04-03',6),(36,1,25,1,'Hamburg','Masters','clay',1,1,'2005-05-15',7),(37,1,43,1,'Halle',NULL,'grass',1,1,'2005-06-13',12),(38,1,20,1,'Wimbledon','Grand Slam','grass',1,1,'2005-07-03',13),(39,1,20,1,'Cincinnati','Masters','hard',1,1,'2005-08-21',22),(40,1,9,1,'US Open','Grand Slam','hard',1,1,'2005-09-11',19),(41,1,26,1,'Bangkok',NULL,'hard',0,1,'2005-10-02',20),(42,1,27,0,'Championships','Championships','carpet',0,1,'2005-11-20',23),(43,1,28,1,'Doha',NULL,'hard',1,1,'2006-01-08',21),(44,1,29,1,'Australian Open','Grand Slam','hard',1,1,'2006-01-29',16),(45,1,24,0,'Dubai',NULL,'hard',1,1,'2006-03-05',9),(46,1,30,1,'Indian Wells','Masters','hard',1,1,'2006-03-19',17),(47,1,23,1,'Miami','Masters','hard',1,1,'2006-04-02',6),(48,1,24,0,'Monte Carlo','Masters','clay',1,1,'2006-04-23',24),(49,1,24,0,'Rome','Masters','clay',1,1,'2006-05-14',11),(50,1,24,0,'French Open','Grand Slam','clay',1,1,'2006-06-11',25),(51,1,31,1,'Halle',NULL,'grass',1,1,'2006-06-18',12),(52,1,24,1,'Wimbledon','Grand Slam','grass',1,1,'2006-07-09',13),(53,1,25,1,'Toronto','Masters','hard',1,1,'2006-08-13',18),(54,1,20,1,'US Open','Grand Slam','hard',1,1,'2006-09-10',19),(55,1,6,1,'Tokyo',NULL,'hard',1,1,'2006-10-08',26),(56,1,32,1,'Madrid','Masters','hard',0,1,'2006-10-22',27),(57,1,32,1,'Basel',NULL,'carpet',0,1,'2006-10-29',2),(58,1,30,1,'Championships','Championships','hard',0,1,'2006-11-19',23),(59,1,32,1,'Australian Open','Grand Slam','hard',1,1,'2007-01-28',16),(60,1,33,1,'Dubai',NULL,'hard',1,1,'2007-03-03',9),(61,1,24,0,'Monte Carlo','Masters','clay',1,1,'2007-04-22',24),(62,1,24,1,'Hamburg','Masters','clay',1,1,'2007-05-20',7),(63,1,24,0,'French Open','Grand Slam','clay',1,1,'2007-06-10',25),(64,1,24,1,'Wimbledon','Grand Slam','grass',1,1,'2007-07-08',13),(65,1,34,0,'Montreal','Masters','hard',1,1,'2007-08-12',28),(66,1,30,1,'Cincinnati','Masters','hard',1,1,'2007-08-19',22),(67,1,34,1,'US Open','Grand Slam','hard',1,1,'2007-09-09',19),(68,1,27,0,'Madrid','Masters','hard',0,1,'2007-10-21',27),(69,1,12,1,'Basel',NULL,'hard',0,1,'2007-10-28',2),(70,1,35,1,'Championships','Championships','hard',0,1,'2007-11-18',23),(71,1,36,1,'Estoril',NULL,'clay',1,1,'2008-04-20',29),(72,1,24,0,'Monte Carlo','Masters','clay',1,1,'2008-04-27',24),(73,1,24,0,'Hamburg','Masters','clay',1,1,'2008-05-18',7),(74,1,24,0,'French Open','Grand Slam','clay',1,1,'2008-06-08',25),(75,1,37,1,'Halle',NULL,'grass',1,1,'2008-06-15',12),(76,1,24,0,'Wimbledon','Grand Slam','grass',1,1,'2008-07-06',13),(77,1,26,1,'US Open','Grand Slam','hard',1,2,'2008-09-08',19),(78,1,27,1,'Basel',NULL,'hard',0,2,'2008-10-26',2),(79,1,24,0,'Australian Open','Grand Slam','hard',1,2,'2009-02-01',16),(80,1,24,1,'Madrid','Masters','clay',1,2,'2009-05-17',27),(81,1,38,1,'French Open','Grand Slam','clay',1,2,'2009-06-07',25),(82,1,20,1,'Wimbledon','Grand Slam','grass',1,2,'2009-07-05',13),(83,1,34,1,'Cincinnati','Masters','hard',1,1,'2009-08-23',22),(84,1,39,0,'US Open','Grand Slam','hard',1,1,'2009-09-14',19),(85,1,34,0,'Basel',NULL,'hard',0,1,'2009-11-08',2),(86,1,26,1,'Australian Open','Grand Slam','hard',1,1,'2010-01-31',16),(87,1,24,0,'Madrid','Masters','clay',1,1,'2010-05-16',27),(88,1,22,0,'Halle',NULL,'grass',1,2,'2010-06-13',12),(89,1,26,0,'Toronto','Masters','hard',1,3,'2010-08-15',18),(90,1,19,1,'Cincinnati','Masters','hard',1,2,'2010-08-23',22),(91,1,26,0,'Shanghai','Masters','hard',1,3,'2010-10-17',23),(92,1,40,1,'Stockholm',NULL,'hard',0,2,'2010-10-24',30),(93,1,34,1,'Basel',NULL,'hard',0,2,'2010-11-07',2),(94,1,24,1,'Championships','Championships','hard',0,2,'2010-11-28',13),(95,1,36,1,'Doha',NULL,'hard',1,2,'2011-01-08',21),(96,1,34,0,'Dubai',NULL,'hard',1,2,'2011-02-26',9),(97,1,24,0,'French Open','Grand Slam','clay',1,3,'2011-06-05',25),(98,1,41,1,'Basel',NULL,'hard',0,4,'2011-11-06',2),(99,1,42,1,'Paris','Masters','hard',0,4,'2011-11-13',25),(100,1,42,1,'Championships','Championships','hard',0,4,'2011-11-27',13),(101,1,39,1,'Rotterdam',NULL,'hard',0,3,'2012-02-19',4),(102,1,26,1,'Dubai',NULL,'hard',1,3,'2012-03-03',9);
/*!40000 ALTER TABLE `final` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `continent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Marseille','France','Europe'),(2,'Basel','Switzerland','Europe'),(3,'Milan','Italy','Europe'),(4,'Rotterdam','Netherlands','Europe'),(5,'Sydney','Australia','Oceania'),(6,'Miami','USA','North America'),(7,'Hamburg','Germany','Europe'),(8,'Vienna','Austria','Europe'),(9,'Dubai','United Arab Emirates','Middle East'),(10,'Munich','Germany','Europe'),(11,'Rome','Italy','Europe'),(12,'Halle','Germany','Europe'),(13,'London','UK','Europe'),(14,'Gstaad','Switzerland','Europe'),(15,'Houston','USA','North America'),(16,'Melbourne','Australia','Oceania'),(17,'Indian Wells','USA','North America'),(18,'Toronto','Canada','North America'),(19,'New York','USA','North America'),(20,'Bangkok','Thailand','Asia'),(21,'Doha','Qatar','Middle East'),(22,'Cincinnati','USA','North America'),(23,'Shanghai','China','Asia'),(24,'Monte Carlo','Monaco','Europe'),(25,'Paris','France','Europe'),(26,'Tokyo','Japan','Asia'),(27,'Madrid','Spain','Europe'),(28,'Montreal','Canada','North America'),(29,'Estoril','Portugal','Europe'),(30,'Stockholm','Sweden','Europe');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniquename` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Roger Federer','Switzerland'),(2,'Marc Rosset','Switzerland'),(3,'Thomas Enqvist','Sweden'),(4,'Julien Boutter','France'),(5,'Nicolas Escude','France'),(6,'Tim Henman','UK'),(7,'Juan Ignacio Chela','Argentina'),(8,'Davide Sanguinetti','Italy'),(9,'Andre Agassi','USA'),(10,'Jiri Novak','Czech Republic'),(11,'Jonas Bjorkman','Sweden'),(12,'Jarkko Nieminen','Finland'),(13,'Felix Mantilla','Spain'),(14,'Nicolas Kiefer','Germany'),(15,'Mark Philippoussis','Australia'),(16,'Carlos Moya','Spain'),(17,'Feliciano Lopez','Spain'),(18,'Guillermo Coria','Argentina'),(19,'Mardy Fish','USA'),(20,'Andy Roddick','USA'),(21,'Igor Andreev','Russia'),(22,'Lleyton Hewitt','Australia'),(23,'Ivan Ljubicic','Croatia'),(24,'Rafael Nadal','Spain'),(25,'Richard Gasquet','France'),(26,'Andy Murray','UK'),(27,'David Nalbandian','Argentina'),(28,'Gael Monfils','France'),(29,'Marcos Baghdatis','Cyprus'),(30,'James Blake','USA'),(31,'Tomas Berdych','Czech Republic'),(32,'Fernando Gonzalez','Chile'),(33,'Mikhail Youzhny','Russia'),(34,'Novak Djokovic','Serbia'),(35,'David Ferrer','Spain'),(36,'Nikolay Davydenko','Russia'),(37,'Philipp Kohlschreiber','Germany'),(38,'Robin Soderling','Sweden'),(39,'Juan Martin del Potro','Argentina'),(40,'Florian Mayer','Germany'),(41,'Kei Nishikori','Japan'),(42,'Jo-Wilfried Tsonga','France'),(43,'Marat Safin','Russia');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;




/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-03 20:44:24
