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
INSERT INTO status (statusid, status) VALUES (593, 'default1');
INSERT INTO seasons (year, url) VALUES (591, 'default2'), (0, 'default1'), (592, 'unique_2'), (1, 'unique_3'), (2, 'unique_4'), (593, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (593, 'default1', 0, NULL, 'default1', 'default2', '2023-01-01', NULL, 'default1'), (591, 'default2', 593, 'default1', 'default2', 'default1', '2023-01-02', NULL, 'default2'), (592, 'default2', 0, NULL, 'default2', 'default1', '2023-01-01', NULL, 'unique_2'), (1, 'default2', 593, 'default2', 'default1', 'default2', '2023-01-01', 'default1', 'unique_3'), (0, 'default1', 593, 'default2', 'default2', 'default1', '2023-01-02', 'default2', 'unique_4'), (2, 'default1', NULL, 'default2', 'default1', 'default2', '2023-01-01', 'default1', 'unique_5'), (3, 'default1', 1, NULL, 'default2', 'default1', '2023-01-01', 'default2', 'unique_6'), (4, 'default1', NULL, 'default2', 'default2', 'default1', '2023-01-01', 'default2', 'unique_7'), (5, 'default2', NULL, NULL, 'default1', 'default2', '2023-01-01', NULL, 'unique_8'), (6, 'default1', NULL, 'default1', 'default1', 'default2', '2023-01-01', 'default1', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (593, 'default2', 'default1', 'default1', 'default1'), (591, 'default2', 'default2', NULL, 'default1'), (2, 'default2', 'unique_2', 'default1', 'default2'), (1, 'default1', 'unique_3', 'default2', 'default1'), (0, 'default1', 'unique_4', NULL, 'default1'), (592, 'default1', 'unique_5', 'default2', 'default2'), (3, 'default2', 'unique_6', 'default1', 'default1'), (4, 'default2', 'unique_7', NULL, 'default1'), (5, 'default1', 'unique_8', 'default2', 'default1'), (6, 'default2', 'unique_9', 'default2', 'default1'), (7, 'default1', 'unique_10', 'default1', 'default1'), (8, 'default2', 'unique_11', 'default2', 'default2'), (9, 'default2', 'unique_12', 'default2', 'default2'), (10, 'default1', 'unique_13', NULL, 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default2', 'default1', 'default1', NULL, 591.0, 592, 'default2'), (2, 'default1', 'default1', 'default1', 'default1', 592.0, 592.0, 591, 'default1'), (591, 'default1', 'default1', 'default2', NULL, 593.0, NULL, 2, 'unique_2'), (592, 'default2', 'default2', 'default1', 'default1', 1.0, 1.0, 1, 'unique_3'), (593, 'default2', 'default1', NULL, 'default1', 1.0, 2.0, NULL, 'unique_4'), (1, 'default1', 'default2', NULL, 'default2', 591.0, NULL, 2, 'unique_5'), (3, 'default2', 'default2', 'default2', 'default2', 591.0, NULL, 2, 'unique_6'), (4, 'default2', 'default1', 'default2', 'default2', 593.0, 0.0, 593, 'unique_7'), (5, 'default1', 'default2', NULL, 'default1', 593.0, 0.0, NULL, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 593, 0, 'default1', '2023-01-02', 'default2', NULL), (1, 6, 2, 592, 'default2', '2023-01-02', 'default2', 'default2'), (593, 5, 593, 0, 'default2', '2023-01-02', 'default2', 'default1'), (2, 4, 0, 592, 'default2', '2023-01-01', 'default1', 'unique_3'), (592, 4, 3, 592, 'default2', '2023-01-01', 'default2', 'unique_4'), (591, 592, 591, 0, 'default1', '2023-01-02', 'default1', 'unique_5'), (3, 591, 2, 591, 'default2', '2023-01-01', 'default1', 'unique_6'), (4, 591, 0, 591, 'default1', '2023-01-01', 'default1', 'unique_7'), (5, 591, 593, 591, 'default1', '2023-01-01', 'default2', 'unique_8'), (6, 3, 3, 591, 'default2', '2023-01-02', 'default2', 'unique_9');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 1, 5, 2, 593, 2, 592, 0, 'default1', 591, 591.0, 0, 'default2', NULL, 2, 593, 'default1', 'default2'), (1, 593, 5, 9, 593, 2, 1, NULL, 'default2', 2, 593.0, 1, NULL, 591, 1, 592, NULL, 'default2'), (593, 5, 591, 6, 593, 592, 1, NULL, 'default1', 2, 2.0, 2, 'default1', 2, 2, 591, 'default1', 'default2'), (591, 1, 3, 3, 593, 2, 1, 1, 'default2', 593, 1.0, 591, NULL, 591, 2, 591, 'default1', NULL), (592, 592, 1, 5, 593, 1, 591, 592, 'default1', 2, 592.0, 0, NULL, 2, 593, 591, 'default2', 'default1'), (2, 1, 5, 1, 593, 592, 2, 592, 'default1', 2, 1.0, 2, 'default1', 591, 1, 2, 'default1', 'default1'), (3, 4, 6, 10, 593, 2, 593, 2, 'default1', 592, 591.0, 593, NULL, 591, 2, 592, 'default1', NULL), (4, 592, 0, 6, 593, NULL, 0, 2, 'default1', 2, 592.0, 1, 'default1', 592, 1, 592, 'default1', 'default2'), (5, 593, 3, 6, 593, 591, 1, 592, 'default1', 591, 593.0, 1, 'default2', 593, 0, 593, NULL, 'default1'), (6, 592, 4, 9, 593, 592, 2, 0, 'default2', 591, 592.0, 591, 'default2', 1, 2, 1, 'default2', 'default1'), (7, 6, 6, 3, 593, 2, 0, 1, 'default1', 593, 1.0, 0, NULL, 592, 592, NULL, NULL, 'default1'), (8, 4, 2, 7, 593, 0, 593, 2, 'default2', 593, 593.0, 0, NULL, 1, 593, 592, 'default2', 'default2'), (9, 6, 592, 7, 593, NULL, 2, 591, 'default2', 592, 0.0, 1, NULL, 2, 593, 591, 'default2', 'default1'), (10, 4, 5, 5, 593, 593, 592, 0, 'default1', 592, 591.0, 2, NULL, NULL, NULL, 593, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 592 AND NOT T2.time IS NULL AND NOT T1.dob IS NULL ORDER BY T1.dob ASC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2', 'default1')
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname", "drivers"."dob" FROM "drivers" INNER JOIN "results" ON "drivers"."driverid" = "results"."driverid" WHERE "results"."raceid" = 592 AND NOT "results"."time" IS NULL ORDER BY "drivers"."dob" ASC, drivers.driverid NULLS LAST, results.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2', 'default1', '2023-01-01')
*/