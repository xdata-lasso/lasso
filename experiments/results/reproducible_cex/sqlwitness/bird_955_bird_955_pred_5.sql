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
INSERT INTO status (statusid, status) VALUES (61, 'default1'), (3, 'default1'), (7, 'default1'), (6, 'default1'), (3601, '%S'), (1974, '%M'), (1976, '%S'), (2, 'default2'), (1, '%H'), (0, '%S'), (4, '%M');
INSERT INTO seasons (year, url) VALUES (3, '%M');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (7, '%M', 2, NULL, '%H', '%H', '2023-01-01', 'default2', '%M'), (1974, 'default2', 60, 'default2', 'default2', '%H', NULL, 'default2', 'default1'), (3599, '%H', 1, NULL, 'default2', '%M', '2023-01-02', '%S', 'default2'), (1976, '%S', 5, '%H', 'default2', 'default1', '2023-01-01', '%H', '%H'), (60, 'default2', 59, 'default2', 'default2', '%S', '2023-01-02', 'default1', '%S'), (61, '%H', 1975, 'default2', '%S', '%S', '2023-01-02', 'default1', 'unique_5'), (1, '%H', 5, '%S', 'default2', 'default1', NULL, 'default2', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1975, '%M', '%H', 'default2', 'default1'), (3, '%H', 'default2', '%S', 'default2'), (60, '%S', '%M', '%H', '%H'), (3600, 'default2', '%S', '%H', '%S'), (7, '%H', 'default1', 'default2', '%S'), (1, 'default2', 'unique_5', '%H', '%S'), (0, '%M', 'unique_6', NULL, '%H'), (2, '%S', 'unique_7', '%S', '%S'), (4, '%H', 'unique_8', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (6, 'default1', '%M', 'default1', 'default1', 1.0, 1.0, 3, 'default2'), (61, 'default1', '%H', '%H', NULL, 0.0, 2.0, 3599, '%S'), (1976, 'default2', 'default1', 'default1', 'default2', 60.0, 6.0, 1, '%H'), (1, 'default2', '%S', '%S', '%S', 60.0, 4.0, 59, '%M'), (2, '%M', '%H', NULL, 'default1', 59.0, 60.0, 1975, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (5, 3, 1976, 59, 'default2', '2023-01-02', '%S', 'default2'), (7, 3, 2, 4, '%M', '2023-01-02', '%H', 'default1'), (1975, 3, 1, 3599, '%H', '2023-01-01', 'default2', '%M'), (1, 3, 1976, 6, '%M', '2023-01-02', 'default1', '%H');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (61, 1, 1976, 1975, 2, 7, 4, 6, '%S', 1, 3.0, 6, 'default1', 59, 61, NULL, NULL, '%M'), (6, 5, 61, 7, 1, 1976, 1976, 4, '%S', 7, 61.0, 1, 'default2', 7, 7, 1975, '%S', 'default1'), (2, 1, 1, 7, 2, 4, 1, 61, '%H', 1, 1974.0, 1976, '%S', 4, 3599, 3599, '%S', '%H'), (3, 7, 1, 4, 0, 60, 60, 61, 'default2', 61, 1974.0, 60, NULL, 3600, 2, 3601, '%H', '%S'), (59, 7, 1974, 60, 1976, NULL, 1975, 2, '%H', 1975, 7.0, 7, '%S', 1975, 3600, 61, NULL, '%H'), (1974, 7, 7, 4, 7, 2, 3, 4, '%H', 61, 7.0, 5, NULL, 7, 3600, 3601, 'default1', NULL), (1, 1, 1974, 3600, 1, 59, 5, 1, '%M', 61, 5.0, 1, 'default2', 59, 3601, 1974, '%H', '%H'), (0, 5, 1, 7, 61, 1976, 4, 3, 'default2', 1976, 7.0, 61, NULL, 3, 1974, 1975, '%H', '%S'), (4, 5, 1, 1, 1974, 4, 1, 0, 'default1', 3, 1976.0, 61, '%H', 1975, 7, 2, '%M', '%S'), (5, 1975, 1, 60, 3, 60, 3, 3601, '%H', 3600, 60.0, 59, '%H', 3601, 60, 61, 'default1', '%M'), (7, 5, 1974, 1, 6, 1, 61, 3600, '%M', 3600, 1.0, 1, 'default2', 3, 1974, 1974, 'default2', 'default2'), (3600, 7, 60, 3600, 1974, 1974, 3, 1974, 'default2', 61, 5.0, 4, '%H', 2, 59, 7, 'default2', '%M'), (3599, 5, 60, 7, 1974, 2, 0, NULL, 'default2', 1, 3.0, 3600, '%S', 0, 7, 3600, '%S', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
(3, 0.0)
*/

-- Prediction Query
SELECT T1.year, AVG(STRFTIME('%H', T2.time) * 3600 + STRFTIME('%M', T2.time) * 60 + STRFTIME('%S', T2.time)) AS average_time_seconds FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE T2.position = 1 AND T1.year < 1975 GROUP BY T1.year;

/*
Prediction Result:
(3, None)
*/