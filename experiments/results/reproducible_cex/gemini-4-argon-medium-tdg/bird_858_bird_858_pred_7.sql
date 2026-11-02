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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://c1.com');
INSERT INTO seasons (year, url) VALUES (2000, 'http://s2000.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (23, 2000, 1, 1, 'Race 23', '2000-01-01', 'http://r23.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (24, 2000, 2, 1, 'Race 24', '2000-01-02', 'http://r24.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (25, 2000, 3, 1, 'Race 25', '2000-01-03', 'http://r25.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'con1', 'TargetCon', 'British', 'http://con1.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'con2', 'ZeroPtsCon', 'Italian', 'http://con2.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'con3', 'TwoPtsCon', 'German', 'http://con3.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (4, 'con4', 'NullPtsCon', 'French', 'http://con4.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (5, 'con5', 'WrongRace23Con', 'Spanish', 'http://con5.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (6, 'con6', 'WrongRace25Con', 'Japanese', 'http://con6.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (7, 'con7', 'UnjoinedCon', 'American', 'http://con7.com');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (24, 'con24', 'Id24Con', 'Swiss', 'http://con24.com');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (101, 24, 1, 1.0, 'OK');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (102, 24, 2, 0.0, 'OK');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (103, 24, 3, 2.0, 'OK');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (104, 24, 4, NULL, 'OK');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (105, 23, 5, 1.0, 'OK');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (106, 25, 6, 1.0, 'OK');
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points, status) VALUES (24, 23, 24, 24.0, 'OK');
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
(1,)
*/