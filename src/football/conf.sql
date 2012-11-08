
use football;


create view conf_appearances as
  select 
    conf, 
    count(*) as appearances, 
    avg(points) as apoints,
    avg(o_points) as opoints
  from 
    all_teams 
  group by 
    conf;


create view conf_wins as
  select 
    w_conf, 
    count(*) as wins, 
    avg(w_points) as wpoints 
  from 
    joined_teams 
  group by 
    w_conf;
    
    
create view conf_losses as
  select 
    l_conf, 
    count(*) as losses, 
    avg(l_points) as lpoints 
  from 
    joined_teams 
  group by 
    l_conf;
    
    
create view conf_rose as
  select
    conf,
    count(*) as rose
  from
    all_games
  where
    bowl = "Rose Bowl"
  group by 
    conf;


create view conf_orange as
  select
    conf,
    count(*) as orange
  from
    all_games
  where
    bowl = "Orange Bowl"
  group by 
    conf;
    
    
create view conf_fiesta as
  select
    conf,
    count(*) as fiesta
  from
    all_games
  where
    bowl = "Fiesta Bowl"
  group by 
    conf;
    
    
create view conf_sugar as
  select
    conf,
    count(*) as sugar
  from
    all_games
  where
    bowl = "Sugar Bowl"
  group by 
    conf;
    
    
create view conf_champ as
  select
    conf,
    count(*) as championship
  from
    all_games
  where
    isChampionship
  group by 
    conf;
    

create view conf_teams_0 as
  select distinct
    conf,
    name
  from
    all_teams;

    
create view conf_teams as
  select
    conf,
    count(*) as teams
  from
    conf_teams_0
  group by
    conf;


create view conf_report as
  select 
    a.conf, 
    appearances, 
    coalesce(wins, 0)         as `wins`, 
    coalesce(losses, 0)       as `losses`,
    apoints                   as `points scored`,
    opoints                   as `points given up`,
    wpoints                   as `avg points, wins`,
    lpoints                   as `avg points, losses`,
    coalesce(rose, 0)         as `rose`,
    coalesce(orange, 0)       as `orange`,
    coalesce(fiesta, 0)       as `fiesta`,
    coalesce(sugar, 0)        as `sugar`,
    coalesce(championship, 0) as `championship`,
    teams   
  from 
    conf_appearances a 
  left join
    conf_wins b 
    on a.conf = b.w_conf 
  left join 
    conf_losses c 
    on a.conf = c.l_conf
  left join
    conf_rose e
    on a.conf = e.conf
  left join
    conf_orange f
    on a.conf = f.conf
  left join
    conf_fiesta g
    on a.conf = g.conf
  left join 
    conf_sugar h
    on a.conf = h.conf
  left join
    conf_champ i
    on a.conf = i.conf
  left join
    conf_teams j
    on a.conf = j.conf;
    
