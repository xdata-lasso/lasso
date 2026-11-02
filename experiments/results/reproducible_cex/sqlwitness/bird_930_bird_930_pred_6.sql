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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (2, 'default2'), (0, 'default2'), (3, 'Hamilton'), (4, 'Lewis'), (5, 'default2'), (6, 'Hamilton'), (7, 'default2'), (8, 'default2');
INSERT INTO seasons (year, url) VALUES (2, 'Hamilton'), (0, 'Lewis'), (1, 'default2'), (3, 'default1'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 0, 'Lewis', 'Lewis', 'Lewis', '2023-01-02', NULL, 'default2'), (1, 'Hamilton', 1, 'default2', 'Hamilton', 'default2', '2023-01-01', 'default1', 'Lewis'), (2, 'default2', NULL, NULL, 'Lewis', 'Lewis', '2023-01-01', 'default2', 'default1'), (3, 'Hamilton', 0, 'default1', 'Lewis', 'Hamilton', NULL, 'Hamilton', 'Hamilton'), (4, 'Hamilton', 0, 'Lewis', 'Hamilton', 'default1', '2023-01-01', 'default1', 'unique_4'), (5, 'default2', NULL, NULL, 'default2', 'default1', '2023-01-02', 'default2', 'unique_5'), (6, 'default1', 1, 'Hamilton', 'Hamilton', 'default2', NULL, 'default1', 'unique_6'), (7, 'default1', 2, 'default2', 'default1', 'default2', NULL, 'default2', 'unique_7'), (8, 'Lewis', 0, 'default2', 'default2', 'default1', '2023-01-02', 'default2', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default2', 'default1', 'default2', 'default1'), (1, 'default2', 'Lewis', NULL, 'Hamilton'), (2, 'default2', 'Hamilton', 'Lewis', 'default2'), (3, 'Hamilton', 'default2', NULL, 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'Lewis', 'default2', 'Hamilton', NULL, NULL, 1, 'default2'), (1, 'default2', 'Lewis', NULL, 'default2', 2.0, 2.0, 0, 'Hamilton'), (2, 'Hamilton', 'default2', NULL, 'Lewis', NULL, NULL, 0, 'default1'), (3, 'Hamilton', 'default2', NULL, 'default1', 0.0, NULL, 0, 'Lewis'), (4, 'default2', 'default2', 'default1', 'default2', NULL, NULL, 2, 'unique_4'), (5, 'default2', 'default2', 'Lewis', 'Hamilton', NULL, NULL, 2, 'unique_5'), (6, 'default1', 'default1', 'Lewis', 'Hamilton', 0.0, NULL, 2, 'unique_6'), (7, 'Hamilton', 'Lewis', 'default1', NULL, NULL, 2.0, 2, 'unique_7'), (8, 'Hamilton', 'Hamilton', 'default1', 'Hamilton', 0.0, 2.0, 1, 'unique_8'), (9, 'Hamilton', 'Hamilton', 'Lewis', 'Hamilton', 0.0, NULL, 1, 'unique_9'), (10, 'Hamilton', 'Lewis', 'Hamilton', 'Hamilton', NULL, 0.0, 1, 'unique_10'), (11, 'Lewis', 'Lewis', 'Lewis', 'default1', NULL, 1.0, 1, 'unique_11'), (12, 'Lewis', 'Hamilton', 'default1', 'default1', 2.0, 2.0, 1, 'unique_12'), (13, 'default2', 'default2', 'Hamilton', 'Lewis', NULL, 0.0, 2, 'unique_13'), (14, 'Lewis', 'default2', NULL, 'Lewis', 2.0, 1.0, NULL, 'unique_14'), (15, 'Hamilton', 'Lewis', 'Lewis', 'default2', 1.0, 2.0, 0, 'unique_15');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 3, 1, 'default2', '2023-01-02', 'Hamilton', 'Lewis'), (1, 1, 2, 2, 'Lewis', '2023-01-02', 'default2', 'Hamilton'), (2, 6, 12, 1, 'Lewis', '2023-01-02', 'Lewis', 'default1'), (3, 5, 1, 2, 'Lewis', '2023-01-01', 'default2', NULL), (4, 2, 9, 1, 'default1', '2023-01-01', 'Lewis', 'default2'), (5, 1, 11, 0, 'Hamilton', '2023-01-02', 'default2', 'unique_5'), (6, 1, 15, 2, 'Hamilton', '2023-01-02', 'Hamilton', 'unique_6'), (7, 3, 15, 0, 'default2', '2023-01-01', 'default2', 'unique_7'), (8, 1, 6, 0, 'Hamilton', '2023-01-02', NULL, 'unique_8');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 2, 5, 3, 6, 0, 2, 1, 'default2', 2, 1.0, 1, 'Hamilton', NULL, NULL, 0, NULL, NULL), (2, 1, 0, 0, 5, NULL, 0, 1, 'Lewis', 1, 0.0, 2, NULL, 2, 1, 0, 'default2', 'Hamilton'), (0, 7, 2, 0, 2, 1, 0, NULL, 'Hamilton', 1, 0.0, 2, 'default1', 2, NULL, 0, 'Lewis', 'Hamilton'), (3, 5, 2, 3, 5, 2, 2, 1, 'default2', 2, 0.0, 1, 'Lewis', 0, NULL, 1, 'default2', 'Hamilton'), (4, 2, 2, 2, 1, NULL, 0, NULL, 'default1', 2, 0.0, 0, 'Lewis', NULL, NULL, 1, 'Hamilton', 'Hamilton'), (5, 5, 5, 0, 3, NULL, 0, NULL, 'Hamilton', 2, 1.0, 2, 'default1', 0, 0, 1, NULL, NULL), (6, 6, 6, 3, 6, 0, 2, NULL, 'default1', 0, 0.0, 2, 'default1', 2, 1, 0, NULL, 'Hamilton'), (7, 4, 2, 2, 4, NULL, 2, NULL, 'default2', 2, 2.0, 0, 'default1', 1, 0, NULL, 'default2', 'default1'), (8, 5, 3, 1, 0, 1, 0, 1, 'Hamilton', 1, 1.0, 1, 'default2', 1, NULL, NULL, 'default2', 'Hamilton'), (9, 5, 8, 1, 5, 1, 2, 2, 'default2', 2, 2.0, 2, NULL, NULL, 0, NULL, 'Lewis', NULL), (10, 4, 1, 3, 1, 0, 0, 0, 'Lewis', 0, 0.0, 2, 'default2', 2, NULL, NULL, 'default1', NULL), (11, 8, 1, 1, 3, NULL, 0, 0, 'default2', 2, 2.0, 1, 'default1', 0, 0, 1, 'default1', 'Hamilton'), (12, 1, 7, 1, 7, 1, 0, 0, 'Lewis', 2, 2.0, 2, 'default1', 2, 2, NULL, 'Hamilton', 'default1'), (13, 7, 0, 2, 0, 2, 2, 2, 'default2', 1, 1.0, 1, 'Lewis', NULL, 0, 0, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE raceId IN (SELECT raceId FROM results WHERE rank = 1 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'));

/*
Gold Result:
*/

-- Prediction Query
SELECT r.name FROM results AS res INNER JOIN drivers AS d ON res.driverId = d.driverId INNER JOIN races AS r ON res.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY res.rank ASC, res.resultid NULLS LAST, d.driverid NULLS LAST, r.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hamilton',)
*/