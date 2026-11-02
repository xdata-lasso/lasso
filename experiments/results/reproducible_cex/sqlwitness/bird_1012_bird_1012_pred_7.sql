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
INSERT INTO status (statusid, status) VALUES (2, 'Hamilton'), (1, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'Lewis'), (2, 'default1'), (0, 'Hamilton'), (3, 'default2'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', NULL, 'default2', 'Lewis', 'Hamilton', '2023-01-01', NULL, 'default1'), (0, 'Hamilton', 1, 'default2', 'Hamilton', 'Lewis', '2023-01-01', NULL, 'Hamilton'), (2, 'Hamilton', 2, 'Hamilton', 'default1', 'default1', NULL, NULL, 'Lewis'), (3, 'default1', NULL, 'default1', 'Lewis', 'Hamilton', NULL, 'default1', 'default2'), (4, 'Hamilton', 0, 'default2', 'default1', 'default2', NULL, NULL, 'unique_4'), (5, 'default1', NULL, 'Hamilton', 'default1', 'default2', NULL, 'default2', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'Hamilton', 'Lewis', NULL, 'default2'), (0, 'default1', 'Hamilton', 'Hamilton', 'Lewis'), (1, 'default2', 'default1', 'Lewis', 'Hamilton'), (3, 'Lewis', 'default2', NULL, 'default1'), (4, 'Lewis', 'unique_4', 'default2', 'default1'), (5, 'default1', 'unique_5', 'default2', 'Lewis'), (6, 'default1', 'unique_6', NULL, 'Hamilton'), (7, 'Lewis', 'unique_7', NULL, 'Lewis'), (8, 'Hamilton', 'unique_8', 'Lewis', 'Lewis'), (9, 'default2', 'unique_9', 'default1', 'Lewis'), (10, 'Lewis', 'unique_10', 'default2', 'default2'), (11, 'Lewis', 'unique_11', 'Lewis', 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'Lewis', 'default1', 'Hamilton', NULL, 2.0, 1, 'default2'), (0, 'default2', 'default2', NULL, 'Hamilton', 0.0, 2.0, 0, 'Hamilton'), (2, 'Hamilton', 'Hamilton', 'default2', 'default1', 0.0, NULL, 2, 'default1'), (3, 'Hamilton', 'default1', 'default1', 'default1', NULL, NULL, 2, 'Lewis'), (4, 'default1', 'default1', 'Lewis', NULL, 2.0, NULL, 1, 'unique_4'), (5, 'Hamilton', 'default1', 'default1', 'Lewis', NULL, 0.0, 2, 'unique_5'), (6, 'Hamilton', 'default2', 'Hamilton', 'Hamilton', 2.0, NULL, 0, 'unique_6'), (7, 'Lewis', 'default1', 'default1', 'default2', 0.0, 0.0, 2, 'unique_7'), (8, 'default2', 'Hamilton', NULL, 'default2', 2.0, NULL, 0, 'unique_8'), (9, 'Lewis', 'Lewis', 'default1', 'default1', NULL, NULL, NULL, 'unique_9'), (10, 'Hamilton', 'default2', NULL, NULL, 1.0, 2.0, 2, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 7, 1, 0, 'Hamilton', '2023-01-02', 'Hamilton', 'Hamilton'), (2, 0, 4, 0, 'Hamilton', '2023-01-02', 'default2', 'Lewis'), (0, 3, 5, 0, 'Lewis', '2023-01-01', NULL, 'default1'), (3, 7, 8, 0, 'default2', '2023-01-01', 'Hamilton', NULL), (4, 8, 6, 0, 'Lewis', '2023-01-01', 'default1', 'default2'), (5, 0, 1, 2, 'default1', '2023-01-01', 'default1', 'unique_5'), (6, 6, 4, 0, 'Hamilton', '2023-01-01', 'Hamilton', 'unique_6'), (7, 5, 9, 0, 'Hamilton', '2023-01-01', 'default2', 'unique_7'), (8, 3, 1, 2, 'Hamilton', '2023-01-01', 'default1', 'unique_8'), (9, 6, 8, 0, 'Lewis', '2023-01-02', 'Hamilton', 'unique_9'), (10, 5, 8, 2, 'Lewis', '2023-01-02', NULL, 'unique_10'), (11, 2, 6, 2, 'Hamilton', '2023-01-02', 'default2', 'unique_11'), (12, 5, 7, 0, 'default1', '2023-01-02', NULL, 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 9, 1, 3, 2, 1, 0, 2, 'Hamilton', 1, 2.0, 2, 'Lewis', 1, 2, 2, 'default1', 'Lewis'), (1, 0, 3, 0, 2, NULL, 1, 0, 'default1', 0, 1.0, 0, 'default1', NULL, 2, 1, 'Lewis', 'default2'), (2, 7, 5, 8, 2, 1, 1, 1, 'Lewis', 0, 1.0, 2, 'default2', NULL, NULL, NULL, 'Hamilton', 'default1'), (3, 12, 1, 9, 1, 1, 0, NULL, 'Lewis', 2, 0.0, 1, 'default1', 0, 2, 0, 'default2', 'Hamilton'), (4, 6, 3, 10, 2, 0, 0, NULL, 'default2', 2, 2.0, 1, 'Lewis', 2, 1, 2, NULL, 'Lewis');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 2, 4, 1.0, 1, NULL, 1), (1, 4, 3, 1.0, 2, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.position FROM results AS T1 JOIN races AS T2 ON T1.raceId = T2.raceId JOIN driverStandings AS T3 ON T1.driverId = T3.driverId JOIN drivers AS T4 ON T1.driverId = T4.driverId WHERE T4.forename = 'Lewis' AND T4.surname = 'Hamilton' ORDER BY T1.time ASC, T1.resultid NULLS LAST, T2.raceid NULLS LAST, T3.driverstandingsid NULLS LAST, T4.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/