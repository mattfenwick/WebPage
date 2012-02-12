
create table messages (
  id         int primary key auto_increment,
  username   varchar(45),
  room       varchar(45),
  text       varchar(500),
  time       timestamp 
    default CURRENT_TIMESTAMP
);