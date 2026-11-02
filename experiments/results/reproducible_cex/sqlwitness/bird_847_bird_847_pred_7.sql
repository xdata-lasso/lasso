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
INSERT INTO seasons (year, url) VALUES (18, 'default1'), (2, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', 20, 'default2', 'default2', 'default1', NULL, NULL, 'default1'), (18, 'default1', 19, NULL, 'default1', 'default2', NULL, 'default2', 'default2'), (20, 'default2', NULL, 'default1', 'default1', 'default1', NULL, 'default1', 'unique_2'), (3, 'default2', 18, NULL, 'default1', 'default1', NULL, 'default1', 'unique_3'), (2, 'default2', 20, 'default1', 'default1', 'default2', '2023-01-01', 'default1', 'unique_4'), (0, 'default1', 20, 'default1', 'default1', 'default1', NULL, 'default1', 'unique_5'), (19, 'default1', 3, 'default1', 'default1', 'default2', NULL, 'default2', 'unique_6'), (4, 'default2', 19, NULL, 'default2', 'default1', '2023-01-01', 'default2', 'unique_7'), (5, 'default2', 20, 'default1', 'default1', 'default1', '2023-01-02', 'default2', 'unique_8'), (6, 'default1', 2, 'default1', 'default2', 'default1', '2023-01-02', 'default1', 'unique_9'), (7, 'default1', 1, 'default2', 'default1', 'default2', '2023-01-01', NULL, 'unique_10'), (8, 'default2', 18, NULL, 'default1', 'default1', '2023-01-02', NULL, 'unique_11'), (9, 'default2', 20, 'default1', 'default2', 'default1', '2023-01-02', NULL, 'unique_12');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (18, 'default1', 'default1', NULL, 'default1'), (2, 'default2', 'default2', 'default2', 'default2'), (3, 'default2', 'unique_2', NULL, 'default2'), (1, 'default2', 'unique_3', 'default2', 'default2'), (0, 'default2', 'unique_4', 'default2', 'default1'), (19, 'default1', 'unique_5', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', 'default1', 'default2', 'default2', 18.0, 0.0, 18, 'default1'), (20, 'default2', 'default2', 'default2', 'default1', 18.0, 0.0, NULL, 'default2'), (19, 'default2', 'default2', 'default2', 'default2', 1.0, 19.0, 2, 'unique_2'), (18, 'default1', 'default1', 'default2', NULL, 3.0, 20.0, 1, 'unique_3'), (3, 'default1', 'default1', 'default2', 'default1', NULL, 1.0, 2, 'unique_4'), (0, 'default1', 'default1', NULL, 'default2', 3.0, 0.0, 3, 'unique_5'), (2, 'default1', 'default2', 'default1', 'default1', 3.0, 2.0, 18, 'unique_6'), (4, 'default1', 'default2', 'default1', NULL, 19.0, 18.0, 2, 'unique_7'), (5, 'default2', 'default1', 'default2', 'default1', 0.0, 0.0, 0, 'unique_8'), (6, 'default2', 'default2', NULL, 'default2', 19.0, 19.0, 3, 'unique_9'), (7, 'default1', 'default2', NULL, 'default2', 0.0, 0.0, 18, 'unique_10'), (8, 'default2', 'default2', 'default1', NULL, 2.0, 2.0, 3, 'unique_11'), (9, 'default1', 'default2', 'default1', 'default2', 0.0, 1.0, 0, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (18, 2, 18, 19, 'default2', '2023-01-01', NULL, 'default2'), (19, 18, 19, 0, 'default2', '2023-01-02', 'default2', NULL), (1, 2, 3, 1, 'default1', '2023-01-01', NULL, 'default1'), (0, 2, 4, 3, 'default1', '2023-01-01', 'default2', 'unique_3'), (2, 18, 6, 20, 'default2', '2023-01-01', 'default2', 'unique_4');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (3, 19, 5, 1, 20, 2, 'default1', NULL, 'default2'), (2, 18, 1, 18, 20, 20, NULL, 'default1', 'default2'), (19, 0, 9, 1, 19, 18, 'default2', 'default2', 'default2'), (1, 0, 0, 0, 18, 19, NULL, NULL, 'default2'), (0, 1, 18, 3, 18, 3, 'default2', NULL, 'default2'), (18, 0, 19, 1, 0, 19, 'default1', NULL, NULL), (20, 0, 2, 19, 2, 18, 'default2', 'default1', 'default1'), (4, 18, 5, 2, 1, 19, 'default1', NULL, NULL), (5, 18, 18, 18, 18, 20, 'default1', 'default1', 'default2'), (6, 1, 0, 0, 0, 20, 'default2', NULL, 'default2'), (7, 2, 7, 0, 20, NULL, 'default2', 'default1', NULL), (8, 2, 7, 1, 3, 2, 'default1', 'default2', 'default2'), (9, 1, 4, 1, 2, 0, 'default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 19 AND NOT T1.q2 IS NULL ORDER BY T1.q2 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.surname FROM qualifying AS T1 JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T1.raceId = 19 AND T1.position = 2 ORDER BY T1.q2 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/