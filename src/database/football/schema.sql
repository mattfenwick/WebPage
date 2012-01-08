
use football;


create table if not exists `bcs_game` (
  `id`              int primary key auto_increment,
  `date`            date,
  `city`            varchar(45),
  `bowl`            varchar(45),
  `isChampionship`  boolean
);



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
);



drop view if exists joined_teams;
create view joined_teams as
  select
    l.name    as w_name,
    l.points  as w_points,
    l.rank    as w_rank,
    l.conf    as w_conf,
    l.qual    as w_qual,
    r.name    as l_name,
    r.points  as l_points,
    r.rank    as l_rank,
    r.conf    as l_conf,
    r.qual    as l_qual,
    l.id_game
  from
    bcs_team l
  inner join
    bcs_team r
   on
     l.id_game = r.id_game and l.points > r.points; -- so the winner is always on the left



drop view if exists joined_games;
create view joined_game as
  select
    *
  from
    bcs_game
  inner join
    joined_teams
  on
    id = id_game;
