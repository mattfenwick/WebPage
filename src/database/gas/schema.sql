
use gas;

--
-- Table structure for table `gas_brand`
--

DROP TABLE IF EXISTS `gas_brand`;
CREATE TABLE `gas_brand` (
  `gb_id` 			int(11) NOT NULL AUTO_INCREMENT,
  `brand_name` 		varchar(45),
  PRIMARY KEY (`gb_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;



--
-- Table structure for table `gas_station`
--

DROP TABLE IF EXISTS `gas_station`;
CREATE TABLE `gas_station` (
  `gs_id` 		int(11) NOT NULL AUTO_INCREMENT,
  `city` 		varchar(45),
  `gb_id` 		int(11) NOT NULL,
  `state` 		varchar(50),
  PRIMARY KEY (`gs_id`),
  KEY `fk_gas_station_gas_brand1` (`gb_id`),
  CONSTRAINT `fk_gas_station_gas_brand1` FOREIGN KEY (`gb_id`) REFERENCES `gas_brand` (`gb_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;


--
-- Table structure for table `fillup`
--

DROP TABLE IF EXISTS `fillup`;
CREATE TABLE `fillup` (
  `mileage` 		int(11) NOT NULL,
  `date` 			date NOT NULL,
  `gallons` 		decimal(7,3),
  `gs_id` 			int(11),
  `price_per_gallon` 	decimal(6,3),
  `comment` 		varchar(100),
  PRIMARY KEY (`mileage`),
  KEY `fk_fillup_gas_station` (`gs_id`),
  CONSTRAINT `fk_fillup_gas_station` FOREIGN KEY (`gs_id`) REFERENCES `gas_station` (`gs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

