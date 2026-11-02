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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (2, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default2', NULL, 'default1', 'default2', 'default1', '2023-01-02', NULL, 'default1'), (2, 'default2', 2, 'default1', 'default1', 'default1', '2023-01-02', 'default1', 'default2'), (0, 'default2', 2, 'default2', 'default2', 'default2', NULL, 'default1', 'unique_2');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default2', 'default2', 'default1', 'default2'), (20, 'default1', 'default1', 'default2', 'default1'), (0, 'default2', 'unique_2', 'default2', 'default2'), (1, 'default2', 'unique_3', 'default2', 'default2'), (18, 'default1', 'unique_4', 'default2', 'default2'), (19, 'default1', 'unique_5', NULL, 'default2'), (3, 'default2', 'unique_6', 'default2', 'default2'), (4, 'default1', 'unique_7', 'default2', 'default1'), (5, 'default1', 'unique_8', 'default1', 'default2'), (6, 'default1', 'unique_9', NULL, 'default2'), (7, 'default2', 'unique_10', NULL, 'default2'), (8, 'default2', 'unique_11', 'default1', 'default2'), (9, 'default1', 'unique_12', 'default1', 'default2'), (10, 'default2', 'unique_13', 'default1', 'default2'), (11, 'default1', 'unique_14', NULL, 'default1'), (12, 'default1', 'unique_15', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', 'default1', 'default2', 'default2', 18.0, 0.0, 19, 'default1'), (20, 'default1', 'default1', 'default1', 'default2', 1.0, 19.0, 20, 'default2'), (2, 'default1', 'default1', 'default1', 'default2', NULL, 18.0, 0, 'unique_2'), (0, 'default1', 'default1', NULL, 'default2', NULL, 2.0, 1, 'unique_3'), (18, 'default2', 'default2', 'default2', 'default1', 2.0, 2.0, 1, 'unique_4'), (19, 'default2', 'default2', 'default2', 'default1', 0.0, NULL, NULL, 'unique_5'), (3, 'default1', 'default2', NULL, NULL, 18.0, 18.0, NULL, 'unique_6'), (4, 'default2', 'default2', 'default1', NULL, 20.0, 19.0, 20, 'unique_7'), (5, 'default1', 'default1', 'default2', 'default2', 18.0, 18.0, 18, 'unique_8'), (6, 'default1', 'default1', NULL, 'default2', 19.0, 19.0, 20, 'unique_9'), (7, 'default1', 'default1', 'default1', NULL, 19.0, 0.0, 2, 'unique_10'), (8, 'default1', 'default2', 'default2', NULL, 2.0, 2.0, 18, 'unique_11'), (9, 'default1', 'default2', 'default1', NULL, 1.0, 2.0, 18, 'unique_12'), (10, 'default2', 'default2', 'default2', 'default1', 1.0, 20.0, 2, 'unique_13'), (11, 'default2', 'default1', 'default2', NULL, 0.0, 0.0, 1, 'unique_14'), (12, 'default1', 'default2', NULL, 'default2', 2.0, 19.0, NULL, 'unique_15'), (13, 'default1', 'default1', 'default1', 'default1', 2.0, 0.0, 1, 'unique_16'), (14, 'default2', 'default2', 'default1', 'default1', 19.0, 2.0, 18, 'unique_17'), (15, 'default1', 'default2', 'default2', NULL, 0.0, 1.0, 1, 'unique_18'), (16, 'default1', 'default1', 'default1', 'default1', 18.0, 2.0, 0, 'unique_19');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (19, 0, 20, 20, 'default1', '2023-01-02', 'default2', NULL);
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (2, 19, 2, 3, 0, 20, NULL, 'default1', 'default1'), (19, 19, 2, 1, 19, NULL, 'default2', 'default2', NULL), (18, 19, 1, 3, 2, 18, NULL, 'default2', NULL), (1, 19, 2, 7, 18, NULL, 'default2', NULL, NULL), (0, 19, 0, 10, 0, 2, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 19 AND NOT T1.q2 IS NULL ORDER BY T1.q2 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT d.surname FROM qualifying AS q JOIN drivers AS d ON q.driverId = d.driverId WHERE q.raceId = 19 ORDER BY q.q2, q.qualifyid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/