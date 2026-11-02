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
INSERT INTO status (statusid, status) VALUES (3601, 'default2'), (3, '00:00:00'), (3599, 'default2'), (-1, 'default1'), (0, 'default2'), (1, '00:00:00');
INSERT INTO seasons (year, url) VALUES (7, 'default1'), (6, '00:00:00'), (5, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1975, 'default1', 59, '%s', 'default1', 'default2', '2026-10-27', '00:00:00', 'default2'), (59, 'default2', 3599, '00:00:00', 'default1', '00:00:00', '2023-01-01', '00:00:00', 'default1'), (0, 'default1', 7, '%s', '%s', '%s', NULL, NULL, '%s');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (3599, 'default1', '%s', '%s', 'default1'), (3601, '00:00:00', 'default1', '%s', 'default2'), (5, '00:00:00', '00:00:00', 'default1', '%s'), (3600, '00:00:00', 'default2', 'default1', '%s'), (0, 'default2', 'unique_4', '00:00:00', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (7, 'default2', 'default1', '00:00:00', '%s', 3.0, -1.0, 60, 'default1'), (3599, 'default1', 'default1', 'default2', 'default1', NULL, 4.0, 1974, '00:00:00');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (3, 5, 7, 5, 'default2', '2026-10-27', '00:00:00', '%s'), (3599, 6, 7, 3, '%s', '2023-01-02', '%s', NULL);
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (3601, 3, 59, 5, 3, 3, 3600, 0, 'default1', 7, 3599.0, 6, 'default1', 3600, 6, 1975, '00:00:00', '00:00:00'), (61, 3, 1975, 3600, 3599, 3599, 1974, 0, 'default2', 5, 60.0, 1974, NULL, 3600, 1, 59, '%s', 'default2'), (1, 3, 1975, 3600, -1, 3600, 5, 61, '%s', 1974, 4.0, 4, 'default1', 1, 3599, 5, '%s', '%s'), (1974, 3, 1975, 3601, 0, 3600, -1, 6, '00:00:00', 4, 0.0, 1976, 'default2', 1975, 7, 61, NULL, 'default1'), (1975, 3, 59, 3600, 0, 3599, 1975, 4, '00:00:00', 60, 3599.0, 1974, '%s', 59, 60, 4, '00:00:00', 'default1'), (0, 3599, 1975, 3601, 3, 3601, 1975, 7, '%s', 1976, 1974.0, 1975, 'default2', NULL, 1976, 1974, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT r.year, AVG(CAST(STRFTIME('%s', r.time) AS REAL) - CAST(STRFTIME('%s', '00:00:00') AS REAL)) AS average_time_seconds FROM races AS r INNER JOIN results AS res ON r.raceId = res.raceId WHERE r.year < 1975 AND res.points > 0 GROUP BY r.year;

/*
Prediction Result:
(5, 0.0)
(6, None)
*/