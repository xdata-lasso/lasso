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
INSERT INTO status (statusid, status) VALUES (0, 'Hamilton'), (1, 'Lewis'), (2, 'Turkish Grand Prix'), (3, 'Lewis'), (4, 'default2'), (5, 'Turkish Grand Prix'), (6, 'Hamilton');
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (0, 'Turkish Grand Prix'), (2, 'Lewis'), (3, 'default2'), (4, 'default1'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Hamilton', NULL, 'default2', 'default1', 'Hamilton', NULL, 'Lewis', 'Lewis'), (1, 'default2', 0, 'default2', 'default2', 'default2', '2023-01-02', 'default2', 'default2'), (2, 'Turkish Grand Prix', NULL, 'default2', 'Lewis', 'Hamilton', NULL, 'default2', 'default1'), (3, 'Lewis', 0, 'Hamilton', 'default1', 'Turkish Grand Prix', '2023-01-02', 'Turkish Grand Prix', 'Hamilton'), (4, 'Lewis', NULL, 'Turkish Grand Prix', 'Hamilton', 'Turkish Grand Prix', '2023-01-01', 'default1', 'Turkish Grand Prix'), (5, 'Turkish Grand Prix', NULL, 'default1', 'default1', 'Hamilton', '2023-01-02', 'Turkish Grand Prix', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'Hamilton', 'default2', 'Turkish Grand Prix', 'Hamilton'), (0, 'Lewis', 'Lewis', 'Lewis', 'Lewis');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'Hamilton', 'Hamilton', 'Lewis', NULL, NULL, NULL, 'default1'), (0, 'Hamilton', 'Lewis', 'default2', NULL, NULL, NULL, 1, 'Hamilton'), (2, 'default1', 'Lewis', NULL, 'default2', NULL, 0.0, NULL, 'Lewis');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 0, 0, 'Lewis', '2023-01-02', NULL, 'default2'), (0, 11, 1, 0, 'default2', '2023-01-01', 'Lewis', 'Lewis'), (2, 4, 0, 1, 'Lewis', '2023-01-02', 'default2', 'Turkish Grand Prix'), (3, 15, 1, 0, 'default1', '2023-01-01', 'default2', 'Hamilton'), (4, 16, 1, 0, 'Turkish Grand Prix', '2023-01-01', 'Turkish Grand Prix', 'default1'), (5, 3, 0, 0, 'default2', '2023-01-02', 'Lewis', NULL), (6, 7, 0, 1, 'default2', '2023-01-01', 'Lewis', 'unique_6'), (7, 11, 1, 1, 'Turkish Grand Prix', '2023-01-02', 'Lewis', 'unique_7'), (8, 0, 0, 1, 'Hamilton', '2023-01-02', 'Lewis', 'unique_8'), (9, 6, 0, 0, 'Hamilton', '2023-01-01', 'default2', 'unique_9'), (10, 10, 0, 0, 'Lewis', '2023-01-01', 'Turkish Grand Prix', 'unique_10');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 2, 0, 0, 3, NULL, 1, 1, 'Lewis', 1, 1.0, 0, 'default2', 0, 1, 1, 'default2', 'Hamilton'), (1, 10, 1, 1, 0, 0, 1, 1, 'Hamilton', 1, 0.0, 1, 'default1', 1, 1, 1, 'default2', 'Turkish Grand Prix'), (2, 7, 0, 0, 2, 1, 0, NULL, 'default2', 1, 0.0, 0, 'Lewis', NULL, 1, NULL, 'Lewis', 'default2'), (3, 6, 5, 0, 3, NULL, 0, 1, 'default1', 0, 0.0, 1, 'default2', 0, 0, 0, 'Hamilton', NULL), (4, 8, 4, 1, 6, 0, 0, NULL, 'default2', 0, 0.0, 0, 'default1', 0, NULL, NULL, 'Lewis', NULL), (5, 3, 5, 1, 5, NULL, 0, 1, 'Lewis', 0, 0.0, 0, 'Hamilton', NULL, 1, 0, 'Lewis', 'Lewis'), (6, 7, 2, 1, 0, NULL, 1, 0, 'default2', 1, 0.0, 1, 'default2', 1, NULL, NULL, 'Hamilton', 'Turkish Grand Prix'), (7, 6, 1, 0, 2, 0, 0, NULL, 'Turkish Grand Prix', 0, 0.0, 0, 'default2', NULL, NULL, 1, 'default2', 'default2'), (8, 10, 0, 1, 0, 1, 1, 0, 'default2', 0, 0.0, 1, 'default1', 0, 0, 0, 'default2', 'default1'), (9, 7, 1, 1, 5, 0, 0, 1, 'default1', 1, 1.0, 0, 'Lewis', 1, NULL, 1, 'Turkish Grand Prix', 'Lewis'), (10, 0, 5, 0, 1, 0, 0, NULL, 'Turkish Grand Prix', 0, 0.0, 0, 'Turkish Grand Prix', 1, NULL, NULL, 'default2', 'Hamilton');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 4, 5, 1.0, 0, 'Hamilton', 0), (1, 1, 2, 0.0, NULL, NULL, 0), (2, 0, 3, 0.0, NULL, 'Hamilton', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' AND T3.name = 'Turkish Grand Prix';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.points) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' AND T2.name = 'Turkish Grand Prix';

/*
Prediction Result:
(0.0,)
*/