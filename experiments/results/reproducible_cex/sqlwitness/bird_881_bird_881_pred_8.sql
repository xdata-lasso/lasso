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
INSERT INTO status (statusid, status) VALUES (101, 'default1'), (0, 'default2'), (-1, ''), (2, '1983-07-16'), (1, '1983-07-16'), (99, '1983-07-16'), (100, ''), (3, '1983-07-16'), (4, '1983-07-16'), (5, 'default1'), (6, 'default2'), (7, '1983-07-16'), (8, ''), (9, 'default2'), (10, '1983-07-16'), (11, 'default2'), (12, 'default1'), (13, 'default2'), (14, 'default1'), (15, 'default2'), (16, 'default2');
INSERT INTO seasons (year, url) VALUES (99, 'default2'), (-1, '1983-07-16'), (100, ''), (0, 'default1'), (1, 'unique_4'), (2, 'unique_5'), (101, 'unique_6'), (3, 'unique_7'), (4, 'unique_8'), (5, 'unique_9'), (6, 'unique_10'), (7, 'unique_11'), (8, 'unique_12'), (9, 'unique_13'), (10, 'unique_14'), (11, 'unique_15');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default1', 100, '1983-07-16', '', 'default2', '1983-07-15', NULL, 'default2'), (1, '', 2, '', '', 'default2', '1983-07-17', 'default2', 'default1'), (100, '', -1, 'default2', '1983-07-16', '1983-07-16', '2023-01-01', '1983-07-16', '1983-07-16'), (101, 'default1', 0, NULL, '', 'default1', '1983-07-15', '', ''), (99, '1983-07-16', 0, '', 'default2', '1983-07-16', '2023-01-02', '', 'unique_4'), (-1, 'default1', -1, 'default2', '1983-07-16', 'default1', '1983-07-16', '1983-07-16', 'unique_5'), (0, 'default2', 100, NULL, 'default2', 'default2', '2023-01-01', '1983-07-16', 'unique_6'), (3, '', -1, '1983-07-16', '1983-07-16', '1983-07-16', '2023-01-01', '1983-07-16', 'unique_7');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (101, '1983-07-16', '1983-07-16', 'default2', 'default2'), (100, 'default1', 'default1', 'default2', 'default1'), (0, 'default1', 'default2', 'default1', 'default2'), (2, '1983-07-16', '', 'default2', '1983-07-16'), (99, 'default1', 'unique_4', 'default2', 'default2'), (-1, 'default1', 'unique_5', 'default2', 'default1'), (1, 'default1', 'unique_6', 'default2', '1983-07-16'), (3, 'default1', 'unique_7', NULL, 'default2'), (4, '1983-07-16', 'unique_8', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (99, '', 'default1', '1983-07-16', 'default2', 100.0, 101.0, 1, '1983-07-16');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (100, 4, 99, 1, 'default1', '1983-07-15', '1983-07-16', 'default2'), (99, 2, 99, -1, 'default2', '1983-07-16', '', NULL), (-1, 8, 99, 1, 'default2', '1983-07-17', 'default1', ''), (0, 11, 99, 100, 'default2', '2023-01-01', 'default2', '1983-07-16'), (1, 3, 99, 99, 'default2', '1983-07-15', '1983-07-16', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 99, 3, 100, 101, 100, 100, NULL, 'default1', 100, 100.0, 101, '', 1, 0, 99, NULL, NULL), (100, 0, 101, 3, 2, NULL, -1, 1, 'default1', 0, 2.0, -1, '1983-07-16', 100, 100, 2, NULL, ''), (0, -1, 101, 99, 100, 1, 100, 1, 'default1', 101, -1.0, 99, '1983-07-16', 100, 0, 1, '', 'default2'), (99, 0, 3, 101, 16, 0, 2, 0, '1983-07-16', 101, 2.0, 101, '', 101, 2, 2, '1983-07-16', 'default1'), (1, 1, -1, 100, 2, NULL, 101, NULL, '', 1, 2.0, 99, NULL, 101, NULL, 1, 'default2', 'default1'), (101, 99, -1, 0, 3, NULL, -1, 100, 'default1', -1, 0.0, 2, '', NULL, -1, 101, 'default2', ''), (-1, 99, 101, 101, 16, -1, 1, 2, '', 0, 100.0, 100, 'default2', 100, 99, -1, NULL, 'default1'), (3, -1, 0, 100, 2, 100, -1, 101, '', 1, 1.0, 99, '', NULL, NULL, 99, 'default1', NULL), (4, 1, 1, 3, 9, 99, 0, 101, '1983-07-16', 101, 99.0, 99, 'default1', 101, 101, 2, '1983-07-16', ''), (5, 0, -1, 99, 14, 1, 0, 0, '1983-07-16', 100, 100.0, 2, NULL, 100, -1, 101, NULL, NULL), (6, 100, 100, -1, 13, 99, 101, 2, '', 2, 101.0, 1, '', 101, 100, 100, 'default2', 'default2'), (7, 99, 2, 2, 99, 99, 101, NULL, '', 100, 99.0, 99, 'default1', NULL, 2, 99, '', '1983-07-16'), (8, 100, 0, 99, 9, 101, 1, 1, 'default1', 2, 1.0, 100, '1983-07-16', 0, 99, 100, 'default2', '1983-07-16'), (9, -1, 100, 1, 11, 2, 100, 2, 'default1', 101, 0.0, 101, 'default1', 99, 100, 1, NULL, '1983-07-16'), (10, 100, 100, 99, 2, 1, 101, 1, 'default1', 1, 99.0, 99, '', -1, NULL, 0, 'default1', 'default2'), (11, -1, 0, 3, 1, 100, -1, 1, 'default1', 99, -1.0, 99, 'default2', 2, 100, -1, '1983-07-16', '1983-07-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN NOT T2.time IS NULL THEN T2.driverId END) AS REAL) * 100 / COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '1983-07-16';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.time <> '' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.date = '1983-07-16';

/*
Prediction Result:
(50.0,)
*/