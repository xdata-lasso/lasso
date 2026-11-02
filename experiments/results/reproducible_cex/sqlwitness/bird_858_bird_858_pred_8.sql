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
INSERT INTO seasons (year, url) VALUES (23, 'default1'), (2, 'default2'), (0, 'unique_2'), (25, 'unique_3'), (1, 'unique_4'), (24, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default2', 'default1', 'default1', 'default2'), (25, 'default2', 'default2', NULL, 'default2'), (24, 'default2', 'unique_2', 'default1', 'default2'), (2, 'default1', 'unique_3', 'default2', 'default1'), (23, 'default2', 'unique_4', NULL, 'default1'), (1, 'default1', 'unique_5', 'default2', 'default1'), (3, 'default1', 'unique_6', 'default2', 'default2'), (4, 'default1', 'unique_7', 'default2', 'default2'), (5, 'default2', 'unique_8', 'default2', 'default2'), (6, 'default2', 'unique_9', NULL, 'default2'), (7, 'default1', 'unique_10', 'default1', 'default2'), (8, 'default1', 'unique_11', 'default2', 'default2'), (9, 'default1', 'unique_12', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', 'default1', 'default2', NULL, 24.0, 24.0, 24, 'default1'), (25, 'default1', 'default1', 'default2', NULL, NULL, NULL, 23, 'default2'), (23, 'default1', 'default2', 'default2', 'default2', 1.0, 25.0, NULL, 'unique_2'), (0, 'default2', 'default2', NULL, NULL, 0.0, 1.0, NULL, 'unique_3'), (2, 'default1', 'default1', 'default1', 'default2', 23.0, 24.0, 1, 'unique_4'), (24, 'default1', 'default2', NULL, NULL, 0.0, 0.0, 0, 'unique_5'), (3, 'default1', 'default1', NULL, NULL, 23.0, 1.0, NULL, 'unique_6'), (4, 'default2', 'default1', 'default1', 'default2', 25.0, 24.0, 2, 'unique_7'), (5, 'default2', 'default1', NULL, NULL, 23.0, 2.0, 0, 'unique_8'), (6, 'default2', 'default1', 'default2', NULL, 25.0, 1.0, 23, 'unique_9'), (7, 'default1', 'default2', 'default1', NULL, 1.0, 23.0, 25, 'unique_10'), (8, 'default1', 'default1', NULL, NULL, 25.0, 24.0, 2, 'unique_11'), (9, 'default2', 'default1', 'default1', 'default2', 24.0, 24.0, 2, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 5, 23, 'default2', '2023-01-01', 'default1', 'default2'), (24, 1, 1, 24, 'default2', '2023-01-02', 'default2', NULL), (25, 4, 2, 23, 'default1', '2023-01-02', NULL, 'default1'), (0, 1, 24, 0, 'default1', '2023-01-02', 'default1', 'unique_3'), (23, 6, 24, 0, 'default2', '2023-01-01', 'default2', 'unique_4'), (2, 3, 1, 2, 'default2', '2023-01-01', NULL, 'unique_5');
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (23, 1, 6, NULL, NULL), (24, 24, 4, 1.0, 'default1'), (0, 1, 24, 24.0, NULL), (25, 2, 0, 24.0, 'default2'), (1, 23, 8, 2.0, 'default1'), (2, 0, 9, 1.0, 'default1'), (3, 2, 4, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T1.raceId = 24 AND T1.points = 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.country FROM circuits AS T1 JOIN races AS T2 ON T1.circuitId = T2.circuitId JOIN constructorResults AS T3 ON T3.raceId = T2.raceId JOIN constructors AS T4 ON T4.constructorId = T3.constructorId WHERE T2.raceId = 24 AND T3.points = 1;

/*
Prediction Result:
(None,)
*/