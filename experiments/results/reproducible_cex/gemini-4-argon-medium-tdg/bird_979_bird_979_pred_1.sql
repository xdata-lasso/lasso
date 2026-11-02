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
-- Distinguishes COUNT(NOT time IS NULL) [which equals COUNT(*)] from COUNT(time) or SUM(NOT time IS NULL).
-- Also differentiates INNER JOIN with races vs querying results directly, and tests ASC vs DESC ordering.
INSERT INTO seasons (year, url) VALUES (2020, 'http://example.com/s1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://example.com/c1');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'con1', 'Constructor 1', 'http://example.com/con1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'John', 'Doe', 'http://example.com/d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'Jane', 'Doe', 'http://example.com/d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'Jim', 'Beam', 'http://example.com/d3');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2020, 1, 1, 'Race 10', '2020-01-01', '12:00:00', 'http://example.com/r10');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (20, 2020, 2, 1, 'Race 20', '2020-01-08', NULL, 'http://example.com/r20');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (30, 2020, 3, 1, 'Race 30', '2020-01-15', '14:00:00', 'http://example.com/r30');
-- Race 10: 3 total rows, 0 non-null times. COUNT(NOT time IS NULL) = 3, COUNT(time) = 0.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (1, 10, 1, 1, 1, 'R', 1, 0, 10, NULL, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (2, 10, 2, 1, 2, 'R', 2, 0, 10, NULL, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (3, 10, 3, 1, 3, 'R', 3, 0, 10, NULL, 1);
-- Race 20: 2 total rows, 2 non-null identical times. COUNT(NOT time IS NULL) = 2, COUNT(time) = 2, COUNT(DISTINCT time) = 1.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (4, 20, 1, 1, 1, '1', 1, 25, 50, '1:30:00', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (5, 20, 2, 1, 2, '2', 2, 18, 50, '1:30:00', 1);
-- Race 30: 1 total row, 1 non-null time.
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (6, 30, 1, 1, 1, '1', 1, 25, 50, '1:31:00', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT raceId FROM results GROUP BY raceId ORDER BY COUNT(NOT time IS NULL) DESC, raceId NULLS LAST LIMIT 1;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT "raceid" FROM "results" WHERE NOT "time" IS NULL GROUP BY "raceid" ORDER BY COUNT("raceid") DESC, "raceid" NULLS LAST LIMIT 1;

/*
Prediction Result:
(20,)
*/