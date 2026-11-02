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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://c1');
INSERT INTO seasons (year, url) VALUES (2023, 'http://s2023');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2023, 1, 1, 'Race 1', '2023-01-01', 'http://r10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 2023, 2, 1, 'Race 2', '2023-02-01', 'http://r20');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'F1', 'S1', 'http://d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'F2', 'S2', 'http://d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'F3', 'S3', 'http://d3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'd4', 'F4', 'S4', 'http://d4');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'd5', 'F5', 'S5', 'http://d5');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'd6', 'F6', 'S6', 'http://d6');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (7, 'd7', 'F7', 'S7', 'http://d7');
-- Lap 2 with faster time (tests WHERE lap = 1 vs no filter or lap != 1)
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 7, 2, 1, '0:50.000', 50000);
-- Lap 1 records:
-- Discrepancy between time (TEXT), milliseconds (INT), and position (INT)
-- Also tests DISTINCT (driver 1 appears twice in top 5 across different races)
-- Also tests LIMIT 5 (7 total lap=1 rows, only top 5 should return)
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 1, 1, 6, '1:10.000', 90000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (20, 1, 1, 5, '1:11.000', 85000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 2, 1, 4, '1:12.000', 80000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 3, 1, 3, '1:13.000', 75000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 4, 1, 2, '1:14.000', 70000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 5, 1, 1, '1:15.000', 65000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 6, 1, 7, '1:16.000', 95000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY time, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Gold Result:
(1,)
(1,)
(2,)
(3,)
(4,)
*/

-- Prediction Query
SELECT t1.driverid FROM laptimes AS t1 INNER JOIN (SELECT driverid, MIN(time) AS min_time FROM laptimes WHERE lap = 1 GROUP BY driverid) AS t2 ON t1.driverid = t2.driverid AND t1.time = t2.min_time WHERE t1.lap = 1 ORDER BY t2.min_time ASC, t1.raceid NULLS LAST, t1.driverid NULLS LAST, t1.lap NULLS LAST LIMIT 5;

/*
Prediction Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/