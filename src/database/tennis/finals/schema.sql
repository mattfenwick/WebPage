
use tennisfinals;



create table player (
    id           int primary key auto_increment,
    name         varchar(50),
    country      varchar(50)
    unique index (name)
);


create table location (
    id           int primary key auto_increment,
    city         varchar(50),
    country      varchar(50),
    continent    varchar(50)
);


create table final (
    id           int primary key auto_increment,

    playerid     int,
      foreign key (playerid) references player(id),

    opponentid   int,
      foreign key (opponentid) references player(id),

    isvictory    bool,
    event        varchar(50),
    type         varchar(50),
    surface      varchar(30),
    isoutdoor    bool,
    rank         int,
    date         date,

    locationid   int,
      foreign key (locationid) references location(id)

) engine = InnoDB;