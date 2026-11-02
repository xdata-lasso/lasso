CREATE TABLE circuits (
    circuitid integer NOT NULL,
    circuitref varchar,
    myname varchar,
     myloc varchar,
    country varchar,
    lat real,
    lng real,
    alt integer,
    myurl varchar,
    PRIMARY KEY (circuitid)
);
CREATE TABLE seasons (
    myyear integer NOT NULL,
    myurl varchar,
    PRIMARY KEY (myyear)
);
CREATE TABLE races (
    raceid integer NOT NULL,
    myyear integer,
    round integer,
    circuitid integer,
    myname varchar,
    racesdate date,
    mytime varchar,
    myurl varchar,
    PRIMARY KEY (raceid),
    FOREIGN KEY (circuitid) REFERENCES circuits (circuitid),
    FOREIGN KEY (myyear) REFERENCES seasons (myyear)
);
CREATE TABLE constructors (
    constructorid integer NOT NULL,
    constructorref varchar,
    myname varchar,
    nationality varchar,
    myurl varchar,
    PRIMARY KEY (constructorid)
);
CREATE TABLE constructorresults (
    constructorresultsid integer NOT NULL,
    raceid integer,
    constructorid integer,
    points real,
    mystatus varchar,
    PRIMARY KEY (constructorresultsid),
    FOREIGN KEY (constructorid) REFERENCES constructors (constructorid)
);
CREATE TABLE constructorstandings (
    constructorstandingsid integer NOT NULL,
    raceid integer,
    constructorid integer,
    points real,
    position integer,
    positiontext varchar,
    wins integer,
    PRIMARY KEY (constructorstandingsid),
    FOREIGN KEY (constructorid) REFERENCES constructors (constructorid)
);
CREATE TABLE drivers (
    driverid integer NOT NULL,
    driverref varchar,
    mynumber integer,
    code varchar,
    forename varchar,
    surname varchar,
    dob date,
    nationality varchar,
    myurl varchar,
    PRIMARY KEY (driverid)
);
CREATE TABLE driverstandings (
    driverstandingsid integer NOT NULL,
    raceid integer,
    driverid integer,
    points real,
    position integer,
    positiontext varchar,
    wins integer,
    PRIMARY KEY (driverstandingsid),
    FOREIGN KEY (driverid) REFERENCES drivers (driverid)
);
CREATE TABLE laptimes (
    raceid integer NOT NULL,
    driverid integer NOT NULL,
    lap integer NOT NULL,
    position integer,
    mytime varchar,
    milliseconds integer,
    PRIMARY KEY (raceid, driverid, lap),
    FOREIGN KEY (driverid) REFERENCES drivers (driverid),
    FOREIGN KEY (raceid) REFERENCES races (raceid)
);
CREATE TABLE pitstops (
    raceid integer NOT NULL,
    driverid integer NOT NULL,
    mystop integer NOT NULL,
    lap integer,
    mytime varchar,
    duration varchar,
    milliseconds integer,
    PRIMARY KEY (raceid, driverid, mystop),
    FOREIGN KEY (driverid) REFERENCES drivers (driverid),
    FOREIGN KEY (raceid) REFERENCES races (raceid)
);
CREATE TABLE qualifying (
    qualifyid integer NOT NULL,
    raceid integer,
    driverid integer,
    constructorid integer,
    mynumber integer,
    position integer,
    qa varchar,
    qb varchar,
    qc varchar,
    PRIMARY KEY (qualifyid),
    FOREIGN KEY (constructorid) REFERENCES constructors (constructorid),
    FOREIGN KEY (driverid) REFERENCES drivers (driverid),
    FOREIGN KEY (raceid) REFERENCES races (raceid)
);
CREATE TABLE statustable (
    statusid integer NOT NULL,
    mystatus varchar,
    PRIMARY KEY (statusid)
);
CREATE TABLE results (
    resultid integer NOT NULL,
    raceid integer,
    driverid integer,
    constructorid integer,
    mynumber integer,
    grid integer,
    position integer,
    positiontext varchar,
    positionorder integer,
    points real,
    laps integer,
    mytime varchar,
    milliseconds integer,
    fastestlap integer,
    rank integer,
    fastestlaptime varchar,
    fastestlapspeed varchar,
    statusid integer,
    PRIMARY KEY (resultid),
    FOREIGN KEY (constructorid) REFERENCES constructors (constructorid),
    FOREIGN KEY (driverid) REFERENCES drivers (driverid),
    FOREIGN KEY (raceid) REFERENCES races (raceid),
    FOREIGN KEY (statusid) REFERENCES statustable (statusid)
);