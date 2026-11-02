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
-- Core Dataset: Tests exact matches vs single-condition violations (forename, surname, race name, year) and column confusion (positionOrder vs position vs grid vs rank vs driverStandings.position vs qualifying.position).
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Australian Grand Prix', 'http://circuit1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'sepang', 'Sepang International Circuit', 'http://circuit2');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://constructor1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (2007, 'http://season2007');
INSERT INTO seasons (year, url) VALUES (2008, 'http://season2008');
INSERT INTO seasons (year, url) VALUES (2009, 'http://season2009');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (10, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', 'http://driver10');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (11, 'd_hamilton', 45, 'DHA', 'Duncan', 'Hamilton', 'http://driver11');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (12, 'l_smith', 46, 'LSM', 'Lewis', 'Smith', 'http://driver12');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (100, 2008, 1, 1, 'Australian Grand Prix', '2008-03-16', 'http://race100');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (101, 2007, 1, 1, 'Australian Grand Prix', '2007-03-18', 'http://race101');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (102, 2009, 1, 1, 'Australian Grand Prix', '2009-03-29', 'http://race102');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (103, 2008, 2, 2, 'Malaysian Grand Prix', '2008-03-23', 'http://race103');
-- Target match: Lewis Hamilton, 2008 Australian Grand Prix.
-- Distinct values for grid (2), position (3), positionText ('3'), positionOrder (1), points (10), rank (4) to kill wrong-column projection mutants.
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1000, 100, 10, 1, 22, 2, 3, '3', 1, 10.0, 58, 4, 1);
-- Wrong driver forename (Duncan Hamilton in 2008 Australian GP)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1001, 100, 11, 1, 23, 5, 5, '5', 5, 4.0, 58, 5, 1);
-- Wrong driver surname (Lewis Smith in 2008 Australian GP)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1002, 100, 12, 1, 24, 6, 6, '6', 6, 3.0, 58, 6, 1);
-- Wrong year < 2008 (Lewis Hamilton in 2007 Australian GP)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1003, 101, 10, 1, 22, 4, 7, '7', 7, 2.0, 58, 7, 1);
-- Wrong year > 2008 (Lewis Hamilton in 2009 Australian GP)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1004, 102, 10, 1, 1, 18, 8, '8', 8, 1.0, 58, 8, 1);
-- Wrong race name, but circuit.name is 'Australian Grand Prix' (Lewis Hamilton in 2008 Malaysian GP held on circuit 1 to test circuit.name vs races.name confusion)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (104, 2008, 3, 1, 'Melbourne F1 Race', '2008-04-01', 'http://race104');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1005, 104, 10, 1, 22, 1, 9, '9', 9, 0.0, 58, 9, 1);
-- Decoy rows in driverStandings and qualifying to kill table-substitution mutants
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (500, 100, 10, 10.0, 99, '99', 1);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position) VALUES (600, 100, 10, 1, 22, 88);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.positionOrder FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' AND T1.name = 'Australian Grand Prix' AND T1.year = 2008;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.positionOrder FROM results AS T1 JOIN races AS T2 ON T1.raceId = T2.raceId JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.name = 'Chinese Grand Prix' AND T2.year = 2008 AND T3.forename = 'Lewis' AND T3.surname = 'Hamilton';

/*
Prediction Result:
*/