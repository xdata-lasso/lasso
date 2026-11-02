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
INSERT INTO seasons (year, url) VALUES (2001, 'http://en.wikipedia.org/wiki/2001_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (401, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne', 'Australia', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (402, 'sepang', 'Sepang International Circuit', 'Kuala Lumpur', 'Malaysia', 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (101, 2001, 1, 401, 'Australian Grand Prix', '2001-03-04', 'http://en.wikipedia.org/wiki/2001_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (102, 2001, 2, 402, 'Malaysian Grand Prix', '2001-03-18', 'http://en.wikipedia.org/wiki/2001_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (103, 2001, 3, 401, 'Brazilian Grand Prix', '2001-04-01', 'http://en.wikipedia.org/wiki/2001_Brazilian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (104, 2001, 4, 402, 'San Marino Grand Prix', '2001-04-15', 'http://en.wikipedia.org/wiki/2001_San_Marino_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (105, 2001, 5, 401, 'Spanish Grand Prix', '2001-04-29', 'http://en.wikipedia.org/wiki/2001_Spanish_Grand_Prix');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (201, 'yoong', 20, 'YOO', 'Alex', 'Yoong', '1976-07-20', 'Malaysian', 'http://en.wikipedia.org/wiki/Alex_Yoong');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (50, 101, 201, 15.0, 9, '9', 12);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (51, 102, 201, 25.0, 2, '2', 15);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (5, 103, 201, 5.0, 10, '10', 0);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (6, 104, 201, 1.0, 11, '11', 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (7, 105, 201, 0.0, NULL, 'D', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
('Australian Grand Prix',)
('Malaysian Grand Prix',)
*/

-- Prediction Query
SELECT races.name FROM drivers INNER JOIN results ON drivers.driverId = results.driverId INNER JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Alex' AND drivers.surname = 'Yoong' AND results.position < 20;

/*
Prediction Result:
*/