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
INSERT INTO status (statusid, status) VALUES (2, 'Lewis'), (1, 'default1');
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (1, 'Lewis'), (2, 'default2'), (3, 'Hamilton'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default1', 0, 'default2', 'default1', 'Hamilton', NULL, NULL, 'default2'), (1, 'Lewis', 1, NULL, 'default1', 'default1', '2023-01-02', 'Lewis', 'Hamilton'), (0, 'default1', 2, NULL, 'Lewis', 'Hamilton', NULL, 'default2', 'Lewis'), (3, 'default2', 2, NULL, 'default1', 'default1', '2023-01-01', NULL, 'default1'), (4, 'Hamilton', NULL, 'default1', 'default2', 'default2', '2023-01-01', 'default1', 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'Lewis', 'Lewis', 'default1', 'Hamilton'), (1, 'Hamilton', 'Hamilton', NULL, 'Lewis'), (0, 'default2', 'default2', 'Lewis', 'default1'), (3, 'Lewis', 'default1', 'Hamilton', 'Hamilton'), (4, 'default1', 'unique_4', 'default2', 'Hamilton'), (5, 'Lewis', 'unique_5', 'default2', 'Lewis');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default2', 'default2', 'default2', NULL, NULL, 2, 'default2'), (2, 'Lewis', 'Hamilton', NULL, 'Hamilton', 0.0, 1.0, 0, 'Lewis'), (0, 'Hamilton', 'default1', 'Hamilton', NULL, 1.0, 0.0, 2, 'Hamilton'), (3, 'default2', 'default1', 'default2', NULL, 1.0, 0.0, NULL, 'default1'), (4, 'default1', 'Lewis', 'Lewis', NULL, NULL, NULL, 2, 'unique_4'), (5, 'default1', 'default1', 'Lewis', NULL, 1.0, 2.0, NULL, 'unique_5'), (6, 'default2', 'Hamilton', 'default1', 'Hamilton', 0.0, NULL, NULL, 'unique_6'), (7, 'Hamilton', 'default1', 'Hamilton', 'Hamilton', 0.0, NULL, 1, 'unique_7'), (8, 'Lewis', 'Hamilton', 'default1', 'default2', 0.0, NULL, 1, 'unique_8'), (9, 'Lewis', 'default1', NULL, 'Hamilton', NULL, 0.0, 0, 'unique_9'), (10, 'default2', 'default2', 'Hamilton', NULL, NULL, NULL, 1, 'unique_10'), (11, 'default2', 'Hamilton', 'default2', 'Lewis', 1.0, 0.0, 1, 'unique_11'), (12, 'default1', 'default2', 'default1', 'Hamilton', 2.0, 1.0, NULL, 'unique_12'), (13, 'default2', 'Hamilton', 'default1', NULL, 0.0, 2.0, 0, 'unique_13'), (14, 'Lewis', 'default1', 'Hamilton', 'Lewis', 0.0, NULL, 1, 'unique_14'), (15, 'default1', 'Lewis', 'Hamilton', 'Lewis', 2.0, 2.0, 0, 'unique_15');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 6, 0, 0, 'Lewis', '2023-01-01', 'Hamilton', 'Hamilton'), (0, 6, 3, 0, 'default2', '2023-01-02', 'default1', NULL), (2, 7, 4, 2, 'Hamilton', '2023-01-01', 'Lewis', 'Lewis'), (3, 3, 4, 2, 'default2', '2023-01-02', 'Lewis', 'default1'), (4, 4, 0, 1, 'Lewis', '2023-01-01', 'default1', 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 1, 1, 0, 1, 2, 1, 0, 'default2', 2, 2.0, 1, 'Hamilton', 1, NULL, NULL, NULL, 'default1'), (0, 0, 0, 5, 2, NULL, 2, 1, 'default2', 0, 2.0, 1, 'default1', 1, 0, 1, NULL, 'default2'), (1, 3, 3, 1, 2, 0, 0, 1, 'Hamilton', 0, 1.0, 2, 'Lewis', NULL, 2, 2, 'Hamilton', 'default2'), (3, 3, 2, 4, 1, 1, 0, 1, 'Hamilton', 2, 0.0, 0, 'default1', 1, NULL, NULL, 'default1', 'Hamilton'), (4, 2, 3, 0, 2, 1, 2, NULL, 'default2', 2, 0.0, 1, 'Lewis', 0, NULL, 2, 'Hamilton', NULL), (5, 0, 1, 1, 2, NULL, 0, 1, 'default2', 1, 2.0, 2, NULL, 0, 2, 2, 'Hamilton', 'default1'), (6, 2, 0, 5, 2, 2, 0, 1, 'Lewis', 1, 2.0, 1, 'Lewis', 2, 0, 1, NULL, 'default2'), (7, 3, 4, 0, 1, NULL, 2, NULL, 'Hamilton', 2, 0.0, 2, 'Lewis', NULL, 2, 2, 'Hamilton', 'default2'), (8, 2, 3, 3, 2, 0, 0, NULL, 'Hamilton', 2, 2.0, 0, 'default1', NULL, 2, NULL, 'Lewis', NULL), (9, 2, 1, 3, 2, 1, 2, 1, 'Hamilton', 0, 0.0, 0, 'default1', 0, 2, NULL, 'default2', 'Hamilton'), (10, 2, 3, 5, 2, NULL, 1, 2, 'default2', 2, 0.0, 2, 'default2', 0, 1, 2, 'default1', 'Hamilton'), (11, 1, 2, 1, 1, 0, 1, NULL, 'Hamilton', 1, 0.0, 2, 'default2', 1, NULL, NULL, 'Lewis', NULL), (12, 1, 0, 2, 1, 1, 2, 1, 'default1', 0, 0.0, 0, 'default2', 0, NULL, 2, 'default2', 'default2'), (13, 0, 0, 1, 1, 1, 0, 2, 'default1', 2, 1.0, 0, 'default1', 1, 1, 0, 'default2', NULL), (14, 3, 1, 1, 2, 2, 0, NULL, 'default1', 2, 1.0, 0, NULL, 0, 1, NULL, 'default2', 'Hamilton');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (1, 0, 0, 2, 'default1', NULL), (2, 3, 1, 2, 'Lewis', NULL), (3, 0, 0, 1, 'default1', NULL), (0, 3, 0, NULL, 'Hamilton', 1), (1, 1, 0, 1, 'default1', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT T3.position FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN lapTimes AS T3 ON T2.raceId = T3.raceId AND T2.fastestLap = T3.lap WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' ORDER BY T3.time, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST, T3.driverid NULLS LAST, T3.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/