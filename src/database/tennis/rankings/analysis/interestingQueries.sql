
-- # of weeks spent by each of Big 4 at each ranking since start of 2009
select 
  rank, lname, count(*) 
from joined_rankings 
where lname in ("Federer", "Murray", "Djokovic", "Nadal") and 
  monday > '2009-1-1' 
group by rank, lname 
order by rank asc, count(*) desc;


-- # of weeks spent in top 10 for each player
select 
  fname as `first name`,
  lname as `last name`,
  count(*) as `number of weeks`
from joined_rankings 
where rank <= 10 
group by fname, lname 
having count(*) > 300 
order by count(*) desc;


-- # of weeks spent in top 5 for each player
select 
  fname, lname, count(*) 
from joined_rankings 
where rank <= 5 
group by fname, lname 
having count(*) > 100 
order by count(*) desc;


-- # of weeks spent in each rank in top 3
select 
  fname, lname, rank, count(*) 
from joined_rankings 
where rank < 4 
group by fname, lname, rank
having count(*) > 100 
order by rank asc, count(*) desc;


-- age statistics for each rank
select 
  rank, min(age), max(age), avg(age), stddev(age) 
from (
  select 
    rank, 
    datediff(monday, dateofbirth) / 365 as age 
  from joined_rankings
) q 
group by rank;


-- # of different years ranked in top 100
select 
  fname as `first name`, 
  lname as `last name`,
  count(*) as `years ranked in top 100`
from (
  select distinct fname, lname, year(monday) from joined_rankings
) q 
group by fname, lname 
order by count(*) desc;


-- # of years between first, last ranking in top 100 for each player
select 
  fname as `first name`,
  lname as `last name`,
  datediff(last, first) / 365 as `longevity`
from (
  select fname, lname, min(monday) as first, max(monday) as last 
  from joined_rankings 
  group by fname, lname
) q 
order by longevity desc;


-- total # of points earned, and points per week, for each player
--   where points are awarded weekly
--   if a player is ranked n for one week, he gets (100 - n) points
--   thus, the top-ranked player gets 99 points for that week
select 
  fname       as `first name`,
  lname       as `last name`,
  sum(points) as total,
  count(*)    as weeks,
  sum(points) / count(*) as average 
from (
  select fname, lname, 100 - rank as points from joined_rankings
) q
group by fname, lname 
order by total desc; -- change the sorting if desired



create view country_per_week as (
  select monday, abbreviation as country, count(*) as total 
  from joined_rankings 
  group by monday, abbreviation
);

-- for each monday, country with most players in top 100
select 
  q.*, 
  r.country 
from (
  select monday, max(total) 
  from country_per_week 
  group by monday
) q 
inner join country_per_week r 
  on q.monday = r.monday and 
  q.`max(total)` = r.total;


-- statistics for each rank vs. points
--   in two categories, old & new system
--   before/after start of 2009
select 
  case when year(monday) >= 2009 
       then "new" 
       else "old"
  end as system,
  rank,
  max(points), min(points), avg(points)
from ranking
group by system, rank
order by system asc, rank asc;


-- age statistics in top 100 for each monday
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


-- height and weight statistics based on year of birth
select 
  year(dateofbirth),
  max(height_cm), min(height_cm),
  avg(height_cm), max(weight_kg), 
  min(weight_kg), avg(weight_kg) 
from player 
group by year(dateofbirth);


-- height and weight statistics based on monday of ranking
select 
  year(monday), 
  max(height_cm), min(height_cm), 
  avg(height_cm), max(weight_kg), 
  min(weight_kg), avg(weight_kg) 
from joined_rankings
group by year(monday);


-- height and weight statistics based on rank
select 
  rank, 
  max(height_cm), min(height_cm), 
  avg(height_cm), max(weight_kg), 
  min(weight_kg), avg(weight_kg) 
from joined_rankings 
group by rank;


-- # of players ranked #1 each year
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

