 
use football;


create view year_scoring as
  select 
    year(date)                    as `year`, 
    avg(w_points)                 as `points, winner`, 
    avg(l_points)                 as `points, loser`,
    avg(w_points - l_points)      as `margin`,
    avg(w_points) + avg(l_points) as `total points` 
  from 
    joined_games
  group by 
    year(date);
    
    
create view year_report as
  select
    `year`,
    `points, winner`,
    `points, loser`,
    `margin`,
    `total points`
  from
    year_scoring;