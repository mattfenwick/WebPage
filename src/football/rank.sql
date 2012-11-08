
use football;


create view rank_all as
  select 
    rank,
    count(*) as appearances
  from
    all_games
  group by 
    rank;
    
    
create view rank_higher as
  select
    rank,
    sum(if(points > o_points, 1, 0)) as `wins, better opp`,
    sum(if(points < o_points, 1, 0)) as `losses, better opp`
  from
    all_games
  where
    rank > o_rank
  group by
    rank;


create view rank_win as
  select
    w_rank as rank,
    count(*) as wins
  from
    joined_games
  group by
    w_rank;
    
    
create view rank_loss as
  select
    l_rank as rank,
    count(*) as losses
  from
    joined_games
  group by
    l_rank;
    
    
create view rank_wl_app as
  select
    a.rank,
    appearances,
    coalesce(wins, 0)     as `wins`, 
    coalesce(losses, 0)   as `losses`
  from
    rank_all a
  left join
    rank_win b
    on a.rank = b.rank
  left join
    rank_loss c
    on a.rank = c.rank;
    
    
create view rank_report as
  select
    a.rank,
    a.appearances,
    a.wins,
    a.losses,
    coalesce(`wins, better opp`, 0)                  as `wins, better opp`, 
    coalesce(`losses, better opp`, 0)                as `losses, better opp`,
    coalesce(wins - `wins, better opp`, wins)        as `wins, lesser opp`,
    coalesce(losses - `losses, better opp`, losses)  as `losses, lesser opp`
  from
    rank_wl_app a
  left join
    rank_higher b
    on a.rank = b.rank;
    
    
create view rank_human as
  select
    a.rank,
    a.appearances,
    concat(wins, '-', losses) as `record`,
    concat(`wins, better opp`, '-', `losses, better opp`) as `record, better opp`,
    concat(`wins, lesser opp`, '-', `losses, lesser opp`) as `record, lesser opp`
  from
    rank_report a;

    