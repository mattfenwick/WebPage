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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` VALUES (1,'Roger Federer','Switzerland'),(2,'Marc Rosset','Switzerland'),(3,'Thomas Enqvist','Sweden'),(4,'Julien Boutter','France'),(5,'Nicolas Escude','France'),(6,'Tim Henman','UK'),(7,'Juan Ignacio Chela','Argentina'),(8,'Davide Sanguinetti','Italy'),(9,'Andre Agassi','USA'),(10,'Jiri Novak','Czech Republic'),(11,'Jonas Bjorkman','Sweden'),(12,'Jarkko Nieminen','Finland'),(13,'Felix Mantilla','Spain'),(14,'Nicolas Kiefer','Germany'),(15,'Mark Philippoussis','Australia'),(16,'Carlos Moya','Spain'),(17,'Feliciano Lopez','Spain'),(18,'Guillermo Coria','Argentina'),(19,'Mardy Fish','USA'),(20,'Andy Roddick','USA'),(21,'Igor Andreev','Russia'),(22,'Lleyton Hewitt','Australia'),(23,'Ivan Ljubicic','Croatia'),(24,'Rafael Nadal','Spain'),(25,'Richard Gasquet','France'),(26,'Andy Murray','UK'),(27,'David Nalbandian','Argentina'),(28,'Gael Monfils','France'),(29,'Marcos Baghdatis','Cyprus'),(30,'James Blake','USA'),(31,'Tomas Berdych','Czech Republic'),(32,'Fernando Gonzalez','Chile'),(33,'Mikhail Youzhny','Russia'),(34,'Novak Djokovic','Serbia'),(35,'David Ferrer','Spain'),(36,'Nikolay Davydenko','Russia'),(37,'Philipp Kohlschreiber','Germany'),(38,'Robin Soderling','Sweden'),(39,'Juan Martin del Potro','Argentina'),(40,'Florian Mayer','Germany'),(41,'Kei Nishikori','Japan'),(42,'Jo-Wilfried Tsonga','France'),(43,'Marat Safin','Russia'),(44,'Dominik Hrbaty','Slovakia'),(45,'Jose Acasuso','Argentina'),(46,'Alberto Martin','Spain'),(47,'Albert Montanes','Spain'),(48,'Juan Carlos Ferrero','Spain'),(49,'Mariano Puerta','Argentina'),(50,'Gaston Gaudio','Argentina'),(51,'Tommy Robredo','Spain'),(52,'Guillermo Canas','Argentina'),(53,'Stanislas Wawrinka','Switzerland'),(54,'Fernando Verdasco','Spain'),(55,'Nicolas Massu','Chile'),(56,'Jurgen Melzer','Austria'),(57,'Chris Guccione','Australia'),(58,'Lukasz Kubot','Poland'),(59,'Tommy Haas','Germany'),(60,'Marin Cilic','Croatia'),(61,'Arnaud Clement','France'),(62,'Ivo Karlovic','Croatia'),(63,'Mario Ancic','Croatia'),(64,'Gilles Simon','France'),(65,'Andrey Golubev','Kazakhstan'),(66,'Sam Querrey','USA'),(67,'Donald Young','USA'),(68,'Alexandr Dolgopolov','Ukraine');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Marseille','France','Europe'),(2,'Basel','Switzerland','Europe'),(3,'Milan','Italy','Europe'),(4,'Rotterdam','Netherlands','Europe'),(5,'Sydney','Australia','Oceania'),(6,'Miami','USA','North America'),(7,'Hamburg','Germany','Europe'),(8,'Vienna','Austria','Europe'),(9,'Dubai','United Arab Emirates','Middle East'),(10,'Munich','Germany','Europe'),(11,'Rome','Italy','Europe'),(12,'Halle','Germany','Europe'),(13,'London','UK','Europe'),(14,'Gstaad','Switzerland','Europe'),(15,'Houston','USA','North America'),(16,'Melbourne','Australia','Oceania'),(17,'Indian Wells','USA','North America'),(18,'Toronto','Canada','North America'),(19,'New York','USA','North America'),(20,'Bangkok','Thailand','Asia'),(21,'Doha','Qatar','Middle East'),(22,'Cincinnati','USA','North America'),(23,'Shanghai','China','Asia'),(24,'Monte Carlo','Monaco','Europe'),(25,'Paris','France','Europe'),(26,'Tokyo','Japan','Asia'),(27,'Madrid','Spain','Europe'),(28,'Montreal','Canada','North America'),(29,'Estoril','Portugal','Europe'),(30,'Stockholm','Sweden','Europe'),(31,'Auckland','New Zealand','Oceania'),(32,'Sopot','Poland','Europe'),(33,'Costa do Sauipe','Brazil','South America'),(34,'Acapulco','Mexico','North America'),(35,'Bastad','Sweden','Europe'),(36,'Beijing','China','Asia'),(37,'Chennai','India','Asia'),(38,'Barcelona','Spain','Europe'),(39,'Stuttgart','Germany','Europe'),(40,'Amersfoort','Netherlands','Europe'),(41,'Umag','Croatia','Europe'),(42,'Metz','France','Europe'),(43,'Adelaide','Australia','Oceania'),(44,'Belgrade','Serbia','Europe'),(45,'San Jose','USA','North America'),(46,'Washington DC','USA','North America'),(47,'St. Petersburg','Russia','Europe'),(48,'Valencia','Spain','Europe'),(49,'Los Angeles','USA','North America'),(50,'Brisbane','Australia','Oceania');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final`
--

