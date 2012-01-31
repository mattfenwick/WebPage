
use words;


CREATE TABLE `translations` (
  `id`             int(11) NOT NULL AUTO_INCREMENT,
  `category`       varchar(50) DEFAULT NULL,
  `english`        varchar(100) DEFAULT NULL,
  `french`         varchar(100) DEFAULT NULL,
  `italian`        varchar(100) DEFAULT NULL,
  `spanish`        varchar(100) DEFAULT NULL,
  `portuguese`     varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;