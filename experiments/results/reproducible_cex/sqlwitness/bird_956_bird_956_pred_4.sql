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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (2, '1975'), (3, '%Y'), (0, '%Y'), (4, '1975'), (5, '%Y'), (6, '1975'), (7, '%Y'), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, '1975');
INSERT INTO seasons (year, url) VALUES (3, 'default2'), (1, 'default1'), (0, '%Y'), (2, '1975'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, '1975', 3, 'default2', 'default1', 'default1', '1975-10-27', '%Y', '%Y'), (2, '%Y', 0, '%Y', '1975', '1975', '2023-01-01', 'default1', 'default2'), (3, '1975', 2, '%Y', 'default2', '1975', '2023-01-01', NULL, '1975'), (1, '%Y', NULL, 'default1', '1975', 'default2', '1975-10-27', '1975', 'default1'), (4, '1975', 0, 'default2', 'default2', 'default1', '2023-01-02', '%Y', 'unique_4'), (5, 'default2', 1, '1975', '1975', 'default2', '2023-01-02', NULL, 'unique_5'), (6, 'default1', 1, '%Y', '1975', '1975', NULL, NULL, 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, '%Y', 'default1', NULL, 'default2'), (0, 'default2', 'default2', '1975', '1975'), (3, 'default1', '%Y', NULL, 'default1'), (1, 'default2', '1975', 'default1', '%Y'), (4, 'default2', 'unique_4', 'default2', 'default1'), (5, 'default1', 'unique_5', '1975', 'default2'), (6, '1975', 'unique_6', '1975', '%Y'), (7, '1975', 'unique_7', '%Y', '1975'), (8, 'default2', 'unique_8', 'default2', 'default2'), (9, 'default2', 'unique_9', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '1975', 'default1', '1975', NULL, 2.0, 3.0, 0, '1975'), (2, '1975', '1975', '%Y', 'default1', 0.0, 2.0, 2, 'default2'), (0, '%Y', 'default1', '%Y', '1975', 3.0, 3.0, NULL, '%Y'), (3, '%Y', '1975', NULL, NULL, 0.0, 1.0, 2, 'default1'), (4, '1975', 'default1', '%Y', NULL, 3.0, 1.0, NULL, 'unique_4'), (5, '1975', '%Y', 'default2', 'default2', 2.0, 3.0, 3, 'unique_5'), (6, '1975', '1975', NULL, NULL, 2.0, NULL, 0, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 6, 1, 'default1', '2023-01-02', '%Y', '1975'), (3, 2, 2, 3, 'default1', '1975-10-27', NULL, 'default1'), (2, 8, 1, 1, '1975', '2023-01-01', 'default1', NULL), (1, 8, 5, 0, '%Y', '2023-01-02', '%Y', '%Y'), (4, 2, 6, 1, 'default2', '2023-01-01', '%Y', 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (3, 3, 6, 6, 1, 0, 0, 2, '1975', 2, 0.0, 0, '1975', 0, NULL, 3, '%Y', '1975'), (2, 4, 1, 6, 5, 3, 2, 1, '%Y', 3, 2.0, 3, '1975', 1, 2, 2, NULL, 'default1'), (1, 4, 5, 3, 3, NULL, 0, 3, '%Y', 2, 0.0, 0, 'default1', NULL, 3, 3, '1975', '%Y'), (0, 2, 6, 4, 5, 2, 0, 0, 'default2', 2, 0.0, 2, '%Y', NULL, 1, 0, '%Y', '1975'), (4, 4, 1, 5, 6, 2, 2, 3, '%Y', 3, 2.0, 1, 'default2', 1, 0, 1, 'default1', NULL), (5, 4, 2, 9, 9, 0, 0, 3, 'default1', 0, 2.0, 2, '%Y', 2, 2, 0, NULL, 'default2'), (6, 3, 6, 6, 6, 0, 0, 3, '1975', 1, 2.0, 1, '1975', NULL, 2, NULL, 'default1', 'default1'), (7, 1, 1, 4, 4, 2, 3, 0, 'default1', 2, 2.0, 0, 'default2', NULL, 3, NULL, '%Y', NULL), (8, 4, 4, 5, 8, 2, 2, 3, 'default1', 3, 0.0, 3, '1975', 2, 2, NULL, 'default1', '%Y'), (9, 3, 0, 7, 10, 1, 2, NULL, 'default2', 1, 0.0, 3, 'default1', 1, 3, 0, 'default2', NULL), (10, 3, 3, 9, 8, 1, 2, 2, 'default1', 2, 0.0, 2, 'default1', 1, NULL, 2, 'default1', NULL), (11, 2, 6, 6, 3, 3, 1, 0, '1975', 1, 2.0, 2, 'default1', 0, 0, 2, 'default1', '1975'), (12, 4, 1, 3, 4, 3, 3, 2, 'default1', 1, 3.0, 2, 'default1', 0, 3, 2, '%Y', 'default2'), (13, 0, 6, 3, 5, 2, 3, 1, 'default2', 2, 1.0, 0, 'default1', 0, 3, 2, '1975', NULL), (14, 4, 0, 5, 9, 2, 0, 1, '1975', 0, 3.0, 1, 'default1', 2, 1, 2, 'default1', 'default2'), (15, 3, 2, 3, 5, 3, 0, 3, '1975', 2, 3.0, 1, '%Y', NULL, NULL, 1, '1975', '%Y');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (2, 0, 6, 3.0, NULL, 'default1', 3), (3, 2, 2, 2.0, 2, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) > '1975' AND T1.rank = 2;

/*
Gold Result:
('default2', '1975')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d JOIN driverStandings AS ds ON d.driverId = ds.driverId WHERE STRFTIME('%Y', d.dob) > '1975' AND ds.position = 2;

/*
Prediction Result:
('1975', '1975')
*/