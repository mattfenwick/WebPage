
create table investment (
  id       int primary key auto_increment, 
  year     int, 
  person   varchar(50), 
  stock    varchar(50), 
  shares   int
);

insert into investment (year, person, stock, shares) values 
  (2009, "Matt",    "Google", 27), 
  (2009, "Jeffrey", "Google", 13),
  (2010, "Timothy", "Yahoo",  31), 
  (2009, "Matt",    "Yahoo",  4), 
  (2011, "Timothy", "IBM",    100), 
  (2011, "Timothy", "Google", 34),
  (2010, "Jeffrey", "Yahoo",  68), 
  (2010, "Jeffrey", "Yahoo",  18),
  (2011, "Matt",    "IBM",    49),
  (2011, "Matt",    "Google", 22), 
  (2011, "Timothy", "Yahoo",  51), 
  (2009, "Jeffrey", "Yahoo",  63);


create view investment_extended as (
  select
    investment.*, 
    case when stock = "Google"  then shares end as Google,
    case when stock = "IBM"     then shares end as IBM,
    case when stock = "Yahoo"   then shares end as Yahoo 
  from investment
);


create view pivot_company_shares as (
  select 
    person, 
    sum(Google)            as Google, 
    coalesce(sum(IBM), 0)  as IBM, 
    sum(Yahoo)             as Yahoo 
  from investment_extended 
  group by person
);


create view pivot_company_transactions as (
  select 
    person, 
    count(Google)  as Google, 
    count(IBM)     as IBM, 
    count(Yahoo)   as Yahoo 
  from investment_extended 
  group by person
);


-- ---------------------------------------

create table point (
  id           int, 
  dimno        int, 
  coordinate   int, 
  primary key (id, dimno)
);

insert into point values
  (1, 1, 4),
  (1,2, 7),
  (1,3,2),
  (2,1,-3),
  (2,2,14),
  (2,3,14),
  (3,1,10),
  (3,2,5),
  (3,3,3);

create view point_extended as (
  select 
    case when dimno = 1 then coordinate end as x, 
    case when dimno = 2 then coordinate end as y,
    case when dimno = 3 then coordinate end as z, 
    point.* from point
);

create view point3d as (
  select 
    id, 
    max(x) as x, 
    max(y) as y, 
    max(z) as z 
  from point_extended 
  group by id
);


