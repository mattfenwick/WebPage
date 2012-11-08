-- use gas_mileage;


drop view if exists v_fill_station;
create view v_fill_station as 
  select * 
  from gas_station 
  right join fillup 
    using (gs_id);


drop view if exists v_fillup;
create view `v_fillup` AS 
  select * 
  from gas_brand 
  right join v_fill_station 
    using (gb_id);


drop view if exists p_full_report;
create view p_full_report as
  select
    date,
    mileage,
    gallons,
    price_per_gallon as `price per gallon`,
    comment,
    brand_name as brand,
    city,
    state
  from 
    v_fillup;


drop view if exists v_1;
create view v_1 as 
  select 
    count(*) as `tank number`,
    l.*,
    max(r.mileage) as `previous mileage`
  from
    p_full_report as l,
    p_full_report as r
  where
    l.mileage > r.mileage
  group by
    l.mileage;


drop view if exists v_2;
create view v_2 as 
  select
    l.*,
    r.date as `previous date`
  from 
    v_1 as l
  inner join
    p_full_report as r
  on
    l.`previous mileage` = r.mileage;


drop view if exists p_tank;
create view p_tank as 
  select
    *,
    mileage - `previous mileage` as miles,
    (mileage - `previous mileage`) / gallons as `miles per gallon`,
    datediff(date, `previous date`) as days
  from 
    v_2;


drop view if exists p_month;
create view p_month as
  select
    month(date) as `month`,
    year(date) as `year`,
    sum(miles) as `miles`,
    sum(gallons) as `gallons`,
    count(*) as `fillups`,
    avg(`price per gallon`) as `average price per gallon`
  from
    p_tank
  group by
    month(date),
    year(date);


drop view if exists p_aggregates;
create view p_aggregates as
  select
    sum(miles) as `total miles`, 
    sum(miles) / count(*) as `average miles per tank`,
    stddev(miles) as `standard deviation, miles per tank`,
    sum(gallons) as `total gallons`, 
    sum(gallons) / count(*) as `average gallons per tank`,
    stddev(gallons) as `standard deviation, gallons per tank`,
    sum(miles) / sum(gallons) as `average mpg`
  from
    p_tank;


drop view if exists p_brand;
create view p_brand as
  select
    brand,
    count(*) as `fillups`,
    avg(`price per gallon`) as `average price`,
    sum(gallons) / count(*) as `average gallons`,
    sum(gallons) as `total gallons`
  from 
    p_tank
  group by
    brand;
