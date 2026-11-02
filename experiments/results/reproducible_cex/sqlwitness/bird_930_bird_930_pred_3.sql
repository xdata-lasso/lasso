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
INSERT INTO status (statusid, status) VALUES (0, 'Hamilton'), (1, 'Hamilton'), (2, 'default2'), (3, 'default2'), (4, 'Hamilton'), (5, 'default2'), (6, 'Lewis'), (7, 'Hamilton'), (8, 'default1'), (9, 'Hamilton'), (10, 'default1'), (11, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (2, 'Hamilton'), (0, 'default1'), (3, 'Lewis'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Lewis', NULL, 'Hamilton', 'default1', 'default1', '2023-01-02', NULL, 'Lewis'), (0, 'Lewis', 2, NULL, 'Lewis', 'Hamilton', NULL, 'default2', 'Hamilton'), (2, 'Lewis', 1, 'Lewis', 'Lewis', 'default2', NULL, 'default1', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default1', 'Hamilton', 'Hamilton', 'default2'), (0, 'Hamilton', 'default2', 'default2', 'Hamilton'), (1, 'default1', 'default1', NULL, 'Lewis'), (3, 'Lewis', 'Lewis', 'Hamilton', 'Lewis'), (4, 'Lewis', 'unique_4', NULL, 'default1'), (5, 'Lewis', 'unique_5', 'Hamilton', 'default1'), (6, 'Hamilton', 'unique_6', 'default2', 'Lewis'), (7, 'Lewis', 'unique_7', 'Lewis', 'default2'), (8, 'Hamilton', 'unique_8', 'Lewis', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'default2', 'default1', 'default2', 2.0, 2.0, 2, 'default2'), (0, 'default1', 'default1', 'Hamilton', 'Hamilton', NULL, 2.0, 0, 'Hamilton'), (1, 'default2', 'default2', 'Hamilton', NULL, 1.0, NULL, 2, 'default1'), (3, 'Hamilton', 'default2', 'default1', 'Lewis', NULL, 2.0, 1, 'Lewis'), (4, 'Lewis', 'Hamilton', 'Lewis', NULL, 2.0, 0.0, 0, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 4, 1, 'Hamilton', '2023-01-02', 'default1', 'default2'), (2, 3, 3, 1, 'Hamilton', '2023-01-01', 'default2', 'default1'), (1, 2, 0, 1, 'default2', '2023-01-02', 'default1', 'Hamilton'), (3, 1, 2, 1, 'Hamilton', '2023-01-01', NULL, NULL), (4, 8, 2, 1, 'default2', '2023-01-02', 'default2', 'Lewis'), (5, 3, 0, 1, 'default2', '2023-01-02', 'Lewis', 'unique_5'), (6, 9, 4, 0, 'Hamilton', '2023-01-01', 'default2', 'unique_6'), (7, 3, 1, 2, 'default2', '2023-01-01', 'default2', 'unique_7'), (8, 6, 4, 1, 'Lewis', '2023-01-02', 'default2', 'unique_8'), (9, 4, 1, 1, 'Lewis', '2023-01-02', 'default2', 'unique_9'), (10, 6, 1, 1, 'default2', '2023-01-02', 'default2', 'unique_10'), (11, 2, 4, 2, 'Hamilton', '2023-01-02', 'Lewis', 'unique_11'), (12, 0, 0, 2, 'Hamilton', '2023-01-01', 'Hamilton', 'unique_12'), (13, 0, 1, 0, 'Hamilton', '2023-01-01', 'Hamilton', 'unique_13'), (14, 3, 0, 0, 'Lewis', '2023-01-01', 'default2', 'unique_14'), (15, 1, 1, 2, 'default2', '2023-01-02', 'default2', 'unique_15'), (16, 11, 1, 0, 'default1', '2023-01-02', 'default2', 'unique_16'), (17, 0, 3, 1, 'Hamilton', '2023-01-02', NULL, 'unique_17'), (18, 11, 0, 0, 'Lewis', '2023-01-02', 'Hamilton', 'unique_18');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 0, 1, 6, 3, 0, 0, 0, 'Hamilton', 0, 1.0, 2, 'default1', NULL, 2, NULL, NULL, 'Lewis'), (1, 17, 2, 7, 10, 2, 2, NULL, 'default2', 0, 2.0, 1, NULL, NULL, 1, 2, 'Hamilton', 'default2'), (2, 1, 1, 5, 6, 2, 2, 0, 'Hamilton', 2, 2.0, 0, 'Hamilton', 1, 0, NULL, 'default2', 'default1'), (3, 9, 0, 4, 2, 0, 2, 2, 'default2', 0, 0.0, 1, 'Lewis', NULL, 0, 1, 'default1', 'default2'), (4, 5, 0, 5, 6, 1, 0, NULL, 'default2', 1, 0.0, 2, 'Hamilton', 1, 0, 2, 'Lewis', 'default2'), (5, 1, 1, 5, 8, 2, 0, 2, 'Hamilton', 2, 1.0, 1, 'Hamilton', 2, 2, NULL, 'Lewis', 'Lewis'), (6, 8, 1, 4, 9, NULL, 1, 2, 'Lewis', 1, 1.0, 0, 'Hamilton', NULL, 0, 0, 'default2', 'default2'), (7, 18, 0, 5, 9, 0, 0, 1, 'default1', 0, 1.0, 1, NULL, 0, 1, 2, NULL, 'Hamilton'), (8, 10, 2, 5, 5, NULL, 2, NULL, 'Lewis', 0, 1.0, 1, NULL, NULL, NULL, 0, 'Hamilton', NULL), (9, 6, 2, 2, 5, NULL, 1, 1, 'default1', 0, 2.0, 2, NULL, 0, 2, 2, 'default2', 'default1'), (10, 8, 2, 5, 2, 1, 1, 1, 'Lewis', 2, 2.0, 2, NULL, 2, 0, 1, 'Lewis', 'Lewis'), (11, 4, 1, 4, 11, 1, 1, 1, 'default2', 2, 0.0, 1, 'Lewis', 0, 1, 0, 'default2', 'default1'), (12, 2, 0, 3, 10, 1, 0, 0, 'Lewis', 1, 2.0, 2, 'default2', 1, 0, 1, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
('Hamilton',)
('Lewis',)
*/

-- Prediction Query
SELECT T3.name FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' AND NOT T2.rank IS NULL ORDER BY T2.rank ASC, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Lewis',)
*/