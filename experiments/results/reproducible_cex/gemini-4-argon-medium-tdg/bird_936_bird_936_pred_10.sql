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
-- Core predicate and join coverage: Tests individual WHERE conditions (name, year, forename, surname), column selection (fastestLap vs rank/laps/grid/position), and table confusion (circuits.name vs races.name).
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'http://c1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'fake_aus', 'Australian Grand Prix', 'http://c2');
INSERT INTO seasons (year, url) VALUES (2007, 'http://s2007');
INSERT INTO seasons (year, url) VALUES (2008, 'http://s2008');
INSERT INTO seasons (year, url) VALUES (2009, 'http://s2009');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://con1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd_hamilton', 'Duncan', 'Hamilton', 'http://d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'lewis_other', 'Lewis', 'Smith', 'http://d3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'alonso', 'Fernando', 'Alonso', 'http://d4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2008, 1, 1, 'Australian Grand Prix', '2008-03-16', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2007, 1, 1, 'Australian Grand Prix', '2007-03-18', 'http://r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2009, 1, 1, 'Australian Grand Prix', '2009-03-29', 'http://r3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2008, 2, 2, 'Malaysian Grand Prix', '2008-03-23', 'http://r4');
-- Target match: Lewis Hamilton in 2008 Australian Grand Prix (fastestLap = 39)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 1, 1, 22, 1, 1, '1', 1, 10.0, 58, 39, 2, '1:27.452', '218.300', 1);
-- Wrong year (2007)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 2, 1, 1, 2, 4, 3, '3', 3, 6.0, 58, 41, 3, '1:26.351', '220.000', 1);
-- Wrong year (2009)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (3, 3, 1, 1, 1, 18, 4, '4', 4, 5.0, 58, 42, 4, '1:29.000', '215.000', 1);
-- Wrong race name (Malaysian GP, even though circuit is named 'Australian Grand Prix')
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (4, 4, 1, 1, 22, 9, 5, '5', 5, 4.0, 56, 43, 5, '1:35.000', '205.000', 1);
-- Wrong forename (Duncan Hamilton in 2008 Australian GP)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (5, 1, 2, 1, 23, 2, 2, '2', 2, 8.0, 58, 44, 6, '1:28.000', '217.000', 1);
-- Wrong surname (Lewis Smith in 2008 Australian GP)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (6, 1, 3, 1, 24, 3, 3, '3', 3, 6.0, 58, 45, 7, '1:28.500', '216.000', 1);
-- Completely different driver in 2008 Australian GP
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (7, 1, 4, 1, 5, 11, 4, '4', 4, 5.0, 58, 46, 1, '1:27.000', '219.000', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.fastestLap FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.name = 'Australian Grand Prix' AND T2.year = 2008 AND T3.forename = 'Lewis' AND T3.surname = 'Hamilton';

/*
Gold Result:
(39,)
*/

-- Prediction Query
SELECT r.fastestLapTime FROM results AS r JOIN races AS ra ON r.raceId = ra.raceId JOIN drivers AS d ON r.driverId = d.driverId WHERE ra.name = 'Australian Grand Prix' AND ra.year = 2008 AND d.forename = 'Lewis' AND d.surname = 'Hamilton';

/*
Prediction Result:
('1:27.452',)
*/