LOCK TABLES `final` WRITE;
/*!40000 ALTER TABLE `final` DISABLE KEYS */;
INSERT INTO `final` VALUES (1,1,2,0,'Marseille','250','carpet',0,67,'2000-02-13',1),(2,1,3,0,'Basel','250','carpet',0,34,'2000-10-29',2),(3,1,4,1,'Milan','250','carpet',0,27,'2001-02-04',3),(4,1,5,0,'Rotterdam','500','hard',0,23,'2001-02-25',4),(5,1,6,0,'Basel','250','carpet',0,13,'2001-10-28',2),(6,1,7,1,'Sydney','250','hard',1,13,'2002-01-13',5),(7,1,8,0,'Milan','250','carpet',0,13,'2002-02-03',3),(8,1,9,0,'Miami','Masters','hard',1,14,'2002-03-31',6),(9,1,43,1,'Hamburg','Masters','clay',1,14,'2002-05-19',7),(10,1,10,1,'Vienna','500','hard',0,13,'2002-10-13',8),(11,1,11,1,'Marseille','250','hard',0,6,'2003-02-16',1),(12,1,10,1,'Dubai','500','hard',1,5,'2003-03-02',9),(13,1,12,1,'Munich','250','clay',1,5,'2003-05-04',10),(14,1,13,0,'Rome','Masters','clay',1,5,'2003-05-11',11),(15,1,14,1,'Halle','250','grass',1,5,'2003-06-15',12),(16,1,15,1,'Wimbledon','Grand Slam','grass',1,5,'2003-07-06',13),(17,1,10,0,'Gstaad','250','clay',1,3,'2003-07-13',14),(18,1,16,1,'Vienna','500','hard',0,3,'2003-10-12',8),(19,1,9,1,'Championships','Championships','hard',1,3,'2003-11-16',15),(20,1,43,1,'Australian Open','Grand Slam','hard',1,2,'2004-02-01',16),(21,1,17,1,'Dubai','500','hard',1,1,'2004-03-07',9),(22,1,6,1,'Indian Wells','Masters','hard',1,1,'2004-03-21',17),(23,1,18,1,'Hamburg','Masters','clay',1,1,'2004-05-16',7),(24,1,19,1,'Halle','250','grass',1,1,'2004-06-13',12),(25,1,20,1,'Wimbledon','Grand Slam','grass',1,1,'2004-07-04',13),(26,1,21,1,'Gstaad','250','clay',1,1,'2004-07-11',14),(27,1,20,1,'Toronto','Masters','hard',1,1,'2004-08-01',18),(28,1,22,1,'US Open','Grand Slam','hard',1,1,'2004-09-12',19),(29,1,20,1,'Bangkok','250','hard',0,1,'2004-10-03',20),(30,1,22,1,'Championships','Championships','hard',1,1,'2004-11-21',15),(31,1,23,1,'Doha','250','hard',1,1,'2005-01-09',21),(32,1,23,1,'Rotterdam','500','hard',0,1,'2005-02-20',4),(33,1,23,1,'Dubai','500','hard',1,1,'2005-02-27',9),(34,1,22,1,'Indian Wells','Masters','hard',1,1,'2005-03-20',17),(35,1,24,1,'Miami','Masters','hard',1,1,'2005-04-03',6),(36,1,25,1,'Hamburg','Masters','clay',1,1,'2005-05-15',7),(37,1,43,1,'Halle','250','grass',1,1,'2005-06-13',12),(38,1,20,1,'Wimbledon','Grand Slam','grass',1,1,'2005-07-03',13),(39,1,20,1,'Cincinnati','Masters','hard',1,1,'2005-08-21',22),(40,1,9,1,'US Open','Grand Slam','hard',1,1,'2005-09-11',19),(41,1,26,1,'Bangkok','250','hard',0,1,'2005-10-02',20),(42,1,27,0,'Championships','Championships','carpet',0,1,'2005-11-20',23),(43,1,28,1,'Doha','250','hard',1,1,'2006-01-08',21),(44,1,29,1,'Australian Open','Grand Slam','hard',1,1,'2006-01-29',16),(45,1,24,0,'Dubai','500','hard',1,1,'2006-03-05',9),(46,1,30,1,'Indian Wells','Masters','hard',1,1,'2006-03-19',17),(47,1,23,1,'Miami','Masters','hard',1,1,'2006-04-02',6),(48,1,24,0,'Monte Carlo','Masters','clay',1,1,'2006-04-23',24),(49,1,24,0,'Rome','Masters','clay',1,1,'2006-05-14',11),(50,1,24,0,'French Open','Grand Slam','clay',1,1,'2006-06-11',25),(51,1,31,1,'Halle','250','grass',1,1,'2006-06-18',12),(52,1,24,1,'Wimbledon','Grand Slam','grass',1,1,'2006-07-09',13),(53,1,25,1,'Toronto','Masters','hard',1,1,'2006-08-13',18),(54,1,20,1,'US Open','Grand Slam','hard',1,1,'2006-09-10',19),(55,1,6,1,'Tokyo','500','hard',1,1,'2006-10-08',26),(56,1,32,1,'Madrid','Masters','hard',0,1,'2006-10-22',27),(57,1,32,1,'Basel','250','carpet',0,1,'2006-10-29',2),(58,1,30,1,'Championships','Championships','hard',0,1,'2006-11-19',23),(59,1,32,1,'Australian Open','Grand Slam','hard',1,1,'2007-01-28',16),(60,1,33,1,'Dubai','500','hard',1,1,'2007-03-03',9),(61,1,24,0,'Monte Carlo','Masters','clay',1,1,'2007-04-22',24),(62,1,24,1,'Hamburg','Masters','clay',1,1,'2007-05-20',7),(63,1,24,0,'French Open','Grand Slam','clay',1,1,'2007-06-10',25),(64,1,24,1,'Wimbledon','Grand Slam','grass',1,1,'2007-07-08',13),(65,1,34,0,'Montreal','Masters','hard',1,1,'2007-08-12',28),(66,1,30,1,'Cincinnati','Masters','hard',1,1,'2007-08-19',22),(67,1,34,1,'US Open','Grand Slam','hard',1,1,'2007-09-09',19),(68,1,27,0,'Madrid','Masters','hard',0,1,'2007-10-21',27),(69,1,12,1,'Basel','250','hard',0,1,'2007-10-28',2),(70,1,35,1,'Championships','Championships','hard',0,1,'2007-11-18',23),(71,1,36,1,'Estoril','250','clay',1,1,'2008-04-20',29),(72,1,24,0,'Monte Carlo','Masters','clay',1,1,'2008-04-27',24),(73,1,24,0,'Hamburg','Masters','clay',1,1,'2008-05-18',7),(74,1,24,0,'French Open','Grand Slam','clay',1,1,'2008-06-08',25),(75,1,37,1,'Halle','250','grass',1,1,'2008-06-15',12),(76,1,24,0,'Wimbledon','Grand Slam','grass',1,1,'2008-07-06',13),(77,1,26,1,'US Open','Grand Slam','hard',1,2,'2008-09-08',19),(78,1,27,1,'Basel','250','hard',0,2,'2008-10-26',2),(79,1,24,0,'Australian Open','Grand Slam','hard',1,2,'2009-02-01',16),(80,1,24,1,'Madrid','Masters','clay',1,2,'2009-05-17',27),(81,1,38,1,'French Open','Grand Slam','clay',1,2,'2009-06-07',25),(82,1,20,1,'Wimbledon','Grand Slam','grass',1,2,'2009-07-05',13),(83,1,34,1,'Cincinnati','Masters','hard',1,1,'2009-08-23',22),(84,1,39,0,'US Open','Grand Slam','hard',1,1,'2009-09-14',19),(85,1,34,0,'Basel','500','hard',0,1,'2009-11-08',2),(86,1,26,1,'Australian Open','Grand Slam','hard',1,1,'2010-01-31',16),(87,1,24,0,'Madrid','Masters','clay',1,1,'2010-05-16',27),(88,1,22,0,'Halle','250','grass',1,2,'2010-06-13',12),(89,1,26,0,'Toronto','Masters','hard',1,3,'2010-08-15',18),(90,1,19,1,'Cincinnati','Masters','hard',1,2,'2010-08-23',22),(91,1,26,0,'Shanghai','Masters','hard',1,3,'2010-10-17',23),(92,1,40,1,'Stockholm','250','hard',0,2,'2010-10-24',30),(93,1,34,1,'Basel','500','hard',0,2,'2010-11-07',2),(94,1,24,1,'Championships','Championships','hard',0,2,'2010-11-28',13),(95,1,36,1,'Doha','250','hard',1,2,'2011-01-08',21),(96,1,34,0,'Dubai','500','hard',1,2,'2011-02-26',9),(97,1,24,0,'French Open','Grand Slam','clay',1,3,'2011-06-05',25),(98,1,41,1,'Basel','500','hard',0,4,'2011-11-06',2),(99,1,42,1,'Paris','Masters','hard',0,4,'2011-11-13',25),(100,1,42,1,'Championships','Championships','hard',0,4,'2011-11-27',13),(101,1,39,1,'Rotterdam','500','hard',0,3,'2012-02-19',4),(102,1,26,1,'Dubai','500','hard',1,3,'2012-03-03',9),(103,24,44,0,'Auckland','250','hard',1,NULL,'2004-01-18',31),(104,24,45,1,'Sopot','250','clay',1,NULL,'2004-08-15',32),(105,24,46,1,'Costa do Sauipe','250','clay',1,NULL,'2005-02-20',33),(106,24,47,1,'Acapulco','500','clay',1,NULL,'2005-02-27',34),(107,24,1,0,'Miami','Masters','hard',1,NULL,'2005-04-03',6),(108,24,18,1,'Monte Carlo','Masters','clay',1,NULL,'2005-04-17',24),(109,24,48,1,'Barcelona','500','clay',1,NULL,'2005-04-24',38),(110,24,18,1,'Rome','Masters','clay',1,NULL,'2005-05-08',11),(111,24,49,1,'French Open','Grand Slam','clay',1,NULL,'2005-06-05',25),(112,24,31,1,'Bastad','250','clay',1,NULL,'2005-07-10',35),(113,24,50,1,'Stuttgart','500','clay',1,NULL,'2005-07-24',39),(114,24,9,1,'Montreal','Masters','hard',1,NULL,'2005-08-14',28),(115,24,18,1,'Beijing','250','hard',1,NULL,'2005-09-18',36),(116,24,23,1,'Madrid','Masters','hard',0,NULL,'2005-10-23',27),(117,24,1,1,'Dubai','500','hard',1,NULL,'2006-03-04',9),(118,24,1,1,'Monte Carlo','Masters','clay',1,NULL,'2006-04-23',24),(119,24,51,1,'Barcelona','500','clay',1,NULL,'2006-04-30',38),(120,24,1,1,'Rome','Masters','clay',1,NULL,'2006-05-14',11),(121,24,1,1,'French Open','Grand Slam','clay',1,NULL,'2006-06-11',25),(122,24,1,0,'Wimbledon','Grand Slam','grass',1,NULL,'2006-07-09',13),(123,24,34,1,'Indian Wells','Masters','hard',1,NULL,'2007-03-18',17),(124,24,1,1,'Monte Carlo','Masters','clay',1,NULL,'2007-04-22',24),(125,24,52,1,'Barcelona','500','clay',1,NULL,'2007-04-29',38),(126,24,32,1,'Rome','Masters','clay',1,NULL,'2007-05-13',11),(127,24,1,0,'Hamburg','Masters','clay',1,NULL,'2007-05-20',7),(128,24,1,1,'French Open','Grand Slam','clay',1,NULL,'2007-06-10',25),(129,24,1,0,'Wimbledon','Grand Slam','grass',1,NULL,'2007-07-08',13),(130,24,53,1,'Stuttgart','500','clay',1,NULL,'2007-07-22',39),(131,24,27,0,'Paris','Masters','hard',0,NULL,'2007-11-04',25),(132,24,33,0,'Chennai','250','hard',1,NULL,'2008-01-06',37),(133,24,36,0,'Miami','Masters','hard',1,NULL,'2008-04-06',6),(134,24,1,1,'Monte Carlo','Masters','clay',1,NULL,'2008-04-27',24),(135,24,35,1,'Barcelona','500','clay',1,NULL,'2008-05-04',38),(136,24,1,1,'Hamburg','Masters','clay',1,NULL,'2008-05-18',7),(137,24,1,1,'French Open','Grand Slam','clay',1,NULL,'2008-06-08',25),(138,24,34,1,'Queen\'s Club','250','grass',1,NULL,'2008-06-15',13),(139,24,1,1,'Wimbledon','Grand Slam','grass',1,NULL,'2008-07-06',13),(140,24,14,1,'Toronto','Masters','hard',1,NULL,'2008-07-27',18),(141,24,32,1,'Olympics','Olympics','hard',1,NULL,'2008-08-17',36),(142,24,1,1,'Australian Open','Grand Slam','hard',1,NULL,'2009-02-01',16),(143,24,26,0,'Rotterdam','500','hard',0,NULL,'2009-02-15',4),(144,24,26,1,'Indian Wells','Masters','hard',1,NULL,'2009-03-22',17),(145,24,34,1,'Monte Carlo','Masters','clay',1,NULL,'2009-04-19',24),(146,24,35,1,'Barcelona','500','clay',1,NULL,'2009-04-26',38),(147,24,34,1,'Rome','Masters','clay',1,NULL,'2009-05-03',11),(148,24,1,0,'Madrid','Masters','clay',1,NULL,'2009-05-10',27),(149,24,36,0,'Shanghai','Masters','hard',1,NULL,'2009-10-18',23),(150,24,36,0,'Doha','250','hard',1,NULL,'2010-01-09',21),(151,24,54,1,'Monte Carlo','Masters','clay',1,NULL,'2010-04-18',24),(152,24,35,1,'Rome','Masters','clay',1,NULL,'2010-05-02',11),(153,24,1,1,'Madrid','Masters','clay',1,NULL,'2010-05-16',27),(154,24,38,1,'French Open','Grand Slam','clay',1,NULL,'2010-06-06',25),(155,24,31,1,'Wimbledon','Grand Slam','grass',1,NULL,'2010-07-04',13),(156,24,34,1,'US Open','Grand Slam','hard',1,NULL,'2010-09-13',19),(157,24,28,1,'Tokyo','500','hard',1,NULL,'2010-10-10',26),(158,24,1,0,'Championships','Championships','hard',0,NULL,'2010-11-28',13),(159,24,34,0,'Indian Wells','Masters','hard',1,NULL,'2011-03-20',17),(160,24,34,0,'Miami','Masters','hard',1,NULL,'2011-04-03',6),(161,24,35,1,'Monte Carlo','Masters','clay',1,NULL,'2011-04-17',24),(162,24,35,1,'Barcelona','500','clay',1,NULL,'2011-04-24',38),(163,24,34,0,'Madrid','Masters','clay',1,NULL,'2011-05-08',27),(164,24,34,0,'Rome','Masters','clay',1,NULL,'2011-05-15',11),(165,24,1,1,'French Open','Grand Slam','clay',1,NULL,'2011-06-05',25),(166,24,34,0,'Wimbledon','Grand Slam','grass',1,NULL,'2011-07-03',13),(167,24,34,0,'US Open','Grand Slam','hard',1,NULL,'2011-09-12',19),(168,24,26,0,'Tokyo','500','hard',1,NULL,'2011-10-09',26),(169,24,34,0,'Australian Open','Grand Slam','hard',1,NULL,'2012-01-29',16),(170,34,55,1,'Amersfoort','250','clay',1,NULL,'2006-07-17',40),(171,34,53,0,'Umag','250','clay',1,NULL,'2006-07-30',41),(172,34,56,1,'Metz','250','hard',0,NULL,'2006-10-02',42),(173,34,57,1,'Adelaide','250','hard',1,NULL,'2007-01-01',43),(174,34,24,0,'Indian Wells','Masters','hard',1,NULL,'2007-03-18',17),(175,34,52,1,'Miami','Masters','hard',1,NULL,'2007-04-01',6),(176,34,25,1,'Estoril','250','clay',1,NULL,'2007-04-29',29),(177,34,1,1,'Montreal','Masters','hard',1,NULL,'2007-08-12',28),(178,34,1,0,'US Open','Grand Slam','hard',1,NULL,'2007-09-09',19),(179,34,53,1,'Vienna','500','hard',0,NULL,'2007-10-14',8),(180,34,42,1,'Australian Open','Grand Slam','hard',1,NULL,'2008-01-27',16),(181,34,19,1,'Indian Wells','Masters','hard',1,NULL,'2008-03-23',17),(182,34,53,1,'Rome','Masters','clay',1,NULL,'2008-05-11',11),(183,34,24,0,'Queen\'s Club','250','grass',1,NULL,'2008-06-15',13),(184,34,26,0,'Cincinnati','Masters','hard',1,NULL,'2008-08-03',22),(185,34,42,0,'Bangkok','250','hard',0,NULL,'2008-09-28',20),(186,34,36,1,'Championships','Championships','hard',0,NULL,'2008-11-16',23),(187,34,35,1,'Dubai','500','hard',1,NULL,'2009-02-28',9),(188,34,26,0,'Miami','Masters','hard',1,NULL,'2009-04-05',6),(189,34,24,0,'Monte Carlo','Masters','clay',1,NULL,'2009-04-19',24),(190,34,24,0,'Rome','Masters','clay',1,NULL,'2009-05-03',11),(191,34,58,1,'Belgrade','250','clay',1,NULL,'2009-05-10',44),(192,34,59,0,'Halle','250','grass',1,NULL,'2009-06-14',12),(193,34,1,0,'Cincinnati','Masters','hard',1,NULL,'2009-08-23',22),(194,34,60,1,'Beijing','500','hard',1,NULL,'2009-10-11',36),(195,34,1,1,'Basel','500','hard',0,NULL,'2009-11-08',2),(196,34,28,1,'Paris','Masters','hard',0,NULL,'2009-11-15',25),(197,34,33,1,'Dubai','500','hard',1,NULL,'2010-02-27',9),(198,34,24,0,'US Open','Grand Slam','hard',1,NULL,'2010-09-12',19),(199,34,35,1,'Beijing','500','hard',1,NULL,'2010-10-10',36),(200,34,1,0,'Basel','500','hard',0,NULL,'2010-11-07',2),(201,34,26,1,'Australian Open','Grand Slam','hard',1,NULL,'2011-01-30',16),(202,34,1,1,'Dubai','500','hard',1,NULL,'2011-02-26',9),(203,34,24,1,'Indian Wells','Masters','hard',1,NULL,'2011-03-20',17),(204,34,24,1,'Miami','Masters','hard',1,NULL,'2011-04-03',6),(205,34,17,1,'Belgrade','250','clay',1,NULL,'2011-05-01',44),(206,34,24,1,'Madrid','Masters','clay',1,NULL,'2011-05-08',27),(207,34,24,1,'Rome','Masters','clay',1,NULL,'2011-05-15',11),(208,34,24,1,'Wimbledon','Grand Slam','grass',1,NULL,'2011-07-03',13),(209,34,19,1,'Montreal','Masters','hard',1,NULL,'2011-08-14',28),(210,34,26,0,'Cincinnati','Masters','hard',1,NULL,'2011-08-21',22),(211,34,24,1,'US Open','Grand Slam','hard',1,NULL,'2011-09-12',19),(212,34,24,1,'Australian Open','Grand Slam','hard',1,NULL,'2012-01-29',16),(213,26,1,0,'Bangkok','250','hard',0,NULL,'2005-10-01',20),(214,26,22,1,'San Jose','250','hard',0,NULL,'2006-02-19',45),(215,26,61,0,'Washington','250','hard',1,NULL,'2006-08-06',46),(216,26,23,0,'Doha','250','hard',1,NULL,'2007-01-06',21),(217,26,62,1,'San Jose','250','hard',0,NULL,'2007-02-18',45),(218,26,51,0,'Metz','250','hard',0,NULL,'2007-10-07',42),(219,26,54,1,'St. Petersburg','250','carpet',0,NULL,'2007-10-28',47),(220,26,53,1,'Doha','250','hard',1,NULL,'2008-01-05',21),(221,26,63,1,'Marseille','250','hard',0,NULL,'2008-02-17',1),(222,26,34,1,'Cincinnati','Masters','hard',1,NULL,'2008-08-03',22),(223,26,1,0,'US Open','Grand Slam','hard',1,NULL,'2008-09-08',19),(224,26,64,1,'Madrid','Masters','hard',0,NULL,'2008-10-19',27),(225,26,65,1,'St. Petersburg','250','hard',0,NULL,'2008-10-26',47),(226,26,20,1,'Doha','250','hard',1,NULL,'2009-01-10',21),(227,26,24,1,'Rotterdam','500','hard',0,NULL,'2009-02-15',4),(228,26,24,0,'Indian Wells','Masters','hard',1,NULL,'2009-03-22',17),(229,26,34,1,'Miami','Masters','hard',1,NULL,'2009-04-05',6),(230,26,30,1,'Queen\'s Club','250','grass',1,NULL,'2009-06-14',13),(231,26,39,1,'Montreal','Masters','hard',1,NULL,'2009-08-16',28),(232,26,33,1,'Valencia','500','hard',0,NULL,'2009-11-08',48),(233,26,1,0,'Australian Open','Grand Slam','hard',1,NULL,'2010-01-31',16),(234,26,66,0,'Los Angeles','250','hard',1,NULL,'2010-08-01',49),(235,26,1,1,'Toronto','Masters','hard',1,NULL,'2010-08-15',18),(236,26,1,1,'Shanghai','Masters','hard',1,NULL,'2010-10-17',23),(237,26,34,0,'Australian Open','Grand Slam','hard',1,NULL,'2011-01-30',16),(238,26,42,1,'Queen\'s Club','250','grass',1,NULL,'2011-06-12',13),(239,26,34,1,'Cincinnati','Masters','hard',1,NULL,'2011-08-21',22),(240,26,67,1,'Bangkok','250','hard',0,NULL,'2011-10-02',20),(241,26,24,1,'Tokyo','500','hard',1,NULL,'2011-10-09',26),(242,26,35,1,'Shanghai','Masters','hard',1,NULL,'2011-10-16',23),(243,26,68,1,'Brisbane','250','hard',1,NULL,'2012-01-08',50),(244,26,1,0,'Dubai','500','hard',1,NULL,'2012-03-03',9);
/*!40000 ALTER TABLE `final` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-05 11:21:14
