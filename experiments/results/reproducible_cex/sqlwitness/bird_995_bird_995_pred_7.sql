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
INSERT INTO status (statusid, status) VALUES (0, 'Turkish Grand Prix'), (1, 'Turkish Grand Prix'), (2, 'Hamilton'), (3, 'Turkish Grand Prix'), (4, 'Lewis'), (5, 'default1'), (6, 'default1'), (7, 'Lewis'), (8, 'Turkish Grand Prix');
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (0, 'Turkish Grand Prix'), (2, 'default1'), (3, 'default2'), (4, 'Lewis'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Turkish Grand Prix', 0, 'Hamilton', 'Turkish Grand Prix', 'Hamilton', '2023-01-02', 'Hamilton', 'default1'), (0, 'Hamilton', NULL, 'Lewis', 'Turkish Grand Prix', 'Turkish Grand Prix', NULL, 'Lewis', 'Lewis'), (2, 'Lewis', NULL, 'Hamilton', 'default1', 'default2', '2023-01-01', 'default2', 'default2'), (3, 'default1', 0, 'default1', 'Lewis', 'Hamilton', '2023-01-01', 'default2', 'Turkish Grand Prix'), (4, 'Turkish Grand Prix', 1, 'default2', 'Lewis', 'default2', NULL, 'Hamilton', 'Hamilton'), (5, 'Lewis', 0, 'Turkish Grand Prix', 'default1', 'default1', '2023-01-02', 'default1', 'unique_5'), (6, 'Turkish Grand Prix', 0, 'default1', 'Lewis', 'default1', NULL, NULL, 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default2', 'default2', 'default1', 'Turkish Grand Prix'), (1, 'Hamilton', 'Lewis', NULL, 'Lewis'), (2, 'Turkish Grand Prix', 'Turkish Grand Prix', 'default1', 'Hamilton'), (3, 'default1', 'Hamilton', 'Turkish Grand Prix', 'Turkish Grand Prix'), (4, 'Turkish Grand Prix', 'default1', 'default1', 'Hamilton'), (5, 'Lewis', 'unique_5', NULL, 'Turkish Grand Prix'), (6, 'Turkish Grand Prix', 'unique_6', 'default2', 'default2'), (7, 'Turkish Grand Prix', 'unique_7', 'Hamilton', 'default1'), (8, 'Hamilton', 'unique_8', NULL, 'Turkish Grand Prix'), (9, 'Hamilton', 'unique_9', 'default1', 'Lewis'), (10, 'default1', 'unique_10', 'default2', 'default2'), (11, 'default1', 'unique_11', 'Hamilton', 'default1'), (12, 'Hamilton', 'unique_12', 'Turkish Grand Prix', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Turkish Grand Prix', 'default1', 'default1', NULL, NULL, 1.0, NULL, 'Hamilton'), (1, 'Turkish Grand Prix', 'default1', NULL, 'Turkish Grand Prix', 1.0, 0.0, 0, 'default1'), (2, 'default1', 'default2', 'Turkish Grand Prix', NULL, NULL, NULL, NULL, 'default2'), (3, 'default1', 'default1', 'Hamilton', 'Lewis', 0.0, 1.0, 1, 'Lewis'), (4, 'Lewis', 'Turkish Grand Prix', NULL, NULL, 1.0, 0.0, NULL, 'Turkish Grand Prix'), (5, 'Turkish Grand Prix', 'default1', 'Turkish Grand Prix', NULL, NULL, 1.0, 0, 'unique_5'), (6, 'default2', 'Turkish Grand Prix', 'Hamilton', NULL, 0.0, 0.0, 0, 'unique_6'), (7, 'Hamilton', 'default2', 'Turkish Grand Prix', 'Lewis', 0.0, NULL, 0, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 10, 5, 1, 'Turkish Grand Prix', '2023-01-02', 'default1', 'Lewis'), (0, 4, 3, 0, 'default1', '2023-01-02', 'Turkish Grand Prix', 'default1'), (2, 8, 2, 1, 'default1', '2023-01-02', 'default1', 'Turkish Grand Prix'), (3, 3, 4, 0, 'default2', '2023-01-02', 'Hamilton', 'Hamilton'), (4, 1, 5, 0, 'default1', '2023-01-01', 'default1', NULL), (5, 7, 5, 1, 'default1', '2023-01-02', NULL, 'default2'), (6, 3, 7, 1, 'default2', '2023-01-02', 'Hamilton', 'unique_6'), (7, 5, 7, 1, 'default2', '2023-01-02', 'Turkish Grand Prix', 'unique_7'), (8, 8, 3, 1, 'default2', '2023-01-01', NULL, 'unique_8'), (9, 8, 7, 1, 'Hamilton', '2023-01-01', NULL, 'unique_9'), (10, 6, 3, 0, 'Hamilton', '2023-01-02', 'Hamilton', 'unique_10');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 10, 3, 10, 0, 1, 0, 1, 'default1', 1, 1.0, 0, NULL, NULL, NULL, 0, 'Lewis', 'Lewis'), (1, 7, 2, 9, 7, 0, 1, 1, 'default2', 0, 0.0, 0, 'default2', 1, 0, 0, 'Lewis', NULL), (2, 6, 6, 2, 1, 1, 0, 0, 'Turkish Grand Prix', 0, 0.0, 1, 'Lewis', 0, 1, NULL, 'Lewis', 'Hamilton'), (3, 7, 4, 2, 8, 1, 0, 1, 'Lewis', 0, 0.0, 0, NULL, NULL, 0, NULL, 'default2', 'default2'), (4, 2, 4, 1, 4, NULL, 0, 0, 'Turkish Grand Prix', 0, 0.0, 1, 'Turkish Grand Prix', NULL, NULL, NULL, 'Hamilton', 'Hamilton'), (5, 0, 6, 9, 4, 1, 0, 0, 'Hamilton', 0, 0.0, 1, 'default1', NULL, 1, NULL, 'default2', 'Lewis'), (6, 8, 3, 9, 2, NULL, 1, 0, 'Turkish Grand Prix', 1, 0.0, 1, NULL, 0, 1, 0, 'Turkish Grand Prix', 'default2');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 8, 1, 1.0, 1, 'Turkish Grand Prix', 1), (1, 1, 3, 1.0, 0, 'Hamilton', 1), (2, 6, 6, 1.0, NULL, 'default2', 0), (3, 2, 1, 1.0, 0, 'default2', 0), (4, 10, 5, 0.0, NULL, 'Lewis', 0), (5, 4, 6, 0.0, NULL, 'Lewis', 0), (6, 7, 1, 1.0, 1, 'default1', 0), (7, 6, 4, 0.0, NULL, 'Lewis', 0), (8, 6, 1, 0.0, 0, 'Lewis', 1), (9, 1, 1, 0.0, NULL, 'Hamilton', 1), (10, 0, 5, 1.0, 1, 'Lewis', 0), (11, 9, 5, 0.0, 1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' AND T3.name = 'Turkish Grand Prix';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(results.points) FROM drivers INNER JOIN results ON drivers.driverId = results.driverId INNER JOIN races ON results.raceId = races.raceId WHERE drivers.surname = 'Hamilton' AND races.name = 'Turkish Grand Prix';

/*
Prediction Result:
(None,)
*/