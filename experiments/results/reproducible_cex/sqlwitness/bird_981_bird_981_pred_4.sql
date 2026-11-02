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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (2, 'default1'), (1, 'unique_2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default2', 0, NULL, 'default1', 'default2', '2023-01-01', 'default2', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default1', 'default1', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default1', 'default2', 'default2', 0.0, NULL, NULL, 'default2'), (2, 'default1', 'default2', 'default1', 'default2', 2.0, 2.0, 0, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 0, 0, 0, 'default2', '2023-01-02', 'default2', NULL), (1, 2, 2, 0, 'default1', '2023-01-01', 'default2', 'default1'), (0, 1, 2, 0, 'default1', '2023-01-01', 'default1', 'default2'), (3, 2, 2, 1, 'default2', '2023-01-01', 'default1', 'unique_3'), (4, 2, 2, 0, 'default1', '2023-01-01', NULL, 'unique_4'), (5, 1, 0, 1, 'default2', '2023-01-01', 'default1', 'unique_5'), (6, 0, 0, 0, 'default2', '2023-01-02', 'default1', 'unique_6'), (7, 1, 2, 2, 'default1', '2023-01-01', 'default1', 'unique_7'), (8, 0, 2, 1, 'default2', '2023-01-01', 'default2', 'unique_8'), (9, 1, 0, 0, 'default1', '2023-01-01', NULL, 'unique_9'), (10, 2, 2, 0, 'default2', '2023-01-02', NULL, 'unique_10'), (11, 2, 0, 0, 'default1', '2023-01-02', NULL, 'unique_11');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (2, 1, 2, 1, 0, 0, 'default1', 'default1', 'default2'), (1, 9, 2, 1, 2, 1, 'default1', 'default2', 'default1'), (0, 2, 2, 1, 2, 1, 'default1', 'default1', 'default1'), (3, 10, 2, 1, 2, NULL, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.year, T3.name, T3.date, T3.time FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T1.driverId = (SELECT driverId FROM drivers ORDER BY dob DESC, drivers.driverid NULLS LAST LIMIT 1) ORDER BY T3.date ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(1, 'default1', '2023-01-01', None)
*/

-- Prediction Query
SELECT races.year, races.name, races.date, races.time FROM races JOIN qualifying ON races.raceId = qualifying.raceId JOIN drivers ON qualifying.driverId = drivers.driverId WHERE drivers.dob = (SELECT MAX(dob) FROM drivers) AND races.date = (SELECT MIN(races.date) FROM races JOIN qualifying ON races.raceId = qualifying.raceId JOIN drivers ON qualifying.driverId = drivers.driverId WHERE drivers.dob = (SELECT MAX(dob) FROM drivers)) LIMIT 1;

/*
Prediction Result:
(1, 'default1', '2023-01-01', None)
*/