
use tennisfinals;



drop view if exists by_eventtype;
create view by_eventtype as (
  select 
    `type` as `event type`, sum(isvictory) as wins, 
    count(*) - sum(isvictory) as losses, count(*) as total
  from final 
  group by `type`
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
    `opponent name`, sum(isvictory) as wins, 
    count(*) - sum(isvictory) as losses, count(*) as total
  from joined_player 
  group by `opponent name`
);



drop view if exists by_opponentcountry;
create view by_opponentcountry as (
  select
    `opponent country`,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_player
  group by `opponent country`
);


drop view if exists by_surface;
create view by_surface as (
  select 
    surface, sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses, count(*) as total
  from final
  group by surface
);


drop view if exists by_inoutdoor;
create view by_inoutdoor as (
  select
    case when isoutdoor then "outdoor" else "indoor" end as "indoor/outdoor",
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by isoutdoor
);


drop view if exists by_year;
create view by_year as (
  select
    year(date) as year,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by year(date)
);


drop view if exists by_event;
create view by_event as (
  select
    event,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by event
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
    city,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by city
);


drop view if exists by_country;
create view by_country as (
  select
    country,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by country
);


drop view if exists by_continent;
create view by_continent as (
  select
    continent,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from joined_location
  group by continent
);


drop view if exists by_rank;
create view by_rank as (
  select
    rank,
    sum(isvictory) as wins,
    count(*) - sum(isvictory) as losses,
    count(*) as total
  from final
  group by rank
);



