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
INSERT INTO status (statusid, status) VALUES (1, 'Italian'), (0, 'Italian'), (2, 'default1'), (3, 'Italian'), (4, 'Italian'), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default2'), (9, 'default1'), (10, 'default1'), (11, 'default1'), (12, 'Italian'), (13, 'default2'), (14, 'default2'), (15, 'Italian'), (16, 'Italian'), (17, 'Italian'), (18, 'default1'), (19, 'default1'), (20, 'default2'), (21, 'default1'), (22, 'default2'), (23, 'default2'), (24, 'Italian'), (25, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (0, 'default1'), (2, 'Italian'), (3, 'unique_3'), (4, 'unique_4');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Italian', 1, 'default2', 'default2', 'default1', NULL, NULL, 'Italian'), (1, 'default2', 1, 'Italian', 'default2', 'default2', '2023-01-01', 'default1', 'default2'), (2, 'Italian', NULL, 'Italian', 'Italian', 'Italian', '2023-01-02', 'default2', 'default1'), (3, 'default2', NULL, 'Italian', 'default2', 'Italian', '2023-01-01', 'Italian', 'unique_3'), (4, 'default1', 0, 'default2', 'Italian', 'default1', '2023-01-01', NULL, 'unique_4'), (5, 'default2', 0, 'Italian', 'Italian', 'Italian', NULL, 'default2', 'unique_5'), (6, 'default2', 1, 'default1', 'default2', 'default1', '2023-01-02', 'Italian', 'unique_6'), (7, 'default1', 1, 'Italian', 'Italian', 'default1', NULL, NULL, 'unique_7'), (8, 'default2', 0, 'default1', 'default1', 'Italian', '2023-01-01', NULL, 'unique_8'), (9, 'default1', NULL, NULL, 'default2', 'Italian', '2023-01-02', 'default2', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default2', 'default1', 'default1', 'default2'), (1, 'Italian', 'Italian', 'Italian', 'default1'), (2, 'Italian', 'default2', 'default2', 'default2'), (3, 'default1', 'unique_3', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Italian', 'Italian', 'default1', 'default2', NULL, NULL, 0, 'default2'), (1, 'default2', 'default2', 'Italian', 'Italian', NULL, 1.0, 0, 'default1'), (2, 'default2', 'Italian', 'default2', 'default2', 1.0, 1.0, 0, 'Italian'), (3, 'default1', 'default1', NULL, 'default1', 1.0, 0.0, 0, 'unique_3');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 1, 0, 1, 'Italian', '2023-01-02', 'Italian', NULL), (1, 1, 3, 1, 'Italian', '2023-01-01', 'Italian', 'default2'), (2, 4, 1, 1, 'Italian', '2023-01-01', 'default2', 'default1'), (3, 3, 2, 1, 'Italian', '2023-01-01', 'Italian', 'Italian'), (4, 4, 0, 1, 'default1', '2023-01-02', 'default1', 'unique_4'), (5, 4, 3, 0, 'default2', '2023-01-02', 'default2', 'unique_5'), (6, 3, 2, 0, 'Italian', '2023-01-02', NULL, 'unique_6'), (7, 0, 0, 0, 'default2', '2023-01-01', NULL, 'unique_7'), (8, 0, 1, 1, 'Italian', '2023-01-01', 'default1', 'unique_8'), (9, 3, 0, 0, 'Italian', '2023-01-02', 'Italian', 'unique_9'), (10, 3, 0, 0, 'Italian', '2023-01-02', 'default1', 'unique_10'), (11, 1, 1, 0, 'default1', '2023-01-02', 'Italian', 'unique_11'), (12, 1, 1, 1, 'Italian', '2023-01-02', 'default1', 'unique_12'), (13, 3, 3, 0, 'Italian', '2023-01-01', 'Italian', 'unique_13'), (14, 4, 0, 0, 'Italian', '2023-01-01', 'Italian', 'unique_14'), (15, 2, 1, 1, 'default2', '2023-01-02', NULL, 'unique_15'), (16, 0, 2, 1, 'default1', '2023-01-01', 'default2', 'unique_16'), (17, 1, 1, 1, 'default1', '2023-01-01', 'Italian', 'unique_17'), (18, 4, 2, 1, 'default1', '2023-01-02', 'default1', 'unique_18'), (19, 2, 1, 1, 'default2', '2023-01-01', 'default2', 'unique_19'), (20, 2, 3, 1, 'default2', '2023-01-01', 'default1', 'unique_20');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 4, 6, 1, 10, 0, 1, NULL, 'Italian', 0, 1.0, 1, 'default2', 1, 0, 1, 'default2', 'Italian'), (0, 14, 6, 3, 6, NULL, 0, 0, 'default2', 1, 1.0, 1, NULL, 1, NULL, NULL, 'default1', NULL), (2, 3, 0, 0, 9, 1, 1, 0, 'Italian', 1, 0.0, 0, 'default2', 1, 0, 1, NULL, 'default2'), (3, 10, 5, 3, 24, 0, 0, NULL, 'default2', 1, 0.0, 1, 'default2', NULL, NULL, 0, 'default1', 'default2'), (4, 5, 5, 2, 14, NULL, 0, 0, 'Italian', 1, 0.0, 1, 'Italian', 0, 1, 1, 'default1', 'default1'), (5, 3, 3, 3, 9, NULL, 0, 0, 'Italian', 1, 1.0, 0, 'Italian', 1, 0, 1, NULL, NULL), (6, 13, 3, 3, 17, 1, 0, NULL, 'default2', 1, 0.0, 0, 'default2', NULL, 1, 0, 'default1', 'Italian'), (7, 18, 4, 0, 8, NULL, 0, 1, 'Italian', 0, 1.0, 1, NULL, NULL, 1, 0, 'default1', 'default1'), (8, 2, 3, 0, 13, 1, 1, NULL, 'default1', 0, 1.0, 0, 'default1', 1, 1, NULL, 'default1', 'default1'), (9, 20, 2, 3, 24, 0, 1, 0, 'default2', 1, 0.0, 0, NULL, 1, 0, NULL, 'Italian', 'Italian'), (10, 8, 6, 2, 1, 0, 1, 1, 'default2', 1, 0.0, 1, 'Italian', 0, 0, 0, NULL, 'default1'), (11, 18, 9, 2, 13, 0, 0, 0, 'default1', 0, 1.0, 1, 'default2', 1, 1, 0, NULL, 'Italian'), (12, 20, 9, 3, 25, 1, 1, 0, 'default2', 0, 0.0, 0, 'default1', NULL, NULL, 0, 'default2', 'default2'), (13, 16, 6, 1, 14, 1, 0, NULL, 'default1', 1, 0.0, 0, NULL, NULL, NULL, NULL, 'default1', 'default2'), (14, 14, 3, 3, 22, 1, 0, 0, 'default2', 0, 1.0, 0, 'Italian', NULL, NULL, 0, 'default1', NULL), (15, 8, 3, 0, 22, 1, 0, NULL, 'default2', 0, 0.0, 1, 'default1', 1, 0, 0, NULL, NULL), (16, 16, 2, 1, 11, 1, 1, NULL, 'Italian', 0, 0.0, 0, 'Italian', 1, 1, NULL, NULL, 'default2'), (17, 19, 4, 2, 18, 1, 0, NULL, 'default1', 1, 0.0, 1, 'default1', 1, 1, 1, 'Italian', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'Italian' AND T1.time IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT drivers.driverId) AS italian_drivers_not_finished FROM drivers INNER JOIN results ON drivers.driverId = results.driverId WHERE drivers.nationality = 'Italian' AND results.time IS NULL;

/*
Prediction Result:
(1,)
*/