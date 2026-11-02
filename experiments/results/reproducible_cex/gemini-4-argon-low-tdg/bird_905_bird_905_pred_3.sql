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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park', 'http://circuit1.com');
INSERT INTO seasons (year, url) VALUES (1999, 'http://1999.com');
INSERT INTO seasons (year, url) VALUES (2000, 'http://2000.com');
INSERT INTO seasons (year, url) VALUES (2001, 'http://2001.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'irvine', 'Eddie', 'Irvine', 'http://irvine.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'cheever', 'Eddie', 'Cheever', 'http://cheever.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'jeremy_irvine', 'Jeremy', 'Irvine', 'http://jirvine.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'schumacher', 'Michael', 'Schumacher', 'http://schumacher.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2000, 1, 1, 'Australian GP', '2000-03-12', 'http://race10.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (11, 2000, 2, 1, 'Brazilian GP', '2000-03-26', 'http://race11.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (12, 2000, 3, 1, 'San Marino GP', '2000-04-09', 'http://race12.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (13, 1999, 1, 1, 'Australian GP 99', '1999-03-07', 'http://race13.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (14, 2001, 1, 1, 'Australian GP 01', '2001-03-04', 'http://race14.com');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (100, 10, 1, 3.0, 4, 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (101, 11, 1, 3.0, 5, 1);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (102, 12, 1, 7.0, 3, 2);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (103, 10, 2, 50.0, 1, 5);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (104, 10, 3, 60.0, 2, 6);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (105, 10, 4, 70.0, 3, 7);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (106, 13, 1, 80.0, 1, 8);
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, wins) VALUES (107, 14, 1, 90.0, 1, 9);
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'jaguar', 'Jaguar', 'http://jaguar.com');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (1, 10, 1, 1, 1, '1', 1, 10.0, 50, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (2, 11, 1, 1, 2, '2', 2, 6.0, 50, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (3, 12, 1, 1, 3, '3', 3, 4.0, 50, 1);
INSERT INTO constructorStandings (constructorStandingsId, raceId, constructorId, points, position, wins) VALUES (1, 10, 1, 99.0, 1, 1);
INSERT INTO constructorResults (constructorResultsId, raceId, constructorId, points) VALUES (1, 10, 1, 88.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T2.driverId = T1.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T1.forename = 'Eddie' AND T1.surname = 'Irvine' AND T3.year = 2000;

/*
Gold Result:
(4.333333333333333,)
*/

-- Prediction Query
SELECT AVG(T3.points) FROM drivers AS T1 INNER JOIN results AS T3 ON T1.driverId = T3.driverId INNER JOIN races AS T2 ON T3.raceId = T2.raceId WHERE T1.forename = 'Eddie' AND T1.surname = 'Irvine' AND T2.year = 2000;

/*
Prediction Result:
(6.666666666666667,)
*/