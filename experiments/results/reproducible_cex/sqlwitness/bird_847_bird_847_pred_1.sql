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
INSERT INTO seasons (year, url) VALUES (20, 'default1'), (19, 'default2'), (0, 'unique_2'), (18, 'unique_3'), (2, 'unique_4'), (1, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15'), (13, 'unique_16');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default1', 1, NULL, 'default2', 'default2', '2023-01-01', 'default1', 'default1'), (18, 'default2', 19, NULL, 'default2', 'default1', NULL, 'default1', 'default2'), (19, 'default2', 0, 'default1', 'default1', 'default2', '2023-01-01', NULL, 'unique_2'), (20, 'default2', 20, 'default1', 'default2', 'default2', '2023-01-01', NULL, 'unique_3'), (1, 'default1', 19, 'default2', 'default1', 'default2', NULL, 'default2', 'unique_4'), (0, 'default2', 18, NULL, 'default2', 'default1', '2023-01-01', 'default1', 'unique_5'), (3, 'default1', 19, NULL, 'default1', 'default2', NULL, NULL, 'unique_6'), (4, 'default2', 20, 'default1', 'default2', 'default2', '2023-01-01', 'default2', 'unique_7'), (5, 'default2', 18, 'default1', 'default1', 'default2', NULL, NULL, 'unique_8'), (6, 'default2', 1, 'default2', 'default1', 'default2', NULL, 'default1', 'unique_9'), (7, 'default2', 19, 'default2', 'default2', 'default1', '2023-01-02', NULL, 'unique_10'), (8, 'default1', 19, 'default2', 'default2', 'default2', '2023-01-02', 'default2', 'unique_11'), (9, 'default2', 0, 'default2', 'default2', 'default1', '2023-01-02', 'default1', 'unique_12'), (10, 'default1', 18, 'default2', 'default1', 'default1', NULL, 'default1', 'unique_13'), (11, 'default1', 1, 'default1', 'default2', 'default1', NULL, NULL, 'unique_14'), (12, 'default1', NULL, NULL, 'default2', 'default2', '2023-01-01', 'default1', 'unique_15'), (13, 'default2', 2, 'default2', 'default2', 'default2', NULL, NULL, 'unique_16');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (20, 'default1', 'default2', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (18, 'default2', 'default2', NULL, NULL, 20.0, NULL, 20, 'default1'), (2, 'default1', 'default2', NULL, 'default2', 2.0, 18.0, 2, 'default2'), (1, 'default2', 'default1', 'default2', NULL, NULL, 19.0, 1, 'unique_2'), (20, 'default1', 'default1', 'default2', 'default2', 2.0, NULL, 2, 'unique_3'), (0, 'default2', 'default1', 'default2', 'default2', NULL, 19.0, 18, 'unique_4'), (19, 'default1', 'default1', NULL, NULL, 18.0, 1.0, 19, 'unique_5'), (3, 'default1', 'default2', 'default2', NULL, 1.0, 18.0, 19, 'unique_6'), (4, 'default2', 'default2', 'default2', NULL, 1.0, 19.0, 18, 'unique_7'), (5, 'default2', 'default1', NULL, NULL, 20.0, 18.0, 19, 'unique_8'), (6, 'default1', 'default2', 'default1', 'default2', 19.0, 19.0, 20, 'unique_9'), (7, 'default1', 'default2', 'default2', 'default2', 2.0, 19.0, 20, 'unique_10'), (8, 'default2', 'default2', NULL, 'default1', 0.0, 0.0, 20, 'unique_11'), (9, 'default1', 'default1', 'default1', NULL, 18.0, 2.0, 19, 'unique_12'), (10, 'default1', 'default2', NULL, 'default1', 1.0, 0.0, 2, 'unique_13'), (11, 'default1', 'default1', 'default2', 'default1', 0.0, NULL, 18, 'unique_14'), (12, 'default1', 'default1', 'default1', NULL, 2.0, 20.0, NULL, 'unique_15');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 19, 1, 19, 'default1', '2023-01-01', 'default1', 'default2'), (18, 0, 12, 20, 'default2', '2023-01-02', 'default1', 'default1'), (19, 0, 11, 20, 'default2', '2023-01-01', NULL, NULL);
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (0, 18, 5, 20, 19, 2, NULL, 'default1', 'default1'), (19, 18, 2, 20, 18, 1, 'default1', NULL, 'default2'), (1, 19, 0, 20, 19, 20, NULL, 'default2', 'default1'), (20, 19, 2, 20, 20, 20, 'default2', NULL, 'default1'), (2, 18, 2, 20, 1, 18, NULL, 'default2', 'default2'), (18, 19, 4, 20, 1, 1, 'default1', NULL, NULL), (3, 19, 9, 20, 1, 0, 'default1', 'default1', 'default1'), (4, 0, 3, 20, 18, 19, 'default1', NULL, 'default1'), (5, 19, 18, 20, 19, NULL, 'default1', 'default1', 'default1'), (6, 19, 4, 20, 19, NULL, NULL, NULL, 'default1'), (7, 18, 19, 20, 19, 1, 'default2', 'default1', 'default1'), (8, 18, 19, 20, 20, 18, NULL, NULL, 'default2'), (9, 19, 9, 20, 19, 19, 'default2', 'default1', 'default1'), (10, 18, 4, 20, 0, 20, 'default1', NULL, NULL), (11, 0, 5, 20, 18, 19, NULL, NULL, 'default1'), (12, 0, 19, 20, 2, 20, NULL, NULL, NULL), (13, 0, 6, 20, 20, 18, 'default2', 'default2', 'default2'), (14, 0, 3, 20, 18, 1, 'default1', NULL, 'default2'), (15, 0, 4, 20, 20, 18, 'default2', 'default2', 'default2'), (16, 0, 6, 20, 20, 18, 'default2', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 19 AND NOT T1.q2 IS NULL ORDER BY T1.q2 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT d.surname FROM drivers AS d INNER JOIN qualifying AS q ON d.driverId = q.driverId WHERE q.raceId = 19 AND q.q2 = (SELECT MIN(q2) FROM qualifying WHERE raceId = 19 AND NOT q2 IS NULL);

/*
Prediction Result:
('default1',)
('default1',)
('default1',)
*/