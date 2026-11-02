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
INSERT INTO status (statusid, status) VALUES (2, 'Hamilton'), (1, 'default1'), (0, 'default1'), (3, 'default2'), (4, 'Hamilton'), (5, 'Lewis'), (6, 'Lewis'), (7, 'default2');
INSERT INTO seasons (year, url) VALUES (0, 'Hamilton'), (1, 'default1'), (2, 'Lewis'), (3, 'default2'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Lewis', 2, NULL, 'default1', 'Hamilton', NULL, NULL, 'default1'), (0, 'default2', NULL, 'default2', 'default2', 'default2', NULL, 'default2', 'default2'), (2, 'Lewis', NULL, 'default1', 'Lewis', 'Lewis', '2023-01-02', NULL, 'Hamilton'), (3, 'default2', NULL, 'Hamilton', 'Lewis', 'Hamilton', '2023-01-02', 'default2', 'Lewis');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'Hamilton', 'Hamilton', 'default2', 'Hamilton'), (2, 'default2', 'default2', 'default1', 'Lewis'), (0, 'Lewis', 'default1', NULL, 'default1'), (3, 'default1', 'Lewis', 'Hamilton', 'default2'), (4, 'default1', 'unique_4', 'Hamilton', 'default1'), (5, 'Lewis', 'unique_5', 'Hamilton', 'default1'), (6, 'Hamilton', 'unique_6', 'Lewis', 'Lewis'), (7, 'default1', 'unique_7', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Hamilton', 'Lewis', 'default1', NULL, 0.0, NULL, NULL, 'Hamilton');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 4, 1, 1, 'Lewis', '2023-01-01', 'Lewis', NULL), (0, 0, 1, 2, 'Hamilton', '2023-01-01', 'Lewis', 'default1'), (1, 1, 1, 1, 'Hamilton', '2023-01-02', 'default1', 'Lewis'), (3, 1, 1, 2, 'default2', '2023-01-02', 'Hamilton', 'Hamilton'), (4, 2, 1, 0, 'default2', '2023-01-02', 'Hamilton', 'default2'), (5, 3, 1, 0, 'default2', '2023-01-02', 'Hamilton', 'unique_5'), (6, 5, 1, 1, 'default2', '2023-01-02', 'default1', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 1, 1, 1, 2, 1, 1, 0, 'default2', 2, 2.0, 1, 'Lewis', 2, 0, 0, 'default2', 'Lewis'), (1, 2, 2, 5, 4, 2, 1, 1, 'default2', 1, 1.0, 2, 'default2', 0, NULL, NULL, 'Hamilton', 'default1'), (0, 0, 2, 2, 5, 0, 2, NULL, 'default1', 0, 0.0, 2, 'Hamilton', 1, 0, 0, 'default1', NULL), (3, 3, 0, 6, 4, 0, 2, NULL, 'default2', 0, 2.0, 2, NULL, 0, 0, 0, 'Lewis', 'Hamilton'), (4, 5, 1, 6, 2, 2, 0, NULL, 'Hamilton', 2, 1.0, 2, 'default2', 1, 2, 1, 'Hamilton', 'default2'), (5, 3, 0, 6, 1, 2, 1, NULL, 'default1', 2, 1.0, 0, 'Lewis', 0, 0, NULL, 'default2', 'Hamilton'), (6, 6, 0, 0, 7, 2, 2, 1, 'Hamilton', 1, 1.0, 1, 'Lewis', 0, 2, 0, 'default1', 'default1'), (7, 6, 0, 4, 1, 1, 2, 0, 'Hamilton', 2, 2.0, 2, 'Hamilton', 0, 2, NULL, 'default1', 'Lewis'), (8, 2, 0, 6, 3, 1, 1, NULL, 'default2', 0, 1.0, 2, 'default1', 0, 0, 1, 'default1', NULL), (9, 2, 2, 0, 0, 0, 0, 1, 'default2', 1, 1.0, 0, 'default2', 1, NULL, 1, 'default2', 'Lewis');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (5, 3, 0, 1, NULL, NULL), (3, 2, 1, 0, 'Lewis', 0), (0, 2, 1, 1, 'default1', NULL), (0, 3, 2, 2, 'Lewis', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT c.location FROM circuits AS c JOIN races AS r ON c.circuitId = r.circuitId JOIN results AS res ON r.raceId = res.raceId JOIN drivers AS d ON res.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY res.fastestLapTime ASC, c.circuitid NULLS LAST, r.raceid NULLS LAST, res.resultid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/