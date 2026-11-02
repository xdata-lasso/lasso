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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'default1'), (24, 'unique_2'), (23, 'unique_3'), (2, 'unique_4'), (25, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15'), (13, 'unique_16'), (14, 'unique_17'), (15, 'unique_18'), (16, 'unique_19'), (17, 'unique_20'), (18, 'unique_21'), (19, 'unique_22');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (25, 'default1', 'default1', 'default1', 'default1'), (23, 'default1', 'default2', NULL, 'default1'), (24, 'default2', 'unique_2', 'default2', 'default2'), (1, 'default2', 'unique_3', 'default2', 'default1'), (2, 'default1', 'unique_4', 'default2', 'default1'), (0, 'default2', 'unique_5', 'default1', 'default2'), (3, 'default1', 'unique_6', 'default1', 'default2'), (4, 'default2', 'unique_7', 'default2', 'default1'), (5, 'default2', 'unique_8', NULL, 'default1'), (6, 'default2', 'unique_9', 'default1', 'default2'), (7, 'default2', 'unique_10', 'default1', 'default2'), (8, 'default1', 'unique_11', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'default2', NULL, NULL, 25.0, 2.0, 25, 'default2'), (23, 'default1', 'default1', 'default1', 'default1', NULL, 0.0, 0, 'default1'), (1, 'default1', 'default2', 'default1', 'default1', NULL, 1.0, 2, 'unique_2'), (24, 'default2', 'default2', 'default1', NULL, 24.0, 2.0, 23, 'unique_3'), (0, 'default1', 'default1', 'default1', 'default1', 1.0, 25.0, 2, 'unique_4'), (25, 'default2', 'default1', NULL, NULL, NULL, 1.0, 23, 'unique_5'), (3, 'default2', 'default1', NULL, 'default2', 23.0, 0.0, NULL, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 4, 25, 23, 'default1', '2023-01-02', 'default1', 'default1'), (0, 18, 2, 24, 'default2', '2023-01-02', 'default2', 'default2'), (24, 6, 24, 0, 'default1', '2023-01-01', 'default2', NULL), (1, 15, 2, 25, 'default2', '2023-01-01', 'default1', 'unique_3'), (25, 7, 23, 23, 'default1', '2023-01-01', 'default1', 'unique_4'), (23, 4, 25, 25, 'default2', '2023-01-02', 'default1', 'unique_5'), (3, 3, 1, 23, 'default2', '2023-01-02', NULL, 'unique_6'), (4, 3, 0, 0, 'default1', '2023-01-02', NULL, 'unique_7'), (5, 23, 24, 23, 'default1', '2023-01-01', NULL, 'unique_8'), (6, 6, 25, 24, 'default1', '2023-01-01', 'default2', 'unique_9'), (7, 9, 1, 25, 'default2', '2023-01-01', 'default1', 'unique_10'), (8, 0, 2, 25, 'default1', '2023-01-01', NULL, 'unique_11'), (9, 13, 3, 24, 'default2', '2023-01-01', 'default2', 'unique_12'), (10, 2, 0, 0, 'default1', '2023-01-02', NULL, 'unique_13'), (11, 1, 24, 0, 'default1', '2023-01-01', 'default1', 'unique_14'), (12, 2, 24, 23, 'default2', '2023-01-01', 'default2', 'unique_15'), (13, 24, 23, 24, 'default1', '2023-01-01', 'default1', 'unique_16'), (14, 18, 0, 0, 'default1', '2023-01-02', 'default2', 'unique_17'), (15, 14, 1, 24, 'default1', '2023-01-01', NULL, 'unique_18'), (16, 16, 0, 0, 'default1', '2023-01-01', NULL, 'unique_19'), (17, 13, 2, 23, 'default1', '2023-01-02', 'default1', 'unique_20');
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (24, 9, 5, 2.0, 'default1'), (23, 5, 1, 1.0, 'default2'), (1, 23, 5, 1.0, 'default1'), (2, 1, 6, 2.0, NULL), (0, 0, 8, NULL, 'default1'), (25, 13, 1, 0.0, 'default2'), (3, 6, 23, 25.0, 'default1'), (4, 5, 25, 24.0, 'default1'), (5, 5, 7, 25.0, 'default1'), (6, 24, 25, 1.0, NULL), (7, 13, 7, 1.0, 'default2'), (8, 17, 2, 2.0, 'default1'), (9, 23, 5, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T1.raceId = 24 AND T1.points = 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT c.country FROM constructorResults AS cr INNER JOIN races AS r ON cr.raceId = r.raceId INNER JOIN circuits AS c ON r.circuitId = c.circuitId WHERE r.raceId = 24 AND cr.points = 1;

/*
Prediction Result:
(None,)
*/