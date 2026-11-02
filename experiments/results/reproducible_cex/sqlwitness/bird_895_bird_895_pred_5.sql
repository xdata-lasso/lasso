-- Schema DDL
CREATE TABLE circuits (circuitId INTEGER PRIMARY KEY AUTOINCREMENT, circuitRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL, location TEXT, country TEXT, lat REAL, lng REAL, alt INTEGER, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE constructors (constructorId INTEGER PRIMARY KEY AUTOINCREMENT, constructorRef TEXT DEFAULT '' NOT NULL, name TEXT DEFAULT '' NOT NULL UNIQUE, nationality TEXT, url TEXT DEFAULT '' NOT NULL);

CREATE TABLE drivers (driverId INTEGER PRIMARY KEY AUTOINCREMENT, driverRef TEXT DEFAULT '' NOT NULL, number INTEGER, code TEXT, forename TEXT DEFAULT '' NOT NULL, surname TEXT DEFAULT '' NOT NULL, dob DATE, nationality TEXT, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE seasons (year INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, url TEXT DEFAULT '' NOT NULL UNIQUE);

CREATE TABLE races (raceId INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER DEFAULT 0 NOT NULL, round INTEGER DEFAULT 0 NOT NULL, circuitId INTEGER DEFAULT 0 NOT NULL, name TEXT DEFAULT '' NOT NULL, date DATE DEFAULT '0000-00-00' NOT NULL, time TEXT, url TEXT UNIQUE, FOREIGN KEY (year) REFERENCES seasons (year), FOREIGN KEY (circuitId) REFERENCES circuits (circuitId));

CREATE TABLE constructorResults (constructorResultsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, points REAL, status TEXT, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE constructorStandings (constructorStandingsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT, wins INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE driverStandings (driverStandingsId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT, wins INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE lapTimes (raceId INTEGER NOT NULL, driverId INTEGER NOT NULL, lap INTEGER NOT NULL, position INTEGER, time TEXT, milliseconds INTEGER, PRIMARY KEY (raceId, driverId, lap), FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE pitStops (raceId INTEGER NOT NULL, driverId INTEGER NOT NULL, stop INTEGER NOT NULL, lap INTEGER NOT NULL, time TEXT NOT NULL, duration TEXT, milliseconds INTEGER, PRIMARY KEY (raceId, driverId, stop), FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId));

CREATE TABLE qualifying (qualifyId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, number INTEGER DEFAULT 0 NOT NULL, position INTEGER, q1 TEXT, q2 TEXT, q3 TEXT, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId));

CREATE TABLE status (statusId INTEGER PRIMARY KEY AUTOINCREMENT, status TEXT DEFAULT '' NOT NULL);

CREATE TABLE results (resultId INTEGER PRIMARY KEY AUTOINCREMENT, raceId INTEGER DEFAULT 0 NOT NULL, driverId INTEGER DEFAULT 0 NOT NULL, constructorId INTEGER DEFAULT 0 NOT NULL, number INTEGER, grid INTEGER DEFAULT 0 NOT NULL, position INTEGER, positionText TEXT DEFAULT '' NOT NULL, positionOrder INTEGER DEFAULT 0 NOT NULL, points REAL DEFAULT 0 NOT NULL, laps INTEGER DEFAULT 0 NOT NULL, time TEXT, milliseconds INTEGER, fastestLap INTEGER, rank INTEGER DEFAULT 0, fastestLapTime TEXT, fastestLapSpeed TEXT, statusId INTEGER DEFAULT 0 NOT NULL, FOREIGN KEY (raceId) REFERENCES races (raceId), FOREIGN KEY (driverId) REFERENCES drivers (driverId), FOREIGN KEY (constructorId) REFERENCES constructors (constructorId), FOREIGN KEY (statusId) REFERENCES status (statusId));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO seasons (year, url) VALUES (2009, 'Hamilton'), (2008, 'Chinese GrAND Prix'), (2010, 'Vettel'), (1, 'default2'), (0, 'Sebastian'), (2, 'Malaysian Grand Prix'), (3, 'Lewis'), (4, 'default1'), (5, 'unique_8'), (6, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Sebastian', 0, 'default2', 'Malaysian Grand Prix', 'Chinese GrAND Prix', '2023-01-01', 'Malaysian Grand Prix', 'Lewis'), (2009, 'Malaysian Grand Prix', 2009, 'Sebastian', 'default2', 'Lewis', '2023-01-02', 'Vettel', 'default1'), (2010, 'Hamilton', 1, 'Lewis', 'default2', 'Hamilton', '2023-01-02', 'Hamilton', 'Chinese GrAND Prix'), (2008, 'Vettel', 2010, 'Sebastian', 'Hamilton', 'Malaysian Grand Prix', '2023-01-02', 'default1', 'Malaysian Grand Prix'), (0, 'default2', NULL, 'Hamilton', 'Sebastian', 'default1', '2023-01-01', NULL, 'Vettel'), (2, 'Lewis', 1, 'Vettel', 'Chinese GrAND Prix', 'Malaysian Grand Prix', NULL, 'default2', 'Sebastian'), (3, 'Hamilton', 2009, 'Sebastian', 'Lewis', 'Hamilton', '2023-01-02', NULL, 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2010, 'Chinese GrAND Prix', 'Sebastian', 'Lewis', 'Hamilton', NULL, 2008.0, 2008, 'Lewis'), (2009, 'Hamilton', 'Vettel', 'Hamilton', 'Chinese GrAND Prix', 2010.0, 1.0, 2009, 'Hamilton'), (1, 'Sebastian', 'Sebastian', NULL, 'default2', 2010.0, 1.0, 1, 'default2'), (0, 'default2', 'Hamilton', 'default1', 'default2', 0.0, 2008.0, 1, 'Malaysian Grand Prix'), (2008, 'default1', 'Malaysian Grand Prix', 'Vettel', NULL, 0.0, 2008.0, NULL, 'default1'), (2, 'Malaysian Grand Prix', 'Malaysian Grand Prix', 'Sebastian', NULL, 1.0, 2008.0, 2010, 'Sebastian'), (3, 'Vettel', 'Lewis', NULL, 'Hamilton', 2009.0, 1.0, 1, 'Chinese GrAND Prix');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2008, 2010, 2008, 1, 'Vettel', '2023-01-02', 'Lewis', 'Chinese GrAND Prix'), (0, 2009, 0, 2009, 'Malaysian Grand Prix', '2023-01-02', 'default1', 'Vettel'), (2010, 6, 2010, 0, 'Vettel', '2023-01-01', 'Chinese GrAND Prix', 'Sebastian'), (2009, 2009, 1, 1, 'Lewis', '2023-01-01', 'Malaysian Grand Prix', NULL);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (2008, 2010, 1, 2009, NULL, 1), (2009, 2009, 0, 1, 'Malaysian Grand Prix', 1), (0, 3, 2010, 2009, 'Malaysian Grand Prix', 2009), (2010, 2, 2008, 2010, 'Lewis', 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.milliseconds) FROM races AS T1 INNER JOIN lapTimes AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Sebastian' AND T3.surname = 'Vettel' AND T1.year = 2009 AND T1.name = 'Chinese GrAND Prix';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.milliseconds) FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' AND T3.name = 'Malaysian Grand Prix' AND T3.year = 2009;

/*
Prediction Result:
(2009.0,)
*/