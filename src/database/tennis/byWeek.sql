
use tennis;


drop view if exists v_week_rankings;
create view v_week_rankings as
	select
		monday,
		avg(age) as `average age`,
		max(age) as `max age`,
		min(age) as `min age`
	from
		v_ages
	group by
		monday;


drop view if exists v_weeks_countries;
create view v_weeks_countries as
	select distinct
		monday,
		country
	from
		joined_rankings;
