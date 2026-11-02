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
INSERT INTO status (statusid, status) VALUES (2008, 'default2'), (1, 'Australian Grand Prix'), (4, 'default2'), (3, 'default1'), (5, 'Australian Grand Prix'), (2007, 'Australian Grand Prix'), (2009, 'default2');
INSERT INTO seasons (year, url) VALUES (2009, 'default2'), (3, 'Australian Grand Prix'), (2008, 'default1'), (1, 'unique_3'), (0, 'unique_4'), (2007, 'unique_5');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2007, 'default1', 2007, 'default1', 'default2', 'default2', '2023-01-01', 'Australian Grand Prix', 'default1'), (1988, 'default2', 2008, 'Australian Grand Prix', 'default1', 'default2', NULL, 'default1', 'Australian Grand Prix'), (1, 'Australian Grand Prix', 2008, NULL, 'default1', 'default2', '2023-01-01', 'default1', 'default2'), (2008, 'default1', 5, 'Australian Grand Prix', 'Australian Grand Prix', 'default2', NULL, 'Australian Grand Prix', 'unique_3');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2009, 'default2', 'default2', 'default2', 'Australian Grand Prix'), (5, 'default1', 'default1', 'default2', 'Australian Grand Prix');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2008, 'default2', 'default2', 'default1', 'Australian Grand Prix', 2007.0, 4.0, 2007, 'default2'), (3, 'default2', 'default1', NULL, 'Australian Grand Prix', 1990.0, 2007.0, 3, 'Australian Grand Prix'), (1990, 'default1', 'Australian Grand Prix', 'default1', 'default2', NULL, 2008.0, 1990, 'default1'), (0, 'default1', 'default2', NULL, 'default2', 4.0, 1989.0, 5, 'unique_3'), (4, 'Australian Grand Prix', 'default1', NULL, NULL, 2009.0, 2009.0, 3, 'unique_4'), (2009, 'default1', 'default1', 'default1', 'default1', NULL, 2009.0, 5, 'unique_5'), (2007, 'Australian Grand Prix', 'Australian Grand Prix', 'Australian Grand Prix', 'Australian Grand Prix', 2009.0, 0.0, 2008, 'unique_6'), (5, 'default1', 'default1', NULL, 'default1', 0.0, 2009.0, 1989, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2009, 2008, 3, 2008, 'Australian Grand Prix', '2023-01-02', 'default1', 'Australian Grand Prix'), (5, 0, 5, 2009, 'default1', '2023-01-01', NULL, 'default2'), (2008, 3, 1990, 2007, 'Australian Grand Prix', '2023-01-01', 'default1', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 2008, 2007, 2009, 4, 0, 1, 5, 'default1', 2007, 2007.0, 2008, 'default2', 1988, 4, 5, 'default2', 'default1'), (1988, 2009, 1988, 2009, 3, 2007, 2009, 1990, 'default1', 1989, 2008.0, 2008, 'default1', 5, 1989, 1990, 'Australian Grand Prix', 'default1'), (1990, 2009, 2008, 2009, 1, 1990, 1989, 0, 'default1', 4, 3.0, 1988, NULL, 3, 3, 0, 'default1', 'default1'), (4, 2009, 2008, 5, 4, 4, 1, 1989, 'default1', 1, 3.0, 4, 'default1', 5, 2007, 1, 'default2', 'Australian Grand Prix'), (1, 2008, 2007, 5, 5, 5, 5, 1, 'default2', 0, 2009.0, 2007, NULL, 2007, NULL, 4, 'default2', 'default1'), (2008, 2009, 2007, 2009, 2007, 2008, 4, NULL, 'Australian Grand Prix', 1988, 3.0, 1990, 'default2', NULL, 2009, 1988, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T2.grid = 4 AND T1.name = 'Australian Grand Prix' AND T1.year = 2008;

/*
Gold Result:
('default2', 'default2')
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname FROM races INNER JOIN results ON races.raceId = results.raceId INNER JOIN drivers ON results.driverId = drivers.driverId WHERE races.year = 1989 AND results.grid = 4 AND races.name = 'Australian Grand Prix';

/*
Prediction Result:
*/