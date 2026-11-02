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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (0, 'Hamilton'), (2, 'default1'), (3, 'Hamilton');
INSERT INTO seasons (year, url) VALUES (0, 'Lewis'), (1, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'Lewis', NULL, 'default1', 'Lewis', 'Lewis', '2023-01-02', 'Lewis', 'default2'), (0, 'default2', 2, 'Lewis', 'Lewis', 'Lewis', NULL, NULL, 'default1'), (1, 'Lewis', NULL, NULL, 'Hamilton', 'default1', NULL, 'default2', 'Lewis'), (3, 'default1', NULL, 'Hamilton', 'Lewis', 'Hamilton', '2023-01-01', 'default1', 'Hamilton'), (4, 'default2', NULL, 'default2', 'default1', 'default1', NULL, 'Lewis', 'unique_4'), (5, 'Lewis', 0, 'Lewis', 'default2', 'default1', '2023-01-01', 'default1', 'unique_5'), (6, 'Hamilton', 2, NULL, 'Hamilton', 'Hamilton', NULL, 'Hamilton', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'Lewis', 'default2', 'Lewis', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'default2', NULL, 'default2', 2.0, 0.0, 2, 'Hamilton'), (1, 'Lewis', 'default2', 'default2', 'Hamilton', 1.0, 2.0, 1, 'Lewis'), (2, 'Lewis', 'Hamilton', NULL, 'Hamilton', 0.0, 1.0, NULL, 'default1'), (3, 'default1', 'default1', 'Hamilton', 'default1', NULL, 0.0, 0, 'default2'), (4, 'default1', 'Lewis', 'Hamilton', NULL, NULL, 2.0, 2, 'unique_4'), (5, 'default1', 'default2', 'default2', 'default2', 2.0, 0.0, 2, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 4, 1, 'Lewis', '2023-01-01', NULL, NULL), (0, 0, 3, 1, 'default2', '2023-01-01', 'default2', 'Hamilton'), (2, 1, 5, 0, 'default1', '2023-01-01', 'Lewis', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 1, 3, 1, 2, NULL, 1, 1, 'default1', 1, 2.0, 1, 'Lewis', 0, NULL, 2, NULL, 'Hamilton'), (1, 0, 1, 1, 0, 1, 0, 0, 'Hamilton', 1, 1.0, 0, NULL, 2, 0, NULL, 'default1', 'default1'), (2, 1, 3, 1, 1, NULL, 0, 0, 'Lewis', 1, 2.0, 2, 'Lewis', 2, 2, 1, 'Lewis', 'default2'), (3, 1, 0, 1, 3, 1, 1, NULL, 'Lewis', 1, 1.0, 0, 'Lewis', NULL, 1, 2, 'Lewis', 'default2'), (4, 2, 2, 1, 2, 0, 1, 0, 'default2', 1, 1.0, 2, 'Hamilton', NULL, 2, 2, NULL, 'default2'), (5, 1, 6, 1, 1, NULL, 2, 0, 'default2', 0, 2.0, 2, 'Lewis', 0, 1, 0, NULL, 'Hamilton');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (2, 0, 4, 0.0, 0, 'Lewis', 0), (0, 1, 5, 0.0, 2, 'Lewis', 1), (1, 1, 0, 1.0, 0, 'default2', 2), (3, 2, 6, 1.0, 2, 'default2', 0), (4, 1, 2, 2.0, 0, 'Hamilton', 1), (5, 1, 6, 2.0, 2, 'Lewis', 2), (6, 0, 5, 2.0, 0, 'Hamilton', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT races.year, results.points FROM results INNER JOIN drivers ON results.driverId = drivers.driverId INNER JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' ORDER BY races.date ASC, results.resultid NULLS LAST, drivers.driverid NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
(0, 2.0)
*/