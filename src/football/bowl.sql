
use football;


create view bowl_wl as
  select 
    bowl,
    avg(w_points) as `points, winner`,
    avg(l_points) as `points, loser`,
    avg(w_rank) as `average winner`,
    avg(l_rank) as `average loser`,
    max(w_rank) as `worst winner`,
    max(l_rank) as `worst loser`,
    min(w_rank) as `best winner`,
    min(l_rank) as `best loser`
  from
    joined_games
  group by
    bowl;
    
    
create view bowl_all as
  select
    bowl, 
    avg(rank) as `average rank`
  from
    all_games
  group by 
    bowl;
    
    
create view bowl_report as
  select
    a.bowl,
    `points, winner`,
    `points, loser`,
    `average rank`,
    `average winner`,
    `average loser`,
    `best winner`,
    `best loser`,
    `worst winner`,
    `worst loser`
  from 
    bowl_wl a
  inner join
    bowl_all b
    on a.bowl = b.bowl;
    
-- create view bowl_report as