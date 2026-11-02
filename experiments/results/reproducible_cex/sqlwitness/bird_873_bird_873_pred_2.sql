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
INSERT INTO status (statusid, status) VALUES (0, 'default2'), (744, 'Bruce'), (1, 'default1'), (742, 'Bruce'), (743, 'default2'), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'Bruce'), (6, 'default2'), (7, 'default2'), (8, 'Bruce'), (9, 'default1');
INSERT INTO seasons (year, url) VALUES (744, 'McLaren'), (0, 'Bruce'), (742, 'default1'), (1, 'default2'), (743, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (744, 'default1', 744, 'default1', 'default1', 'Bruce', NULL, 'McLaren', 'default2'), (0, 'McLaren', 744, 'default1', 'McLaren', 'McLaren', '2023-01-01', NULL, 'McLaren'), (743, 'default1', 742, 'default2', 'default1', 'default1', NULL, 'default2', 'Bruce'), (1, 'default2', 744, NULL, 'default1', 'default1', NULL, 'Bruce', 'default1'), (742, 'default1', NULL, 'Bruce', 'Bruce', 'default1', NULL, 'default2', 'unique_4'), (2, 'default2', 744, NULL, 'default2', 'default2', '2023-01-02', 'default1', 'unique_5'), (3, 'default1', 743, 'default1', 'default2', 'default1', NULL, 'default2', 'unique_6'), (4, 'default1', 1, 'default1', 'Bruce', 'McLaren', '2023-01-02', 'McLaren', 'unique_7'), (5, 'default2', 744, 'default2', 'Bruce', 'McLaren', NULL, NULL, 'unique_8'), (6, 'default2', NULL, 'Bruce', 'default2', 'Bruce', '2023-01-01', 'default1', 'unique_9'), (7, 'default2', NULL, 'Bruce', 'Bruce', 'default1', NULL, 'Bruce', 'unique_10'), (8, 'default2', 742, 'default2', 'default2', 'default1', '2023-01-02', NULL, 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (743, 'default2', 'McLaren', NULL, 'McLaren'), (744, 'default1', 'Bruce', 'default2', 'McLaren'), (1, 'Bruce', 'default2', 'default1', 'McLaren'), (742, 'default2', 'default1', 'Bruce', 'default1'), (0, 'McLaren', 'unique_4', 'McLaren', 'McLaren'), (2, 'default2', 'unique_5', 'McLaren', 'default1'), (3, 'default2', 'unique_6', 'default2', 'default1'), (4, 'McLaren', 'unique_7', 'default2', 'Bruce');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'McLaren', 'default1', 'default2', NULL, 1.0, NULL, NULL, 'McLaren'), (743, 'default2', 'McLaren', 'McLaren', 'default2', NULL, NULL, 744, 'default2'), (744, 'default2', 'McLaren', 'default2', 'default1', NULL, 0.0, 1, 'default1'), (742, 'Bruce', 'default2', NULL, 'Bruce', NULL, 743.0, 742, 'Bruce'), (0, 'default2', 'McLaren', 'default1', NULL, NULL, 744.0, NULL, 'unique_4'), (2, 'default1', 'default1', 'default2', NULL, 742.0, 0.0, 742, 'unique_5'), (3, 'default1', 'Bruce', 'McLaren', 'default2', 742.0, 743.0, 744, 'unique_6'), (4, 'Bruce', 'default2', 'Bruce', NULL, 1.0, 742.0, 742, 'unique_7'), (5, 'Bruce', 'McLaren', 'Bruce', NULL, 1.0, NULL, 744, 'unique_8'), (6, 'default2', 'default1', 'McLaren', NULL, NULL, 1.0, NULL, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (744, 744, 6, 743, 'default2', '2023-01-01', NULL, NULL), (742, 744, 742, 1, 'default1', '2023-01-02', 'default2', 'Bruce'), (1, 5, 6, 1, 'default2', '2023-01-01', 'default1', 'default1'), (743, 1, 0, 743, 'Bruce', '2023-01-02', 'McLaren', 'McLaren'), (0, 1, 743, 0, 'McLaren', '2023-01-02', 'Bruce', 'default2'), (2, 2, 4, 743, 'default2', '2023-01-02', 'default2', 'unique_5'), (3, 3, 4, 744, 'McLaren', '2023-01-01', 'default2', 'unique_6'), (4, 5, 1, 744, 'default1', '2023-01-02', NULL, 'unique_7'), (5, 0, 1, 0, 'default1', '2023-01-02', 'default2', 'unique_8'), (6, 3, 3, 1, 'Bruce', '2023-01-02', 'McLaren', 'unique_9'), (7, 2, 744, 1, 'McLaren', '2023-01-01', 'default2', 'unique_10'), (8, 6, 6, 744, 'default1', '2023-01-02', 'McLaren', 'unique_11'), (9, 0, 0, 742, 'default1', '2023-01-01', 'McLaren', 'unique_12'), (10, 4, 742, 743, 'default2', '2023-01-02', 'default1', 'unique_13'), (11, 744, 1, 742, 'Bruce', '2023-01-01', 'default1', 'unique_14'), (12, 1, 2, 743, 'default2', '2023-01-02', 'McLaren', 'unique_15');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (743, 7, 6, 4, 1, 0, 744, 744, 'default1', 743, 743.0, 744, 'Bruce', NULL, 0, 1, 'default1', 'Bruce'), (744, 742, 8, 2, 8, 1, 744, NULL, 'McLaren', 742, 1.0, 744, 'McLaren', 742, 744, 0, 'Bruce', 'default2'), (1, 743, 0, 4, 1, 743, 744, 742, 'default2', 1, 0.0, 742, 'Bruce', NULL, 1, 0, 'McLaren', 'default2'), (0, 6, 0, 4, 1, 742, 1, NULL, 'Bruce', 1, 1.0, 0, 'McLaren', NULL, 0, 0, 'default1', 'default1'), (742, 742, 742, 744, 743, 742, 743, 0, 'default1', 1, 743.0, 0, 'default1', 744, 743, 742, 'Bruce', 'default2'), (2, 7, 1, 2, 1, 743, 744, NULL, 'default2', 0, 1.0, 1, 'McLaren', 0, 743, 742, 'default1', 'McLaren'), (3, 8, 742, 744, 6, 743, 742, 1, 'Bruce', 743, 742.0, 744, 'McLaren', 0, NULL, 1, NULL, 'default1'), (4, 6, 2, 3, 8, 742, 1, 743, 'Bruce', 0, 743.0, 0, 'Bruce', 743, 744, 0, 'Bruce', NULL), (5, 11, 4, 742, 1, NULL, 1, 744, 'default2', 743, 0.0, 744, 'default1', 1, 1, 742, NULL, 'default2'), (6, 8, 3, 4, 5, 742, 743, 744, 'McLaren', 1, 0.0, 0, 'default1', 0, 744, 0, NULL, 'McLaren'), (7, 744, 2, 1, 0, 0, 1, 0, 'default1', 1, 743.0, 1, 'McLaren', 743, 0, 744, 'Bruce', 'default1'), (8, 9, 0, 3, 9, 1, 0, 744, 'Bruce', 0, 1.0, 744, 'default2', 742, 1, 744, 'Bruce', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.time FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 743 AND T1.forename = 'Bruce' AND T1.surname = 'McLaren';

/*
Gold Result:
*/

-- Prediction Query
SELECT "results"."time" FROM "results" INNER JOIN "drivers" ON "results"."driverid" = "drivers"."driverid" WHERE "drivers"."surname" = 'McLaren' AND "results"."raceid" = 743;

/*
Prediction Result:
('Bruce',)
*/