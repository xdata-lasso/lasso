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
INSERT INTO status (statusid, status) VALUES (1, 'default2'), (3601, 'default1'), (100, 'Australian Grand Prix'), (60, 'Australian Grand Prix'), (0, 'default2');
INSERT INTO seasons (year, url) VALUES (3, 'Australian Grand Prix'), (99, 'default2'), (3601, 'default1'), (60, 'unique_3'), (7, 'unique_4'), (2008, 'unique_5'), (2007, 'unique_6'), (1, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (61, 'default1', 59, 'Australian Grand Prix', 'default1', 'default1', NULL, 'default1', 'Australian Grand Prix'), (2008, 'default2', 99, NULL, 'default2', 'default2', '2023-01-02', 'default1', 'default2'), (5, 'default1', 3599, 'default2', 'Australian Grand Prix', 'Australian Grand Prix', NULL, NULL, 'default1'), (1, 'default2', 2, 'default2', 'Australian Grand Prix', 'default2', '2023-01-01', NULL, 'unique_3'), (2, 'Australian Grand Prix', 3600, NULL, 'default1', 'Australian Grand Prix', '2023-01-02', 'default1', 'unique_4'), (59, 'default2', 60, 'default1', 'default2', 'Australian Grand Prix', '2023-01-01', 'default1', 'unique_5'), (6, 'default2', 3, NULL, 'default1', 'default2', '2023-01-01', 'default1', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2009, 'default2', 'default2', 'Australian Grand Prix', 'default1'), (1, 'default1', 'default1', 'Australian Grand Prix', 'Australian Grand Prix'), (2007, 'default1', 'Australian Grand Prix', 'Australian Grand Prix', 'default2'), (3599, 'default2', 'unique_3', 'Australian Grand Prix', 'Australian Grand Prix'), (3, 'Australian Grand Prix', 'unique_4', 'Australian Grand Prix', 'default1'), (99, 'Australian Grand Prix', 'unique_5', 'default2', 'default1'), (4, 'default1', 'unique_6', NULL, 'default2'), (6, 'Australian Grand Prix', 'unique_7', 'default1', 'default1'), (0, 'default1', 'unique_8', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3, 'default2', 'default1', 'Australian Grand Prix', 'Australian Grand Prix', 100.0, NULL, 2, 'default2'), (2007, 'default1', 'default1', 'default2', NULL, 3601.0, 7.0, 3599, 'Australian Grand Prix'), (4, 'default1', 'default1', 'default1', 'default1', 2009.0, 99.0, 100, 'default1'), (1, 'Australian Grand Prix', 'default2', 'default1', 'Australian Grand Prix', 2008.0, 60.0, 3, 'unique_3');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (99, 7, 1, 3599, 'Australian Grand Prix', '2023-01-01', NULL, 'Australian Grand Prix'), (6, 60, 3, 2009, 'default1', '2023-01-01', 'default1', 'default2'), (59, 3, 4, 7, 'default2', '2023-01-02', NULL, 'default1'), (61, 99, 3, 1, 'default2', '2023-01-01', 'default2', NULL), (2009, 3, 2007, 60, 'default2', '2023-01-01', 'default1', 'unique_4'), (1, 99, 4, 2009, 'Australian Grand Prix', '2023-01-01', 'default2', 'unique_5'), (0, 2008, 2007, 3, 'Australian Grand Prix', '2023-01-02', 'default1', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (60, 59, 5, 6, 60, 2007, 6, 2008, 'Australian Grand Prix', 101, 1.0, 4, 'default1', 61, 2, 2008, NULL, 'Australian Grand Prix'), (59, 0, 2008, 99, 1, 99, 100, 99, 'Australian Grand Prix', 1, 99.0, 4, NULL, 3600, 60, 3, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian Grand Prix' AND NOT T1.time IS NULL AND T2.year = 2008), champion_time AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = 1), last_driver_incremental AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = (SELECT MAX(positionOrder) FROM time_in_seconds)) SELECT (CAST((SELECT time_seconds FROM last_driver_incremental) AS REAL) * 100) / (SELECT time_seconds + (SELECT time_seconds FROM last_driver_incremental) FROM champion_time);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST((MIN(milliseconds) - MAX(milliseconds)) AS REAL) * 100 / MIN(milliseconds) FROM results WHERE raceId = (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix');

/*
Prediction Result:
(0.0,)
*/