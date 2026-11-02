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
-- DATASET 1
-- Tests:
-- 1. WHERE lap = 1 vs lap != 1 (e.g. lap = 0, lap = 2)
-- 2. ORDER BY time (TEXT) vs milliseconds (INTEGER) vs position (INTEGER)
-- 3. Duplicate driverId retention (SELECT vs SELECT DISTINCT)
-- 4. LIMIT 5 boundary (7 qualifying rows for lap = 1)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://c1');
INSERT INTO seasons (year, url) VALUES (2020, 'http://s2020');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2020, 1, 1, 'R1', '2020-01-01', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2020, 2, 1, 'R2', '2020-01-08', 'http://r2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'd10', 'F10', 'S10', 'http://d10');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (20, 'd20', 'F20', 'S20', 'http://d20');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (30, 'd30', 'F30', 'S30', 'http://d30');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (40, 'd40', 'F40', 'S40', 'http://d40');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (50, 'd50', 'F50', 'S50', 'http://d50');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (60, 'd60', 'F60', 'S60', 'http://d60');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (70, 'd70', 'F70', 'S70', 'http://d70');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (80, 'd80', 'F80', 'S80', 'http://d80');
-- Non-lap 1 rows with very small time/milliseconds to catch missing/wrong WHERE clause (e.g., lap <= 1, lap >= 1, no WHERE)
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 70, 0, 1, '0:10.000', 10000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 80, 2, 1, '0:11.000', 11000);
-- Lap 1 rows:
-- Lexicographical order of time: '1:15.000' < '1:20.000' < '1:25.000' < '1:30.000' < '2:00.000' < '8:00.000' < '9:00.000'
-- Notice milliseconds and position are inverted relative to time to kill mutants sorting by milliseconds, position, or DESC.
-- Driver 10 appears twice in top 5 (in race 1 and race 2) to kill SELECT DISTINCT mutants.
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 10, 1, 7, '1:15.000', 90000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 10, 1, 6, '1:20.000', 85000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 20, 1, 5, '1:25.000', 80000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 30, 1, 4, '1:30.000', 75000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 40, 1, 3, '2:00.000', 70000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 50, 1, 2, '8:00.000', 65000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 60, 1, 1, '9:00.000', 60000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY time, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Gold Result:
(10,)
(10,)
(20,)
(30,)
(40,)
*/

-- Prediction Query
SELECT driverId FROM lapTimes WHERE lap = 1 AND NOT milliseconds IS NULL ORDER BY milliseconds ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Prediction Result:
(60,)
(50,)
(40,)
(30,)
(20,)
*/