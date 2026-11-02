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
INSERT INTO seasons (year, url) VALUES (0, 'Shanghai');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default2', NULL, NULL, NULL, 1.0, NULL, 'Shanghai'), (0, 'Shanghai', 'default2', 'default2', 'default2', 1.0, 0.0, NULL, 'default1'), (2, 'default1', 'default1', 'default1', 'default2', 1.0, NULL, 0, 'default2'), (3, 'default2', 'default1', NULL, 'Shanghai', 1.0, NULL, 1, 'unique_3'), (4, 'default1', 'default1', NULL, 'default2', NULL, NULL, NULL, 'unique_4'), (5, 'default1', 'Shanghai', NULL, NULL, NULL, 1.0, 1, 'unique_5'), (6, 'Shanghai', 'default2', 'default2', NULL, 1.0, NULL, 1, 'unique_6'), (7, 'default2', 'default2', NULL, 'Shanghai', NULL, 1.0, 0, 'unique_7'), (8, 'default2', 'default2', NULL, 'default2', 1.0, 1.0, 1, 'unique_8'), (9, 'Shanghai', 'default1', 'default2', 'Shanghai', NULL, NULL, NULL, 'unique_9'), (10, 'default1', 'Shanghai', 'default2', 'default1', NULL, 1.0, 0, 'unique_10'), (11, 'default1', 'default1', 'default1', 'default1', 1.0, 1.0, NULL, 'unique_11'), (12, 'default2', 'default2', NULL, 'default1', 0.0, 0.0, 0, 'unique_12'), (13, 'default2', 'Shanghai', NULL, 'default1', NULL, 0.0, 0, 'unique_13'), (14, 'default1', 'default1', 'Shanghai', NULL, NULL, 0.0, 1, 'unique_14'), (15, 'default1', 'default1', 'Shanghai', NULL, 1.0, 1.0, NULL, 'unique_15'), (16, 'default1', 'Shanghai', 'default1', 'Shanghai', 0.0, 1.0, 1, 'unique_16');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 6, 0, 'Shanghai', '2023-01-02', 'default2', NULL), (0, 0, 15, 1, 'default1', '2023-01-02', 'default1', 'default2'), (2, 0, 5, 0, 'Shanghai', '2023-01-02', 'Shanghai', 'default1'), (3, 0, 11, 0, 'Shanghai', '2023-01-01', 'default2', 'Shanghai'), (4, 0, 11, 1, 'Shanghai', '2023-01-01', 'Shanghai', 'unique_4'), (5, 0, 10, 0, 'Shanghai', '2023-01-02', 'Shanghai', 'unique_5'), (6, 0, 12, 0, 'default1', '2023-01-02', 'default2', 'unique_6'), (7, 0, 12, 0, 'default2', '2023-01-01', NULL, 'unique_7'), (8, 0, 5, 0, 'Shanghai', '2023-01-01', NULL, 'unique_8'), (9, 0, 12, 1, 'default1', '2023-01-01', 'default2', 'unique_9'), (10, 0, 15, 1, 'Shanghai', '2023-01-01', 'default1', 'unique_10'), (11, 0, 11, 1, 'Shanghai', '2023-01-01', 'Shanghai', 'unique_11'), (12, 0, 11, 0, 'default2', '2023-01-02', 'Shanghai', 'unique_12'), (13, 0, 8, 1, 'default1', '2023-01-01', 'default1', 'unique_13'), (14, 0, 10, 0, 'default1', '2023-01-01', NULL, 'unique_14'), (15, 0, 6, 0, 'Shanghai', '2023-01-02', 'default2', 'unique_15'), (16, 0, 0, 0, 'default1', '2023-01-02', 'default1', 'unique_16'), (17, 0, 12, 0, 'Shanghai', '2023-01-01', 'default1', 'unique_17'), (18, 0, 1, 1, 'default2', '2023-01-02', NULL, 'unique_18'), (19, 0, 10, 0, 'default1', '2023-01-02', NULL, 'unique_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.year FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.location = 'Shanghai';

/*
Gold Result:
(0,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT T2.year FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T1.location = 'Shanghai';

/*
Prediction Result:
(0,)
*/