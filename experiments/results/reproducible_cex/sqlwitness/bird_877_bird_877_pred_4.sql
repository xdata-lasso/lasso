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
INSERT INTO status (statusid, status) VALUES (2, 'default1'), (871, 'default2'), (1, 'default1'), (0, 'default2'), (872, 'default1'), (873, 'default1'), (3, 'default2'), (4, 'default2');
INSERT INTO seasons (year, url) VALUES (872, 'default1'), (873, 'default2'), (0, 'unique_2'), (2, 'unique_3'), (871, 'unique_4'), (1, 'unique_5'), (3, 'unique_6'), (4, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 871, 'default2', 'default2', 'default2', NULL, NULL, 'default1'), (872, 'default1', 2, 'default2', 'default2', 'default2', '2023-01-01', NULL, 'default2'), (873, 'default1', NULL, 'default2', 'default2', 'default1', '2023-01-02', 'default1', 'unique_2'), (1, 'default2', 872, 'default2', 'default1', 'default1', NULL, 'default2', 'unique_3'), (871, 'default2', 2, 'default1', 'default2', 'default1', '2023-01-02', 'default2', 'unique_4'), (2, 'default2', NULL, NULL, 'default1', 'default1', '2023-01-01', NULL, 'unique_5'), (3, 'default2', 0, 'default1', 'default2', 'default2', '2023-01-01', 'default1', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (873, 'default1', 'default2', 'default1', 'default1'), (872, 'default2', 'default1', NULL, 'default1'), (2, 'default1', 'unique_2', 'default1', 'default1'), (871, 'default2', 'unique_3', 'default1', 'default2'), (1, 'default2', 'unique_4', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default2', 'default1', 'default1', 0.0, NULL, 1, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 0, 872, 'default2', '2023-01-01', NULL, 'default1'), (872, 0, 0, 0, 'default2', '2023-01-01', 'default1', NULL), (0, 872, 0, 2, 'default1', '2023-01-01', NULL, 'default2'), (873, 872, 0, 1, 'default2', '2023-01-01', NULL, 'unique_3'), (871, 4, 0, 872, 'default2', '2023-01-02', NULL, 'unique_4');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (873, 872, 1, 871, 1, 1, 2, 873, 'default1', 2, 2.0, 872, NULL, NULL, 1, 871, 'default2', 'default1'), (1, 872, 3, 871, 3, 2, 1, 873, 'default1', 873, 873.0, 0, NULL, NULL, NULL, NULL, 'default1', NULL), (0, 0, 871, 2, 871, 0, 872, NULL, 'default1', 873, 872.0, 872, NULL, 873, 0, 0, NULL, NULL), (872, 872, 3, 1, 2, 872, 871, 0, 'default1', 2, 872.0, 871, NULL, 871, 1, NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 872 AND NOT T2.time IS NULL ORDER BY T1.dob DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 872 ORDER BY T1.dob DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2', 'default2')
*/