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
INSERT INTO status (statusid, status) VALUES (8, 'default1'), (7, 'default2'), (3599, 'default1'), (2, 'default2'), (1, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (8, 'default2'), (0, 'unique_2'), (1975, 'unique_3'), (2, 'unique_4'), (7, 'unique_5'), (3, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (61, 'default2', 3599, 'default2', 'default1', 'default2', '2023-01-01', 'default2', 'default1'), (1974, 'default1', 0, 'default2', 'default1', 'default2', '2023-01-01', NULL, 'default2'), (4, 'default1', 60, 'default1', 'default1', 'default1', '2023-01-02', NULL, 'unique_2');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (3599, 'default1', 'default1', 'default1', 'default2'), (1, 'default1', 'default2', NULL, 'default2'), (1974, 'default1', 'unique_2', 'default1', 'default1'), (3600, 'default1', 'unique_3', 'default1', 'default2'), (0, 'default1', 'unique_4', 'default1', 'default2'), (2, 'default2', 'unique_5', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1975, 'default2', 'default1', 'default2', 'default2', 1.0, 60.0, 3599, 'default2'), (3, 'default2', 'default2', 'default1', 'default1', 8.0, 7.0, 5, 'default1'), (7, 'default1', 'default1', 'default1', 'default2', 3599.0, 8.0, 1975, 'unique_2'), (61, 'default1', 'default2', NULL, 'default1', 5.0, 3599.0, 3, 'unique_3'), (3599, 'default2', 'default1', 'default1', NULL, 1975.0, 59.0, 61, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 1975, 3599, 0, 'default2', '2023-01-01', NULL, 'default2'), (3601, 2, 61, 1974, 'default2', '2023-01-02', NULL, 'default1'), (61, 2, 1975, 7, 'default1', '2023-01-02', 'default2', NULL), (2, 0, 3599, 8, 'default2', '2023-01-02', 'default2', 'unique_3'), (4, 3, 3599, 5, 'default1', '2023-01-01', NULL, 'unique_4');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (6, 3601, 4, 1974, 2, 59, 6, 2, 'default1', 3, 3.0, 60, 'default2', 8, 59, 8, NULL, 'default1'), (0, 1, 1974, 3600, 2, 4, 4, 0, 'default2', 59, 5.0, 2, NULL, 61, 3, 1975, 'default1', 'default1'), (1974, 2, 1974, 3600, 1, 3599, 3600, 1, 'default1', 60, 1976.0, 5, 'default1', 59, 1, 60, NULL, NULL), (3601, 3601, 4, 3600, 2, 60, 6, 1974, 'default1', 1, 60.0, 1974, 'default2', 59, 1974, 61, 'default1', NULL), (61, 3601, 1974, 3599, 3599, 3599, 5, 8, 'default1', 1, 4.0, 5, NULL, NULL, 8, 7, 'default1', NULL), (1, 4, 4, 3599, 7, 2, 0, 1974, 'default2', 7, 3601.0, 1974, 'default1', 3599, 0, NULL, 'default2', NULL), (2, 1, 4, 1, 3599, 0, 1, 1974, 'default1', 3, 6.0, 3599, 'default2', 4, 1974, 61, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
(2, 0.0)
*/

-- Prediction Query
SELECT "races"."year", AVG(CAST(SUBSTRING("results"."time", 1, 2) AS INTEGER) * 3600 + CAST(SUBSTRING("results"."time", 4, 2) AS INTEGER) * 60 + CAST(SUBSTRING("results"."time", 7) AS REAL)) AS avg_time_seconds FROM "races" INNER JOIN "results" ON "races"."raceId" = "results"."raceId" WHERE "results"."position" = 1 AND NOT "results"."time" IS NULL AND "races"."year" < 1975 GROUP BY "races"."year";

/*
Prediction Result:
(0, 0.0)
*/