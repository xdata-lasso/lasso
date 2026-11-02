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
INSERT INTO status (statusid, status) VALUES (0, 'default1'), (1, 'Italian'), (2, 'default2'), (3, 'Italian'), (4, 'default2'), (5, 'default2'), (6, 'default2'), (7, 'Italian'), (8, 'default1'), (9, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (0, 'Italian'), (2, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Italian', 1, 'default2', 'default1', 'default1', '2023-01-02', NULL, 'Italian'), (0, 'default2', NULL, 'default2', 'default1', 'Italian', '2023-01-01', 'Italian', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default2', 'default2', NULL, 'Italian');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'Italian', 'default2', 'default2', 1.0, 0.0, 0, 'Italian'), (1, 'default1', 'default2', 'Italian', NULL, 0.0, 1.0, NULL, 'default2'), (2, 'Italian', 'Italian', 'default2', NULL, 1.0, 1.0, 1, 'default1'), (3, 'default2', 'Italian', 'Italian', NULL, 0.0, NULL, 0, 'unique_3'), (4, 'Italian', 'default2', 'Italian', 'Italian', 0.0, 1.0, NULL, 'unique_4'), (5, 'default1', 'default2', 'default1', 'default2', NULL, 0.0, NULL, 'unique_5'), (6, 'Italian', 'default2', 'default2', 'default2', 1.0, 0.0, NULL, 'unique_6'), (7, 'default1', 'default1', 'default2', 'default2', NULL, 1.0, 1, 'unique_7'), (8, 'default1', 'default2', 'default2', 'default1', 0.0, NULL, 1, 'unique_8'), (9, 'Italian', 'default2', 'Italian', NULL, 0.0, NULL, 0, 'unique_9'), (10, 'Italian', 'default2', NULL, NULL, NULL, 0.0, NULL, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 5, 1, 'default1', '2023-01-02', 'Italian', 'default2'), (0, 1, 2, 0, 'default2', '2023-01-02', NULL, NULL), (2, 0, 10, 0, 'Italian', '2023-01-01', 'default1', 'Italian'), (3, 2, 2, 1, 'default1', '2023-01-02', 'Italian', 'default1'), (4, 1, 5, 1, 'Italian', '2023-01-01', 'default2', 'unique_4'), (5, 2, 5, 0, 'default1', '2023-01-01', 'default2', 'unique_5');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 1, 0, 0, 3, NULL, 0, NULL, 'Italian', 0, 1.0, 0, 'Italian', NULL, NULL, 0, NULL, 'Italian'), (1, 3, 1, 0, 0, 1, 1, 0, 'default2', 1, 1.0, 1, 'Italian', NULL, 1, 0, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'Italian' AND T1.time IS NULL;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'Italian' AND T2.milliseconds IS NULL;

/*
Prediction Result:
(1,)
*/