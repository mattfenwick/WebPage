
use tennisfinals;



select
  concat("[", group_concat(json order by `player name`), "]") as full
from
( select 
    `player name`, 
    concat("[", group_concat(total order by year), "]") as json 
  from by_year 
  group by `player name`) q;
