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
-- Core Predicate & Boundary Testing: Tests exact match alongside single-condition violations (wrong year, wrong race name, wrong grid boundaries 3 & 5, and confusion between grid, position, positionOrder, rank, number, and qualifying/standings tables).
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne', 'Australia', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'sepang', 'Sepang International Circuit', 'Kuala Lumpur', 'Malaysia', 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mclaren', 'McLaren', 'British', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (2007, 'http://en.wikipedia.org/wiki/2007_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (1, 'massa', 2, 'MAS', 'Felipe', 'Massa', 'Brazilian', 'http://en.wikipedia.org/wiki/Felipe_Massa');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (2, 'hamilton', 22, 'HAM', 'Lewis', 'Hamilton', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (3, 'kubica', 4, 'KUB', 'Robert', 'Kubica', 'Polish', 'http://en.wikipedia.org/wiki/Robert_Kubica');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (4, 'kovalainen', 23, 'KOV', 'Heikki', 'Kovalainen', 'Finnish', 'http://en.wikipedia.org/wiki/Heikki_Kovalainen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (5, 'alonso', 5, 'ALO', 'Fernando', 'Alonso', 'Spanish', 'http://en.wikipedia.org/wiki/Fernando_Alonso');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (6, 'raikkonen', 1, 'RAI', 'Kimi', 'Räikkönen', 'Finnish', 'http://en.wikipedia.org/wiki/Kimi_R%C3%A4ikk%C3%B6nen');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (7, 'rosberg', 7, 'ROS', 'Nico', 'Rosberg', 'German', 'http://en.wikipedia.org/wiki/Nico_Rosberg');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, nationality, url) VALUES (8, 'webber', 10, 'WEB', 'Mark', 'Webber', 'Australian', 'http://en.wikipedia.org/wiki/Mark_Webber');
-- Races: Target race (1), Wrong Year 2007 (2), Wrong Year 2009 (3), Wrong Name in 2008 (4), Wrong Name on Australian Circuit in 2008 (5)
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2008, 1, 1, 'Australian Grand Prix', '2008-03-16', 'http://en.wikipedia.org/wiki/2008_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2007, 1, 1, 'Australian Grand Prix', '2007-03-18', 'http://en.wikipedia.org/wiki/2007_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2009, 1, 1, 'Australian Grand Prix', '2009-03-29', 'http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2008, 2, 2, 'Malaysian Grand Prix', '2008-03-23', 'http://en.wikipedia.org/wiki/2008_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2008, 4, 1, 'Melbourne Grand Prix', '2008-04-01', 'http://en.wikipedia.org/wiki/2008_Melbourne_Grand_Prix');
-- Target match: Driver 1 has grid = 4 in Race 1
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (1, 1, 1, 1, 2, 4, 10, '10', 10, 0, 58, 5, 1);
-- Decoy 1: Driver 2 in Race 1 with grid = 3 (boundary < 4), position = 4, positionOrder = 4, rank = 4
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (2, 1, 2, 1, 22, 3, 4, '4', 4, 5, 58, 4, 1);
-- Decoy 2: Driver 3 in Race 1 with grid = 5 (boundary > 4), number = 4, points = 4, laps = 4
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (3, 1, 3, 1, 4, 5, 2, '2', 2, 4, 4, 2, 1);
-- Decoy 3: Driver 4 in Race 2 (2007 Australian GP) with grid = 4
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (4, 2, 4, 1, 23, 4, 1, '1', 1, 10, 58, 1, 1);
-- Decoy 4: Driver 5 in Race 3 (2009 Australian GP) with grid = 4
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (5, 3, 5, 1, 5, 4, 1, '1', 1, 10, 58, 1, 1);
-- Decoy 5: Driver 6 in Race 4 (2008 Malaysian GP) with grid = 4
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (6, 4, 6, 1, 1, 4, 1, '1', 1, 10, 58, 1, 1);
-- Decoy 6: Driver 7 in Race 5 (2008 Melbourne GP on circuit 1) with grid = 4
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (7, 5, 7, 1, 7, 4, 1, '1', 1, 10, 58, 1, 1);
-- Decoy 7: Driver 8 in Qualifying & DriverStandings for Race 1 at position = 4, but grid = 6 in Results
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, rank, statusId) VALUES (8, 1, 8, 1, 10, 6, 6, '6', 6, 3, 58, 6, 1);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position) VALUES (1, 1, 8, 1, 10, 4);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1, 1, 8, 5, 4, '4', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T2.grid = 4 AND T1.name = 'Australian Grand Prix' AND T1.year = 2008;

/*
Gold Result:
('Felipe', 'Massa')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM results AS r INNER JOIN drivers AS d ON r.driverId = d.driverId INNER JOIN races AS ra ON r.raceId = ra.raceId WHERE ra.name = 'Australian Grand Prix' AND ra.date LIKE '1989%' AND r.grid = 4;

/*
Prediction Result:
*/