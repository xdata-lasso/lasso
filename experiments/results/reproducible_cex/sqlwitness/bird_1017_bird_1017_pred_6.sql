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
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (0, '1:29.488'), (2, 'default2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 0, 'default1', 'default1', '1:29.488', NULL, 'default1', 'default2'), (1, 'default2', 1, NULL, 'default1', 'default2', '2023-01-01', NULL, 'default1'), (2, '1:29.488', 0, 'default2', 'default2', 'default2', '2023-01-01', 'default2', '1:29.488'), (3, 'default1', 1, 'default2', 'default2', '1:29.488', '2023-01-02', '1:29.488', 'unique_3'), (4, 'default1', 1, NULL, 'default2', '1:29.488', '2023-01-02', 'default1', 'unique_4'), (5, 'default1', NULL, 'default1', '1:29.488', '1:29.488', '2023-01-01', 'default2', 'unique_5'), (6, 'default2', NULL, NULL, '1:29.488', 'default2', '2023-01-02', NULL, 'unique_6'), (7, '1:29.488', 1, 'default2', '1:29.488', '1:29.488', '2023-01-02', NULL, 'unique_7'), (8, 'default1', 1, 'default1', 'default2', 'default1', '2026-10-27', 'default1', 'unique_8'), (9, 'default2', 0, 'default2', 'default1', '1:29.488', NULL, NULL, 'unique_9'), (10, 'default2', 0, 'default1', 'default1', 'default2', '2023-01-02', 'default2', 'unique_10'), (11, 'default2', 1, NULL, 'default1', 'default1', '2023-01-02', 'default1', 'unique_11'), (12, '1:29.488', 0, 'default1', 'default2', 'default1', '2023-01-02', '1:29.488', 'unique_12'), (13, 'default1', NULL, 'default2', 'default1', 'default1', '2026-10-27', '1:29.488', 'unique_13'), (14, 'default1', NULL, 'default2', '1:29.488', 'default2', '2023-01-02', NULL, 'unique_14'), (15, 'default2', 0, NULL, 'default2', 'default2', NULL, 'default1', 'unique_15');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', 'default2', NULL, NULL, NULL, 0.0, 0, '1:29.488'), (0, 'default1', 'default1', 'default1', NULL, NULL, NULL, NULL, 'default2'), (2, '1:29.488', '1:29.488', '1:29.488', NULL, 0.0, NULL, 0, 'default1'), (3, 'default2', '1:29.488', '1:29.488', NULL, NULL, NULL, 0, 'unique_3'), (4, 'default1', 'default2', 'default1', '1:29.488', 1.0, 1.0, 1, 'unique_4'), (5, 'default2', 'default2', '1:29.488', 'default2', 1.0, 1.0, 0, 'unique_5'), (6, '1:29.488', 'default1', 'default2', '1:29.488', 1.0, 1.0, 1, 'unique_6'), (7, '1:29.488', 'default1', 'default2', '1:29.488', 1.0, 0.0, 1, 'unique_7'), (8, 'default2', '1:29.488', 'default2', NULL, 1.0, NULL, NULL, 'unique_8'), (9, 'default2', 'default1', 'default1', '1:29.488', 0.0, NULL, 0, 'unique_9'), (10, 'default1', 'default1', 'default1', NULL, 0.0, NULL, NULL, 'unique_10'), (11, 'default1', 'default2', '1:29.488', 'default1', NULL, 0.0, 0, 'unique_11');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 3, 0, 1, 'default1', '2023-01-02', 'default2', 'default1'), (1, 9, 10, 1, 'default1', '2023-01-01', 'default2', 'default2'), (2, 14, 9, 0, '1:29.488', '2026-10-27', NULL, NULL), (3, 6, 11, 0, '1:29.488', '2026-10-27', NULL, '1:29.488'), (4, 4, 2, 1, 'default1', '2023-01-01', NULL, 'unique_4'), (5, 7, 9, 0, '1:29.488', '2023-01-02', NULL, 'unique_5'), (6, 5, 4, 1, '1:29.488', '2023-01-01', 'default2', 'unique_6'), (7, 3, 0, 0, '1:29.488', '2023-01-02', 'default1', 'unique_7'), (8, 5, 3, 1, 'default1', '2026-10-27', NULL, 'unique_8'), (9, 11, 6, 1, '1:29.488', '2023-01-02', 'default1', 'unique_9'), (10, 9, 7, 0, 'default2', '2023-01-01', '1:29.488', 'unique_10'), (11, 6, 0, 0, '1:29.488', '2023-01-02', 'default2', 'unique_11'), (12, 2, 8, 1, '1:29.488', '2026-10-27', 'default1', 'unique_12'), (13, 11, 1, 1, '1:29.488', '2023-01-02', NULL, 'unique_13'), (14, 8, 7, 1, '1:29.488', '2023-01-01', 'default1', 'unique_14'), (15, 2, 3, 1, 'default1', '2023-01-02', 'default2', 'unique_15');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (10, 0, 1, 0, '1:29.488', NULL), (5, 11, 0, NULL, '1:29.488', NULL), (3, 4, 0, 1, 'default1', NULL), (0, 12, 0, 0, 'default1', 0), (5, 1, 1, NULL, 'default1', 0), (12, 6, 1, NULL, 'default1', NULL), (2, 3, 0, NULL, 'default1', 0), (4, 3, 0, 1, '1:29.488', 1), (6, 0, 1, 1, NULL, 0), (12, 0, 1, NULL, '1:29.488', 0), (12, 2, 0, 1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.lat, T3.lng FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T1.time = '1:29.488';

/*
Gold Result:
(1.0, 0.0)
(0.0, None)
(0.0, None)
(1.0, None)
*/

-- Prediction Query
SELECT DISTINCT circuits.lat, circuits.lng FROM races INNER JOIN lapTimes ON races.raceId = lapTimes.raceId INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE lapTimes.time = '1:29.488';

/*
Prediction Result:
(1.0, 0.0)
(0.0, None)
(1.0, None)
*/