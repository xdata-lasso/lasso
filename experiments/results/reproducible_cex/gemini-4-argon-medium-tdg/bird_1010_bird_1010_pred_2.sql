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
-- 1. Partial matches on forename ('Lewis' with different surname) and surname ('Hamilton' with different forename) to kill OR vs AND mutations and missing conjuncts.
-- 2. Duplicate 'time' values for 'Lewis Hamilton' across different laps/races to kill SELECT DISTINCT mutations.
-- 3. Disjoint 'time' values in pitStops and results to kill wrong table selection mutations.
-- 4. Matching vs non-matching driverId to kill cross-join or wrong join key (e.g., raceId = driverId) mutations.
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'silverstone', 'Silverstone', 'http://url.com/c1');
INSERT INTO seasons (year, url) VALUES (2021, 'http://url.com/s2021');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2021, 1, 1, 'British GP', '2021-07-18', '14:00:00', 'http://url.com/r10');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (20, 2021, 2, 1, 'Hungarian GP', '2021-08-01', '14:00:00', 'http://url.com/r20');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://url.com/d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'lewis_other', 'Lewis', 'Clark', 'http://url.com/d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'other_hamilton', 'Duncan', 'Hamilton', 'http://url.com/d3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'alonso', 'Fernando', 'Alonso', 'http://url.com/d10');
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 1, 1, 1, '1:29.111', 89111);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 1, 2, 1, '1:29.111', 89111);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (20, 1, 1, 2, '1:18.222', 78222);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 2, 1, 3, '1:30.333', 90333);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 3, 1, 4, '1:31.444', 91444);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 10, 1, 5, '1:32.555', 92555);
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mercedes', 'Mercedes', 'http://url.com/con1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (10, 1, 1, 15, '14:30:00', '24.111', 24111);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (1, 10, 1, 1, 1, '1', 1, 25.0, 52, '1:25:00.000', 5100000, '1:27.000', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.time FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton';

/*
Gold Result:
('1:29.111',)
('1:29.111',)
('1:18.222',)
*/

-- Prediction Query
SELECT MIN("laptimes"."time") FROM "laptimes" INNER JOIN "drivers" ON "laptimes"."driverid" = "drivers"."driverid" WHERE "drivers"."forename" = 'Lewis' AND "drivers"."surname" = 'Hamilton';

/*
Prediction Result:
('1:18.222',)
*/