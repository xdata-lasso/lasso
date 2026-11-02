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
INSERT INTO status (statusid, status) VALUES (1, 'default2'), (0, '%Y'), (2, '1971'), (3, 'default2'), (4, 'default2'), (5, '1971'), (6, 'default1'), (7, 'default1'), (8, 'default2'), (9, 'default2'), (10, '%Y'), (11, 'default2');
INSERT INTO seasons (year, url) VALUES (1, '1971');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default2', NULL, NULL, 'default1', '%Y', NULL, 'default2', 'default2'), (0, 'default2', NULL, NULL, 'default1', 'default1', '1971-10-27', '%Y', '1971'), (2, '1971', 0, 'default1', '1971', 'default2', '1971-10-27', 'default1', '%Y'), (3, 'default1', 1, NULL, 'default1', '1971', '2023-01-01', NULL, 'default1'), (4, 'default1', NULL, '1971', 'default2', 'default2', '2023-01-02', '%Y', 'unique_4'), (5, '1971', NULL, '1971', 'default1', 'default1', '2023-01-02', NULL, 'unique_5'), (6, 'default2', 0, 'default2', 'default2', '%Y', '2023-01-02', 'default2', 'unique_6'), (7, 'default2', NULL, 'default1', '%Y', 'default2', '2023-01-01', '1971', 'unique_7'), (8, '1971', 0, 'default2', 'default2', '%Y', '1971-10-27', '%Y', 'unique_8'), (9, '%Y', NULL, '1971', 'default1', '%Y', NULL, '1971', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, '1971', '1971', 'default1', 'default2'), (1, '1971', 'default2', '%Y', '1971'), (2, 'default2', '%Y', NULL, 'default2'), (3, 'default2', 'default1', '1971', '1971'), (4, 'default2', 'unique_4', '%Y', 'default1'), (5, '%Y', 'unique_5', '%Y', 'default2'), (6, 'default2', 'unique_6', '1971', 'default2'), (7, '%Y', 'unique_7', NULL, '1971'), (8, 'default1', 'unique_8', 'default1', '%Y'), (9, '%Y', 'unique_9', 'default1', '%Y'), (10, 'default1', 'unique_10', '%Y', 'default2'), (11, '1971', 'unique_11', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', '%Y', 'default2', '%Y', 0.0, 0.0, 0, '1971'), (0, 'default2', '1971', NULL, NULL, 0.0, NULL, NULL, 'default1'), (2, '%Y', 'default1', NULL, '%Y', 0.0, 1.0, NULL, 'default2'), (3, '%Y', 'default2', 'default1', '%Y', NULL, NULL, 0, '%Y'), (4, 'default2', '1971', '1971', NULL, 0.0, 1.0, 1, 'unique_4'), (5, 'default1', '1971', NULL, '%Y', NULL, NULL, NULL, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 1, 4, 0, 'default2', '2023-01-02', 'default2', NULL), (1, 1, 2, 0, '%Y', '1971-10-27', '%Y', 'default1'), (2, 1, 5, 0, '1971', '2023-01-01', '%Y', '1971');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1, 1, 5, 9, 1, 1, 0, 'default1', 0, 1.0, 1, 'default2', 0, NULL, NULL, 'default2', '%Y'), (0, 0, 2, 4, 7, NULL, 0, 1, 'default2', 1, 1.0, 1, '%Y', NULL, NULL, 1, '%Y', 'default1'), (2, 1, 5, 6, 7, 0, 0, 0, 'default1', 0, 1.0, 1, NULL, NULL, 1, 1, '1971', 'default1'), (3, 2, 4, 9, 3, 1, 0, NULL, 'default1', 0, 1.0, 0, '%Y', NULL, 0, NULL, '1971', 'default2'), (4, 1, 5, 8, 3, 0, 1, 1, '1971', 0, 0.0, 1, '1971', NULL, 1, 0, NULL, NULL), (5, 1, 2, 7, 1, NULL, 0, 1, 'default2', 0, 1.0, 1, '%Y', 1, 0, NULL, '1971', 'default2'), (6, 1, 9, 3, 5, 0, 1, NULL, 'default2', 0, 0.0, 0, '1971', 0, NULL, 0, NULL, 'default2'), (7, 2, 0, 9, 1, 1, 0, 0, '1971', 1, 1.0, 0, 'default1', 0, 0, 0, '1971', '%Y'), (8, 1, 0, 6, 6, NULL, 0, 1, 'default2', 1, 0.0, 1, '%Y', 1, NULL, 1, '1971', '%Y'), (9, 1, 6, 3, 10, NULL, 0, 1, '%Y', 0, 1.0, 1, '1971', 1, NULL, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId, T2.code FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) = '1971' AND NOT T1.fastestLapTime IS NULL;

/*
Gold Result:
(2, 'default1')
(2, 'default1')
(0, None)
(0, None)
*/

-- Prediction Query
SELECT DISTINCT drivers.driverId, drivers.code FROM drivers INNER JOIN results ON drivers.driverId = results.driverId WHERE STRFTIME('%Y', drivers.dob) = '1971' AND NOT results.fastestLapTime IS NULL;

/*
Prediction Result:
(2, 'default1')
(0, None)
*/