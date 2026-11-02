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
INSERT INTO status (statusid, status) VALUES (0, 'default2'), (1, 'default2'), (2, 'default1'), (3, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (0, 'default1'), (2, 'Lewis'), (3, 'default2'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Hamilton', 0, 'Hamilton', 'Lewis', 'default2', '2023-01-02', 'default2', 'Hamilton'), (1, 'Lewis', NULL, 'default2', 'Hamilton', 'Lewis', NULL, 'default2', 'Lewis'), (2, 'default2', 1, 'default2', 'Hamilton', 'default1', '2023-01-02', NULL, 'default2'), (3, 'default2', 0, 'Lewis', 'Hamilton', 'Lewis', '2023-01-02', 'Lewis', 'default1'), (4, 'Lewis', 1, NULL, 'Hamilton', 'default1', '2023-01-02', NULL, 'unique_4'), (5, 'Hamilton', NULL, 'Lewis', 'Lewis', 'default2', '2023-01-02', 'default1', 'unique_5'), (6, 'default2', 1, NULL, 'Lewis', 'Lewis', NULL, 'default1', 'unique_6'), (7, 'default1', 1, 'Hamilton', 'Lewis', 'Hamilton', '2023-01-01', NULL, 'unique_7'), (8, 'Hamilton', 0, 'default2', 'default2', 'Hamilton', NULL, 'default2', 'unique_8'), (9, 'default1', NULL, NULL, 'Lewis', 'default2', NULL, 'Lewis', 'unique_9'), (10, 'default1', NULL, 'Lewis', 'default1', 'Hamilton', '2023-01-01', 'Hamilton', 'unique_10'), (11, 'default1', 0, 'Lewis', 'Hamilton', 'Hamilton', '2023-01-01', 'default1', 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Lewis', 'default1', 'Lewis', 'Hamilton'), (1, 'Hamilton', 'Lewis', 'default1', 'default2'), (2, 'Lewis', 'Hamilton', 'Lewis', 'Hamilton'), (3, 'default1', 'default2', 'default2', 'Lewis'), (4, 'Lewis', 'unique_4', 'Lewis', 'Lewis'), (5, 'Lewis', 'unique_5', 'default1', 'Lewis'), (6, 'default2', 'unique_6', 'Hamilton', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default1', NULL, NULL, NULL, NULL, 0, 'Lewis'), (0, 'Lewis', 'default1', 'default1', 'Lewis', 0.0, NULL, 1, 'default1'), (2, 'Lewis', 'Lewis', NULL, 'default2', 1.0, 1.0, 0, 'Hamilton'), (3, 'Hamilton', 'default2', 'default1', 'default1', 1.0, 1.0, 1, 'default2'), (4, 'default2', 'default2', 'Lewis', NULL, 1.0, 1.0, NULL, 'unique_4'), (5, 'Lewis', 'Lewis', 'default1', 'default2', 1.0, NULL, 0, 'unique_5'), (6, 'Hamilton', 'Lewis', 'Lewis', 'Hamilton', 1.0, 1.0, 0, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 8, 1, 1, 'Hamilton', '2023-01-02', NULL, 'Hamilton'), (1, 7, 1, 1, 'default2', '2023-01-01', NULL, NULL), (2, 5, 2, 1, 'default2', '2023-01-01', 'default2', 'default2'), (3, 5, 5, 0, 'default1', '2023-01-01', NULL, 'default1'), (4, 0, 2, 0, 'default1', '2023-01-01', 'default1', 'Lewis'), (5, 3, 4, 1, 'Lewis', '2023-01-01', 'Hamilton', 'unique_5'), (6, 6, 3, 1, 'Lewis', '2023-01-02', 'Hamilton', 'unique_6'), (7, 3, 1, 1, 'default1', '2023-01-02', 'Hamilton', 'unique_7');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 7, 6, 2, 3, NULL, 0, 1, 'default1', 0, 0.0, 0, 'default2', 1, 1, NULL, 'default2', 'Lewis'), (0, 0, 4, 3, 3, 1, 0, 1, 'default2', 1, 1.0, 1, 'default1', 0, NULL, NULL, 'Hamilton', 'Lewis'), (2, 6, 4, 2, 3, 0, 1, 1, 'Lewis', 1, 1.0, 1, 'Hamilton', 1, 0, 0, 'Hamilton', 'Hamilton'), (3, 0, 4, 0, 1, 0, 0, 0, 'Hamilton', 1, 1.0, 1, 'Lewis', 0, 0, 0, 'Lewis', NULL), (4, 0, 10, 5, 1, NULL, 1, 1, 'Lewis', 1, 0.0, 0, 'Lewis', NULL, 1, 0, 'default1', 'Lewis'), (5, 3, 3, 2, 0, 0, 0, NULL, 'Hamilton', 1, 1.0, 0, 'default1', NULL, 0, 0, 'default2', 'Hamilton'), (6, 1, 7, 6, 2, NULL, 0, 1, 'default1', 0, 1.0, 0, 'Hamilton', 1, 0, NULL, 'Hamilton', 'default1'), (7, 6, 1, 1, 3, 0, 0, NULL, 'Hamilton', 0, 0.0, 1, 'Hamilton', 1, 1, NULL, 'default2', 'Lewis'), (8, 4, 6, 0, 3, NULL, 1, 0, 'Lewis', 0, 0.0, 0, 'default2', 1, 1, NULL, 'Hamilton', 'default1'), (9, 0, 0, 6, 2, NULL, 0, 0, 'Lewis', 1, 0.0, 1, NULL, NULL, NULL, 1, 'default2', 'Hamilton'), (10, 5, 5, 1, 1, NULL, 1, NULL, 'Lewis', 1, 1.0, 1, 'Lewis', NULL, 1, 0, 'Lewis', 'default1');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (1, 10, 0, 0, 'Lewis', 1), (4, 5, 0, 1, 'Lewis', NULL), (3, 7, 1, 0, 'Lewis', NULL), (0, 8, 0, 1, 'default1', 0), (4, 3, 0, 0, 'Hamilton', 0), (2, 3, 1, 0, 'Lewis', NULL), (5, 2, 0, 0, 'Lewis', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.time FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton';

/*
Gold Result:
('Lewis',)
*/

-- Prediction Query
SELECT T2.fastestLapTime FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T1.forename = 'Lewis' AND T1.surname = 'Hamilton';

/*
Prediction Result:
('Hamilton',)
*/