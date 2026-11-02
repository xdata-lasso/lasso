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
INSERT INTO seasons (year, url) VALUES (346, 'default2'), (347, 'default1'), (0, '1:15%'), (348, '0:01:15'), (1, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (347, 'default2', 346, '1:15%', '0:01:15', 'default2', NULL, '0:01:15', '1:15%'), (0, '1:15%', 1, 'default2', '1:15%', 'default1', '2026-10-27', 'default1', 'default2'), (1, '0:01:15', 346, 'default2', 'default1', 'default1', NULL, '1:15%', '0:01:15'), (348, '1:15%', 348, '1:15%', 'default1', '0:01:15', '2023-01-02', '0:01:15', 'default1'), (346, 'default2', 0, NULL, '0:01:15', '1:15%', '2026-10-27', NULL, 'unique_4'), (2, 'default1', 346, NULL, '0:01:15', '1:15%', '2026-10-27', '1:15%', 'unique_5'), (3, '1:15%', 347, NULL, '0:01:15', 'default2', '2026-10-27', NULL, 'unique_6'), (4, 'default1', NULL, '1:15%', 'default1', 'default2', NULL, 'default2', 'unique_7'), (5, 'default1', 348, 'default2', 'default2', 'default1', '2023-01-01', 'default1', 'unique_8'), (6, '0:01:15', 347, '1:15%', 'default2', '0:01:15', '2026-10-27', NULL, 'unique_9'), (7, 'default1', 0, 'default2', '1:15%', 'default1', '2023-01-01', '1:15%', 'unique_10'), (8, '0:01:15', 346, '1:15%', 'default1', 'default2', '2023-01-02', NULL, 'unique_11'), (9, '0:01:15', 0, 'default2', '0:01:15', 'default1', '2026-10-27', NULL, 'unique_12'), (10, '0:01:15', 348, 'default2', 'default2', '0:01:15', '2023-01-01', '0:01:15', 'unique_13');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (346, '0:01:15', '0:01:15', NULL, '0:01:15'), (0, '1:15%', '1:15%', 'default1', 'default2'), (1, '1:15%', 'default1', '0:01:15', 'default1'), (347, '1:15%', 'default2', '1:15%', 'default2'), (348, '0:01:15', 'unique_4', '0:01:15', '1:15%'), (2, '1:15%', 'unique_5', 'default1', '0:01:15'), (3, 'default1', 'unique_6', '1:15%', 'default1'), (4, 'default1', 'unique_7', '0:01:15', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (347, 'default2', '1:15%', '1:15%', 'default1', 347.0, 346.0, 346, 'default2'), (0, '1:15%', 'default1', 'default1', 'default1', 348.0, 0.0, NULL, 'default1'), (1, '1:15%', 'default1', NULL, 'default2', 1.0, NULL, 347, '0:01:15'), (346, '1:15%', 'default1', '1:15%', '0:01:15', 348.0, 347.0, 346, '1:15%'), (348, 'default2', '1:15%', '1:15%', '0:01:15', 0.0, NULL, NULL, 'unique_4'), (2, '0:01:15', '1:15%', '0:01:15', '1:15%', 0.0, 346.0, 348, 'unique_5'), (3, '0:01:15', '1:15%', '1:15%', 'default2', 0.0, NULL, 347, 'unique_6'), (4, '0:01:15', '0:01:15', 'default2', NULL, NULL, NULL, NULL, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (347, 0, 4, 347, '1:15%', '2023-01-02', '0:01:15', '0:01:15');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (347, 347, 1, 4, 347, NULL, '0:01:15', '0:01:15', NULL), (0, 347, 3, 3, 1, 348, 'default1', 'default2', '0:01:15'), (348, 347, 347, 4, 346, 346, '0:01:15', NULL, 'default1'), (1, 347, 0, 2, 0, 348, 'default2', '0:01:15', 'default1'), (346, 347, 8, 2, 0, 347, '1:15%', NULL, NULL), (2, 347, 1, 4, 348, 346, '1:15%', '0:01:15', '0:01:15'), (3, 347, 346, 2, 0, 347, NULL, 'default2', 'default1'), (4, 347, 0, 3, 348, 0, 'default1', 'default1', NULL), (5, 347, 7, 4, 347, NULL, NULL, '0:01:15', NULL), (6, 347, 8, 3, 347, 348, 'default2', NULL, 'default1'), (7, 347, 3, 0, 0, 346, 'default2', '1:15%', 'default2'), (8, 347, 10, 4, 347, NULL, '1:15%', '1:15%', '0:01:15'), (9, 347, 9, 4, 348, NULL, NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 347 AND T1.q2 LIKE '1:15%';

/*
Gold Result:
(None,)
('0:01:15',)
*/

-- Prediction Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceid = 347 AND T2.q2 LIKE '0:01:15';

/*
Prediction Result:
('default1',)
('1:15%',)
('1:15%',)
('1:15%',)
*/