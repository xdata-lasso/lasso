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
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne', 'Australia', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (23, 2009, 6, 1, 'Monaco Grand Prix', '2009-05-24', 'http://en.wikipedia.org/wiki/2009_Monaco_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (24, 2009, 7, 1, 'Turkish Grand Prix', '2009-06-07', 'http://en.wikipedia.org/wiki/2009_Turkish_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (25, 2009, 8, 1, 'British Grand Prix', '2009-06-21', 'http://en.wikipedia.org/wiki/2009_British_Grand_Prix');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (10, 'mclaren', 'McLaren', 'British', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (11, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (12, 'bmw_sauber', 'BMW Sauber', 'German', 'http://en.wikipedia.org/wiki/BMW_Sauber');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (13, 'renault', 'Renault', 'French', 'http://en.wikipedia.org/wiki/Renault_in_Formula_One');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (14, 'toyota', 'Toyota', 'Japanese', 'http://en.wikipedia.org/wiki/Toyota_Racing');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (15, 'red_bull', 'Red Bull', 'Austrian', 'http://en.wikipedia.org/wiki/Red_Bull_Racing');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (16, 'sauber', 'Sauber', 'Swiss', 'http://en.wikipedia.org/wiki/Sauber');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (101, 24, 10, 1.0, '1');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (102, 24, 11, 0.0, '1');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (103, 24, 12, 2.0, '1');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (104, 23, 13, 1.0, '1');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (105, 25, 14, 1.0, '1');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (106, 24, 15, NULL, 'DNF');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T1.raceId = 24 AND T1.points = 1;

/*
Gold Result:
('British',)
*/

-- Prediction Query
SELECT DISTINCT constructors.constructorid FROM constructorresults INNER JOIN constructors ON constructorresults.constructorid = constructors.constructorid WHERE constructorresults.raceid = 24 AND constructorresults.points = 1;

/*
Prediction Result:
(10,)
*/