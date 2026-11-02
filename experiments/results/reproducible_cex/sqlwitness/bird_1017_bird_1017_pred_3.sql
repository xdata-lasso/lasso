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
INSERT INTO status (statusid, status) VALUES (0, 'default2'), (1, 'default1'), (2, 'default2'), (3, '1:29.488'), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default1'), (8, 'default2'), (9, 'default1'), (10, '1:29.488'), (11, 'default2'), (12, '1:29.488'), (13, '1:29.488');
INSERT INTO seasons (year, url) VALUES (1, '1:29.488'), (0, 'default1'), (2, 'default2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, '1:29.488', NULL, '1:29.488', 'default2', 'default2', NULL, 'default1', 'default2'), (1, 'default2', 0, '1:29.488', 'default1', 'default2', '2023-01-01', NULL, '1:29.488'), (2, 'default1', 1, NULL, '1:29.488', 'default1', '2026-10-27', 'default2', 'default1'), (3, '1:29.488', 1, 'default1', '1:29.488', '1:29.488', '2023-01-01', 'default1', 'unique_3'), (4, 'default2', NULL, '1:29.488', 'default2', 'default1', '2023-01-01', 'default2', 'unique_4'), (5, '1:29.488', 1, '1:29.488', '1:29.488', '1:29.488', '2026-10-27', NULL, 'unique_5'), (6, 'default1', NULL, NULL, 'default1', '1:29.488', NULL, '1:29.488', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'default2', 'default1', 'default2'), (1, 'default1', '1:29.488', '1:29.488', 'default1'), (2, 'default1', 'default1', NULL, 'default2'), (3, '1:29.488', 'unique_3', 'default2', 'default1'), (4, 'default1', 'unique_4', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '1:29.488', 'default2', 'default2', NULL, NULL, 0.0, NULL, '1:29.488'), (0, '1:29.488', 'default1', 'default1', NULL, 1.0, NULL, NULL, 'default2'), (2, 'default1', 'default1', '1:29.488', 'default2', 0.0, 1.0, 1, 'default1'), (3, 'default2', '1:29.488', 'default2', 'default1', 0.0, 0.0, NULL, 'unique_3'), (4, 'default1', 'default2', NULL, 'default2', 1.0, NULL, NULL, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 0, 1, '1:29.488', '2023-01-02', 'default1', 'default2'), (0, 0, 0, 1, '1:29.488', '2023-01-01', '1:29.488', NULL), (2, 1, 0, 0, 'default1', '2023-01-02', '1:29.488', '1:29.488'), (3, 1, 4, 1, '1:29.488', '2026-10-27', 'default2', 'default1'), (4, 4, 1, 1, '1:29.488', '2023-01-01', 'default1', 'unique_4'), (5, 1, 2, 0, 'default2', '2023-01-01', '1:29.488', 'unique_5'), (6, 1, 1, 0, 'default2', '2026-10-27', 'default2', 'unique_6'), (7, 3, 2, 0, 'default1', '2026-10-27', 'default2', 'unique_7'), (8, 2, 1, 0, 'default1', '2026-10-27', 'default2', 'unique_8'), (9, 1, 3, 0, 'default1', '2023-01-02', 'default1', 'unique_9'), (10, 1, 4, 1, 'default2', '2023-01-02', '1:29.488', 'unique_10'), (11, 5, 3, 0, 'default1', '2023-01-02', '1:29.488', 'unique_11'), (12, 2, 1, 0, '1:29.488', '2023-01-01', 'default1', 'unique_12'), (13, 1, 2, 1, 'default2', '2026-10-27', '1:29.488', 'unique_13');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 11, 5, 1, 4, 0, 1, 0, '1:29.488', 0, 0.0, 0, 'default2', 1, NULL, 0, '1:29.488', '1:29.488'), (1, 2, 0, 2, 0, 0, 1, 0, 'default2', 1, 1.0, 1, NULL, NULL, NULL, 0, NULL, '1:29.488'), (2, 8, 3, 2, 8, NULL, 0, NULL, 'default2', 1, 1.0, 0, NULL, 1, NULL, NULL, 'default2', 'default2'), (3, 2, 1, 3, 9, NULL, 1, NULL, 'default2', 1, 0.0, 1, NULL, 1, 0, 1, '1:29.488', NULL), (4, 11, 6, 0, 6, NULL, 1, NULL, 'default2', 0, 0.0, 1, 'default1', 0, 0, 0, '1:29.488', 'default1'), (5, 1, 6, 2, 0, NULL, 0, NULL, 'default1', 0, 0.0, 1, 'default1', 0, NULL, 0, 'default2', 'default2'), (6, 12, 1, 2, 11, NULL, 0, 0, 'default1', 1, 0.0, 1, 'default1', 1, 0, NULL, 'default2', 'default1'), (7, 3, 5, 3, 9, 0, 1, NULL, '1:29.488', 0, 0.0, 1, 'default1', NULL, 0, 1, 'default1', '1:29.488'), (8, 11, 5, 0, 7, NULL, 0, NULL, '1:29.488', 1, 1.0, 1, '1:29.488', 0, NULL, NULL, 'default1', NULL), (9, 4, 6, 1, 4, 1, 0, 0, '1:29.488', 0, 1.0, 0, 'default1', NULL, 0, 1, '1:29.488', NULL), (10, 12, 4, 3, 7, NULL, 0, 0, 'default2', 1, 1.0, 1, 'default1', NULL, 0, NULL, NULL, 'default1'), (11, 3, 3, 0, 9, NULL, 0, 0, 'default1', 0, 1.0, 0, NULL, 0, 0, NULL, 'default2', 'default2'), (12, 7, 0, 3, 7, NULL, 0, 1, 'default1', 1, 0.0, 0, 'default2', 0, NULL, NULL, 'default2', 'default2'), (13, 1, 1, 2, 2, 1, 0, 1, 'default1', 1, 1.0, 1, NULL, 0, NULL, 1, NULL, 'default2'), (14, 3, 2, 2, 9, 0, 1, 1, '1:29.488', 0, 1.0, 1, 'default2', 1, NULL, NULL, 'default1', 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (8, 0, 0, NULL, 'default1', NULL), (12, 2, 1, NULL, '1:29.488', 1), (2, 2, 1, 1, NULL, 0), (8, 2, 1, 1, 'default2', NULL), (7, 6, 0, NULL, '1:29.488', NULL), (12, 6, 0, NULL, NULL, 0), (5, 3, 0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.lat, T3.lng FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T1.time = '1:29.488';

/*
Gold Result:
(None, 0.0)
(0.0, 1.0)
*/

-- Prediction Query
SELECT T3.lat, T3.lng FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T1.fastestLapTime = '1:29.488';

/*
Prediction Result:
(0.0, 0.0)
(1.0, None)
(0.0, 0.0)
(None, 0.0)
*/