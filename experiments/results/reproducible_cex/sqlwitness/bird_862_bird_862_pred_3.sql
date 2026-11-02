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
INSERT INTO status (statusid, status) VALUES (2008, 'Bahrain Grand Prix');
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (2006, 'default2'), (2007, 'Bahrain Grand Prix');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2007, 'Bahrain Grand Prix', 1, 'Finished', 'default2', 'default2', '2023-01-01', NULL, 'Bahrain Grand Prix'), (2008, 'default2', 1, 'default1', 'default1', 'Finished', '2023-01-01', 'default2', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'default2', 'default2', 'default1'), (2007, 'Finished', 'default1', NULL, 'Finished'), (2008, 'default2', 'Bahrain Grand Prix', 'default2', 'Bahrain Grand Prix'), (2006, 'Bahrain Grand Prix', 'Finished', NULL, 'default2'), (0, 'Finished', 'unique_4', 'Finished', 'Bahrain Grand Prix'), (2, 'Finished', 'unique_5', NULL, 'Finished');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2008, 'Finished', 'Finished', 'Bahrain Grand Prix', 'default1', 2006.0, 0.0, NULL, 'Finished'), (0, 'default1', 'default1', 'Bahrain Grand Prix', 'default1', 2007.0, 0.0, 2008, 'default2'), (2007, 'Finished', 'default1', 'default2', NULL, 2008.0, 2006.0, 2008, 'Bahrain Grand Prix'), (2006, 'default1', 'default2', 'default2', 'Bahrain Grand Prix', 2006.0, 0.0, NULL, 'default1'), (1, 'default2', 'Finished', 'Finished', 'Finished', 2006.0, 2008.0, 0, 'unique_4'), (2, 'default1', 'default1', 'default2', 'Bahrain Grand Prix', 0.0, 0.0, 0, 'unique_5'), (3, 'Finished', 'default2', 'Bahrain Grand Prix', 'Bahrain Grand Prix', 1.0, 2006.0, 2006, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 1, 2007, 'Finished', '2023-01-01', 'Bahrain Grand Prix', NULL), (0, 0, 2007, 0, 'default1', '2023-01-01', 'Finished', 'default2'), (2007, 2007, 2, 2006, 'Bahrain Grand Prix', '2023-01-02', NULL, 'default1'), (2006, 0, 3, 1, 'Finished', '2023-01-01', 'Finished', 'Finished'), (2008, 2007, 3, 2006, 'default2', '2023-01-02', 'Bahrain Grand Prix', 'Bahrain Grand Prix'), (2, 0, 2006, 2007, 'Finished', '2023-01-02', 'Finished', 'unique_5'), (3, 2007, 2007, 2008, 'default2', '2023-01-01', 'Bahrain Grand Prix', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 2007, 2007, 2008, 2008, 1, 2007, 2007, 'Bahrain Grand Prix', 1, 0.0, 2008, 'default2', 0, 2008, 2007, NULL, 'Bahrain Grand Prix'), (2007, 2007, 2008, 2, 2008, 0, 2008, 2007, 'default2', 2007, 2007.0, 2006, 'Finished', 2007, NULL, NULL, 'default1', 'Finished'), (2006, 1, 2007, 0, 2008, 1, 2006, 1, 'default1', 2006, 2007.0, 2006, 'Finished', 2007, 2008, NULL, 'default2', 'default1'), (2008, 2, 2008, 2, 2008, 1, 2006, NULL, 'default2', 2006, 1.0, 0, 'default2', 2006, NULL, NULL, 'Bahrain Grand Prix', 'default2'), (0, 2008, 2007, 2006, 2008, NULL, 2006, 2008, 'Finished', 2007, 1.0, 0, 'default1', 2006, 2007, NULL, NULL, 'default1'), (2, 2006, 2007, 2008, 2008, 2008, 2008, 2007, 'default2', 2006, 2007.0, 1, NULL, 0, 0, 1, 'default2', 'Bahrain Grand Prix'), (3, 2007, 2008, 0, 2008, 1, 2008, 1, 'default1', 1, 1.0, 1, 'default1', 2007, 2007, 1, NULL, NULL), (4, 1, 2008, 2008, 2008, 2007, 2008, 2007, 'default1', 2006, 2006.0, 0, 'default2', 1, NULL, 2006, 'Bahrain Grand Prix', 'default1'), (5, 2006, 2008, 2007, 2008, NULL, 2008, 2007, 'Bahrain Grand Prix', 2008, 2007.0, 2007, 'default2', 2006, 0, 2006, 'default1', 'default1'), (6, 1, 2007, 2008, 2008, 2007, 2008, 0, 'default1', 1, 2006.0, 2006, 'Bahrain Grand Prix', NULL, 2007, 1, NULL, NULL), (7, 0, 2008, 1, 2008, NULL, 1, NULL, 'default2', 2008, 2008.0, 0, 'Bahrain Grand Prix', 0, 2007, NULL, 'Bahrain Grand Prix', NULL), (8, 2007, 2007, 2006, 2008, 2006, 1, 2007, 'default1', 2008, 2006.0, 0, 'Finished', NULL, 1, 2008, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.year = 2007 AND T1.name = 'Bahrain Grand Prix' AND T2.time IS NULL;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.raceId) FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T2.statusId = T3.statusId WHERE T1.name = 'Bahrain Grand Prix' AND T1.year = 2007 AND T3.status <> 'Finished';

/*
Prediction Result:
(4,)
*/