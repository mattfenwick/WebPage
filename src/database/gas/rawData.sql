
use gas;

--
-- Dumping data for table `gas_brand`
--

LOCK TABLES `gas_brand` WRITE;
INSERT INTO `gas_brand` VALUES 
 (1,'Shell'),
 (2,'Mobil'),
 (3,'Texaco'),
 (4,'Sunoco'),
 (5,'Phillips 66'),
 (6,'Irving'),
 (7,'Hess'),
 (8,'BP');
UNLOCK TABLES;



--
-- Dumping data for table `gas_station`
--

LOCK TABLES `gas_station` WRITE;
INSERT INTO `gas_station` VALUES 
 (1,NULL,1,NULL),
 (2,NULL,2,NULL),
 (3,NULL,3,NULL),
 (4,NULL,4,NULL),
 (5,NULL,5,NULL),
 (6,NULL,6,NULL),
 (7,NULL,7,NULL),
 (8,NULL,8,NULL),
 (9,'Hyannis',7,'MA'),
 (15,'West Hartford',2,'CT'),
 (17,'Newington',5,'CT'),
 (18,'Farmington',4,'CT'),
 (20,'West Hartford',1,'CT'),
 (22,'Cranbury',4,'NJ'),
 (23,'Chesapeake',4,'VA'),
 (24,'Virginia Beach',8,'VA'),
 (25,'New Jersey Turnpike',4,'NJ');
UNLOCK TABLES;



--
-- Dumping data for table `fillup`
--

LOCK TABLES `fillup` WRITE;
INSERT INTO `fillup` VALUES 
 (89513,'2009-08-20',8.500,NULL,NULL,'Dad\'s fillup'),
 (89804,'2009-08-22',8.830,NULL,NULL,NULL),
 (90118,'2009-08-22',9.000,NULL,NULL,NULL),
 (90330,'2009-08-23',6.050,NULL,NULL,NULL),
 (90651,'2009-08-23',9.540,1,2.799,NULL),
 (90970,'2009-08-29',9.930,2,2.799,NULL),
 (91263,'2009-09-05',5.600,NULL,2.679,'may not be full - 293 written in notebook'),
 (91374,'2009-09-06',6.250,1,2.639,'did not start from a full tank'),
 (91697,'2009-09-24',9.520,NULL,NULL,NULL),
 (92005,'2009-10-15',10.260,NULL,NULL,NULL),
 (92299,'2009-11-11',9.920,3,2.799,NULL),
 (92427,'2009-11-22',4.630,3,2.789,NULL),
 (92668,'2009-12-10',8.570,3,2.829,NULL),
 (92829,'2010-01-05',6.630,3,2.839,NULL),
 (93129,'2010-01-10',NULL,NULL,NULL,'blank space in log book -- guessed mileage and date'),
 (93437,'2010-01-20',10.269,3,2.929,'mpg probably inaccurate due to previous entry'),
 (93695,'2010-02-09',9.830,3,2.769,NULL),
 (93947,'2010-03-01',9.360,3,2.869,NULL),
 (94221,'2010-03-18',8.931,3,2.939,NULL),
 (94515,'2010-04-12',9.802,3,2.999,NULL),
 (94850,'2010-05-05',NULL,NULL,NULL,'blank space in log -- guessed date and mileage'),
 (95101,'2010-05-29',7.400,2,2.759,'mileage may be inaccurate by up to 50 miles'),
 (95334,'2010-06-26',8.840,2,2.759,NULL),
 (95586,'2010-07-18',7.253,6,2.639,NULL),
 (95886,'2010-07-20',8.360,2,2.899,NULL),
 (96118,'2010-07-20',5.747,2,2.639,NULL),
 (96422,'2010-08-12',9.263,2,2.849,NULL),
 (96561,'2010-08-30',4.388,1,2.899,'maybe it was Shell, maybe it wasn\'t'),
 (96730,'2010-09-02',4.439,9,2.629,NULL),
 (97064,'2010-09-30',9.263,4,2.699,NULL),
 (97342,'2010-10-30',10.290,15,3.039,NULL),
 (97472,'2010-11-07',4.035,17,3.039,NULL),
 (97711,'2011-02-27',8.574,18,3.499,'not full -- prepaid $30 '),
 (97996,'2011-05-21',9.360,20,4.299,NULL),
 (98206,'2011-06-04',6.279,22,3.819,NULL),
 (98537,'2011-06-04',7.814,23,3.699,NULL),
 (98837,'2011-06-11',7.730,24,3.659,NULL),
 (99133,'2011-06-11',7.453,25,3.749,NULL),
 (99410,'2011-07-04',7.632,20,3.829,NULL),
 (99745,'2011-07-20',9.107,18,3.979,NULL);
UNLOCK TABLES;