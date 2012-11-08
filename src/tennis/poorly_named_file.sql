
use tennis;


drop view if exists joined_rankings;
create view joined_rankings as
	select
		p.fname,
		p.lname,
		p.dateofbirth,
		r.*,
		country.*
	from 
		ranking as r,
		player as p,
		country
	where
		r.pid = p.pid and
		p.country = country.abbreviation;
		

