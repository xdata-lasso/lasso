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
INSERT INTO status (statusid, status) VALUES (2, 'Lewis'), (1, 'Lewis'), (0, 'default1'), (3, 'Hamilton'), (4, 'default1'), (5, 'default1'), (6, 'default1'), (7, 'default2'), (8, 'Lewis'), (9, 'Hamilton'), (10, 'default2'), (11, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (2, 'default1'), (0, 'default2'), (3, 'Lewis'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', 0, 'default2', 'Lewis', 'Hamilton', '2023-01-01', NULL, 'Lewis'), (2, 'default1', 0, 'Lewis', 'default1', 'Lewis', '2023-01-02', NULL, 'Hamilton'), (0, 'Lewis', NULL, 'Lewis', 'Hamilton', 'default1', '2023-01-01', 'Lewis', 'default2'), (3, 'default1', 1, NULL, 'default1', 'default1', NULL, 'default1', 'default1'), (4, 'Lewis', NULL, 'Hamilton', 'default2', 'default2', '2023-01-02', 'Lewis', 'unique_4'), (5, 'default1', 2, 'Hamilton', 'Lewis', 'default1', NULL, NULL, 'unique_5'), (6, 'Lewis', NULL, 'default1', 'default1', 'default2', '2023-01-02', 'default2', 'unique_6'), (7, 'Hamilton', NULL, 'default1', 'default2', 'Lewis', '2023-01-02', NULL, 'unique_7'), (8, 'Lewis', 1, 'Hamilton', 'default1', 'default2', '2023-01-01', NULL, 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default1', 'Lewis', 'Lewis', 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'default1', NULL, 'default2', NULL, 1.0, 1, 'default1'), (1, 'Lewis', 'Lewis', 'default1', 'Lewis', NULL, 1.0, 0, 'default2'), (0, 'Hamilton', 'Lewis', NULL, 'Hamilton', 0.0, 0.0, 0, 'Hamilton'), (3, 'Lewis', 'default1', 'default2', 'Hamilton', 2.0, 0.0, 1, 'Lewis'), (4, 'Lewis', 'Hamilton', 'default2', 'default1', 0.0, 2.0, 1, 'unique_4'), (5, 'default2', 'default1', 'default2', 'default1', 1.0, 1.0, 1, 'unique_5'), (6, 'Lewis', 'default1', 'default1', 'Hamilton', 2.0, NULL, 2, 'unique_6'), (7, 'Lewis', 'Hamilton', NULL, NULL, 0.0, 2.0, 2, 'unique_7'), (8, 'Lewis', 'default2', 'default2', 'Hamilton', 0.0, 2.0, 1, 'unique_8'), (9, 'default1', 'Lewis', 'Lewis', NULL, 0.0, 0.0, 2, 'unique_9'), (10, 'default1', 'default2', NULL, 'Lewis', 1.0, 2.0, NULL, 'unique_10'), (11, 'Lewis', 'Lewis', NULL, 'default2', 0.0, 1.0, NULL, 'unique_11'), (12, 'Lewis', 'default2', 'Hamilton', 'default2', NULL, 0.0, 0, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 9, 9, 0, 'Hamilton', '2023-01-02', 'Lewis', 'default2'), (0, 2, 3, 0, 'Hamilton', '2023-01-02', 'default2', NULL);
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 2, 3, 2, 6, 2, 1, NULL, 'Lewis', 0, 1.0, 2, NULL, 2, 1, NULL, 'Hamilton', 'Hamilton'), (1, 2, 8, 2, 6, 0, 1, 0, 'default2', 0, 1.0, 2, 'Hamilton', 1, NULL, 2, NULL, 'Hamilton'), (0, 2, 1, 2, 11, 0, 2, 1, 'Lewis', 0, 0.0, 1, 'default2', 0, 2, 2, 'Hamilton', 'Lewis'), (3, 2, 6, 2, 9, 2, 2, 2, 'Hamilton', 2, 2.0, 1, 'Hamilton', 0, 0, 0, 'Hamilton', 'Hamilton');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
*/

-- Prediction Query
SELECT races.name FROM races INNER JOIN results ON races.raceId = results.raceId INNER JOIN drivers ON drivers.driverId = results.driverId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' ORDER BY results.rank ASC, races.raceid NULLS LAST, results.resultid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hamilton',)
*/