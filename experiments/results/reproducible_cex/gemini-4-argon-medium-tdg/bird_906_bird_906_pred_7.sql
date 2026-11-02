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
INSERT INTO seasons (year, url) VALUES (2006, 'http://en.wikipedia.org/wiki/2006_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2007, 'http://en.wikipedia.org/wiki/2007_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park Circuit', 'http://circuit1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'sepang', 'Sepang International Circuit', 'http://circuit2');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://mclaren');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://lewis_hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'lewis_other', 'Lewis', 'Smith', 'http://lewis_smith');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'hamilton_other', 'Duncan', 'Hamilton', 'http://duncan_hamilton');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2006, 1, 1, '2006 Australian Grand Prix', '2006-03-12', 'http://race10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 2007, 2, 2, '2007 Malaysian Grand Prix', '2007-04-08', 'http://race20');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (30, 2008, 1, 1, '2008 Australian Grand Prix', '2008-03-16', 'http://race30');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (101, 10, 2, 50.0, 1, 5);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (102, 10, 3, 40.0, 2, 4);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (103, 20, 1, 14.0, 2, 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (104, 30, 1, 10.0, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, points, laps, statusId) VALUES (201, 10, 1, 1, 1, 1, 99.0, 58, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, points, laps, statusId) VALUES (202, 20, 1, 1, 4, 2, 8.0, 56, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, points, laps, statusId) VALUES (203, 30, 1, 1, 1, 1, 10.0, 58, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('2007 Malaysian Grand Prix', 14.0)
*/

-- Prediction Query
SELECT r.name, res.points FROM races AS r INNER JOIN results AS res ON r.raceid = res.raceid INNER JOIN drivers AS d ON res.driverid = d.driverid WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' AND r.year = (SELECT MIN(r2.year) FROM races AS r2 INNER JOIN results AS res2 ON r2.raceid = res2.raceid INNER JOIN drivers AS d2 ON res2.driverid = d2.driverid WHERE d2.forename = 'Lewis' AND d2.surname = 'Hamilton') ORDER BY r.date, r.raceid NULLS LAST, res.resultid NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('2006 Australian Grand Prix', 99.0)
*/