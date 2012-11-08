
use football;

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
create view joined_games as
  select
    *
  from
    bcs_game
  inner join
    joined_teams
  on
    id = id_game;
    
    
drop view if exists all_teams;
create view all_teams as
  select
    l.name,
    l.points,
    l.rank,
    l.conf,
    l.qual,
    l.id_game,
    r.name     as o_name,
    r.points   as o_points,
    r.rank     as o_rank,
    r.conf     as o_conf,
    r.qual     as o_qual
  from
    bcs_team l
  inner join
    bcs_team r
  on 
    l.id_game = r.id_game and l.id != r.id;

    
drop view if exists all_games;
create view all_games as
  select 
    *
  from
    all_teams
  inner join
    bcs_game
  on
    id_game = id;
