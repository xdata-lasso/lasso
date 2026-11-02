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
INSERT INTO status (statusid, status) VALUES (59, 'default2'), (3600, 'default1'), (3599, 'default2'), (9, 'default2'), (6, 'default2'), (1975, 'Finished'), (1, 'default2');
INSERT INTO seasons (year, url) VALUES (1975, 'default2'), (11, 'default1'), (9, 'Finished');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1975, 'default1', 60, 'default1', 'Finished', 'Finished', '2023-01-01', NULL, 'default2'), (59, 'Finished', 59, 'Finished', 'default2', 'default2', '2023-01-01', 'default2', 'default1'), (9, 'default1', 9, NULL, 'default1', 'Finished', '2023-01-02', NULL, 'Finished'), (10, 'default2', 3, 'default2', 'default1', 'Finished', '2023-01-01', 'default2', 'unique_3');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1976, 'Finished', 'Finished', 'default2', 'Finished'), (3600, 'default1', 'default2', 'Finished', 'default2'), (1, 'default1', 'default1', NULL, 'Finished'), (1974, 'default1', 'unique_3', 'Finished', 'Finished'), (5, 'default2', 'unique_4', 'Finished', 'default2'), (4, 'default2', 'unique_5', NULL, 'default1'), (3599, 'default2', 'unique_6', 'default1', 'default1'), (1000, 'default2', 'unique_7', 'default1', 'Finished'), (9, 'default2', 'unique_8', 'default2', 'default1'), (0, 'default2', 'unique_9', 'default2', 'default1'), (2, 'Finished', 'unique_10', 'default1', 'Finished');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3600, 'Finished', 'Finished', 'Finished', 'default1', 3600.0, 5.0, 3, 'default1'), (1000, 'Finished', 'default1', 'default1', 'default1', 2.0, 61.0, 4, 'default2'), (7, 'default2', 'Finished', 'Finished', NULL, 1.0, 3.0, 6, 'Finished'), (1001, 'default1', 'default2', 'default1', 'default1', 3601.0, 4.0, NULL, 'unique_3'), (8, 'default2', 'Finished', 'default1', NULL, NULL, 1001.0, 0, 'unique_4'), (61, 'Finished', 'default2', NULL, 'Finished', 59.0, 6.0, 0, 'unique_5'), (3601, 'default1', 'default1', 'Finished', 'default1', 1001.0, 7.0, 999, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (11, 9, 61, 1000, 'default2', '2023-01-02', 'default2', 'default1'), (999, 1975, 7, 10, 'Finished', '2023-01-02', NULL, 'Finished'), (4, 11, 3601, 1975, 'default1', '2023-01-02', 'default1', 'default2'), (3600, 1975, 3600, 61, 'default2', '2023-01-02', NULL, NULL);
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (59, 4, 9, 1, 3600, 6, 3601, 4, 'default1', 61, 5.0, 1974, 'default2', 5, 3601, 1974, NULL, NULL), (1974, 4, 59, 1000, 1975, NULL, 8, 5, 'default1', 3599, 3599.0, 7, NULL, 7, 1975, 3600, 'Finished', NULL), (1, 3600, 9, 4, 1, 3599, 3, 60, 'default2', 3600, 1975.0, 1975, 'default2', 3600, 1974, 59, 'default2', NULL), (0, 3600, 1975, 1974, 3599, NULL, 61, 11, 'default1', 1974, 59.0, 1000, 'default2', 0, 9, 3600, 'default2', 'default1'), (2, 3600, 59, 1000, 9, 1974, 5, 10, 'default1', 9, 2.0, 7, 'default2', 1000, 2, 1974, 'Finished', 'default2'), (3, 11, 1975, 5, 1, 61, 3600, 3601, 'default2', 9, 60.0, 4, 'Finished', 1974, 60, 9, 'default2', NULL), (4, 4, 1975, 2, 59, 999, 59, 3599, 'default2', 59, 61.0, 8, 'default2', 1974, 1976, 11, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
*/

-- Prediction Query
SELECT r.year, AVG(CAST(SUBSTRING(res.time, 1, 2) AS INTEGER) * 3600 + CAST(SUBSTRING(res.time, 4, 2) AS INTEGER) * 60 + CAST(SUBSTRING(res.time, 7, 2) AS INTEGER) + CAST(SUBSTRING(res.time, 10, 3) AS REAL) / 1000) AS average_time_seconds FROM results AS res INNER JOIN races AS r ON res.raceId = r.raceId INNER JOIN status AS s ON res.statusId = s.statusId WHERE r.year < 1975 AND s.status = 'Finished' GROUP BY r.year;

/*
Prediction Result:
(11, None)
*/