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
INSERT INTO status (statusid, status) VALUES (1, 'Hamilton'), (0, 'Hamilton'), (2, 'Lewis'), (3, 'Lewis'), (4, 'default1'), (5, 'Turkish Grand Prix');
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'Lewis'), (2, 'default1'), (3, 'Turkish Grand Prix'), (4, 'Hamilton'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Hamilton', 0, 'default2', 'Hamilton', 'default2', '2023-01-01', NULL, 'Hamilton'), (0, 'Turkish Grand Prix', NULL, NULL, 'default2', 'Turkish Grand Prix', '2023-01-01', 'Lewis', 'default2'), (2, 'default1', 0, 'default1', 'default1', 'Turkish Grand Prix', '2023-01-01', NULL, 'default1'), (3, 'Turkish Grand Prix', NULL, 'default1', 'default2', 'default2', '2023-01-01', 'default2', 'Turkish Grand Prix'), (4, 'default1', NULL, 'default1', 'Lewis', 'Hamilton', NULL, 'Lewis', 'Lewis'), (5, 'Turkish Grand Prix', 0, 'default1', 'Lewis', 'Turkish Grand Prix', NULL, 'Hamilton', 'unique_5'), (6, 'Turkish Grand Prix', 1, 'Hamilton', 'default1', 'Turkish Grand Prix', '2023-01-02', NULL, 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Hamilton', 'Lewis', 'Hamilton', 'Hamilton'), (1, 'Turkish Grand Prix', 'default2', 'default1', 'default2'), (2, 'default1', 'Turkish Grand Prix', 'Lewis', 'default1'), (3, 'default1', 'Hamilton', NULL, 'Lewis'), (4, 'Lewis', 'default1', 'default2', 'Hamilton'), (5, 'Lewis', 'unique_5', 'Lewis', 'Lewis');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'Lewis', NULL, 'Turkish Grand Prix', NULL, 0.0, 1, 'Hamilton'), (0, 'default1', 'Hamilton', NULL, 'Turkish Grand Prix', 0.0, 1.0, 0, 'Turkish Grand Prix'), (2, 'default1', 'Hamilton', 'Hamilton', 'Lewis', 1.0, 1.0, 0, 'default2');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2, 1, 0, 'default2', '2023-01-01', 'Lewis', 'default2'), (0, 4, 1, 1, 'Lewis', '2023-01-01', 'Turkish Grand Prix', NULL), (2, 3, 0, 1, 'default1', '2023-01-01', 'Hamilton', 'Turkish Grand Prix'), (3, 3, 1, 0, 'Turkish Grand Prix', '2023-01-02', 'default2', 'Lewis'), (4, 3, 2, 1, 'Turkish Grand Prix', '2023-01-01', 'Lewis', 'Hamilton');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1, 5, 3, 3, 0, 1, 0, 'default1', 0, 1.0, 1, NULL, 0, 1, 1, 'default2', 'Hamilton'), (0, 3, 2, 0, 3, 1, 1, 0, 'Hamilton', 1, 1.0, 1, 'Hamilton', NULL, 0, NULL, NULL, 'Turkish Grand Prix'), (2, 3, 4, 0, 3, 1, 0, 1, 'Turkish Grand Prix', 0, 1.0, 0, NULL, 0, 0, NULL, 'Turkish Grand Prix', 'Hamilton'), (3, 3, 3, 5, 4, 1, 1, NULL, 'default2', 1, 0.0, 0, 'Hamilton', NULL, NULL, NULL, 'Lewis', 'default2'), (4, 4, 6, 1, 1, NULL, 0, NULL, 'default2', 0, 0.0, 1, 'Turkish Grand Prix', NULL, 1, NULL, 'Hamilton', 'Hamilton'), (5, 3, 1, 4, 2, NULL, 0, 0, 'Lewis', 0, 0.0, 1, NULL, 1, 1, NULL, 'Hamilton', 'Turkish Grand Prix'), (6, 0, 6, 3, 0, 0, 1, 0, 'Turkish Grand Prix', 1, 0.0, 0, 'Turkish Grand Prix', 0, 1, NULL, 'default2', NULL), (7, 4, 0, 2, 2, NULL, 0, NULL, 'Turkish Grand Prix', 1, 0.0, 0, 'default2', 0, 0, NULL, 'Hamilton', 'default2'), (8, 1, 2, 0, 2, 0, 0, NULL, 'Turkish Grand Prix', 1, 0.0, 0, 'default1', 0, NULL, 1, 'Hamilton', 'Lewis');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 0, 6, 0.0, NULL, NULL, 0), (1, 4, 6, 0.0, NULL, NULL, 1), (2, 0, 6, 0.0, 1, 'default2', 0), (3, 4, 3, 0.0, 1, 'Hamilton', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton' AND T3.name = 'Turkish Grand Prix';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(res.points) AS average_score FROM results AS res INNER JOIN drivers AS d ON res.driverId = d.driverId INNER JOIN races AS r ON res.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' AND r.name = 'Turkish Grand Prix';

/*
Prediction Result:
(1.0,)
*/