
select 
  rank, lname, count(*) 
from joined_rankings 
where lname in ("Federer", "Murray", "Djokovic", "Nadal") and 
  monday > '2011-1-1' 
group by rank, lname 
order by rank asc, count(*) desc;


select 
  fname, lname, count(*) 
from joined_rankings 
where rank <= 10 
group by fname, lname 
having count(*) > 300 
order by count(*) desc;


select 
  fname, lname, count(*) 
from joined_rankings 
where rank <= 5 
group by fname, lname 
having count(*) > 100 
order by count(*) desc;


select 
  fname, lname, rank, count(*) 
from joined_rankings 
where rank < 4 
group by fname, lname, rank
having count(*) > 100 
order by rank asc, count(*) desc;


select 
  rank, min(age), max(age), avg(age), stddev(age) 
from (
  select 
    rank, 
    datediff(monday, dateofbirth) / 365 as age 
  from joined_rankings
) q 
group by rank;


select 
  fname, lname, count(*) as `distinct years ranked in top 100`
from (
  select distinct fname, lname, year(monday) from joined_rankings
) q 
group by fname, lname 
order by count(*) asc;


select 
  fname, lname, datediff(last, first) / 365 as longevity 
from (
  select fname, lname, min(monday) as first, max(monday) as last 
  from joined_rankings 
  group by fname, lname
) q 
order by longevity asc;


select 
  fname, lname, sum(points) as total, count(*) 
from (
  select fname, lname, 100 - rank as points from joined_rankings
) q
group by fname, lname 
order by total asc;


select 
  fname, lname, total / weeks as avg
from (
  select 
    fname, lname, sum(points) as total, count(*) as weeks
  from (
    select fname, lname, 100 - rank as points from joined_rankings
  ) q
  group by fname, lname 
) r
order by avg asc;


create view country_per_week as (
  select monday, abbreviation as country, count(*) as total 
  from joined_rankings 
  group by monday, abbreviation
);
  
select 
  q.monday as date, max(q.total), r.country
from country_per_week q 
inner join country_per_week r
  using (monday, country)
group by q.monday
order by date asc;


select 
  case when year(monday) >= 2009 then "new system" else "old system" end as dateblock,
  rank,
  max(points), min(points), avg(points)
from ranking
group by dateblock, rank
order by dateblock asc, rank asc;


-- average age in top 100
select 
  monday, avg(age), min(age), max(age), stddev(age) 
from (
  select 
    monday, 
    datediff(monday, dateofbirth) / 365 as age 
  from joined_rankings
) q 
group by monday
having count(*) > 1
order by monday asc;


select 
  year(dateofbirth),
  max(height_cm), min(height_cm),
  avg(height_cm), max(weight_kg), 
  min(weight_kg), avg(weight_kg) 
from player 
group by year(dateofbirth);


select 
  year(monday), 
  max(height_cm), min(height_cm), 
  avg(height_cm), max(weight_kg), 
  min(weight_kg), avg(weight_kg) 
from joined_rankings
group by year(monday);


select 
  rank, 
  max(height_cm), min(height_cm), 
  avg(height_cm), max(weight_kg), 
  min(weight_kg), avg(weight_kg) 
from joined_rankings 
group by rank;


select
  `year(monday)`,
  count(*)
from (
  select 
    fname,
    lname,
    year(monday),
    count(*) 
  from joined_rankings 
  where rank < 2 
  group by fname, lname, year(monday) 
) q 
group by `year(monday)`;


-- players outside the Big 4 that were ranked in the top 4 since start of 2009
select 
  * 
from joined_rankings 
where lname not in ("Federer", "Djokovic", "Nadal", "Murray") and 
  year(monday) >= 2009 and rank < 5;


-- number of weeks each #1 was #1, for each year
select 
  fname, 
  lname,
  year(monday),
  count(*)
from joined_rankings 
where rank < 2 
group by fname, lname, year(monday)
order by year(monday) asc, count(*) desc;


-- number of different years each #1 was #1 for at least one week
select 
  lname, 
  count(*) 
from (
  select distinct 
    lname, 
    year(monday)
  from joined_rankings 
  where rank = 1
) q 
group by lname 
order by count(*) desc;


-- number of weeks each player ranked <n> was ranked <n>, by year
select 
  fname,
  lname,
  year(monday),
  count(*)
from joined_rankings
where rank = 4 
group by fname, lname, year(monday) 
order by year(monday) asc, count(*) desc;


-- number of different players ranked in the top <n> each year
select
  year,
  count(*)
from (
  select distinct 
    fname,
    lname,
    year(monday) as year
  from joined_rankings
  where rank <= 5
) q
group by year;

