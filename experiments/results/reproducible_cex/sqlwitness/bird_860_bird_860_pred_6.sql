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
INSERT INTO seasons (year, url) VALUES (354, ':'), (356, '1:40%'), (0, 'default2'), (140, 'default1'), (1, ''), (139, 'unique_5'), (141, 'unique_6'), (355, 'unique_7'), (2, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12'), (7, 'unique_13'), (8, 'unique_14'), (9, 'unique_15'), (10, 'unique_16'), (11, 'unique_17'), (12, 'unique_18'), (13, 'unique_19');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (139, ':', 355, 'default1', ':', '', NULL, '', 'default2'), (0, '1:40%', 356, NULL, ':', ':', '2023-01-01', 'default2', 'default1'), (1, ':', NULL, ':', 'default2', ':', '2023-01-02', NULL, ':'), (356, 'default1', 139, 'default2', ':', 'default1', '2023-01-01', 'default1', '1:40%'), (141, '', NULL, 'default2', ':', '1:40%', '2023-01-01', 'default1', ''), (355, '', 1, '1:40%', ':', 'default1', '2023-01-01', '1:40%', 'unique_5'), (354, '1:40%', 139, '1:40%', 'default1', '', '2023-01-02', NULL, 'unique_6'), (140, 'default2', 1, NULL, '', '', NULL, 'default1', 'unique_7'), (2, '', 356, NULL, '1:40%', 'default1', NULL, 'default1', 'unique_8'), (3, '', 140, 'default2', ':', 'default1', NULL, ':', 'unique_9'), (4, '', 355, ':', 'default1', '1:40%', NULL, 'default2', 'unique_10'), (5, '', 356, '1:40%', ':', ':', '2023-01-01', 'default2', 'unique_11'), (6, '', 140, 'default2', 'default2', ':', '2023-01-01', ':', 'unique_12'), (7, 'default2', 139, ':', 'default1', 'default1', '2023-01-02', 'default1', 'unique_13');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (140, 'default2', ':', '', ':');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (140, 'default1', ':', 'default1', '', 1.0, NULL, 0, 'default1'), (0, 'default2', '1:40%', ':', NULL, 139.0, NULL, 1, '1:40%'), (139, ':', 'default2', 'default2', ':', 356.0, 0.0, 139, ':'), (354, 'default2', '1:40%', 'default2', '', 355.0, 140.0, 140, ''), (355, '', '1:40%', 'default2', '', 354.0, 356.0, NULL, 'default2'), (356, 'default1', '', NULL, ':', 140.0, 139.0, 0, 'unique_5'), (141, '', 'default1', '1:40%', '1:40%', 355.0, 139.0, 1, 'unique_6'), (1, ':', 'default1', 'default2', ':', 140.0, 356.0, NULL, 'unique_7'), (2, ':', '1:40%', '1:40%', ':', 1.0, 139.0, 354, 'unique_8'), (3, '', '', '', 'default1', 139.0, 139.0, 355, 'unique_9'), (4, ':', ':', NULL, '', 140.0, 1.0, 355, 'unique_10'), (5, '1:40%', 'default1', NULL, '', 0.0, NULL, 140, 'unique_11'), (6, 'default1', ':', '', 'default2', NULL, 139.0, 0, 'unique_12'), (7, '', 'default1', 'default2', '', 355.0, 1.0, 354, 'unique_13'), (8, '1:40%', '', 'default2', 'default1', 141.0, NULL, 1, 'unique_14'), (9, '', '1:40%', 'default1', ':', 1.0, 139.0, 140, 'unique_15'), (10, 'default2', 'default2', 'default1', '', 141.0, 1.0, 139, 'unique_16'), (11, 'default1', '1:40%', 'default2', ':', 0.0, NULL, 1, 'unique_17'), (12, '1:40%', '', '1:40%', 'default1', 355.0, 140.0, 140, 'unique_18'), (13, ':', 'default2', '', NULL, 356.0, 355.0, 355, 'unique_19'), (14, '', 'default2', 'default1', 'default2', 0.0, 1.0, 1, 'unique_20'), (15, '', ':', '', 'default1', NULL, 140.0, 140, 'unique_21');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (141, 5, 140, 355, '1:40%', '2023-01-02', NULL, ''), (139, 10, 10, 141, ':', '2023-01-01', 'default1', '1:40%'), (0, 8, 9, 354, '', '2023-01-01', 'default1', 'default1'), (140, 10, 5, 355, ':', '2023-01-02', ':', ':'), (354, 4, 140, 356, '1:40%', '2023-01-01', '', NULL), (1, 1, 14, 141, ':', '2023-01-02', '1:40%', 'default2'), (355, 9, 1, 356, '1:40%', '2023-01-01', '', 'unique_6'), (356, 6, 139, 355, '1:40%', '2023-01-01', ':', 'unique_7'), (2, 3, 6, 139, 'default1', '2023-01-02', 'default1', 'unique_8'), (3, 139, 1, 354, 'default1', '2023-01-01', NULL, 'unique_9'), (4, 354, 15, 140, 'default2', '2023-01-01', '', 'unique_10'), (5, 1, 141, 141, '', '2023-01-02', 'default2', 'unique_11'), (6, 13, 11, 141, '', '2023-01-02', 'default2', 'unique_12'), (7, 11, 355, 354, ':', '2023-01-02', '1:40%', 'unique_13'), (8, 10, 12, 354, ':', '2023-01-02', ':', 'unique_14'), (9, 11, 1, 356, ':', '2023-01-02', ':', 'unique_15'), (10, 10, 141, 140, '1:40%', '2023-01-01', 'default1', 'unique_16'), (11, 140, 140, 355, '1:40%', '2023-01-02', '1:40%', 'unique_17');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (141, 5, 354, 140, 356, 356, 'default1', ':', 'default2'), (139, 0, 141, 140, 1, 356, ':', 'default1', NULL), (1, 355, 6, 140, 354, 0, 'default1', '1:40%', NULL), (356, 6, 139, 140, 141, 1, ':', NULL, ':'), (0, 4, 139, 140, 140, NULL, '', ':', NULL), (140, 3, 5, 140, 354, 355, '', ':', '1:40%'), (354, 2, 7, 140, 354, NULL, '', 'default1', 'default1'), (355, 10, 6, 140, 140, 140, '', 'default1', 'default2'), (2, 6, 1, 140, 356, 1, 'default2', '', ''), (3, 355, 6, 140, 141, 356, '1:40%', '1:40%', NULL), (4, 11, 0, 140, 141, 139, '1:40%', ':', ':'), (5, 141, 354, 140, 355, 139, '', ':', 'default2'), (6, 6, 141, 140, 140, 141, '1:40%', NULL, NULL), (7, 2, 4, 140, 356, 141, 'default2', '', ''), (8, 4, 3, 140, 141, 1, '1:40%', ':', 'default1'), (9, 11, 0, 140, 355, 1, 'default2', '1:40%', NULL), (10, 9, 7, 140, 1, 354, '1:40%', 'default1', 'default2'), (11, 139, 6, 140, 354, NULL, '', NULL, '1:40%'), (12, 4, 141, 140, 354, NULL, 'default2', NULL, 'default1'), (13, 3, 354, 140, 355, 355, 'default2', '1:40%', ''), (14, 2, 1, 140, 139, 354, ':', '1:40%', 'default2'), (15, 355, 3, 140, 0, NULL, 'default1', 'default1', 'default2'), (16, 139, 356, 140, 354, 139, '', '1:40%', ':'), (17, 11, 354, 140, 140, NULL, '', NULL, 'default1'), (18, 4, 0, 140, 356, 356, '', ':', '1:40%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 355 AND T1.q2 LIKE '1:40%';

/*
Gold Result:
(':',)
*/

-- Prediction Query
SELECT drivers.nationality FROM qualifying INNER JOIN drivers ON qualifying.driverId = drivers.driverId WHERE qualifying.raceId = 355 AND CAST(REPLACE(qualifying.q2, ':', '') AS INTEGER) = 140;

/*
Prediction Result:
(':',)
(':',)
*/