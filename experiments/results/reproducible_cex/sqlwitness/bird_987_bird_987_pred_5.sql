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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (9, 'United States Grand Prix'), (11, 'United States Grand Prix'), (12, '.'), (0, ':'), (2007, 'default1'), (2, 'default1'), (2006, 'default1'), (10, '.'), (2005, 'United States GrAND Prix'), (3, 'United States Grand Prix'), (4, ':'), (5, ':'), (6, 'default1'), (7, 'default2'), (8, 'United States GrAND Prix'), (13, '.'), (14, ':'), (15, '.'), (16, 'default1'), (17, 'default1');
INSERT INTO seasons (year, url) VALUES (2006, 'United States Grand Prix'), (2007, 'default2'), (0, 'United States GrAND Prix'), (1, ':');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, ':', NULL, 'United States Grand Prix', 'United States Grand Prix', '.', '2023-01-01', 'default1', '.'), (11, 'default1', 11, NULL, 'default1', 'default1', NULL, NULL, ':'), (2007, 'default2', 10, ':', '.', 'default2', NULL, '.', 'United States Grand Prix'), (10, 'United States Grand Prix', 10, ':', 'United States GrAND Prix', ':', NULL, 'United States Grand Prix', 'default1'), (2, 'United States Grand Prix', 2005, 'United States Grand Prix', 'default1', 'United States GrAND Prix', NULL, 'United States GrAND Prix', 'default2'), (2006, 'United States Grand Prix', 2006, ':', 'default1', ':', '2023-01-01', 'United States GrAND Prix', 'United States GrAND Prix'), (0, 'default1', 10, 'default2', 'United States GrAND Prix', '.', '2023-01-02', ':', 'unique_6'), (9, ':', 2005, NULL, 'United States GrAND Prix', 'default2', '2023-01-01', 'United States Grand Prix', 'unique_7'), (2005, ':', 10, 'United States GrAND Prix', 'default2', ':', '2023-01-02', ':', 'unique_8'), (12, 'United States Grand Prix', 1, 'default2', 'United States GrAND Prix', '.', '2023-01-01', 'United States GrAND Prix', 'unique_9'), (3, 'United States Grand Prix', 2007, '.', 'United States GrAND Prix', 'default2', '2023-01-02', '.', 'unique_10'), (4, ':', 0, 'default2', ':', 'default1', '2023-01-02', 'United States Grand Prix', 'unique_11'), (5, ':', 2005, '.', 'United States GrAND Prix', 'United States Grand Prix', '2023-01-01', 'United States Grand Prix', 'unique_12'), (6, 'default2', 10, ':', 'default2', 'United States Grand Prix', '2023-01-02', 'default2', 'unique_13'), (7, 'United States GrAND Prix', 2006, 'default2', ':', 'default2', '2023-01-01', 'United States Grand Prix', 'unique_14'), (8, 'United States GrAND Prix', 10, '.', 'United States GrAND Prix', '.', '2023-01-01', 'United States GrAND Prix', 'unique_15'), (13, 'default1', 0, '.', 'United States Grand Prix', 'United States Grand Prix', '2023-01-01', 'default1', 'unique_16'), (14, 'United States GrAND Prix', 11, 'default1', 'United States GrAND Prix', ':', '2023-01-02', ':', 'unique_17');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, ':', '.', '.', 'default2'), (2007, '.', 'United States Grand Prix', NULL, 'United States GrAND Prix'), (10, 'United States GrAND Prix', 'default1', 'United States GrAND Prix', 'United States GrAND Prix'), (12, 'default1', 'default2', ':', 'United States Grand Prix'), (1, 'default2', ':', 'default2', 'United States GrAND Prix'), (2005, 'United States GrAND Prix', 'United States GrAND Prix', 'United States Grand Prix', '.'), (2, '.', 'unique_6', 'United States Grand Prix', 'default2'), (9, 'United States GrAND Prix', 'unique_7', NULL, ':'), (11, '.', 'unique_8', NULL, 'United States Grand Prix'), (2006, '.', 'unique_9', ':', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2006, 'United States GrAND Prix', 'United States GrAND Prix', 'United States Grand Prix', ':', 2006.0, 9.0, 9, ':'), (2, ':', '.', 'default2', '.', 2006.0, 2007.0, 10, 'United States GrAND Prix');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (10, 0, 2006, 12, 'default1', '2023-01-02', 'United States GrAND Prix', 'United States Grand Prix'), (2006, 2006, 2, 2005, 'United States Grand Prix', '2023-01-01', 'United States Grand Prix', 'United States GrAND Prix'), (1, 0, 2, 2006, 'United States GrAND Prix', '2023-01-01', 'United States GrAND Prix', ':');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 10, 1, 1, 2, 2, 9, 2006, 'United States Grand Prix', 2007, 9.0, 1, '.', 11, 2007, 12, 'United States Grand Prix', 'default1'), (2006, 10, 12, 2006, 4, 2007, 9, 0, '.', 2007, 2007.0, 2007, 'United States GrAND Prix', 2005, NULL, 2, 'United States GrAND Prix', '.'), (12, 10, 2, 12, 17, 9, 0, 11, 'United States Grand Prix', 12, 9.0, 2005, NULL, 0, 2007, 12, ':', ':'), (9, 1, 2005, 11, 11, 2, 0, 2006, ':', 11, 11.0, 11, 'default2', 9, 9, 2, 'United States GrAND Prix', 'United States GrAND Prix'), (11, 1, 9, 0, 9, 1, 2, 2005, 'default2', 2007, 2006.0, 2, 'United States GrAND Prix', 2005, 12, 1, ':', 'default1'), (0, 1, 2007, 2, 16, 12, 12, 1, ':', 2, 9.0, 10, ':', 0, 2007, NULL, '.', 'United States Grand Prix'), (2005, 10, 7, 9, 15, 2007, 2, NULL, '.', 9, 2005.0, 1, 'United States GrAND Prix', 2005, 1, 10, 'United States GrAND Prix', '.'), (1, 2006, 4, 10, 15, 9, 9, 2006, ':', 2007, 2006.0, 1, 'United States Grand Prix', 1, 9, 0, '.', 'default2'), (10, 1, 10, 9, 1, 12, 9, 2006, 'United States Grand Prix', 10, 1.0, 2006, '.', 11, 9, 2, NULL, 'United States Grand Prix'), (2007, 2006, 7, 2005, 0, 2005, 2006, 2, ':', 2, 2005.0, 12, 'default2', 11, 2006, 9, 'United States GrAND Prix', ':');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.fastestLapTime) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T1.rank < 11 AND T2.year = 2006 AND T2.name = 'United States GrAND Prix';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(AVG(REPLACE(SUBSTRING(fastestLapTime, 1, INSTR(fastestLapTime, '.') - 1), ':', '.') * 1.0) AS REAL) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.year = 2006 AND T2.name = 'United States Grand Prix' AND T1.rank <= 10;

/*
Prediction Result:
(0.0,)
*/