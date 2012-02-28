
use football;


create view team_appearances as
  select 
    name, 
    count(*) as appearances 
  from 
    bcs_team 
  group by 
    name;


create view team_wins as
  select 
    w_name, 
    count(*) as wins 
  from 
    joined_teams 
  group by 
    w_name;


create view team_losses as
  select
    l_name,
    count(*) as losses
  from
    joined_teams
  group by
    l_name;
    

create view team_scoring as
  select 
    name,
    avg(points)    as `points scored`,
    avg(o_points)  as `points given up`
  from
    all_teams
  group by
    name;
    
    
create view team_rose as
  select
    name,
    count(*) as rose
  from
    all_games
  where
    bowl = "Rose Bowl"
  group by
    name;
    
    
create view team_orange as
  select
    name,
    count(*) as orange
  from
    all_games
  where
    bowl = "Orange Bowl"
  group by
    name;


create view team_sugar as
  select
    name,
    count(*) as sugar
  from
    all_games
  where
    bowl = "Sugar Bowl"
  group by
    name;
    
    
create view team_fiesta as
  select
    name,
    count(*) as fiesta
  from
    all_games
  where
    bowl = "Fiesta Bowl"
  group by
    name;
    
    
create view team_champ as
  select
    name,
    count(*) as championship
  from
    all_games
  where
    isChampionship
  group by
    name;
    
    
create view team_report as 
  select 
    a.name, 
    appearances, 
    coalesce(wins, 0)          as wins, 
    coalesce(losses, 0)        as losses,
    `points scored`,
    `points given up`,
    coalesce(rose, 0)          as `rose`,
    coalesce(orange, 0)        as `orange`,
    coalesce(fiesta, 0)        as `fiesta`,
    coalesce(sugar, 0)         as `sugar`,
    coalesce(championship, 0)  as `championship`
  from 
    team_appearances a 
  left join
    team_wins b 
    on a.name = b.w_name 
  left join 
    team_losses c 
    on a.name = c.l_name
  left join
    team_scoring d
    on a.name = d.name
  left join
    team_rose e
    on a.name = e.name
  left join
    team_orange f
    on a.name = f.name
  left join
    team_fiesta g
    on a.name = g.name
  left join 
    team_sugar h
    on a.name = h.name
  left join
    team_champ i
    on a.name = i.name;
