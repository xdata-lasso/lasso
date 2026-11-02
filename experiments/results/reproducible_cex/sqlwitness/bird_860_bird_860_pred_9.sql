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
INSERT INTO seasons (year, url) VALUES (355, 'default1'), (354, '1:40%'), (1, '0:01:40'), (0, 'default2'), (356, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (356, '0:01:40', 356, '0:01:40', 'default2', '0:01:40', '2023-01-02', NULL, 'default2'), (0, '1:40%', 1, NULL, 'default1', 'default1', '2023-01-01', '1:40%', '1:40%'), (355, 'default2', 354, '0:01:40', '1:40%', '1:40%', '2023-01-02', '0:01:40', 'default1'), (1, 'default2', NULL, NULL, '1:40%', 'default2', '2023-01-02', NULL, '0:01:40'), (354, '0:01:40', 1, NULL, 'default1', '1:40%', NULL, 'default1', 'unique_4'), (2, 'default1', NULL, '0:01:40', 'default2', 'default1', '2023-01-01', 'default2', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (356, 'default2', 'default2', '0:01:40', 'default1'), (354, '0:01:40', '1:40%', 'default1', '1:40%'), (1, '1:40%', 'default1', '0:01:40', 'default2'), (355, '1:40%', '0:01:40', '0:01:40', 'default1'), (0, '0:01:40', 'unique_4', 'default1', '1:40%'), (2, '0:01:40', 'unique_5', NULL, '1:40%'), (3, 'default1', 'unique_6', 'default2', 'default2'), (4, '0:01:40', 'unique_7', NULL, '1:40%'), (5, 'default2', 'unique_8', 'default2', '1:40%'), (6, '0:01:40', 'unique_9', 'default1', '0:01:40');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', '1:40%', 'default1', '1:40%', 355.0, 355.0, 356, '1:40%'), (355, '0:01:40', 'default1', '1:40%', 'default2', 356.0, 0.0, 1, '0:01:40'), (356, 'default2', 'default1', 'default1', NULL, NULL, NULL, 355, 'default1'), (354, 'default2', 'default1', '1:40%', NULL, 354.0, 354.0, NULL, 'default2'), (1, 'default1', '1:40%', NULL, 'default1', 0.0, 355.0, NULL, 'unique_4'), (2, 'default2', '1:40%', 'default2', '1:40%', 354.0, 356.0, 1, 'unique_5'), (3, 'default2', '0:01:40', 'default1', '0:01:40', 354.0, 356.0, 354, 'unique_6'), (4, 'default1', 'default1', 'default2', NULL, 354.0, NULL, 0, 'unique_7'), (5, 'default2', 'default2', NULL, '1:40%', NULL, 355.0, 355, 'unique_8'), (6, '0:01:40', 'default2', '1:40%', NULL, 354.0, 356.0, NULL, 'unique_9'), (7, '0:01:40', '1:40%', '1:40%', 'default1', NULL, 0.0, 355, 'unique_10'), (8, 'default2', '0:01:40', NULL, 'default2', 354.0, NULL, 355, 'unique_11'), (9, '0:01:40', '0:01:40', NULL, NULL, 0.0, 356.0, 354, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 354, 354, 'default2', '2026-10-27', 'default1', '1:40%'), (0, 4, 7, 356, '0:01:40', '2023-01-01', '0:01:40', '0:01:40'), (355, 3, 0, 356, 'default1', '2023-01-02', NULL, NULL), (354, 5, 1, 0, 'default1', '2026-10-27', 'default1', 'default2'), (356, 1, 4, 354, '0:01:40', '2023-01-02', NULL, 'default1'), (2, 2, 356, 355, 'default2', '2023-01-02', 'default1', 'unique_5'), (3, 4, 3, 0, '1:40%', '2026-10-27', 'default2', 'unique_6'), (4, 1, 1, 0, 'default1', '2023-01-02', NULL, 'unique_7'), (5, 0, 3, 1, '1:40%', '2026-10-27', 'default1', 'unique_8'), (6, 4, 354, 356, '1:40%', '2023-01-02', 'default1', 'unique_9'), (7, 0, 354, 356, 'default1', '2023-01-01', NULL, 'unique_10');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (355, 1, 0, 355, 0, 0, 'default1', '1:40%', NULL), (0, 356, 356, 0, 1, 1, '1:40%', 'default1', '1:40%'), (356, 5, 355, 5, 1, 0, 'default1', NULL, 'default1'), (354, 6, 0, 354, 356, 0, NULL, '0:01:40', '1:40%'), (1, 0, 355, 5, 355, NULL, '0:01:40', '1:40%', 'default1'), (2, 355, 0, 3, 354, 356, NULL, '1:40%', 'default1'), (3, 355, 1, 356, 0, 1, 'default2', 'default1', 'default2'), (4, 5, 355, 356, 354, 0, '0:01:40', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 355 AND T1.q2 LIKE '1:40%';

/*
Gold Result:
('1:40%',)
*/

-- Prediction Query
SELECT T1.nationality FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 355 AND TRIM(T2.q2) = '0:01:40';

/*
Prediction Result:
*/