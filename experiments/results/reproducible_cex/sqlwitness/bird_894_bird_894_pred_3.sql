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
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (1, 'default2'), (2, 'unique_2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16'), (17, 'unique_17'), (18, 'unique_18');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default1', 2, NULL, 'default1', 'default1', '2023-01-02', NULL, 'default1'), (1, 'default1', NULL, NULL, 'default1', 'default2', '2023-01-02', 'default2', 'default2'), (0, 'default1', NULL, NULL, 'default1', 'default2', '2023-01-02', NULL, 'unique_2'), (3, 'default1', NULL, 'default2', 'default2', 'default1', '2023-01-01', 'default2', 'unique_3'), (4, 'default1', NULL, NULL, 'default1', 'default1', '2023-01-02', 'default2', 'unique_4'), (5, 'default1', NULL, NULL, 'default1', 'default1', NULL, NULL, 'unique_5'), (6, 'default1', NULL, 'default1', 'default2', 'default2', '2023-01-02', 'default2', 'unique_6'), (7, 'default2', NULL, NULL, 'default2', 'default1', '2023-01-01', NULL, 'unique_7'), (8, 'default1', 1, 'default2', 'default2', 'default1', '2023-01-02', 'default2', 'unique_8'), (9, 'default2', 2, NULL, 'default1', 'default1', '2023-01-01', 'default1', 'unique_9'), (10, 'default1', 2, NULL, 'default1', 'default1', '2023-01-01', 'default1', 'unique_10'), (11, 'default1', 1, NULL, 'default1', 'default1', '2023-01-02', 'default2', 'unique_11'), (12, 'default1', 0, NULL, 'default1', 'default2', '2023-01-01', 'default2', 'unique_12'), (13, 'default1', 0, 'default1', 'default2', 'default2', NULL, 'default2', 'unique_13'), (14, 'default2', 1, 'default2', 'default1', 'default1', NULL, NULL, 'unique_14'), (15, 'default1', NULL, 'default1', 'default1', 'default1', '2023-01-01', 'default2', 'unique_15'), (16, 'default2', 2, 'default2', 'default2', 'default2', '2023-01-01', 'default2', 'unique_16'), (17, 'default1', NULL, NULL, 'default2', 'default1', NULL, NULL, 'unique_17'), (18, 'default1', 1, 'default2', 'default2', 'default2', '2023-01-01', NULL, 'unique_18'), (19, 'default1', 1, NULL, 'default1', 'default2', '2023-01-02', 'default1', 'unique_19'), (20, 'default1', NULL, NULL, 'default2', 'default2', '2023-01-02', 'default2', 'unique_20');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'default1', 'default2', 'default1', 1.0, 1.0, 2, 'default1'), (2, 'default1', 'default2', NULL, 'default2', 1.0, 0.0, NULL, 'default2'), (1, 'default2', 'default2', 'default2', NULL, 2.0, 0.0, 2, 'unique_2');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 5, 0, 2, 'default1', '2023-01-01', 'default2', NULL), (2, 2, 2, 1, 'default1', '2023-01-01', 'default1', 'default2'), (0, 13, 1, 0, 'default2', '2023-01-02', 'default2', 'default1'), (3, 9, 1, 1, 'default1', '2023-01-01', 'default1', 'unique_3'), (4, 1, 0, 1, 'default1', '2023-01-02', NULL, 'unique_4'), (5, 9, 0, 1, 'default2', '2023-01-01', 'default2', 'unique_5'), (6, 5, 0, 0, 'default2', '2023-01-01', 'default2', 'unique_6'), (7, 8, 2, 2, 'default2', '2023-01-02', NULL, 'unique_7'), (8, 5, 1, 0, 'default1', '2023-01-02', 'default1', 'unique_8'), (9, 8, 0, 1, 'default2', '2023-01-01', 'default1', 'unique_9'), (10, 14, 0, 1, 'default1', '2023-01-02', 'default2', 'unique_10'), (11, 11, 1, 1, 'default2', '2023-01-02', 'default2', 'unique_11'), (12, 4, 0, 1, 'default1', '2023-01-02', NULL, 'unique_12'), (13, 9, 0, 2, 'default2', '2023-01-01', 'default1', 'unique_13'), (14, 18, 2, 0, 'default2', '2023-01-02', NULL, 'unique_14'), (15, 11, 1, 2, 'default1', '2023-01-02', 'default2', 'unique_15'), (16, 5, 1, 1, 'default2', '2023-01-01', 'default2', 'unique_16'), (17, 17, 1, 0, 'default1', '2023-01-01', 'default2', 'unique_17'), (18, 7, 0, 2, 'default2', '2023-01-02', NULL, 'unique_18'), (19, 7, 2, 1, 'default1', '2023-01-02', NULL, 'unique_19'), (20, 12, 2, 1, 'default1', '2023-01-01', 'default1', 'unique_20');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (4, 16, 0, 2, 'default1', NULL), (12, 1, 1, 1, 'default1', NULL), (2, 14, 1, NULL, NULL, 1), (18, 9, 2, 0, NULL, 1), (18, 16, 0, 0, NULL, NULL), (7, 13, 0, 0, 'default1', NULL), (1, 0, 0, 2, 'default2', 1), (15, 19, 0, 2, NULL, 0), (12, 13, 2, 0, 'default1', 1), (14, 19, 0, NULL, NULL, 2), (0, 10, 0, 1, 'default2', 0), (10, 20, 1, 1, 'default1', 2), (6, 12, 1, 1, NULL, NULL), (7, 1, 0, NULL, 'default2', 2), (5, 1, 1, 1, 'default1', 0), (5, 17, 2, 2, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.milliseconds, T1.forename, T1.surname, T3.name FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId ORDER BY T2.milliseconds ASC, T1.driverid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(None, 'default1', 'default2', 'default1')
*/

-- Prediction Query
SELECT T1.milliseconds, T2.forename, T2.surname, T3.name FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId ORDER BY T1.milliseconds, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 'default2', 'default2', 'default1')
*/