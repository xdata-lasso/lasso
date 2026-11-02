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
INSERT INTO status (statusid, status) VALUES (2007, 'default2'), (2008, 'Australian Grand Prix'), (2, 'default2'), (100, 'Australian GrAND Prix'), (2009, 'default1');
INSERT INTO seasons (year, url) VALUES (101, 'Australian Grand Prix'), (0, 'Australian GrAND Prix'), (2007, 'default1'), (100, 'default2'), (2009, 'unique_4'), (2008, 'unique_5'), (1, 'unique_6'), (2, 'unique_7'), (99, 'unique_8'), (-1, 'unique_9'), (3, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Australian Grand Prix', NULL, 'Australian GrAND Prix', 'default2', 'default1', NULL, 'Australian GrAND Prix', 'Australian GrAND Prix'), (101, 'Australian Grand Prix', 100, 'Australian Grand Prix', 'Australian GrAND Prix', 'default2', NULL, NULL, 'default2'), (100, 'default1', 0, 'default2', 'default2', 'default2', NULL, 'default1', 'default1'), (99, 'default1', NULL, 'default2', 'default2', 'default1', '2023-01-02', 'default1', 'Australian Grand Prix'), (-1, 'default1', 2007, NULL, 'Australian Grand Prix', 'Australian Grand Prix', '2023-01-02', NULL, 'unique_4'), (2008, 'Australian Grand Prix', 100, 'Australian GrAND Prix', 'default1', 'Australian Grand Prix', '2023-01-01', 'default1', 'unique_5'), (2007, 'Australian GrAND Prix', NULL, 'default1', 'default2', 'default1', NULL, 'default2', 'unique_6'), (2009, 'default2', 2007, 'Australian GrAND Prix', 'Australian Grand Prix', 'default1', NULL, 'default2', 'unique_7'), (1, 'Australian GrAND Prix', 2007, 'Australian Grand Prix', 'default1', 'Australian Grand Prix', '2023-01-01', NULL, 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (-1, 'Australian GrAND Prix', 'Australian Grand Prix', 'default2', 'default1'), (101, 'Australian Grand Prix', 'default2', NULL, 'Australian GrAND Prix'), (2008, 'default2', 'Australian GrAND Prix', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2007, 'Australian Grand Prix', 'Australian Grand Prix', 'Australian GrAND Prix', 'Australian Grand Prix', 2009.0, 2.0, NULL, 'Australian Grand Prix');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (99, 100, 2007, 2007, 'Australian GrAND Prix', '2023-01-02', 'Australian GrAND Prix', NULL), (2009, 1, 2007, 2008, 'default2', '2023-01-01', 'default1', 'Australian Grand Prix'), (2008, 2008, 2007, 2, 'Australian GrAND Prix', '2023-01-02', 'Australian Grand Prix', 'Australian GrAND Prix'), (2007, -1, 2007, 1, 'default1', '2023-01-02', 'Australian GrAND Prix', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 2008, 2008, -1, 2007, -1, 100, 2007, 'Australian Grand Prix', -1, 2008.0, 0, 'Australian GrAND Prix', 2007, 1, 99, 'default2', 'default1'), (2007, 99, 99, 2008, 2009, 0, 0, -1, 'default1', 0, 101.0, 1, 'default1', 1, 2007, 2, NULL, 'Australian Grand Prix'), (-1, 2007, 2007, 2008, 2, 1, 0, 0, 'Australian Grand Prix', -1, 99.0, 101, 'Australian GrAND Prix', 100, NULL, 2007, 'Australian GrAND Prix', 'Australian GrAND Prix'), (2008, 2008, 101, 2008, 100, 99, 99, -1, 'Australian Grand Prix', 99, 2.0, 0, 'default2', NULL, 1, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(NOT T1.time IS NULL, 1, 0)) AS REAL) * 100 / COUNT(T1.resultId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian GrAND Prix' AND T2.year = 2008;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT T2.time IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.raceId) AS completion_rate FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE T1.year = 2008 AND T1.name = 'Australian Grand Prix';

/*
Prediction Result:
(None,)
*/