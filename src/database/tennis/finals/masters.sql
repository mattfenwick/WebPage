
use tennisfinals;


drop view if exists v_masters_wins;
create view v_masters_wins as (
  select *
  from joined_location
  where type = "Masters" and isvictory
);


drop view if exists p_masters_wins;
create view p_masters_wins as (
  select 
    date, 
    (select count(*) from v_masters_wins s 
     where s.`player name` = "Novak Djokovic" and s.date <= l.date) as djokovic,
    (select count(*) from v_masters_wins s 
     where s.`player name` = "Rafael Nadal" and s.date <= l.date)   as nadal, 
    (select count(*) from v_masters_wins s 
     where s.`player name` = "Roger Federer" and s.date <= l.date)  as federer,
    (select count(*) from v_masters_wins s 
     where s.`player name` = "Andy Murray" and s.date <= l.date)    as murray
  from v_masters_wins l 
  order by date
);

