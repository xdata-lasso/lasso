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
INSERT INTO status (statusid, status) VALUES (2, 'default2'), (934, 'default1'), (0, 'default1'), (1, 'default2'), (932, 'default2'), (933, 'default2'), (3, 'default2'), (4, 'default1'), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'default2'), (12, 'default1'), (13, 'default1'), (14, 'default1'), (15, 'default2'), (16, 'default1');
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (932, 'default1'), (1, 'unique_2'), (934, 'unique_3'), (2, 'unique_4'), (933, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (933, 'default1', 1, 'default1', 'default2', 'default2', '2023-01-02', NULL, 'default2'), (934, 'default1', 934, 'default1', 'default2', 'default2', '2023-01-01', NULL, 'default1'), (932, 'default2', 0, 'default1', 'default2', 'default1', '2023-01-01', NULL, 'unique_2'), (2, 'default1', NULL, NULL, 'default1', 'default2', NULL, 'default1', 'unique_3'), (1, 'default2', 933, 'default1', 'default2', 'default1', NULL, 'default2', 'unique_4'), (0, 'default2', 932, 'default2', 'default2', 'default2', NULL, 'default1', 'unique_5'), (3, 'default1', 2, NULL, 'default1', 'default1', '2023-01-02', NULL, 'unique_6'), (4, 'default2', NULL, 'default1', 'default1', 'default2', '2023-01-02', 'default2', 'unique_7'), (5, 'default1', 933, NULL, 'default1', 'default2', NULL, 'default2', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'default2', NULL, 'default1'), (2, 'default1', 'default1', 'default1', 'default2'), (934, 'default2', 'unique_2', NULL, 'default1'), (932, 'default2', 'unique_3', 'default2', 'default2'), (0, 'default1', 'unique_4', 'default1', 'default1'), (933, 'default1', 'unique_5', 'default2', 'default2'), (3, 'default2', 'unique_6', NULL, 'default2'), (4, 'default1', 'unique_7', NULL, 'default1'), (5, 'default1', 'unique_8', 'default2', 'default1'), (6, 'default1', 'unique_9', 'default2', 'default2'), (7, 'default2', 'unique_10', NULL, 'default1'), (8, 'default1', 'unique_11', NULL, 'default2'), (9, 'default1', 'unique_12', NULL, 'default1'), (10, 'default2', 'unique_13', NULL, 'default1'), (11, 'default2', 'unique_14', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (932, 'default2', 'default1', 'default2', NULL, 934.0, 2.0, NULL, 'default1'), (2, 'default1', 'default1', 'default2', 'default2', 932.0, 0.0, 2, 'default2'), (933, 'default1', 'default2', NULL, 'default2', 932.0, NULL, 932, 'unique_2'), (0, 'default1', 'default2', NULL, 'default2', NULL, NULL, NULL, 'unique_3'), (1, 'default2', 'default1', NULL, 'default2', 1.0, 1.0, 933, 'unique_4'), (934, 'default2', 'default2', 'default2', 'default1', NULL, 0.0, 933, 'unique_5'), (3, 'default1', 'default2', NULL, NULL, 2.0, 2.0, 0, 'unique_6'), (4, 'default2', 'default1', 'default1', 'default2', 2.0, 2.0, 932, 'unique_7'), (5, 'default1', 'default2', 'default1', 'default1', 934.0, 932.0, 1, 'unique_8'), (6, 'default1', 'default2', NULL, 'default2', 932.0, NULL, 0, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (934, 5, 932, 933, 'default2', '2023-01-01', 'default1', NULL), (0, 4, 0, 2, 'default2', '2023-01-02', NULL, 'default2'), (933, 933, 3, 934, 'default2', '2023-01-01', 'default2', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (932, 0, 1, 2, 16, 933, 0, 933, 'default2', 933, 933.0, 934, 'default1', 934, 2, 1, 'default2', 'default2'), (1, 934, 5, 932, 6, NULL, 2, 934, 'default2', 932, 932.0, 0, 'default1', 932, 934, 933, NULL, NULL), (933, 0, 2, 2, 6, 2, 934, 934, 'default2', 934, 2.0, 1, 'default1', 1, NULL, 0, 'default1', 'default1'), (2, 0, 932, 2, 15, 934, 934, 0, 'default1', 2, 934.0, 1, 'default1', 0, 932, 0, 'default2', NULL), (0, 933, 933, 7, 6, NULL, 932, NULL, 'default2', 2, 0.0, 932, 'default1', 2, 933, 0, 'default2', 'default1'), (934, 0, 933, 8, 16, 2, 2, 0, 'default1', 932, 0.0, 932, NULL, 1, 933, 934, 'default2', NULL), (3, 0, 934, 3, 13, 2, 0, 933, 'default2', 2, 934.0, 2, 'default2', 933, 933, NULL, NULL, NULL), (4, 934, 3, 0, 16, 1, 934, 932, 'default2', 0, 2.0, 1, 'default1', 933, 1, 0, 'default2', 'default2'), (5, 933, 933, 4, 932, 1, 934, NULL, 'default1', 932, 933.0, 934, 'default1', 2, 0, 2, 'default2', NULL), (6, 934, 3, 4, 11, 933, 933, NULL, 'default1', 933, 0.0, 0, 'default1', 2, 0, 933, 'default2', 'default1'), (7, 933, 1, 2, 14, 2, 1, 1, 'default1', 934, 2.0, 933, 'default1', NULL, 932, 1, NULL, 'default2'), (8, 0, 5, 934, 934, 2, 2, 0, 'default1', 934, 0.0, 2, 'default2', 1, 932, 933, NULL, 'default2'), (9, 933, 934, 3, 934, 2, 932, 933, 'default1', 1, 2.0, 932, NULL, 1, 934, 933, 'default1', 'default1'), (10, 934, 4, 8, 9, 1, 2, 2, 'default2', 934, 932.0, 2, NULL, 933, 0, 0, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 933 AND NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapSpeed DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 933 ORDER BY T2.fastestLapSpeed DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/