
create database football;

use football;


create table if not exists `bcs_game` (
  `id`              int primary key auto_increment,
  `date`            date,
  `city`            varchar(45),
  `bowl`            varchar(45),
  `isChampionship`  boolean
) engine = innodb;



create table if not exists `bcs_team` (
  `id`         int primary key auto_increment,
  `name`       varchar(45),
  `conf`       varchar(45),
  `points`     int,
  `rank`       int,
  `qual`       varchar(45),
  `id_game`    int,
    foreign key (`id_game` )
      references `football`.`bcs_game` (`id` )
) engine = innodb;

