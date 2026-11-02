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
INSERT INTO status (statusid, status) VALUES (61, '%s'), (59, 'default1');
INSERT INTO seasons (year, url) VALUES (1975, 'default1'), (59, 'default2'), (3600, '%s'), (3599, '00:00:00'), (7, 'unique_4'), (1976, 'unique_5'), (3, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1975, 'default1', 59, NULL, 'default1', 'default2', '2023-01-02', 'default1', '00:00:00'), (3601, 'default2', 0, 'default2', 'default2', '00:00:00', '2023-01-01', 'default1', 'default1'), (3600, 'default2', 59, NULL, '00:00:00', 'default2', '2023-01-02', '%s', 'default2'), (1976, '%s', 61, '00:00:00', '%s', 'default2', NULL, '00:00:00', '%s'), (7, '%s', 3, '%s', 'default2', 'default1', NULL, '%s', 'unique_4'), (5, 'default2', 1975, 'default1', 'default2', '%s', NULL, 'default1', 'unique_5'), (6, 'default2', 60, 'default1', 'default1', '00:00:00', NULL, 'default2', 'unique_6'), (1, 'default1', 61, 'default2', 'default2', '00:00:00', '2026-10-27', 'default1', 'unique_7'), (0, 'default2', 4, 'default1', 'default2', '%s', NULL, 'default1', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (60, 'default1', '%s', '00:00:00', '%s'), (59, 'default1', 'default1', 'default2', '00:00:00'), (1976, 'default2', 'default2', NULL, '%s'), (1975, 'default2', '00:00:00', '00:00:00', 'default1'), (2, 'default2', 'unique_4', '00:00:00', 'default1'), (6, 'default2', 'unique_5', 'default2', '00:00:00'), (1, 'default2', 'unique_6', 'default1', 'default1'), (0, '00:00:00', 'unique_7', '00:00:00', '%s');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (4, '00:00:00', 'default2', '00:00:00', 'default1', 3601.0, 60.0, 5, 'default2'), (1974, 'default2', '00:00:00', '%s', '%s', 0.0, 3601.0, 0, '%s'), (3601, '00:00:00', '00:00:00', '00:00:00', '00:00:00', 0.0, 3601.0, 2, 'default1'), (6, 'default2', 'default2', 'default2', 'default2', 6.0, 1975.0, 7, '00:00:00'), (61, '%s', 'default1', '%s', 'default2', 59.0, 2.0, 59, 'unique_4'), (59, 'default2', '00:00:00', '00:00:00', '%s', NULL, 3601.0, 3, 'unique_5'), (1, 'default2', 'default1', 'default1', 'default1', 60.0, 0.0, 60, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (4, 1975, 1, 1975, '00:00:00', '2023-01-02', NULL, '%s'), (61, 1975, 1974, 1, '%s', '2023-01-02', '%s', 'default2'), (1, 1975, 4, 6, '00:00:00', '2026-10-27', 'default2', 'default1'), (3, 59, 59, 3599, '%s', '2026-10-27', NULL, '00:00:00'), (60, 1976, 3601, 0, '%s', '2026-10-27', 'default1', NULL), (5, 3599, 4, 6, 'default1', '2023-01-01', NULL, 'unique_5'), (0, 3, 59, 60, '%s', '2023-01-02', '00:00:00', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1974, 5, 6, 1976, 59, 2, 4, 5, 'default1', 1975, 3599.0, 5, 'default1', 61, 61, 1975, NULL, NULL), (3, 3, 1976, 60, 61, 3599, 3, 59, 'default2', 3601, 59.0, 4, '00:00:00', NULL, 1975, 1975, '%s', 'default2'), (1, 61, 1975, 6, 59, 61, 3601, 6, '%s', 2, 1.0, 5, 'default1', 3, 7, 3601, '00:00:00', NULL), (7, 4, 1, 60, 59, 1976, 7, NULL, '%s', 7, 3.0, 1, 'default2', 7, 3, 3599, '00:00:00', '%s'), (3601, 61, 0, 1976, 61, 3601, 3601, 4, '00:00:00', 1, 7.0, 1, 'default1', 4, 6, 1976, 'default1', 'default1'), (1976, 5, 1975, 2, 61, 3600, 61, 3600, '00:00:00', 1974, 7.0, 4, 'default2', 1974, 1974, 60, 'default1', '%s'), (6, 1, 7, 1976, 61, 3601, 1975, 1975, 'default2', 3599, 3601.0, 2, NULL, 59, 3600, 2, 'default1', '%s'), (2, 60, 3600, 1, 59, NULL, 6, 59, 'default2', 0, 3.0, 61, 'default2', 59, 7, 1, 'default1', NULL), (5, 0, 6, 60, 61, 4, 4, 7, 'default1', 0, 2.0, 2, 'default2', 59, 3600, 2, 'default2', NULL), (0, 5, 7, 59, 61, NULL, 60, 4, 'default1', 61, 5.0, 60, 'default1', 1976, 1976, 59, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
(1975, 0.0)
*/

-- Prediction Query
SELECT s.year, AVG(CAST(STRFTIME('%s', r.time) - STRFTIME('%s', '00:00:00') AS REAL)) AS avg_time_in_seconds FROM drivers AS d JOIN results AS r ON d.driverId = r.driverId JOIN races AS ra ON r.raceId = ra.raceId JOIN seasons AS s ON ra.year = s.year WHERE s.year < 1975 AND r.position = 1 GROUP BY s.year;

/*
Prediction Result:
*/