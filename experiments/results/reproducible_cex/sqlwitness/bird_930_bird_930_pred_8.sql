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
INSERT INTO status (statusid, status) VALUES (1, 'default2'), (2, 'default1'), (0, 'default1'), (3, 'Hamilton'), (4, 'default1'), (5, 'Hamilton'), (6, 'Hamilton'), (7, 'default1'), (8, 'Hamilton'), (9, 'Lewis'), (10, 'default1'), (11, 'Lewis'), (12, 'default2'), (13, 'Hamilton'), (14, 'Lewis'), (15, 'default1'), (16, 'default1'), (17, 'default1'), (18, 'Lewis'), (19, 'default2'), (20, 'Lewis'), (21, 'Lewis'), (22, 'default1'), (23, 'default2'), (24, 'Lewis'), (25, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (0, 'default2'), (2, 'Lewis'), (3, 'default1'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default2', 2, 'default1', 'default1', 'Hamilton', '2023-01-02', 'default2', 'default1'), (1, 'Lewis', 1, 'Hamilton', 'Lewis', 'default1', '2023-01-02', 'default1', 'Hamilton'), (0, 'Hamilton', 1, NULL, 'Hamilton', 'Lewis', NULL, NULL, 'Lewis'), (3, 'Lewis', 1, NULL, 'Lewis', 'Hamilton', NULL, NULL, 'default2');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'Hamilton', 'default1', NULL, 'default2'), (1, 'default2', 'Hamilton', 'default2', 'default1'), (0, 'Hamilton', 'default2', 'default1', 'Lewis'), (3, 'Lewis', 'Lewis', 'Lewis', 'default1'), (4, 'Lewis', 'unique_4', 'Lewis', 'Hamilton'), (5, 'default1', 'unique_5', 'default2', 'default1'), (6, 'default1', 'unique_6', 'Lewis', 'default2'), (7, 'Lewis', 'unique_7', 'Hamilton', 'Lewis'), (8, 'default1', 'unique_8', 'Hamilton', 'default1'), (9, 'Lewis', 'unique_9', 'Lewis', 'default1'), (10, 'default2', 'unique_10', 'Lewis', 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'Hamilton', 'default2', 'default2', 2.0, NULL, 1, 'Hamilton'), (2, 'default1', 'Lewis', 'default2', 'default2', 1.0, NULL, NULL, 'Lewis'), (1, 'Hamilton', 'Lewis', 'default2', 'Lewis', NULL, 2.0, 1, 'default2'), (3, 'Lewis', 'default2', 'default2', 'Hamilton', 0.0, NULL, 2, 'default1'), (4, 'default1', 'Hamilton', NULL, NULL, 2.0, NULL, 1, 'unique_4'), (5, 'Hamilton', 'default1', 'default2', 'Hamilton', NULL, 2.0, NULL, 'unique_5'), (6, 'Hamilton', 'default2', 'default1', 'Hamilton', 0.0, 0.0, 1, 'unique_6'), (7, 'Lewis', 'default2', 'default1', NULL, 2.0, 0.0, 1, 'unique_7'), (8, 'default1', 'default2', 'default1', 'Hamilton', 1.0, NULL, 2, 'unique_8'), (9, 'default2', 'Hamilton', NULL, 'Hamilton', 2.0, NULL, NULL, 'unique_9'), (10, 'Lewis', 'Lewis', 'default1', 'Hamilton', NULL, 2.0, 0, 'unique_10'), (11, 'default2', 'Hamilton', 'Hamilton', 'default1', 0.0, 2.0, NULL, 'unique_11'), (12, 'default2', 'default1', 'Hamilton', 'Lewis', 2.0, 0.0, 0, 'unique_12'), (13, 'Hamilton', 'Lewis', 'default1', NULL, 1.0, 0.0, 1, 'unique_13'), (14, 'Hamilton', 'Hamilton', 'Lewis', 'default1', NULL, 2.0, 1, 'unique_14'), (15, 'default2', 'Hamilton', 'Lewis', 'default1', NULL, 0.0, 0, 'unique_15'), (16, 'Lewis', 'Lewis', 'default1', 'Lewis', NULL, 1.0, 1, 'unique_16'), (17, 'Hamilton', 'default2', NULL, 'Lewis', 2.0, 2.0, 1, 'unique_17'), (18, 'Lewis', 'Lewis', 'Hamilton', 'default2', 1.0, NULL, 1, 'unique_18'), (19, 'Hamilton', 'default2', NULL, NULL, NULL, 2.0, NULL, 'unique_19'), (20, 'default1', 'Lewis', NULL, 'Lewis', NULL, NULL, 1, 'unique_20'), (21, 'Lewis', 'default1', 'default1', NULL, 0.0, 2.0, NULL, 'unique_21');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 10, 1, 'Lewis', '2023-01-02', 'Lewis', 'default1'), (1, 13, 3, 2, 'Lewis', '2023-01-01', 'Lewis', 'default2'), (2, 4, 2, 1, 'Lewis', '2023-01-02', 'Lewis', 'Hamilton'), (3, 5, 20, 1, 'Lewis', '2023-01-02', 'default1', NULL), (4, 7, 17, 1, 'Hamilton', '2023-01-01', 'default2', 'Lewis'), (5, 11, 1, 2, 'Lewis', '2023-01-01', 'default2', 'unique_5'), (6, 0, 10, 0, 'Hamilton', '2023-01-02', 'Hamilton', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 2, 1, 1, 4, 2, 0, 0, 'Hamilton', 1, 1.0, 1, NULL, 2, NULL, 1, 'default1', 'default2'), (2, 0, 1, 7, 20, 0, 0, 2, 'default1', 1, 2.0, 2, 'Hamilton', 0, 0, 2, 'default1', NULL), (1, 4, 1, 8, 5, NULL, 1, 1, 'Hamilton', 2, 1.0, 2, 'Lewis', 1, 1, NULL, 'default1', 'Hamilton'), (3, 6, 2, 6, 11, 0, 0, NULL, 'default2', 0, 2.0, 0, 'default2', 2, 2, NULL, 'default2', 'default2'), (4, 3, 0, 3, 19, 2, 0, NULL, 'Lewis', 0, 2.0, 0, 'default1', 2, 2, NULL, 'default1', NULL), (5, 4, 0, 2, 11, 1, 0, 1, 'Lewis', 1, 2.0, 2, NULL, 1, NULL, NULL, 'Lewis', 'default1'), (6, 6, 3, 0, 7, 2, 1, 2, 'default2', 0, 2.0, 0, 'Lewis', 2, 2, 0, 'Lewis', 'Lewis'), (7, 2, 1, 4, 11, 0, 0, 2, 'default2', 0, 0.0, 0, 'Hamilton', NULL, 1, 1, NULL, 'default1'), (8, 0, 0, 7, 17, 0, 0, 2, 'Lewis', 2, 0.0, 0, 'default2', 1, 1, NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
*/

-- Prediction Query
SELECT r.name FROM races AS r JOIN results AS res ON r.raceId = res.raceId JOIN drivers AS d ON res.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY res.rank, r.raceid NULLS LAST, res.resultid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hamilton',)
*/