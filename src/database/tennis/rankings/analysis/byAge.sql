
use tennis;


drop view if exists v_ages;
create view v_ages as
	select
		pid,
		monday,
		rank,
		lname, 
		fname,
		dateofbirth,
		(YEAR(MONDAY)-YEAR(dateofbirth)) - (RIGHT(MONDAY,5)<RIGHT(dateofbirth,5)) AS age
	from 
		joined_rankings
	where
		dateofbirth is not null;
		
		
drop view if exists v_player_age;
create view v_player_age as
	select
		pid,
		min(age) as `youngest ranking`,
		max(age) as `oldest ranking`
	from 
		v_ages
	group by
		pid;
		
		
drop view if exists v_old_age_counts;
create view v_old_age_counts as
	select
		`oldest ranking`,
		count(*) as `count`
	from
		v_player_age
	group by
		`oldest ranking`;


drop view if exists v_young_age_counts;
create view v_young_age_counts as
	select
		`youngest ranking`,
		count(*) as `count`
	from
		v_player_age
	group by
		`youngest ranking`;


drop view if exists v_age_counts;
create view v_age_counts as
	select
		age,
		count(*) as `count`
	from 
		v_ages
	group by
		age;
