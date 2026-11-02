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
-- DATASET 2
-- String pattern boundary tests for T1.time LIKE '_:%:__.___'
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'sepang', 'Sepang', 'http://en.wikipedia.org/wiki/Sepang');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'red_bull', 'Red Bull', 'http://en.wikipedia.org/wiki/Red_Bull');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'vettel', 'Sebastian', 'Vettel', 'http://en.wikipedia.org/wiki/Vettel');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_F1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2009, 2, 1, 'Malaysian GP', '2009-04-05', '09:00:00', 'http://en.wikipedia.org/wiki/2009_Malaysian_GP');
-- 1. Valid match with multi-character middle segment (e.g. '1:23:45.678')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (1, 1, 1, 1, 1, '1', 1, 10, 56, '1:23:45.678', 10, 1);
-- 2. Valid match with empty middle '%' segment (e.g. '1::45.678' matches '_:%:__.___')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (2, 1, 1, 1, 2, '2', 2, 8, 56, '1::45.678', 20, 1);
-- 3. Invalid: Two characters before first colon (e.g. '12:34:56.789' -> fails leading '_')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (3, 1, 1, 1, 3, '3', 3, 6, 56, '12:34:56.789', 30, 1);
-- 4. Invalid: Only one character between second colon and dot (e.g. '1:23:4.567' -> fails '__')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (4, 1, 1, 1, 4, '4', 4, 5, 56, '1:23:4.567', 40, 1);
-- 5. Invalid: Only two characters after dot (e.g. '1:23:45.67' -> fails '___')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (5, 1, 1, 1, 5, '5', 5, 4, 56, '1:23:45.67', 50, 1);
-- 6. Invalid: Four characters after dot (e.g. '1:23:45.6789' -> fails '___')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (6, 1, 1, 1, 6, '6', 6, 3, 56, '1:23:45.6789', 60, 1);
-- 7. Invalid: Relative gap time format '+18.456' or '+1:23.456' (common F1 non-winner time format)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (7, 1, 1, 1, 7, '7', 7, 2, 56, '+1:23.456', 70, 1);
-- 8. Invalid: Missing second colon (e.g. '1:23.456' - typical fastestLapTime format, not race time)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (8, 1, 1, 1, 8, '8', 8, 1, 56, '1:23.456', 80, 1);
-- 9. Invalid: NULL time
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, fastestLap, statusId) VALUES (9, 1, 1, 1, 9, 'R', 9, 0, 12, NULL, 90, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.fastestLap FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.year = 2009 AND T1.time LIKE '_:%:__.___';

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT results.fastestlap FROM results INNER JOIN races ON results.raceid = races.raceid WHERE races.year = 2009 AND results.time LIKE '%:%:%.%';

/*
Prediction Result:
(10,)
(20,)
(30,)
(40,)
(50,)
(60,)
*/