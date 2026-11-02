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
INSERT INTO status (statusid, status) VALUES (743, 'default1'), (742, 'McLaren'), (0, 'default2'), (744, 'default1'), (1, 'default1'), (2, 'default2'), (3, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (742, 'default2'), (0, 'McLaren'), (743, 'Bruce'), (744, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (742, 'McLaren', NULL, 'Bruce', 'default2', 'default1', '2023-01-01', 'Bruce', 'Bruce'), (744, 'default1', 742, 'Bruce', 'Bruce', 'default2', '2023-01-01', 'McLaren', 'default1'), (743, 'McLaren', 1, 'Bruce', 'Bruce', 'default2', '2023-01-02', 'McLaren', 'McLaren'), (1, 'default1', 744, 'default1', 'default2', 'McLaren', NULL, 'default2', 'default2'), (0, 'default1', 742, NULL, 'default1', 'McLaren', NULL, 'McLaren', 'unique_4'), (2, 'default2', 1, NULL, 'McLaren', 'McLaren', '2023-01-01', 'McLaren', 'unique_5'), (3, 'default2', 0, 'default1', 'Bruce', 'McLaren', NULL, NULL, 'unique_6'), (4, 'Bruce', 744, 'default1', 'Bruce', 'McLaren', '2023-01-01', NULL, 'unique_7'), (5, 'Bruce', 743, 'McLaren', 'default2', 'Bruce', '2023-01-01', 'default1', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'McLaren', 'Bruce', 'Bruce', 'McLaren'), (742, 'default1', 'McLaren', 'default1', 'default2'), (744, 'default2', 'default1', 'Bruce', 'McLaren'), (0, 'default1', 'default2', 'default1', 'default2'), (743, 'McLaren', 'unique_4', 'McLaren', 'Bruce'), (2, 'default1', 'unique_5', 'Bruce', 'McLaren'), (3, 'McLaren', 'unique_6', 'default1', 'default2'), (4, 'Bruce', 'unique_7', 'default2', 'default1'), (5, 'Bruce', 'unique_8', 'default2', 'McLaren'), (6, 'Bruce', 'unique_9', 'default1', 'default2'), (7, 'default1', 'unique_10', NULL, 'default1'), (8, 'default1', 'unique_11', 'default1', 'default2'), (9, 'Bruce', 'unique_12', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (743, 'McLaren', 'default1', 'default2', 'Bruce', 744.0, NULL, 742, 'McLaren'), (0, 'default2', 'default2', 'default2', 'default1', 742.0, 744.0, 742, 'default2'), (744, 'Bruce', 'McLaren', 'default1', 'default2', 743.0, 742.0, 744, 'Bruce'), (1, 'default1', 'default2', 'McLaren', NULL, 743.0, NULL, 0, 'default1'), (742, 'McLaren', 'Bruce', 'default2', 'Bruce', 0.0, 0.0, 744, 'unique_4'), (2, 'McLaren', 'default2', 'default2', 'McLaren', 744.0, 742.0, 1, 'unique_5'), (3, 'default1', 'default1', NULL, 'default1', 0.0, 0.0, 0, 'unique_6'), (4, 'Bruce', 'default2', 'McLaren', 'Bruce', NULL, 1.0, 744, 'unique_7'), (5, 'Bruce', 'Bruce', NULL, 'McLaren', 0.0, 1.0, 1, 'unique_8'), (6, 'default1', 'default1', NULL, 'default1', 744.0, 744.0, 743, 'unique_9'), (7, 'McLaren', 'default2', 'McLaren', 'Bruce', 742.0, NULL, 744, 'unique_10'), (8, 'default2', 'McLaren', 'default1', 'default1', 0.0, NULL, 743, 'unique_11'), (9, 'Bruce', 'Bruce', 'Bruce', 'default1', NULL, 744.0, 744, 'unique_12'), (10, 'Bruce', 'default1', NULL, 'McLaren', NULL, 1.0, 0, 'unique_13'), (11, 'default2', 'Bruce', 'default1', NULL, 744.0, NULL, 742, 'unique_14');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (744, 0, 1, 743, 'default1', '2023-01-02', NULL, 'Bruce'), (0, 3, 10, 742, 'default2', '2023-01-02', NULL, NULL), (1, 1, 5, 743, 'McLaren', '2023-01-02', 'default1', 'McLaren'), (742, 743, 10, 742, 'McLaren', '2023-01-01', 'default1', 'default2'), (743, 743, 743, 1, 'default2', '2023-01-02', NULL, 'default1'), (2, 743, 742, 742, 'default2', '2023-01-01', NULL, 'unique_5'), (3, 4, 10, 0, 'Bruce', '2023-01-01', 'default1', 'unique_6'), (4, 742, 8, 742, 'default2', '2023-01-01', 'Bruce', 'unique_7'), (5, 3, 744, 743, 'Bruce', '2023-01-01', 'McLaren', 'unique_8'), (6, 4, 7, 743, 'default1', '2023-01-02', 'Bruce', 'unique_9'), (7, 742, 0, 743, 'default1', '2023-01-02', 'McLaren', 'unique_10'), (8, 742, 2, 744, 'Bruce', '2023-01-02', 'default2', 'unique_11'), (9, 3, 6, 743, 'Bruce', '2023-01-02', 'Bruce', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (743, 0, 743, 5, 743, 744, 744, 0, 'Bruce', 742, 0.0, 742, 'McLaren', 744, 744, 0, NULL, 'default2'), (744, 744, 0, 8, 2, NULL, 0, 744, 'default1', 742, 744.0, 743, 'McLaren', NULL, 743, 743, 'McLaren', 'Bruce'), (742, 0, 743, 7, 742, 744, 743, 1, 'Bruce', 744, 1.0, 744, NULL, 742, 742, 744, 'McLaren', 'default2'), (0, 742, 3, 9, 2, 743, 744, 744, 'Bruce', 743, 742.0, 1, 'Bruce', 0, 1, 1, NULL, NULL), (1, 5, 743, 743, 3, 742, 1, 1, 'Bruce', 1, 0.0, 744, 'default1', 0, 1, 1, 'default1', 'default2'), (2, 8, 0, 9, 2, 0, 743, 744, 'Bruce', 1, 744.0, 1, 'Bruce', 742, 0, 742, 'default1', 'default1'), (3, 0, 2, 7, 2, 744, 0, 742, 'default1', 0, 1.0, 743, 'default1', NULL, 0, NULL, NULL, NULL), (4, 6, 744, 6, 2, 743, 742, 743, 'default2', 742, 742.0, 744, 'default2', NULL, 742, 1, NULL, 'default2'), (5, 743, 3, 0, 1, 742, 0, 1, 'Bruce', 743, 744.0, 0, 'Bruce', 0, NULL, NULL, 'default1', 'default1'), (6, 0, 744, 742, 2, NULL, 0, NULL, 'Bruce', 1, 1.0, 1, 'McLaren', NULL, NULL, 743, 'default2', 'Bruce'), (7, 5, 1, 4, 0, 744, 1, 744, 'default2', 0, 0.0, 743, 'default1', 1, 744, 1, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.time FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 743 AND T1.forename = 'Bruce' AND T1.surname = 'McLaren';

/*
Gold Result:
('Bruce',)
*/

-- Prediction Query
SELECT results.milliseconds FROM drivers INNER JOIN results ON drivers.driverid = results.driverid WHERE drivers.forename = 'Bruce' AND drivers.surname = 'McLaren' AND results.raceid = 743;

/*
Prediction Result:
(0,)
*/