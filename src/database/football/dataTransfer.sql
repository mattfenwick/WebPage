
use football;

insert into bcs_team
  (id, name, conf, points, rank, qual)
select * from bcs_team_old;

insert into bcs_game
  (id, date, bowl)
select 
  id, date, game
from
  bcs_game_old;