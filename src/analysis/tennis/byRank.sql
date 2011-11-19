
use tennis;


drop view if exists v_ranks;
create view v_ranks as
	select
		rank,
		max(age) as `maximum age`,
		min(age) as `minimum age`,
		avg(age) as `average age`,
		stddev(age) as `standard deviation of age`
	from
		v_ages
	group by
		rank;
	
		
drop view if exists v_ranks_and_players;
create view v_ranks_and_players as
	select 
		rank,
		pid,
		count(*) as `count`
	from 
		joined_rankings
	group by
		rank, 
		pid;
		
drop view if exists v_ranks_counts_players;
create view v_ranks_counts_players as
	select
		rank,
		count(*) as `number of players`
	from 
		v_ranks_and_players
	group by
		rank;

drop view if exists v_by_rank;
create view v_by_rank as
	select
		*
	from
		v_ranks
	inner join
		v_ranks_counts_players
	using 
		(rank);
