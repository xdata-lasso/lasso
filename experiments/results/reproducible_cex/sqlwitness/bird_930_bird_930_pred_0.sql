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
INSERT INTO status (statusid, status) VALUES (1, 'Hamilton'), (2, 'default1'), (0, 'default1'), (3, 'Lewis'), (4, 'default2'), (5, 'default2'), (6, 'Hamilton');
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (2, 'default2'), (0, 'Lewis'), (3, 'default1'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', NULL, 'default1', 'Lewis', 'default2', '2023-01-02', 'default2', 'Lewis'), (2, 'default2', NULL, 'Lewis', 'default2', 'Hamilton', NULL, 'Hamilton', 'Hamilton'), (0, 'Lewis', 1, 'default1', 'Lewis', 'Hamilton', '2023-01-01', 'Hamilton', 'default1'), (3, 'Hamilton', 0, 'Hamilton', 'Lewis', 'default2', '2023-01-01', 'Hamilton', 'default2'), (4, 'Lewis', NULL, 'Hamilton', 'default2', 'Lewis', NULL, 'default2', 'unique_4'), (5, 'Hamilton', 1, NULL, 'Lewis', 'Lewis', '2023-01-01', NULL, 'unique_5'), (6, 'Lewis', NULL, NULL, 'Lewis', 'Hamilton', NULL, NULL, 'unique_6'), (7, 'Lewis', NULL, 'Lewis', 'Lewis', 'Hamilton', '2023-01-01', 'Lewis', 'unique_7'), (8, 'Hamilton', 2, 'Hamilton', 'default1', 'Lewis', '2023-01-01', 'Hamilton', 'unique_8'), (9, 'Hamilton', 0, NULL, 'default1', 'Hamilton', '2023-01-01', 'Lewis', 'unique_9'), (10, 'Lewis', 2, 'default2', 'Lewis', 'Lewis', '2023-01-02', NULL, 'unique_10'), (11, 'default1', NULL, 'Lewis', 'default1', 'Lewis', NULL, 'default2', 'unique_11'), (12, 'Lewis', 1, 'default2', 'default1', 'default2', '2023-01-02', 'Hamilton', 'unique_12'), (13, 'Lewis', 2, 'Hamilton', 'Hamilton', 'Hamilton', '2023-01-02', 'Lewis', 'unique_13'), (14, 'default1', 1, 'Hamilton', 'Hamilton', 'default1', '2023-01-01', 'Hamilton', 'unique_14');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Hamilton', 'default2', NULL, 'default1'), (2, 'Lewis', 'Lewis', 'default2', 'Lewis'), (1, 'Hamilton', 'Hamilton', 'Lewis', 'Lewis'), (3, 'Hamilton', 'default1', NULL, 'default1'), (4, 'Hamilton', 'unique_4', NULL, 'default1'), (5, 'Hamilton', 'unique_5', 'Hamilton', 'Lewis'), (6, 'default1', 'unique_6', 'default2', 'default2'), (7, 'default2', 'unique_7', 'Lewis', 'default2'), (8, 'Hamilton', 'unique_8', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Hamilton', 'default1', 'default2', 'Lewis', 0.0, 0.0, 1, 'Lewis'), (0, 'default2', 'Lewis', 'Hamilton', 'default2', NULL, 1.0, NULL, 'default1'), (2, 'default1', 'default1', 'default2', 'Hamilton', 0.0, 0.0, 0, 'Hamilton'), (3, 'default2', 'default2', NULL, 'default2', NULL, 0.0, NULL, 'default2'), (4, 'Lewis', 'Hamilton', 'Hamilton', 'default1', 2.0, NULL, 1, 'unique_4'), (5, 'default1', 'default2', 'Lewis', 'default2', 2.0, 2.0, 1, 'unique_5'), (6, 'Lewis', 'default2', 'Lewis', 'default1', 2.0, NULL, NULL, 'unique_6'), (7, 'default1', 'Hamilton', 'default2', NULL, 0.0, 2.0, NULL, 'unique_7'), (8, 'default2', 'default2', 'Hamilton', 'default1', NULL, 1.0, 1, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 9, 5, 0, 'default2', '2023-01-01', 'Hamilton', NULL), (1, 0, 7, 2, 'Hamilton', '2023-01-01', 'default2', 'default2'), (2, 12, 6, 2, 'Lewis', '2023-01-01', 'Lewis', 'Hamilton'), (3, 1, 7, 0, 'default2', '2023-01-02', 'Lewis', 'default1'), (4, 4, 1, 2, 'default2', '2023-01-01', 'default2', 'Lewis'), (5, 8, 8, 1, 'Hamilton', '2023-01-01', 'default2', 'unique_5'), (6, 9, 4, 1, 'Lewis', '2023-01-02', 'default2', 'unique_6'), (7, 2, 1, 2, 'Lewis', '2023-01-01', 'Hamilton', 'unique_7'), (8, 1, 4, 0, 'default1', '2023-01-02', 'default2', 'unique_8'), (9, 12, 4, 2, 'Lewis', '2023-01-01', 'default2', 'unique_9'), (10, 3, 1, 2, 'Lewis', '2023-01-01', NULL, 'unique_10');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 4, 7, 7, 1, 0, 1, 2, 'Lewis', 0, 1.0, 0, 'default1', 2, NULL, 0, 'Hamilton', 'Lewis'), (0, 10, 5, 2, 3, 0, 1, NULL, 'default2', 1, 0.0, 1, 'Hamilton', 1, 2, NULL, NULL, 'Lewis'), (1, 4, 7, 5, 1, 1, 1, 0, 'Hamilton', 2, 2.0, 2, NULL, NULL, NULL, 1, 'default1', 'default2'), (3, 0, 9, 7, 3, 2, 2, 0, 'default2', 2, 2.0, 1, 'default1', 1, 2, 2, 'Hamilton', NULL), (4, 6, 8, 5, 4, 2, 1, 2, 'default1', 0, 1.0, 0, 'Lewis', 1, 1, 2, NULL, 'default1'), (5, 3, 11, 8, 1, NULL, 2, 2, 'default1', 0, 0.0, 1, 'Hamilton', 1, NULL, 2, NULL, 'Hamilton'), (6, 6, 3, 5, 5, 1, 0, NULL, 'default1', 1, 2.0, 0, 'Hamilton', NULL, 2, 2, 'default2', 'Hamilton');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.name FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T2.driverId = T3.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T2.rank ASC, T1.raceid NULLS LAST, T2.resultid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/