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
-- Tests strict inequality boundaries (raceId = 50, 51, 99, 100), statusId variations (1, 2, 3), and time NULL vs NOT NULL.
INSERT INTO seasons (year, url) VALUES (2020, 'http://example.com/s2020');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://example.com/c1');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'con1', 'Constructor 1', 'http://example.com/con1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'John', 'Doe', 'http://example.com/d1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Disqualified');
INSERT INTO status (statusId, status) VALUES (3, 'Accident');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (50, 2020, 1, 1, 'R50', '2020-01-01', '12:00:00', 'http://example.com/r50');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (51, 2020, 2, 1, 'R51', '2020-01-02', '12:00:00', 'http://example.com/r51');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (75, 2020, 3, 1, 'R75', '2020-01-03', '12:00:00', 'http://example.com/r75');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (99, 2020, 4, 1, 'R99', '2020-01-04', '12:00:00', 'http://example.com/r99');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (100, 2020, 5, 1, 'R100', '2020-01-05', '12:00:00', 'http://example.com/r100');
-- Boundary violations for raceId (50 and 100) with matching statusId and non-null time
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (1, 50, 1, 1, 2, '1:30:00');
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (2, 100, 1, 1, 2, '1:30:00');
-- Inside boundaries (51, 75, 99) with matching statusId=2 and non-null time (including identical times to kill COUNT(DISTINCT time))
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (3, 51, 1, 1, 2, '1:30:00');
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (4, 75, 1, 1, 2, '1:30:00');
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (5, 99, 1, 1, 2, '1:31:00');
-- Inside boundaries with matching statusId=2, but time IS NULL (kills COUNT(*) vs COUNT(time))
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (6, 51, 1, 1, 2, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (7, 75, 1, 1, 2, NULL);
-- Inside boundaries with non-matching statusId (1 and 3)
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (8, 75, 1, 1, 1, '1:30:00');
INSERT INTO results (resultId, raceId, driverId, constructorId, statusId, time) VALUES (9, 75, 1, 1, 3, '1:30:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(NOT time IS NULL, 1, 0)) FROM results WHERE statusId = 2 AND raceID < 100 AND raceId > 50;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(T1.raceId) FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE T1.raceId BETWEEN 50 AND 100 AND T2.statusId = 2 AND NOT T2.time IS NULL;

/*
Prediction Result:
(5,)
*/