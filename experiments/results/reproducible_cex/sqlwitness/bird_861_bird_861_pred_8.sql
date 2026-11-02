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
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (1, '01:54'), (903, '1:54%'), (902, '%M:%S'), (904, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (902, '01:54', 902, '1:54%', '%M:%S', '%M:%S', NULL, '1:54%', '01:54'), (0, '1:54%', 0, '%M:%S', '1:54%', 'default1', NULL, '01:54', '1:54%'), (904, '1:54%', 0, '%M:%S', '1:54%', '1:54%', '2023-01-02', '%M:%S', 'default1'), (903, 'default2', 903, 'default2', '1:54%', '%M:%S', NULL, '01:54', '%M:%S');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', '%M:%S', '01:54', '1:54%'), (902, '01:54', 'default2', 'default1', '%M:%S'), (904, 'default2', 'default1', '1:54%', 'default1'), (1, 'default1', '01:54', 'default1', 'default2'), (903, '%M:%S', '1:54%', NULL, 'default1'), (2, '01:54', 'unique_5', '%M:%S', '1:54%'), (3, 'default2', 'unique_6', 'default2', '%M:%S'), (4, 'default2', 'unique_7', '01:54', '%M:%S'), (5, '01:54', 'unique_8', 'default1', 'default1'), (6, '01:54', 'unique_9', '01:54', 'default2'), (7, 'default1', 'unique_10', '%M:%S', '1:54%'), (8, 'default1', 'unique_11', NULL, '1:54%');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '01:54', '%M:%S', '%M:%S', NULL, 902.0, NULL, 904, '01:54'), (904, '1:54%', 'default1', NULL, 'default1', 903.0, 903.0, 0, 'default2'), (0, '%M:%S', 'default2', '%M:%S', '01:54', 0.0, 1.0, 903, '%M:%S'), (903, '1:54%', '01:54', 'default1', '01:54', NULL, 902.0, 903, '1:54%'), (902, '%M:%S', '01:54', 'default1', '1:54%', NULL, 903.0, 0, 'default1'), (2, 'default2', 'default2', NULL, 'default1', NULL, 902.0, 903, 'unique_5'), (3, '%M:%S', '%M:%S', 'default1', NULL, 904.0, 904.0, 903, 'unique_6'), (4, 'default1', '%M:%S', '01:54', 'default1', NULL, NULL, 0, 'unique_7'), (5, '%M:%S', '%M:%S', 'default1', NULL, 0.0, NULL, 1, 'unique_8'), (6, '01:54', '01:54', '%M:%S', 'default1', NULL, 1.0, NULL, 'unique_9'), (7, 'default1', '1:54%', 'default1', '01:54', 902.0, 903.0, 0, 'unique_10'), (8, 'default1', '01:54', NULL, '%M:%S', 903.0, 904.0, 904, 'unique_11'), (9, '01:54', '01:54', 'default1', 'default1', 902.0, 904.0, 902, 'unique_12'), (10, 'default1', 'default2', '01:54', '1:54%', 903.0, 1.0, NULL, 'unique_13');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (902, 0, 5, 903, 'default1', '2023-01-02', '1:54%', 'default1'), (904, 902, 3, 902, '1:54%', '2023-01-02', '01:54', '01:54'), (0, 0, 4, 903, 'default1', '2023-01-01', 'default1', '1:54%'), (903, 0, 10, 903, '1:54%', '2026-10-27', '01:54', '%M:%S'), (1, 903, 2, 1, 'default1', '2023-01-01', 'default1', NULL), (2, 1, 5, 903, 'default2', '2026-10-27', 'default1', 'default2'), (3, 0, 10, 1, 'default1', '2023-01-02', '1:54%', 'unique_6'), (4, 904, 6, 1, '%M:%S', '2026-10-27', '1:54%', 'unique_7'), (5, 904, 8, 902, '%M:%S', '2023-01-02', '%M:%S', 'unique_8'), (6, 904, 4, 1, '01:54', '2026-10-27', '01:54', 'unique_9'), (7, 1, 5, 1, '%M:%S', '2026-10-27', 'default2', 'unique_10');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (903, 904, 902, 8, 0, 1, '01:54', 'default1', '1:54%'), (1, 5, 904, 904, 1, 1, NULL, NULL, NULL), (902, 903, 903, 904, 904, 903, '01:54', '01:54', 'default2'), (0, 2, 0, 904, 903, 904, 'default2', NULL, '01:54'), (904, 5, 903, 8, 903, 0, 'default1', '01:54', '01:54'), (2, 904, 902, 7, 902, 0, '%M:%S', '1:54%', 'default2'), (3, 904, 0, 6, 903, NULL, '01:54', 'default1', '%M:%S'), (4, 904, 0, 8, 902, 1, '01:54', NULL, '1:54%'), (5, 7, 902, 8, 904, 1, '01:54', NULL, 'default1'), (6, 6, 0, 902, 0, 902, '01:54', NULL, 'default1'), (7, 902, 904, 902, 903, 903, '%M:%S', NULL, '1:54%'), (8, 7, 904, 904, 904, 902, '01:54', 'default1', '01:54'), (9, 903, 903, 904, 904, 1, 'default2', NULL, '1:54%'), (10, 2, 903, 902, 902, NULL, 'default1', '%M:%S', NULL), (11, 2, 902, 4, 903, 903, '%M:%S', '%M:%S', '01:54'), (12, 3, 902, 903, 1, 904, '1:54%', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.number FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 903 AND T1.q3 LIKE '1:54%';

/*
Gold Result:
(903,)
*/

-- Prediction Query
SELECT T1.number FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 903 AND STRFTIME('%M:%S', T2.q3) = '01:54';

/*
Prediction Result:
*/