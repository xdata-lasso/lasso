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
-- 1. WHERE clause conjunction (forename = 'Lewis' AND surname = 'Hamilton') vs OR or missing conditions.
-- 2. ORDER BY T1.year ASC vs DESC, or ordering by points/position/round instead of year.
-- 3. Column selection (T1.name vs circuit name or driver name; T2.points vs position or wins).
-- 4. Conflicting data in `results` table vs `driverStandings` table (catches wrong table join).
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park Circuit', 'http://en.wikipedia.org/wiki/Albert_Park');
INSERT INTO seasons (year, url) VALUES (2006, 'http://en.wikipedia.org/wiki/2006_F1');
INSERT INTO seasons (year, url) VALUES (2007, 'http://en.wikipedia.org/wiki/2007_F1');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_F1');
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_F1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'lewis_other', 'Lewis', 'Smith', 'http://en.wikipedia.org/wiki/Lewis_Smith');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'other_hamilton', 'Duncan', 'Hamilton', 'http://en.wikipedia.org/wiki/Duncan_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2006, 1, 1, '2006 Trap GP', '2006-03-12', 'http://en.wikipedia.org/wiki/2006_Trap');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (50, 2007, 5, 1, 'Australian Grand Prix', '2007-03-18', 'http://en.wikipedia.org/wiki/2007_Aus');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 2008, 1, 1, 'Bahrain Grand Prix', '2008-03-16', 'http://en.wikipedia.org/wiki/2008_Bah');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (30, 2020, 2, 1, 'Styrian Grand Prix', '2020-07-12', 'http://en.wikipedia.org/wiki/2020_Sty');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (1, 10, 1, 100.0, 1, 5);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (2, 10, 2, 90.0, 2, 4);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (3, 50, 3, 6.0, 3, 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (4, 20, 3, 10.0, 1, 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (5, 30, 3, 0.0, 10, 0);
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, points, laps, statusId) VALUES (1, 50, 3, 1, 4, 3, 99.0, 58, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, points, laps, statusId) VALUES (2, 10, 3, 1, 1, 1, 88.0, 58, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Australian Grand Prix', 6.0)
*/

-- Prediction Query
SELECT T2.name, T1.points FROM results AS T1 JOIN races AS T2 ON T1.raceId = T2.raceId JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T2.year ASC, T2.date ASC, T1.resultid NULLS LAST, T2.raceid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('2006 Trap GP', 88.0)
*/