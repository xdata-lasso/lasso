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
INSERT INTO status (statusid, status) VALUES (0, 'default1'), (1, 'default2'), (2, 'Hamilton'), (3, 'Lewis'), (4, 'Lewis');
INSERT INTO seasons (year, url) VALUES (1, 'Lewis'), (2, 'Hamilton'), (0, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Hamilton', 1, 'Hamilton', 'Hamilton', 'default2', '2023-01-01', 'default1', 'Hamilton'), (0, 'Hamilton', 1, NULL, 'Lewis', 'Hamilton', NULL, 'default2', 'default2'), (2, 'Hamilton', 1, 'default2', 'default2', 'default2', '2023-01-01', 'default2', 'Lewis');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'default1', 'default2', 'default1'), (2, 'Lewis', 'Lewis', 'default2', 'Lewis'), (0, 'Hamilton', 'default2', 'default1', 'default1'), (3, 'default2', 'Hamilton', 'Hamilton', 'Lewis'), (4, 'default1', 'unique_4', 'Lewis', 'Hamilton'), (5, 'default1', 'unique_5', 'Hamilton', 'default2'), (6, 'Lewis', 'unique_6', 'Hamilton', 'default2'), (7, 'Lewis', 'unique_7', 'Hamilton', 'Hamilton'), (8, 'Hamilton', 'unique_8', 'default2', 'default2'), (9, 'default1', 'unique_9', 'Lewis', 'Lewis'), (10, 'Lewis', 'unique_10', NULL, 'default1'), (11, 'default1', 'unique_11', 'default2', 'Hamilton'), (12, 'default2', 'unique_12', 'Lewis', 'default1'), (13, 'default2', 'unique_13', 'default2', 'Hamilton'), (14, 'default1', 'unique_14', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default1', 'default2', 'default2', 'Lewis', NULL, NULL, NULL, 'Lewis'), (0, 'default1', 'default2', NULL, 'Lewis', 0.0, 1.0, 0, 'default2'), (1, 'Lewis', 'Lewis', 'default1', NULL, NULL, NULL, 2, 'default1'), (3, 'Hamilton', 'default1', 'default1', 'Hamilton', 0.0, NULL, NULL, 'Hamilton'), (4, 'Lewis', 'Lewis', 'Lewis', 'Hamilton', 1.0, 1.0, 0, 'unique_4'), (5, 'Lewis', 'default1', 'Hamilton', 'default2', 1.0, 0.0, 0, 'unique_5'), (6, 'Hamilton', 'default1', NULL, 'Lewis', 2.0, 2.0, 0, 'unique_6'), (7, 'Lewis', 'Hamilton', 'default1', 'Lewis', 0.0, 0.0, NULL, 'unique_7'), (8, 'default1', 'Hamilton', NULL, NULL, NULL, 2.0, 0, 'unique_8'), (9, 'default1', 'Lewis', 'default2', NULL, 1.0, 1.0, 0, 'unique_9'), (10, 'default2', 'default2', NULL, NULL, 1.0, NULL, 0, 'unique_10'), (11, 'default2', 'default1', 'Hamilton', 'Lewis', 1.0, NULL, 0, 'unique_11'), (12, 'Hamilton', 'Lewis', 'Lewis', 'Hamilton', 2.0, 2.0, 2, 'unique_12'), (13, 'Lewis', 'default2', 'Hamilton', 'Hamilton', 2.0, 1.0, 2, 'unique_13');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 0, 9, 2, 'default2', '2023-01-01', 'Lewis', 'default2'), (1, 2, 5, 2, 'default1', '2023-01-01', 'Hamilton', 'Lewis'), (2, 0, 6, 2, 'default1', '2023-01-01', 'Hamilton', NULL), (3, 1, 6, 0, 'Lewis', '2023-01-02', 'default1', 'Hamilton'), (4, 0, 4, 1, 'default2', '2023-01-01', NULL, 'default1'), (5, 0, 9, 1, 'Lewis', '2023-01-01', 'default2', 'unique_5'), (6, 2, 12, 0, 'Hamilton', '2023-01-02', 'Lewis', 'unique_6'), (7, 1, 10, 2, 'Hamilton', '2023-01-01', 'default2', 'unique_7'), (8, 0, 0, 1, 'default1', '2023-01-01', 'default1', 'unique_8'), (9, 0, 10, 0, 'default2', '2023-01-01', 'default2', 'unique_9'), (10, 0, 8, 0, 'Lewis', '2023-01-02', 'Hamilton', 'unique_10'), (11, 0, 1, 1, 'default2', '2023-01-01', NULL, 'unique_11'), (12, 0, 11, 1, 'Lewis', '2023-01-01', NULL, 'unique_12'), (13, 2, 4, 2, 'Hamilton', '2023-01-01', 'Hamilton', 'unique_13'), (14, 1, 12, 2, 'default2', '2023-01-02', NULL, 'unique_14'), (15, 1, 3, 0, 'Lewis', '2023-01-01', 'default2', 'unique_15'), (16, 0, 9, 2, 'Lewis', '2023-01-01', 'default2', 'unique_16');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 4, 0, 5, 4, 2, 0, 1, 'default2', 2, 2.0, 1, NULL, NULL, 2, 0, 'default1', NULL), (0, 5, 0, 14, 1, 2, 1, NULL, 'default1', 1, 1.0, 0, 'Lewis', NULL, NULL, 0, 'default1', NULL), (1, 11, 1, 1, 2, 2, 0, 0, 'default2', 0, 2.0, 0, 'Hamilton', 2, 2, 0, 'Lewis', NULL), (3, 8, 0, 10, 3, 2, 2, 2, 'default2', 0, 1.0, 1, NULL, 2, NULL, 1, 'Lewis', 'default2'), (4, 12, 0, 13, 1, 2, 1, NULL, 'default1', 1, 0.0, 0, 'Hamilton', 1, 0, 2, 'default1', 'Lewis'), (5, 5, 0, 9, 1, 1, 0, NULL, 'Hamilton', 1, 1.0, 2, 'Lewis', NULL, 1, 0, 'Lewis', 'Lewis'), (6, 1, 2, 0, 4, 2, 0, 1, 'Hamilton', 0, 0.0, 0, 'default1', 2, NULL, 2, 'Hamilton', 'Hamilton'), (7, 5, 0, 7, 4, 2, 2, NULL, 'Hamilton', 0, 1.0, 1, 'Lewis', 0, 1, 2, 'Hamilton', 'Lewis'), (8, 1, 2, 5, 2, 0, 1, NULL, 'Hamilton', 1, 2.0, 0, 'default2', 1, 2, NULL, 'Hamilton', NULL), (9, 1, 0, 6, 4, NULL, 0, NULL, 'default1', 1, 0.0, 2, 'default1', 0, 1, 0, 'Lewis', 'Hamilton');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (1, 5, 2, 1.0, NULL, 'Hamilton', 0), (2, 1, 0, 0.0, 1, 'Lewis', 2), (0, 11, 2, 0.0, NULL, 'default1', 2), (3, 4, 1, 2.0, 1, 'default1', 1), (4, 7, 2, 0.0, 2, 'default2', 1), (5, 3, 0, 2.0, NULL, 'default1', 2), (6, 16, 1, 1.0, 2, 'default2', 0), (7, 14, 2, 1.0, 1, NULL, 2), (8, 11, 1, 0.0, 2, NULL, 1), (9, 11, 2, 1.0, 1, NULL, 1), (10, 10, 1, 0.0, 1, 'Hamilton', 1), (11, 5, 2, 1.0, 1, 'Hamilton', 0), (12, 4, 2, 0.0, NULL, 'default1', 1), (13, 14, 1, 0.0, NULL, 'default1', 0), (14, 1, 0, 1.0, 0, 'default1', 1), (15, 0, 2, 2.0, 2, 'Lewis', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Lewis', 2.0)
*/

-- Prediction Query
SELECT T1.year, T1.name, T3.points FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN driverStandings AS T3 ON T2.driverId = T3.driverId INNER JOIN drivers AS T4 ON T3.driverId = T4.driverId WHERE T4.surname = 'Hamilton' ORDER BY T1.year, T1.raceid NULLS LAST, T2.resultid NULLS LAST, T3.driverstandingsid NULLS LAST, T4.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
(0, 'default2', 0.0)
*/