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
INSERT INTO status (statusid, status) VALUES (3601, 'default1'), (1, 'default2'), (5, 'default2'), (2, 'default2');
INSERT INTO seasons (year, url) VALUES (2, 'default1'), (60, 'default2'), (3600, 'unique_2'), (3599, 'unique_3'), (61, 'unique_4'), (7, 'unique_5'), (11, 'unique_6'), (5, 'unique_7'), (3601, 'unique_8'), (1, 'unique_9'), (0, 'unique_10'), (3, 'unique_11'), (4, 'unique_12');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (5, 'default2', 3, 'default2', 'default2', 'default2', '2023-01-02', 'default1', 'default1'), (3, 'default1', 3600, 'default1', 'default2', 'default2', '2023-01-02', NULL, 'default2'), (4, 'default2', 3, 'default1', 'default2', 'default1', NULL, NULL, 'unique_2'), (59, 'default1', 1, 'default2', 'default1', 'default2', '2023-01-02', NULL, 'unique_3'), (3599, 'default1', 5, NULL, 'default2', 'default1', '2023-01-01', NULL, 'unique_4'), (1, 'default2', 1, NULL, 'default1', 'default1', NULL, NULL, 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (60, 'default2', 'default1', 'default2', 'default1'), (3601, 'default2', 'default2', NULL, 'default2'), (1, 'default1', 'unique_2', 'default2', 'default1'), (61, 'default2', 'unique_3', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3599, 'default1', 'default2', 'default1', 'default2', 7.0, 5.0, 0, 'default2'), (3, 'default2', 'default1', 'default1', 'default1', 61.0, 0.0, 3, 'default1'), (4, 'default2', 'default1', 'default1', NULL, 10.0, 3601.0, 0, 'unique_2'), (3600, 'default1', 'default2', 'default1', NULL, 3599.0, 6.0, 3599, 'unique_3'), (11, 'default1', 'default2', 'default1', 'default2', 0.001, -0.999, 1, 'unique_4'), (6, 'default1', 'default2', 'default2', NULL, -0.999, 0.0, 8, 'unique_5'), (8, 'default1', 'default1', NULL, NULL, 1.001, 3601.0, 10, 'unique_6'), (1, 'default2', 'default1', 'default2', 'default2', NULL, 2.0, 4, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (3600, 2, 3, 3599, 'default2', '2023-01-02', 'default2', NULL), (4, 3, 3, 10, 'default2', '2023-01-02', 'default2', 'default1'), (61, 0, 1, 0, 'default1', '2023-01-01', 'default2', 'default2'), (1, 61, 3599, 2, 'default1', '2023-01-02', 'default2', 'unique_3');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (60, 1, 59, 1, 3601, 8, 3599, 8, 'default2', 61, 0.001, 59, 'default2', 3599, 59, 60, NULL, NULL), (3601, 3600, 59, 61, 2, 3, 3, 4, 'default2', 6, 7.0, 3599, 'default1', 60, 10, 1, 'default2', 'default2'), (4, 1, 4, 61, 5, 11, 2, 59, 'default2', 3600, 3601.0, 11, NULL, 61, 60, 61, NULL, 'default1'), (5, 3600, 59, 3601, 1, 10, 0, 59, 'default1', 2, 10.0, 6, NULL, 8, 61, 6, 'default2', NULL), (8, 4, 3599, 3601, 5, 61, 6, 9, 'default1', 59, 60.0, 2, 'default2', 10, NULL, 9, 'default2', 'default2'), (11, 4, 4, 61, 1, 11, 5, 61, 'default2', 3600, 8.0, 60, NULL, 61, 10, 59, 'default2', 'default2'), (1, 3600, 4, 1, 3601, 61, 60, 3, 'default2', 8, 0.001, 7, NULL, 3600, NULL, 3, 'default1', NULL), (0, 4, 4, 60, 3601, NULL, 61, 60, 'default1', 59, 11.0, 5, NULL, 10, 5, 3601, 'default2', 'default1'), (2, 61, 59, 61, 1, 11, 2, 4, 'default2', 8, 7.0, 5, 'default2', 4, 3601, 3600, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.year, AVG(SUBSTRING(T2.time, 1, 2) * 3600 + SUBSTRING(T2.time, 4, 2) * 60 + SUBSTRING(T2.time, 7, 2) + SUBSTRING(T2.time, 10, 3) * 0.001) AS average_seconds FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE NOT T2.time IS NULL GROUP BY T1.year;

/*
Prediction Result:
(0, 0.0)
(2, 0.0)
(3, 0.0)
(61, 0.0)
*/