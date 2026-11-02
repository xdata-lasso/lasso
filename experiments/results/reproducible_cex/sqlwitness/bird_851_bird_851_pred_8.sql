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
INSERT INTO seasons (year, url) VALUES (0, 'Renault'), (1, 'default1'), (2, 'default2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16'), (17, 'unique_17'), (18, 'unique_18'), (19, 'unique_19'), (20, 'unique_20'), (21, 'unique_21'), (22, 'unique_22'), (23, 'unique_23'), (24, 'unique_24'), (25, 'unique_25'), (26, 'unique_26'), (27, 'unique_27'), (28, 'unique_28');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'Renault', 'Renault', 'Renault'), (0, 'default2', 'default1', NULL, 'default2'), (2, 'Renault', 'default2', 'Renault', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Renault', 'default1', NULL, 'default2', 0.0, NULL, NULL, 'default1'), (0, 'Renault', 'default2', 'default1', 'default1', NULL, 1.0, 1, 'default2'), (2, 'Renault', 'default2', 'default1', NULL, NULL, 0.0, 0, 'Renault'), (3, 'default1', 'default1', 'Renault', NULL, 0.0, NULL, NULL, 'unique_3'), (4, 'default1', 'default2', 'default2', 'default1', 1.0, NULL, 1, 'unique_4'), (5, 'Renault', 'default2', 'Renault', 'default1', NULL, NULL, 1, 'unique_5'), (6, 'Renault', 'default2', 'default2', 'Renault', NULL, 0.0, 0, 'unique_6'), (7, 'default1', 'Renault', 'default1', 'default2', 0.0, 0.0, NULL, 'unique_7'), (8, 'default1', 'Renault', 'default1', 'default1', 0.0, 1.0, 0, 'unique_8'), (9, 'default2', 'default1', NULL, 'default2', 0.0, 0.0, 1, 'unique_9'), (10, 'default1', 'default2', NULL, 'Renault', 1.0, 0.0, 0, 'unique_10'), (11, 'default2', 'default2', 'default2', 'Renault', 1.0, 1.0, NULL, 'unique_11'), (12, 'default1', 'default1', 'default2', 'default1', 0.0, 0.0, 0, 'unique_12'), (13, 'default2', 'default2', 'Renault', 'default1', 1.0, 0.0, NULL, 'unique_13'), (14, 'Renault', 'default2', 'default2', NULL, NULL, NULL, 1, 'unique_14'), (15, 'default1', 'default1', 'default1', 'default1', NULL, 0.0, 0, 'unique_15'), (16, 'default2', 'Renault', 'Renault', 'Renault', 0.0, 1.0, NULL, 'unique_16'), (17, 'default1', 'default1', 'default2', 'default2', 0.0, 0.0, NULL, 'unique_17'), (18, 'Renault', 'default2', 'default1', 'default1', NULL, 0.0, NULL, 'unique_18'), (19, 'default1', 'Renault', 'default1', NULL, 0.0, NULL, NULL, 'unique_19'), (20, 'default2', 'default2', 'default2', 'default2', NULL, 1.0, 0, 'unique_20'), (21, 'default1', 'default2', 'default2', 'Renault', 0.0, 0.0, NULL, 'unique_21'), (22, 'Renault', 'default1', 'default2', NULL, 0.0, 0.0, 1, 'unique_22'), (23, 'default1', 'default1', 'default1', NULL, 0.0, NULL, 1, 'unique_23'), (24, 'default1', 'default1', NULL, 'default1', 1.0, NULL, NULL, 'unique_24'), (25, 'Renault', 'default2', NULL, 'Renault', 1.0, NULL, 1, 'unique_25'), (26, 'Renault', 'default2', 'default2', 'default2', 1.0, 1.0, NULL, 'unique_26'), (27, 'default2', 'default2', NULL, 'default1', 1.0, 1.0, NULL, 'unique_27'), (28, 'default1', 'default2', 'default1', NULL, 1.0, 1.0, 0, 'unique_28'), (29, 'default1', 'Renault', 'default2', 'Renault', NULL, 0.0, NULL, 'unique_29'), (30, 'Renault', 'default1', 'default1', 'default1', 0.0, 0.0, 0, 'unique_30'), (31, 'default1', 'default1', 'Renault', 'default1', 1.0, 1.0, NULL, 'unique_31'), (32, 'default1', 'default2', 'default1', NULL, 1.0, 0.0, NULL, 'unique_32'), (33, 'Renault', 'Renault', 'default2', 'default1', NULL, 1.0, 1, 'unique_33'), (34, 'Renault', 'default1', 'default2', 'Renault', 0.0, NULL, 0, 'unique_34'), (35, 'default2', 'default1', 'default2', 'default2', NULL, 1.0, 1, 'unique_35'), (36, 'default2', 'Renault', 'default2', 'Renault', 0.0, NULL, 0, 'unique_36'), (37, 'default2', 'default1', NULL, 'default1', NULL, NULL, NULL, 'unique_37');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 16, 8, 1, 'default2', '2023-01-02', 'default1', NULL), (1, 15, 11, 1, 'default1', '2023-01-01', 'default1', 'default2'), (2, 10, 31, 1, 'default2', '2023-01-02', NULL, 'default1'), (3, 22, 15, 0, 'default2', '2023-01-01', 'Renault', 'Renault'), (4, 5, 14, 0, 'default2', '2023-01-02', NULL, 'unique_4'), (5, 13, 22, 0, 'default2', '2023-01-01', NULL, 'unique_5'), (6, 14, 34, 0, 'default1', '2023-01-02', NULL, 'unique_6'), (7, 13, 22, 1, 'default1', '2023-01-02', NULL, 'unique_7'), (8, 21, 35, 0, 'Renault', '2023-01-02', 'Renault', 'unique_8'), (9, 2, 35, 1, 'Renault', '2023-01-02', 'Renault', 'unique_9'), (10, 11, 11, 0, 'Renault', '2023-01-02', 'default1', 'unique_10'), (11, 17, 25, 1, 'default2', '2023-01-01', 'default2', 'unique_11'), (12, 6, 28, 1, 'Renault', '2023-01-01', 'Renault', 'unique_12'), (13, 2, 34, 0, 'default1', '2023-01-02', 'default2', 'unique_13'), (14, 16, 31, 1, 'default2', '2023-01-01', 'default1', 'unique_14'), (15, 12, 28, 0, 'default2', '2023-01-02', 'default2', 'unique_15'), (16, 10, 16, 0, 'Renault', '2023-01-02', 'Renault', 'unique_16'), (17, 22, 30, 0, 'default1', '2023-01-01', 'Renault', 'unique_17'), (18, 18, 24, 1, 'Renault', '2023-01-02', NULL, 'unique_18'), (19, 5, 5, 0, 'Renault', '2023-01-02', 'default2', 'unique_19'), (20, 7, 37, 0, 'Renault', '2023-01-01', NULL, 'unique_20'), (21, 1, 0, 0, 'default2', '2023-01-02', 'Renault', 'unique_21'), (22, 16, 16, 1, 'default2', '2023-01-01', NULL, 'unique_22'), (23, 27, 4, 0, 'default2', '2023-01-02', NULL, 'unique_23'), (24, 19, 17, 0, 'default1', '2023-01-01', NULL, 'unique_24'), (25, 13, 15, 0, 'Renault', '2023-01-01', NULL, 'unique_25'), (26, 3, 20, 0, 'Renault', '2023-01-02', 'Renault', 'unique_26'), (27, 4, 23, 0, 'default2', '2023-01-02', NULL, 'unique_27'), (28, 1, 23, 0, 'default1', '2023-01-02', 'default1', 'unique_28'), (29, 28, 12, 1, 'default1', '2023-01-02', 'default1', 'unique_29'), (30, 2, 9, 1, 'Renault', '2023-01-01', 'Renault', 'unique_30');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (1, 11, 2, 1.0, NULL, 'default1', 1), (0, 7, 1, 0.0, 0, 'default2', 1), (2, 10, 1, 0.0, 1, NULL, 1), (3, 29, 1, 1.0, 0, 'default2', 0), (4, 17, 1, 0.0, NULL, 'default2', 1), (5, 26, 1, 1.0, 1, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.position FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T2.name = 'Renault';

/*
Gold Result:
(0,)
(1,)
(None,)
*/

-- Prediction Query
SELECT position FROM constructorStandings WHERE constructorId IN (SELECT constructorId FROM constructors WHERE name = 'Renault');

/*
Prediction Result:
(0,)
(1,)
(0,)
(None,)
(1,)
*/