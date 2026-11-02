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
INSERT INTO status (statusid, status) VALUES (0, 'default1'), (1, 'default2'), (18, 'default2');
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'default1'), (18, 'unique_2'), (17, 'unique_3');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 18, NULL, 'default1', 'default2', NULL, NULL, 'default2'), (18, 'default1', 19, NULL, 'default2', 'default2', NULL, NULL, 'default1'), (17, 'default2', 1, 'default2', 'default2', 'default2', '2023-01-01', NULL, 'unique_2');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (19, 'default1', 'default1', 'default2', 'default1'), (18, 'default2', 'default2', 'default2', 'default2'), (0, 'default2', 'unique_2', 'default2', 'default2'), (17, 'default2', 'unique_3', 'default2', 'default2'), (1, 'default1', 'unique_4', 'default1', 'default1'), (2, 'default1', 'unique_5', 'default2', 'default1'), (3, 'default2', 'unique_6', NULL, 'default2'), (4, 'default2', 'unique_7', 'default2', 'default1'), (5, 'default1', 'unique_8', 'default1', 'default2'), (6, 'default2', 'unique_9', NULL, 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'default1', 'default1', NULL, 17.0, NULL, NULL, 'default2'), (19, 'default2', 'default2', NULL, NULL, NULL, 1.0, 18, 'default1'), (1, 'default1', 'default1', 'default2', 'default1', 17.0, 0.0, 18, 'unique_2'), (17, 'default1', 'default1', 'default2', 'default2', NULL, 19.0, 18, 'unique_3'), (18, 'default1', 'default2', NULL, NULL, 17.0, 0.0, 1, 'unique_4'), (2, 'default1', 'default2', 'default2', 'default1', 1.0, 18.0, NULL, 'unique_5'), (3, 'default2', 'default2', NULL, 'default2', NULL, 17.0, 18, 'unique_6'), (4, 'default2', 'default2', 'default1', 'default2', 1.0, 1.0, 1, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 17, 19, 1, 'default2', '2023-01-02', NULL, 'default1'), (0, 18, 18, 1, 'default1', '2023-01-01', 'default2', 'default2'), (17, 17, 0, 18, 'default2', '2023-01-01', NULL, NULL), (18, 1, 3, 19, 'default1', '2023-01-01', 'default2', 'unique_3');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 17, 18, 2, 0, 1, 1, 19, 'default1', 0, 19.0, 19, 'default2', 0, 1, NULL, 'default1', 'default2'), (1, 18, 18, 1, 1, 1, 18, 1, 'default2', 19, 18.0, 17, NULL, 17, 0, 18, NULL, 'default2'), (19, 1, 0, 2, 0, 18, 1, 17, 'default1', 17, 19.0, 19, 'default1', 19, 19, 0, 'default1', NULL), (17, 17, 17, 17, 0, 1, 0, 17, 'default2', 17, 19.0, 17, 'default2', 19, NULL, 18, NULL, 'default1'), (18, 0, 0, 2, 1, 0, 1, NULL, 'default1', 0, 18.0, 17, 'default1', 18, 19, 1, NULL, 'default1'), (2, 1, 18, 2, 1, 0, 0, 17, 'default2', 18, 19.0, 1, NULL, 17, 17, 0, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(driverId) FROM driverStandings WHERE raceId = 18;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT driverId) FROM results WHERE raceId = 18;

/*
Prediction Result:
(1,)
*/