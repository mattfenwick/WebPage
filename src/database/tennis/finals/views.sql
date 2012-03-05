
use tennisfinals;


-- this is a base view
--   many of the views built on this view
--   assume that each "name" is unique

drop view if exists joined_player;
create view joined_player as (
  select 
    f.id,
    f.isvictory,
    f.event,
    f.`type`,
    f.surface,
    f.isoutdoor,
    f.rank,
    f.`date`,
    f.locationid,
    p1.name      as `player name`,
    p1.country   as `player country`,
    p2.name      as `opponent name`,
    p2.country   as `opponent country`
  from final f
  inner join player p1
    on f.playerid = p1.id
  inner join player p2
    on f.opponentid = p2.id
);



drop view if exists by_eventtype;
create view by_eventtype as (
  select 
    `player name`, 
    `type` as `event type`,
    sum(isvictory) as wins, 
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player 
  group by `player name`, `type`
);



drop view if exists by_opponent;
create view by_opponent as (
  select
    `player name`, 
    `opponent name`,
    sum(isvictory) as wins, 
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player 
  group by `player name`, `opponent name`
);



drop view if exists by_opponentcountry;
create view by_opponentcountry as (
  select
    `player name`,
    `opponent country`,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by `player name`, `opponent country`
);


drop view if exists by_surface;
create view by_surface as (
  select 
    `player name`,
    surface,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by `player name`, surface
);


drop view if exists by_inoutdoor;
create view by_inoutdoor as (
  select
    `player name`,
    case when isoutdoor then "outdoor" else "indoor" end as "indoor/outdoor",
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by `player name`, isoutdoor
);


drop view if exists by_year;
create view by_year as (
  select
    `player name`,
    year(date) as year,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by `player name`, year(date)
);


drop view if exists by_event;
create view by_event as (
  select
    `player name`,
    event,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by `player name`, event
);



drop view if exists joined_location;
create view joined_location as (
  select 
    p.*,
    l.city,
    l.country,
    l.continent
  from joined_player p
  inner join location l
    on p.locationid = l.id
);


drop view if exists by_city;
create view by_city as (
  select
    `player name`, 
    city,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by `player name`, city
);


drop view if exists by_country;
create view by_country as (
  select
    `player name`,
    country,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by `player name`, country
);


drop view if exists by_continent;
create view by_continent as (
  select
    `player name`,
    continent,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by `player name`, continent
);


drop view if exists by_rank;
create view by_rank as (
  select
    `player name`, 
    rank,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by `player name`, rank
);



drop view if exists by_opponentsamecountry;
create view by_opponentsamecountry as (
  select
    case
      when `opponent country` = `player country` 
      then "same country" 
      else "different country" end as `is same country?`,
    `opponent country`,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by `is same country?`, `opponent country`
);

