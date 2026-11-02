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
INSERT INTO seasons (year, url) VALUES (0, 'Lewis'), (2, 'default1'), (1, 'Hamilton'), (3, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'Lewis', 0, 'Hamilton', 'default2', 'Lewis', '2023-01-02', NULL, 'Hamilton'), (0, 'Lewis', 2, NULL, 'Hamilton', 'Hamilton', '2023-01-02', 'default2', 'Lewis'), (1, 'default1', 2, 'default2', 'Lewis', 'default1', '2023-01-01', 'Lewis', 'default2'), (3, 'default1', NULL, 'default2', 'default2', 'Lewis', NULL, 'default2', 'default1'), (4, 'Lewis', 1, 'default1', 'default1', 'default2', '2023-01-01', 'Lewis', 'unique_4'), (5, 'default1', 0, 'default2', 'Lewis', 'default1', '2023-01-01', 'default1', 'unique_5'), (6, 'default1', NULL, 'Hamilton', 'Lewis', 'Hamilton', '2023-01-01', NULL, 'unique_6'), (7, 'default2', 1, 'default2', 'default1', 'default2', NULL, 'default1', 'unique_7'), (8, 'default1', NULL, 'default2', 'Hamilton', 'default1', NULL, NULL, 'unique_8'), (9, 'Hamilton', NULL, 'Lewis', 'Lewis', 'Hamilton', '2023-01-01', NULL, 'unique_9'), (10, 'default1', 0, 'default1', 'default1', 'Lewis', NULL, NULL, 'unique_10'), (11, 'default2', 0, 'Lewis', 'default2', 'default1', '2023-01-01', 'Hamilton', 'unique_11');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Hamilton', 'Lewis', NULL, 'Hamilton', 1.0, 1.0, 0, 'default1'), (2, 'Lewis', 'default1', 'default2', 'default2', NULL, NULL, 0, 'Hamilton'), (1, 'default2', 'Lewis', 'default2', 'Lewis', 2.0, NULL, NULL, 'Lewis'), (3, 'default1', 'Hamilton', 'Lewis', NULL, NULL, NULL, 2, 'default2'), (4, 'Hamilton', 'Hamilton', 'Hamilton', 'default1', 1.0, 2.0, 2, 'unique_4'), (5, 'default2', 'default1', 'default2', 'Lewis', 1.0, 1.0, 2, 'unique_5'), (6, 'default1', 'default1', 'Hamilton', 'Hamilton', 0.0, NULL, 2, 'unique_6'), (7, 'default1', 'default2', 'Hamilton', NULL, NULL, NULL, 0, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 1, 1, 'default2', '2023-01-02', 'default2', NULL), (0, 0, 6, 0, 'Lewis', '2023-01-02', 'Hamilton', 'default2'), (2, 2, 7, 2, 'Hamilton', '2023-01-01', 'default1', 'Hamilton'), (3, 2, 3, 2, 'Hamilton', '2023-01-01', 'default2', 'Lewis'), (4, 3, 6, 0, 'default2', '2023-01-01', 'Hamilton', 'default1'), (5, 1, 2, 2, 'Lewis', '2023-01-02', 'default1', 'unique_5'), (6, 3, 1, 2, 'Hamilton', '2023-01-02', 'Lewis', 'unique_6'), (7, 0, 2, 1, 'default1', '2023-01-01', 'default1', 'unique_7'), (8, 2, 2, 2, 'Hamilton', '2023-01-01', 'default2', 'unique_8');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (5, 2, 2, NULL, 'default1', NULL), (5, 7, 0, 0, 'default1', 1), (7, 10, 2, 2, 'default2', 2), (2, 0, 0, NULL, NULL, 0), (8, 3, 1, 2, 'Lewis', 1), (2, 10, 1, 0, 'Hamilton', NULL), (1, 8, 0, 2, 'default2', 2), (5, 6, 1, 0, 'default2', 2), (6, 2, 2, 0, 'Hamilton', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT circuits.name FROM drivers INNER JOIN laptimes ON drivers.driverId = laptimes.driverId INNER JOIN races ON laptimes.raceId = races.raceId INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE drivers.forename = 'Lewis' ORDER BY laptimes.time ASC, drivers.driverid NULLS LAST, laptimes.raceid NULLS LAST, laptimes.driverid NULLS LAST, laptimes.lap NULLS LAST, races.raceid NULLS LAST, circuits.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/