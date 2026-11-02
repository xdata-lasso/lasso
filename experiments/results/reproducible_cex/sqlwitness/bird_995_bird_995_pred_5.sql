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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (0, 'default1'), (2, 'Hamilton'), (3, 'default1'), (4, 'Lewis'), (5, 'Lewis'), (6, 'default1'), (7, 'Hamilton'), (8, 'Hamilton'), (9, 'Turkish Grand Prix'), (10, 'default2'), (11, 'Turkish Grand Prix'), (12, 'default2');
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (1, 'Hamilton'), (2, 'default2'), (3, 'Lewis'), (4, 'Turkish Grand Prix'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 0, 'Hamilton', 'Lewis', 'default1', '2023-01-02', NULL, 'Turkish Grand Prix'), (1, 'Turkish Grand Prix', 0, 'default2', 'Lewis', 'default2', NULL, 'Lewis', 'Hamilton'), (2, 'default1', 1, 'Turkish Grand Prix', 'Lewis', 'Hamilton', NULL, NULL, 'Lewis'), (3, 'default1', 0, 'Turkish Grand Prix', 'default1', 'default2', '2023-01-01', 'default2', 'default1'), (4, 'Turkish Grand Prix', 0, 'default2', 'Hamilton', 'Turkish Grand Prix', '2023-01-02', 'default2', 'default2'), (5, 'Hamilton', NULL, 'Hamilton', 'Hamilton', 'default2', '2023-01-01', 'Hamilton', 'unique_5'), (6, 'default2', 1, 'Hamilton', 'Lewis', 'Lewis', NULL, 'Turkish Grand Prix', 'unique_6'), (7, 'default1', 0, 'Lewis', 'Turkish Grand Prix', 'default2', '2023-01-02', 'default1', 'unique_7'), (8, 'default2', NULL, NULL, 'default1', 'default2', NULL, 'Lewis', 'unique_8'), (9, 'default1', 0, NULL, 'default2', 'Hamilton', '2023-01-01', 'default1', 'unique_9'), (10, 'Lewis', NULL, NULL, 'Lewis', 'default2', NULL, 'Hamilton', 'unique_10');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'Hamilton', 'Turkish Grand Prix', 'default2', 'Hamilton'), (0, 'Turkish Grand Prix', 'Hamilton', 'Turkish Grand Prix', 'default2'), (2, 'Turkish Grand Prix', 'default1', NULL, 'Lewis'), (3, 'default2', 'Lewis', 'default2', 'Turkish Grand Prix'), (4, 'Lewis', 'default2', 'Hamilton', 'Turkish Grand Prix'), (5, 'Lewis', 'unique_5', 'Hamilton', 'default1'), (6, 'Hamilton', 'unique_6', 'default2', 'Hamilton'), (7, 'default2', 'unique_7', NULL, 'Lewis'), (8, 'Lewis', 'unique_8', 'Lewis', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'Hamilton', NULL, NULL, NULL, 1.0, 1, 'default2'), (1, 'default2', 'default1', 'Hamilton', 'Lewis', NULL, NULL, NULL, 'Lewis');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 0, 1, 0, 'Lewis', '2023-01-01', 'Hamilton', NULL), (1, 1, 0, 1, 'default2', '2023-01-02', NULL, 'default1'), (2, 4, 0, 1, 'Hamilton', '2023-01-02', 'Lewis', 'Turkish Grand Prix'), (3, 10, 1, 1, 'default1', '2023-01-01', 'Hamilton', 'Lewis'), (4, 5, 1, 1, 'Turkish Grand Prix', '2023-01-02', 'default2', 'default2'), (5, 6, 0, 0, 'Turkish Grand Prix', '2023-01-01', 'Lewis', 'Hamilton'), (6, 4, 0, 0, 'default2', '2023-01-01', NULL, 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 4, 10, 3, 0, 0, 0, 0, 'Lewis', 1, 0.0, 0, 'Lewis', 1, NULL, 0, 'Lewis', NULL), (1, 4, 8, 1, 6, 1, 1, NULL, 'Lewis', 1, 0.0, 0, 'Lewis', 0, 0, 1, 'Hamilton', 'Turkish Grand Prix'), (2, 0, 8, 6, 11, 1, 1, 0, 'default2', 1, 0.0, 0, 'Hamilton', 0, 1, NULL, NULL, 'Lewis'), (3, 1, 5, 2, 8, 1, 0, 0, 'default1', 0, 1.0, 0, 'Turkish Grand Prix', NULL, NULL, 1, 'Lewis', 'default2'), (4, 1, 4, 1, 6, 1, 1, 1, 'default2', 0, 1.0, 0, 'Turkish Grand Prix', 0, NULL, NULL, 'Lewis', NULL), (5, 3, 4, 7, 11, 0, 1, 1, 'default2', 1, 1.0, 1, 'default1', NULL, 0, NULL, 'Lewis', 'Hamilton'), (6, 4, 3, 3, 8, 1, 0, 1, 'default2', 1, 1.0, 1, 'Hamilton', 0, 0, 1, 'Turkish Grand Prix', 'Hamilton'), (7, 0, 9, 1, 1, 0, 1, 0, 'Hamilton', 0, 1.0, 1, 'Lewis', NULL, NULL, 0, NULL, NULL);
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 0, 7, 1.0, 1, 'default1', 1), (1, 0, 9, 1.0, 1, 'Turkish Grand Prix', 1), (2, 3, 7, 1.0, 0, 'Turkish Grand Prix', 0), (3, 4, 8, 1.0, 1, 'Lewis', 0), (4, 1, 0, 0.0, 1, 'Hamilton', 0), (5, 3, 2, 0.0, 1, NULL, 1), (6, 5, 2, 1.0, NULL, NULL, 0), (7, 4, 8, 1.0, 1, 'Turkish Grand Prix', 1), (8, 5, 3, 1.0, 1, 'Lewis', 1), (9, 5, 6, 0.0, NULL, 'default2', 0), (10, 3, 2, 1.0, 0, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' AND T3.name = 'Turkish Grand Prix';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(r.points) AS average_points FROM drivers AS d INNER JOIN results AS r ON d.driverId = r.driverId INNER JOIN races AS rc ON r.raceId = rc.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' AND rc.name = 'Turkish Grand Prix';

/*
Prediction Result:
(None,)
*/