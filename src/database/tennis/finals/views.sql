
use tennisfinals;



drop view if exists by_eventtype;
create view by_eventtype as (
  select 
    playerid, 
    `type` as `event type`, sum(isvictory) as wins, 
    count(*) - sum(isvictory) as losses, count(*) as total
  from final 
  group by playerid, `type`
);



drop view if exists joined_player;
create view joined_player as (
  select 
    final.*,
    p1.name,
    p2.name as `opponent name`,
    p2.country as `opponent country`
  from final
  inner join player p1
    on final.playerid = p1.id
  inner join player p2
    on final.opponentid = p2.id
);



drop view if exists by_opponent;
create view by_opponent as (
  select
    name, 
    `opponent name`, sum(isvictory) as wins, 
    count(*) - sum(isvictory) as losses, count(*) as total
  from joined_player 
  group by name, `opponent name`
);



drop view if exists by_opponentcountry;
create view by_opponentcountry as (
  select
    name,
    `opponent country`,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by name, `opponent country`
);


drop view if exists by_surface;
create view by_surface as (
  select 
    playerid,
    surface, sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses, count(*) as total
  from final
  group by playerid, surface
);


drop view if exists by_inoutdoor;
create view by_inoutdoor as (
  select
    playerid,
    case when isoutdoor then "outdoor" else "indoor" end as "indoor/outdoor",
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by playerid, isoutdoor
);


drop view if exists by_year;
create view by_year as (
  select
    playerid,
    year(date) as year,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by playerid, year(date)
);


drop view if exists by_event;
create view by_event as (
  select
    playerid,
    event,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by playerid, event
);


drop view if exists joined_location;
create view joined_location as (
  select 
    f.*,
    l.city,
    l.country,
    l.continent
  from final f
  inner join location l
    on f.locationid = l.id
);


drop view if exists by_city;
create view by_city as (
  select
    playerid, 
    city,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by playerid, city
);


drop view if exists by_country;
create view by_country as (
  select
    playerid,
    country,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by playerid, country
);


drop view if exists by_continent;
create view by_continent as (
  select
    playerid,
    continent,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by playerid, continent
);


drop view if exists by_rank;
create view by_rank as (
  select
    playerid, 
    rank,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by playerid, rank
);



drop view if exists joined_player_location;
create view joined_player_location as (
  select
    l.name as `opponent name`,
    l.country as `opponent country`,
    r.*
  from player l
  inner join joined_location r
    on l.id = r.opponentid
);


drop view if exists by_opponentsamecountry;
create view by_opponentsamecountry as (
  select
    case when `opponent country` = country then "same country" else "different country" end as `is same country?`,
    `opponent country`,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player_location
  group by `is same country?`, `opponent country`
);

