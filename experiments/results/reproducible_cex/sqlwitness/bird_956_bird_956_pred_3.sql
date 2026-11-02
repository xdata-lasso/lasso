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
INSERT INTO status (statusid, status) VALUES (0, '%Y'), (1, '%Y'), (2, 'default1'), (3, '1975'), (4, 'default2'), (5, '1975'), (6, 'default1'), (7, '%Y');
INSERT INTO seasons (year, url) VALUES (3, 'default2'), (2, '%Y');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, '%Y', 2, 'default2', 'default2', '1975', '2023-01-01', '%Y', 'default2'), (1, 'default1', 2, NULL, 'default1', 'default1', '2023-01-02', '1975', 'default1'), (0, 'default1', NULL, '1975', 'default2', '1975', '2023-01-01', 'default2', '%Y'), (3, '%Y', 1, 'default1', '1975', '1975', '1975-10-27', NULL, '1975'), (4, '1975', 1, NULL, '%Y', '1975', '2023-01-01', 'default1', 'unique_4'), (5, 'default2', 2, '%Y', 'default2', 'default1', '1975-10-27', '1975', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default1', '%Y', NULL, 'default2'), (1, 'default1', 'default1', 'default1', '%Y'), (0, '1975', '1975', NULL, '%Y'), (3, '1975', 'default2', 'default1', '%Y'), (4, 'default2', 'unique_4', NULL, 'default2'), (5, 'default2', 'unique_5', '%Y', '%Y'), (6, 'default2', 'unique_6', '%Y', 'default1'), (7, 'default1', 'unique_7', 'default1', '%Y'), (8, 'default1', 'unique_8', '1975', 'default2'), (9, '%Y', 'unique_9', '%Y', 'default1'), (10, '%Y', 'unique_10', '%Y', 'default1'), (11, 'default1', 'unique_11', NULL, '1975'), (12, '1975', 'unique_12', 'default1', '%Y');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3, '1975', '1975', '%Y', 'default1', 3.0, 2.0, 1, 'default1'), (1, '1975', '%Y', '%Y', '1975', 3.0, 2.0, 1, '%Y'), (2, 'default2', 'default1', 'default2', NULL, 0.0, 1.0, 3, '1975'), (0, '%Y', 'default1', 'default2', '%Y', 0.0, 1.0, 2, 'default2'), (4, 'default1', '1975', 'default2', '1975', NULL, NULL, 0, 'unique_4'), (5, 'default1', 'default1', '1975', NULL, 1.0, NULL, 1, 'unique_5'), (6, 'default1', '1975', '1975', '%Y', NULL, 0.0, 0, 'unique_6'), (7, '1975', '%Y', '%Y', 'default2', 3.0, 1.0, 2, 'unique_7'), (8, 'default2', 'default1', '%Y', 'default1', 3.0, 3.0, 0, 'unique_8'), (9, '%Y', 'default1', '1975', 'default1', 1.0, 2.0, 0, 'unique_9'), (10, '1975', 'default1', NULL, '%Y', NULL, 2.0, NULL, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2, 2, 0, 'default2', '2023-01-01', '%Y', '%Y');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (3, 1, 5, 12, 3, 1, 3, NULL, 'default1', 0, 3.0, 3, NULL, 3, 0, NULL, '1975', '%Y'), (0, 1, 5, 10, 0, 1, 0, 2, 'default2', 2, 1.0, 3, NULL, NULL, 0, 3, '%Y', '1975'), (1, 1, 1, 5, 7, 2, 2, 1, '1975', 1, 1.0, 2, 'default2', 0, 1, 3, 'default2', 'default2'), (2, 1, 4, 8, 0, NULL, 3, 3, '%Y', 2, 0.0, 0, NULL, 0, 2, 1, NULL, NULL), (4, 1, 4, 11, 1, 1, 0, 2, 'default1', 3, 3.0, 0, 'default2', 2, 3, 0, 'default1', '1975'), (5, 1, 3, 9, 7, 0, 0, 3, '%Y', 3, 2.0, 0, '1975', 1, 0, 0, '1975', '1975'), (6, 1, 3, 10, 7, 3, 2, 3, 'default2', 3, 0.0, 2, 'default1', 0, 0, NULL, '%Y', '1975'), (7, 1, 1, 6, 6, 1, 2, 1, '%Y', 1, 1.0, 1, NULL, 2, 3, NULL, NULL, '%Y'), (8, 1, 1, 10, 5, 1, 3, 3, '%Y', 0, 3.0, 2, '%Y', NULL, 0, 2, '1975', 'default2'), (9, 1, 5, 10, 2, 0, 2, NULL, '1975', 0, 0.0, 2, NULL, 2, NULL, NULL, '%Y', 'default2'), (10, 1, 5, 12, 7, 0, 1, 0, '%Y', 1, 1.0, 2, NULL, NULL, 3, 3, 'default2', 'default2'), (11, 1, 1, 6, 1, 2, 0, NULL, 'default1', 3, 3.0, 2, '%Y', NULL, NULL, 3, 'default2', '1975'), (12, 1, 1, 6, 5, 1, 1, 2, '%Y', 3, 1.0, 0, 'default2', 2, 3, 2, NULL, '%Y');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 1, 3, 3.0, 3, NULL, 3), (1, 1, 1, 0.0, 1, '%Y', 0), (2, 1, 2, 2.0, 3, 'default1', 1), (3, 1, 5, 2.0, 0, '1975', 0), (4, 1, 3, 1.0, NULL, '1975', 1), (5, 1, 1, 2.0, 2, '1975', 2), (6, 1, 1, 3.0, 3, '1975', 0), (7, 1, 2, 3.0, 2, '1975', 1), (8, 1, 5, 0.0, 1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) > '1975' AND T1.rank = 2;

/*
Gold Result:
('default1', 'default1')
('default1', 'default1')
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId WHERE T2.position = 2 AND STRFTIME('%Y', T1.dob) > '1975';

/*
Prediction Result:
('default1', 'default1')
('default2', '1975')
*/