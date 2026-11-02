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
INSERT INTO status (statusid, status) VALUES (2, 'default2'), (61, 'default1'), (3601, 'default2'), (59, 'default1'), (5, 'default1'), (3599, 'default1'), (1974, 'default1'), (1975, 'default2'), (0, 'default1'), (1, 'default1');
INSERT INTO seasons (year, url) VALUES (59, 'default1'), (5, 'default2'), (60, 'unique_2'), (1974, 'unique_3'), (1000, 'unique_4'), (1001, 'unique_5'), (1, 'unique_6'), (0, 'unique_7'), (2, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (61, 'default1', 0, 'default2', 'default1', 'default2', '2023-01-01', 'default1', 'default1'), (3, 'default2', 2, 'default2', 'default2', 'default2', '2023-01-02', 'default2', 'default2'), (1974, 'default1', 999, 'default1', 'default1', 'default2', NULL, 'default1', 'unique_2'), (1975, 'default1', 4, 'default2', 'default2', 'default2', '2023-01-01', NULL, 'unique_3'), (1, 'default2', 60, 'default1', 'default1', 'default1', '2023-01-01', 'default2', 'unique_4'), (999, 'default2', 1975, NULL, 'default2', 'default1', '2023-01-01', 'default2', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (6, 'default2', 'default1', 'default1', 'default2'), (0, 'default1', 'default2', 'default1', 'default1'), (3599, 'default1', 'unique_2', 'default2', 'default2'), (7, 'default1', 'unique_3', 'default2', 'default2'), (1974, 'default1', 'unique_4', 'default2', 'default1'), (2, 'default2', 'unique_5', 'default2', 'default2'), (3, 'default2', 'unique_6', 'default2', 'default1'), (61, 'default2', 'unique_7', 'default2', 'default2'), (1, 'default1', 'unique_8', NULL, 'default2'), (4, 'default1', 'unique_9', NULL, 'default2'), (5, 'default2', 'unique_10', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1001, 'default2', 'default2', 'default2', NULL, 3.0, 3599.0, 1975, 'default1'), (60, 'default1', 'default1', 'default2', 'default2', 61.0, 6.0, 61, 'default2'), (3, 'default2', 'default1', 'default1', 'default2', 6.0, 1976.0, 6, 'unique_2'), (3599, 'default2', 'default1', 'default1', 'default1', 5.0, 61.0, 7, 'unique_3'), (3601, 'default2', 'default2', 'default1', NULL, 0.0, 5.0, 61, 'unique_4'), (7, 'default2', 'default1', 'default2', 'default2', 1.0, 4.0, 59, 'unique_5'), (5, 'default2', 'default2', 'default1', 'default1', 0.0, 3601.0, 0, 'unique_6'), (1, 'default1', 'default1', NULL, 'default1', 1975.0, 2.0, 60, 'unique_7'), (0, 'default2', 'default2', NULL, NULL, NULL, 59.0, 3601, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1975, 1001, 3, 1, 'default1', '2023-01-01', NULL, 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 1975, 1974, 1, 0, 1, 59, 3601, 'default2', 5, 1001.0, 1975, NULL, 1976, 59, 4, NULL, NULL), (61, 1975, 61, 2, 59, 2, 3600, 3600, 'default2', 1000, 3600.0, 4, 'default2', 999, NULL, 1, 'default1', 'default2'), (7, 1975, 1974, 4, 5, 1976, 61, 60, 'default2', 59, 60.0, 2, NULL, 2, 1000, NULL, 'default2', 'default2'), (5, 1975, 61, 4, 5, 1000, 7, 1001, 'default1', 60, 1975.0, 2, 'default2', 999, 1000, 1974, 'default1', 'default2'), (4, 1975, 999, 7, 5, 1975, 1976, 0, 'default1', 0, 1974.0, 1975, 'default2', 61, 1, 3, 'default2', NULL), (1, 1975, 61, 6, 61, 1, 999, 59, 'default2', 1, 1.0, 2, NULL, 6, 4, 59, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.year, CAST(AVG(T3.milliseconds) AS REAL) / 1000 AS average_time_seconds FROM seasons AS T1 INNER JOIN races AS T2 ON T1.year = T2.year INNER JOIN results AS T3 ON T2.raceId = T3.raceId WHERE T3.positionOrder = 1 AND T1.year < 1975 GROUP BY T1.year;

/*
Prediction Result:
(1001, 0.006)
*/