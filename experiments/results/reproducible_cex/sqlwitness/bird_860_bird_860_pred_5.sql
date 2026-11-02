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
INSERT INTO seasons (year, url) VALUES (354, '1:40%'), (1, 'default1'), (355, 'default2'), (356, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15'), (13, 'unique_16'), (14, 'unique_17'), (15, 'unique_18'), (16, 'unique_19'), (17, 'unique_20'), (18, 'unique_21'), (19, 'unique_22'), (20, 'unique_23'), (21, 'unique_24'), (22, 'unique_25'), (23, 'unique_26'), (24, 'unique_27'), (25, 'unique_28'), (26, 'unique_29'), (27, 'unique_30');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (356, 'default2', 0, '1:40%', 'default2', '1:40%', '2023-01-01', 'default2', '1:40%'), (1, 'default1', 0, NULL, 'default1', '1:40%', '2023-01-02', '1:40%', 'default2'), (355, '1:40%', 0, NULL, 'default2', '1:40%', '2023-01-02', '1:40%', 'default1'), (354, 'default2', 1, NULL, '1:40%', 'default1', '2023-01-02', NULL, 'unique_3'), (0, 'default1', 355, 'default1', '1:40%', 'default1', '2023-01-02', '1:40%', 'unique_4'), (2, 'default1', 1, 'default1', '1:40%', '1:40%', '2023-01-02', 'default1', 'unique_5'), (3, 'default1', 354, 'default1', 'default1', 'default1', '2023-01-02', 'default1', 'unique_6'), (4, 'default2', 1, 'default2', 'default2', 'default1', '2023-01-01', 'default2', 'unique_7'), (5, 'default2', NULL, 'default1', '1:40%', 'default1', NULL, '1:40%', 'unique_8'), (6, 'default2', 1, '1:40%', 'default2', 'default2', '2023-01-01', 'default1', 'unique_9'), (7, 'default1', 356, 'default1', 'default1', 'default2', '2023-01-01', 'default1', 'unique_10'), (8, 'default2', NULL, NULL, '1:40%', 'default1', '2023-01-02', NULL, 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (356, 'default1', 'default1', NULL, 'default2'), (354, '1:40%', 'default2', 'default2', 'default1'), (1, '1:40%', '1:40%', 'default1', 'default1'), (355, 'default2', 'unique_3', 'default2', '1:40%'), (0, 'default1', 'unique_4', 'default1', 'default1'), (2, 'default2', 'unique_5', '1:40%', '1:40%'), (3, '1:40%', 'unique_6', NULL, 'default1'), (4, 'default2', 'unique_7', 'default1', 'default2'), (5, 'default1', 'unique_8', 'default1', '1:40%'), (6, 'default1', 'unique_9', NULL, 'default1'), (7, '1:40%', 'unique_10', 'default2', '1:40%'), (8, '1:40%', 'unique_11', NULL, 'default1'), (9, 'default1', 'unique_12', '1:40%', '1:40%'), (10, '1:40%', 'unique_13', 'default1', 'default2'), (11, '1:40%', 'unique_14', 'default2', 'default2'), (12, 'default1', 'unique_15', 'default1', '1:40%'), (13, 'default1', 'unique_16', 'default1', '1:40%'), (14, 'default1', 'unique_17', '1:40%', '1:40%'), (15, 'default2', 'unique_18', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (356, 'default2', 'default2', 'default1', 'default1', 0.0, 0.0, NULL, '1:40%'), (355, 'default1', 'default1', 'default1', 'default2', 0.0, 355.0, 356, 'default2'), (354, 'default2', 'default1', 'default1', '1:40%', 1.0, 0.0, 356, 'default1'), (0, 'default1', '1:40%', NULL, '1:40%', 355.0, 1.0, 1, 'unique_3'), (1, 'default2', '1:40%', '1:40%', 'default2', NULL, 356.0, NULL, 'unique_4'), (2, '1:40%', 'default2', '1:40%', NULL, 1.0, 356.0, NULL, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (355, 7, 355, 1, 'default2', '2023-01-02', 'default2', 'default2');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (355, 355, 5, 1, 0, 1, 'default2', 'default2', NULL), (1, 355, 8, 11, 356, 355, 'default2', NULL, '1:40%'), (354, 355, 356, 4, 355, 354, NULL, NULL, 'default1'), (356, 355, 5, 3, 0, NULL, 'default1', 'default2', 'default1'), (0, 355, 6, 3, 354, 356, NULL, NULL, 'default2'), (2, 355, 2, 4, 356, 354, NULL, NULL, 'default2'), (3, 355, 3, 354, 356, 355, NULL, '1:40%', '1:40%'), (4, 355, 355, 2, 355, NULL, 'default2', NULL, '1:40%'), (5, 355, 6, 0, 354, 0, 'default2', 'default1', NULL), (6, 355, 2, 4, 1, 0, 'default1', 'default1', 'default2'), (7, 355, 7, 13, 355, NULL, 'default1', 'default2', '1:40%'), (8, 355, 8, 356, 355, 354, '1:40%', '1:40%', 'default1'), (9, 355, 355, 11, 1, 354, 'default2', '1:40%', '1:40%'), (10, 355, 7, 3, 0, 0, NULL, 'default1', 'default1'), (11, 355, 355, 1, 354, 356, 'default2', '1:40%', NULL), (12, 355, 0, 4, 354, NULL, NULL, '1:40%', '1:40%'), (13, 355, 6, 8, 1, 355, '1:40%', 'default2', 'default1'), (14, 355, 4, 7, 354, 355, 'default1', 'default2', '1:40%'), (15, 355, 0, 15, 355, NULL, NULL, 'default1', '1:40%'), (16, 355, 6, 10, 355, 355, '1:40%', 'default2', 'default2'), (17, 355, 7, 8, 1, 1, '1:40%', NULL, '1:40%'), (18, 355, 354, 4, 354, 355, NULL, '1:40%', '1:40%'), (19, 355, 355, 4, 0, 355, 'default1', '1:40%', 'default2'), (20, 355, 6, 13, 356, 0, 'default2', 'default1', 'default1'), (21, 355, 6, 2, 354, 356, 'default1', NULL, 'default1'), (22, 355, 5, 7, 356, 0, NULL, NULL, 'default1'), (23, 355, 7, 12, 355, 0, 'default2', '1:40%', '1:40%'), (24, 355, 0, 4, 0, 356, '1:40%', 'default1', '1:40%'), (25, 355, 2, 354, 355, 356, 'default1', '1:40%', 'default1'), (26, 355, 5, 5, 355, NULL, NULL, NULL, '1:40%'), (27, 355, 5, 0, 355, 356, NULL, '1:40%', 'default1'), (28, 355, 8, 12, 355, 0, '1:40%', '1:40%', '1:40%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 355 AND T1.q2 LIKE '1:40%';

/*
Gold Result:
('default1',)
(None,)
('1:40%',)
*/

-- Prediction Query
SELECT T2.nationality FROM qualifying AS T1 JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T1.raceId = 355 AND T1.q2 LIKE '1:40%';

/*
Prediction Result:
('default1',)
(None,)
('1:40%',)
('1:40%',)
('1:40%',)
(None,)
('1:40%',)
('default1',)
('default1',)
('1:40%',)
(None,)
*/