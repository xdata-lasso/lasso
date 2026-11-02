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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (3, '%Y'), (0, 'default1'), (2, '1975');
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (3, '1975'), (5, 'default2'), (2, '%Y'), (4, 'unique_4'), (0, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default2', 3, '%Y', '%Y', '1975', '2023-01-01', 'default2', 'default1'), (1, 'default2', 0, '%Y', 'default1', '%Y', '2023-01-02', 'default2', '1975');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (5, 'default1', 'default2', '1975', '1975'), (0, 'default1', '%Y', NULL, 'default1'), (3, '1975', '1975', NULL, 'default2'), (2, 'default1', 'default1', '1975', '1975'), (4, 'default2', 'unique_4', '%Y', '%Y'), (1, '1975', 'unique_5', '1975', '1975'), (6, 'default1', 'unique_6', 'default2', '1975'), (7, 'default2', 'unique_7', 'default2', '%Y'), (8, '%Y', 'unique_8', 'default1', 'default1'), (9, 'default1', 'unique_9', NULL, 'default1'), (10, '1975', 'unique_10', 'default1', '1975');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3, '1975', '1975', 'default1', 'default1', 1.0, 4.0, 0, '1975'), (0, '%Y', '1975', '1975', NULL, 4.0, 1.0, 4, 'default1'), (4, 'default2', 'default2', NULL, '1975', 5.0, 4.0, 2, '%Y'), (2, '%Y', 'default1', '%Y', 'default1', NULL, 4.0, 4, 'default2'), (1, 'default2', 'default1', '%Y', 'default1', 3.0, NULL, 3, 'unique_4'), (5, '%Y', '%Y', '1975', 'default2', NULL, 0.0, NULL, 'unique_5'), (6, 'default2', '1975', '%Y', '1975', 3.0, NULL, 1, 'unique_6'), (7, 'default1', '%Y', 'default1', NULL, 5.0, 3.0, 3, 'unique_7'), (8, 'default1', '%Y', '%Y', 'default2', 4.0, 0.0, 1, 'unique_8'), (9, '%Y', '1975', NULL, NULL, 1.0, 1.0, 5, 'unique_9'), (10, 'default1', '%Y', '1975', '%Y', 5.0, 3.0, 5, 'unique_10'), (11, '%Y', '%Y', 'default1', NULL, 4.0, 2.0, 5, 'unique_11'), (12, 'default2', 'default1', 'default1', 'default1', 1.0, NULL, 4, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 10, 10, 1, '1975', '2023-01-01', '%Y', NULL), (0, 13, 11, 4, '%Y', '2023-01-01', '1975', '1975'), (3, 9, 3, 1, '%Y', '2023-01-01', '%Y', 'default1'), (5, 8, 2, 0, 'default1', '1975-10-27', 'default1', '%Y'), (2, 6, 11, 5, '1975', '2023-01-01', '1975', 'default2'), (4, 3, 2, 0, 'default2', '2023-01-02', '%Y', 'unique_5'), (6, 13, 5, 4, 'default2', '2023-01-01', NULL, 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (4, 4, 1, 5, 3, 2, 5, 0, 'default1', 2, 1.0, 1, 'default1', 2, 0, 3, NULL, 'default1'), (1, 1, 1, 8, 3, 1, 1, 5, '1975', 3, 0.0, 1, '1975', 2, NULL, NULL, 'default1', NULL), (5, 6, 1, 0, 3, 4, 3, 2, '%Y', 1, 4.0, 0, '1975', 0, 2, 1, '1975', '%Y'), (3, 0, 1, 10, 1, 0, 0, NULL, '1975', 4, 3.0, 4, '%Y', 5, 4, 1, '1975', NULL), (0, 4, 1, 4, 1, 4, 5, 4, 'default1', 0, 4.0, 3, '1975', 0, 2, 3, '1975', '%Y'), (2, 0, 2, 0, 0, 3, 5, 3, '%Y', 1, 0.0, 0, '%Y', 5, 1, 3, NULL, 'default1'), (6, 4, 1, 1, 2, 0, 0, NULL, 'default2', 3, 3.0, 4, 'default2', 4, 1, 4, '%Y', 'default2'), (7, 0, 1, 5, 3, NULL, 3, 5, '1975', 5, 4.0, 3, 'default2', NULL, 2, 3, 'default1', NULL), (8, 5, 1, 7, 0, 1, 0, 5, 'default1', 2, 5.0, 3, 'default1', 2, 0, 2, 'default1', 'default1'), (9, 1, 1, 10, 2, 2, 0, 0, 'default2', 1, 2.0, 4, NULL, 4, 1, 5, '%Y', '1975'), (10, 3, 1, 3, 0, 2, 0, 3, 'default1', 1, 4.0, 5, '%Y', 3, 5, 0, 'default2', '%Y'), (11, 3, 1, 1, 1, 2, 0, NULL, 'default1', 4, 2.0, 3, 'default2', NULL, 5, 0, NULL, '%Y'), (12, 1, 1, 8, 3, 2, 5, 5, 'default2', 4, 0.0, 1, '1975', 1, 5, 2, 'default1', NULL), (13, 1, 1, 5, 1, 2, 1, 0, '%Y', 1, 2.0, 4, 'default1', 0, 3, 1, NULL, '1975'), (14, 2, 2, 1, 3, 2, 3, NULL, '%Y', 3, 0.0, 4, '%Y', 2, 1, 1, '%Y', 'default2'), (15, 6, 1, 7, 3, 1, 2, NULL, '%Y', 5, 2.0, 1, 'default1', 0, 1, 0, 'default2', 'default2'), (16, 1, 2, 1, 1, 2, 5, 3, '1975', 1, 1.0, 2, '%Y', 2, 3, 2, '%Y', 'default2'), (17, 3, 1, 8, 3, 0, 3, 1, 'default1', 0, 2.0, 5, '1975', 4, 0, 5, NULL, '1975');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) > '1975' AND T1.rank = 2;

/*
Gold Result:
('default1', '%Y')
('default1', '%Y')
('%Y', '1975')
*/

-- Prediction Query
SELECT DISTINCT drivers.forename, drivers.surname FROM drivers INNER JOIN results ON drivers.driverId = results.driverId WHERE SUBSTRING(drivers.dob, 1, 4) > '1975' AND results.rank = 2;

/*
Prediction Result:
('default1', '%Y')
('%Y', '1975')
*/