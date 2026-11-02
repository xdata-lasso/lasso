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
INSERT INTO status (statusid, status) VALUES (2008, 'default1'), (2009, 'default2'), (-1, 'default2'), (100, 'Australian Grand Prix'), (2007, 'default2');
INSERT INTO seasons (year, url) VALUES (2008, 'Australian GrAND Prix'), (101, 'Australian Grand Prix');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2009, 'Australian Grand Prix', -1, NULL, 'default1', 'Australian GrAND Prix', NULL, 'Australian Grand Prix', 'default1'), (2008, 'default1', 2, 'default1', 'Australian Grand Prix', 'Australian Grand Prix', NULL, NULL, 'Australian GrAND Prix'), (2007, 'Australian GrAND Prix', 2007, NULL, 'default1', 'default1', '2023-01-01', 'default2', 'Australian Grand Prix'), (0, 'Australian Grand Prix', 0, NULL, 'Australian Grand Prix', 'default1', '2023-01-02', 'default1', 'default2'), (1, 'Australian Grand Prix', 100, 'default1', 'default1', 'default2', '2023-01-01', 'default1', 'unique_4'), (2, 'default2', 0, NULL, 'default2', 'Australian Grand Prix', NULL, NULL, 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (100, 'Australian Grand Prix', 'default1', NULL, 'Australian GrAND Prix'), (2, 'Australian Grand Prix', 'Australian Grand Prix', 'default2', 'default1'), (2008, 'Australian GrAND Prix', 'Australian GrAND Prix', 'default1', 'default2'), (2007, 'Australian Grand Prix', 'default2', 'Australian GrAND Prix', 'Australian GrAND Prix'), (2009, 'default2', 'unique_4', 'Australian GrAND Prix', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'default1', NULL, 'default2', 2009.0, 2.0, 2008, 'default2'), (0, 'Australian Grand Prix', 'Australian GrAND Prix', 'Australian Grand Prix', 'default2', 2008.0, 2008.0, 100, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2008, 101, 0, 2, 'Australian Grand Prix', '2023-01-02', 'Australian GrAND Prix', 'Australian Grand Prix'), (99, 101, 0, 100, 'default2', '2023-01-01', NULL, NULL), (-1, 2008, 0, 2007, 'Australian Grand Prix', '2023-01-01', 'Australian Grand Prix', 'default1'), (100, 101, 2, 2008, 'Australian Grand Prix', '2023-01-01', NULL, 'default2'), (1, 101, 0, 0, 'Australian Grand Prix', '2023-01-01', 'Australian GrAND Prix', 'Australian GrAND Prix'), (2, 101, 2, 1, 'Australian GrAND Prix', '2023-01-01', NULL, 'unique_5'), (101, 101, 2, 2007, 'Australian Grand Prix', '2023-01-01', 'default1', 'unique_6'), (0, 101, 0, 2009, 'Australian Grand Prix', '2023-01-01', 'Australian Grand Prix', 'unique_7'), (2009, 101, 2, 2009, 'default1', '2023-01-02', 'default1', 'unique_8'), (2007, 2008, 0, 2007, 'Australian Grand Prix', '2023-01-01', 'default2', 'unique_9'), (3, 101, 0, 2, 'default1', '2023-01-01', 'default1', 'unique_10'), (4, 101, 2, 100, 'default2', '2023-01-01', 'Australian GrAND Prix', 'unique_11'), (5, 101, 0, 99, 'Australian GrAND Prix', '2023-01-02', 'Australian GrAND Prix', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 99, 2008, 2007, 100, 100, 2, 2008, 'Australian GrAND Prix', -1, 101.0, 2, 'Australian GrAND Prix', 2008, 1, NULL, 'Australian GrAND Prix', NULL), (101, 2007, 2007, 2, 2009, 2, 100, 100, 'Australian GrAND Prix', 99, 101.0, 1, NULL, 100, 0, 100, NULL, 'Australian Grand Prix'), (0, 2, 1, 2009, -1, 2007, 100, 2008, 'default1', 100, 100.0, 0, 'default2', 100, 2007, 2009, 'Australian GrAND Prix', 'Australian GrAND Prix'), (2, 1, 0, 2009, 2008, 2007, -1, 0, 'Australian Grand Prix', 0, 2008.0, 2007, 'Australian Grand Prix', 2008, -1, 100, NULL, 'Australian Grand Prix'), (2009, 2009, 2009, 2, -1, 2, 2009, -1, 'Australian Grand Prix', 2009, 1.0, 101, NULL, 100, 1, 100, 'Australian GrAND Prix', 'Australian Grand Prix'), (100, 4, 2009, 2009, -1, NULL, 0, 101, 'Australian Grand Prix', 99, 99.0, 100, 'default1', 2009, -1, 101, 'default1', 'Australian GrAND Prix'), (99, 101, 2007, 2008, 2008, NULL, 2009, 101, 'Australian Grand Prix', 2009, 101.0, 100, 'Australian GrAND Prix', 2009, 100, 2008, 'default2', 'Australian GrAND Prix'), (-1, 5, 2008, 2009, 2008, 2009, 2009, 99, 'Australian Grand Prix', 2, 101.0, 2009, 'default2', 2, NULL, 101, NULL, 'Australian Grand Prix'), (2008, 101, 1, 2, 2008, 2008, 101, 2008, 'Australian GrAND Prix', 2007, 1.0, 100, 'default2', 101, NULL, 99, NULL, 'Australian GrAND Prix'), (2007, -1, 2, 2, 100, 1, 101, 2008, 'default1', 100, 1.0, 1, NULL, 1, 101, 99, NULL, 'default2'), (3, 101, 2007, 2, 2008, 99, 0, 100, 'default1', 99, -1.0, 2, NULL, 101, 101, 101, NULL, 'default1'), (4, 4, 2007, 2007, 2008, 1, 2009, 99, 'default2', 0, 100.0, -1, 'default2', 101, 2, 2007, 'Australian Grand Prix', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(NOT T1.time IS NULL, 1, 0)) AS REAL) * 100 / COUNT(T1.resultId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian GrAND Prix' AND T2.year = 2008;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT "results"."time" IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT("results"."raceid") FROM "results" INNER JOIN "races" ON "results"."raceid" = "races"."raceid" WHERE "races"."year" = 2008 AND "races"."name" = 'Australian Grand Prix';

/*
Prediction Result:
(0.0,)
*/