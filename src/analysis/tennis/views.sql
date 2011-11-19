
use tennis;

drop view if exists v_player_rank;
create view v_player_rank as
	select 
		*
	from
		ranking
	inner join
		player
	using
		(pid);


drop view if exists a_player;		
create view a_player as
	select 
		fname, 
		lname,
		avg(rank) as `average ranking`,
		min(rank) as `best ranking`,
		count(*) as `weeks ranked`,
		min(monday) as `first ranked`,
		max(monday) as `last ranked`
	from 
		v_player_rank
	group by
		pid;
		

drop view if exists a_rank;
create view a_rank as
	select 
		rank,
		max(points) as `most points`,
		min(points) as `least points`,
		avg(points) as `average points`
	from
		v_player_rank
	where
		points > 0 and
		monday > '2000-01-01' and
		monday < '2009-01-01'
	group by 
		rank;