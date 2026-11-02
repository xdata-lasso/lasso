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
INSERT INTO status (statusid, status) VALUES (2, 'default1'), (0, 'default1'), (1, 'default2'), (932, 'default2'), (933, 'default2'), (934, 'default1'), (3, 'default2');
INSERT INTO seasons (year, url) VALUES (933, 'default1'), (934, 'default2'), (2, 'unique_2'), (932, 'unique_3'), (0, 'unique_4'), (1, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15'), (13, 'unique_16');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 932, 'default1', 'default1', 'default1', NULL, 'default1', 'default2'), (932, 'default2', 1, NULL, 'default2', 'default2', '2023-01-02', NULL, 'default1'), (1, 'default1', 0, 'default2', 'default1', 'default1', NULL, NULL, 'unique_2'), (933, 'default2', 934, 'default2', 'default1', 'default1', NULL, NULL, 'unique_3'), (934, 'default1', 0, 'default2', 'default1', 'default2', '2023-01-02', 'default2', 'unique_4'), (2, 'default1', 0, 'default2', 'default1', 'default2', NULL, NULL, 'unique_5'), (3, 'default1', 0, NULL, 'default2', 'default1', '2023-01-02', 'default2', 'unique_6'), (4, 'default1', 2, NULL, 'default1', 'default1', '2023-01-02', NULL, 'unique_7'), (5, 'default2', 932, 'default1', 'default2', 'default1', '2023-01-01', 'default2', 'unique_8'), (6, 'default1', 1, 'default2', 'default2', 'default2', '2023-01-02', NULL, 'unique_9'), (7, 'default2', 932, 'default2', 'default2', 'default1', '2023-01-01', 'default2', 'unique_10'), (8, 'default2', 0, NULL, 'default1', 'default1', '2023-01-01', 'default2', 'unique_11'), (9, 'default1', 932, 'default1', 'default1', 'default2', '2023-01-01', 'default1', 'unique_12'), (10, 'default1', 0, 'default1', 'default1', 'default1', '2023-01-01', 'default2', 'unique_13');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (934, 'default2', 'default1', 'default1', 'default2'), (932, 'default1', 'default2', 'default2', 'default1'), (933, 'default1', 'unique_2', 'default1', 'default1'), (1, 'default1', 'unique_3', 'default2', 'default1'), (0, 'default2', 'unique_4', 'default1', 'default1'), (2, 'default2', 'unique_5', 'default2', 'default2'), (3, 'default2', 'unique_6', 'default2', 'default2'), (4, 'default1', 'unique_7', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default1', 'default1', NULL, 933.0, NULL, 1, 'default2'), (933, 'default1', 'default2', 'default1', NULL, 1.0, 0.0, 0, 'default1'), (932, 'default1', 'default2', 'default1', 'default2', 2.0, 932.0, 934, 'unique_2'), (2, 'default2', 'default1', 'default1', 'default2', 934.0, 1.0, 932, 'unique_3'), (934, 'default2', 'default2', NULL, 'default2', 0.0, 934.0, 2, 'unique_4'), (1, 'default2', 'default2', NULL, NULL, NULL, 2.0, 2, 'unique_5'), (3, 'default1', 'default2', NULL, 'default2', 0.0, 2.0, 1, 'unique_6'), (4, 'default1', 'default2', 'default1', 'default2', 933.0, 1.0, 932, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 0, 3, 1, 'default1', '2023-01-02', 'default1', 'default2'), (934, 6, 4, 933, 'default2', '2023-01-02', 'default2', NULL), (933, 1, 0, 2, 'default2', '2023-01-01', NULL, 'default1'), (932, 1, 1, 0, 'default2', '2023-01-02', NULL, 'unique_3'), (2, 10, 2, 0, 'default1', '2023-01-01', NULL, 'unique_4'), (1, 933, 2, 932, 'default1', '2023-01-01', NULL, 'unique_5');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (933, 934, 6, 933, 3, 2, 932, NULL, 'default2', 934, 1.0, 932, NULL, NULL, 932, 1, NULL, 'default2'), (932, 0, 6, 1, 1, 934, 933, 2, 'default2', 2, 932.0, 0, 'default1', 1, NULL, NULL, 'default2', NULL), (0, 2, 0, 3, 932, 1, 1, 933, 'default1', 933, 933.0, 2, 'default2', 932, 1, 934, 'default1', NULL), (934, 1, 3, 0, 3, 1, 2, 1, 'default1', 1, 934.0, 932, 'default1', 934, 934, 0, 'default2', NULL), (1, 933, 9, 0, 934, 933, 932, 1, 'default2', 933, 2.0, 932, 'default1', 934, 933, 0, NULL, 'default2'), (2, 1, 8, 4, 932, NULL, 0, 934, 'default2', 933, 1.0, 933, 'default1', 2, 2, 1, NULL, 'default2'), (3, 934, 1, 4, 933, 0, 1, 1, 'default1', 0, 0.0, 1, 'default1', 933, NULL, 2, 'default1', NULL), (4, 1, 932, 0, 932, 0, 0, 932, 'default1', 934, 932.0, 1, 'default1', 934, 933, NULL, 'default1', 'default1'), (5, 0, 934, 934, 933, 932, 1, 1, 'default1', 934, 934.0, 934, 'default1', 0, 0, 934, NULL, 'default2'), (6, 932, 933, 1, 934, 0, 0, 2, 'default2', 933, 934.0, 1, NULL, 934, 2, 0, 'default1', 'default1'), (7, 1, 933, 0, 2, 934, 0, 934, 'default2', 1, 2.0, 932, 'default1', 0, 932, 1, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 933 AND NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapSpeed DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.nationality FROM results AS T1 JOIN drivers AS T2 ON T1.driverId = T2.driverId JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.raceId = 933 ORDER BY T1.fastestLapSpeed DESC, T1.resultid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/