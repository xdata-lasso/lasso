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
INSERT INTO seasons (year, url) VALUES (2020, 'http://seasons/2020');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'Circuit 1', 'http://circuits/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (18, 2020, 1, 1, 'Race 18', '2020-01-01', 'http://races/18');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'con1', 'Constructor 1', 'http://constructors/1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'F1', 'S1', 'http://drivers/1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'F2', 'S2', 'http://drivers/2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'F3', 'S3', 'http://drivers/3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'd4', 'F4', 'S4', 'http://drivers/4');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'd5', 'F5', 'S5', 'http://drivers/5');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'd6', 'F6', 'S6', 'http://drivers/6');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, q1) VALUES (1, 18, 6, 1, 6, '1:20.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, q1) VALUES (2, 18, 5, 1, 5, '1:20.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, q1) VALUES (3, 18, 4, 1, 4, '1:20.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, q1) VALUES (4, 18, 3, 1, 3, '1:20.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, q1) VALUES (5, 18, 2, 1, 2, '1:20.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, q1) VALUES (6, 18, 1, 1, 1, '1:20.000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('d6',)
('d5',)
('d4',)
('d3',)
('d2',)
*/

-- Prediction Query
SELECT T1.driverRef FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 18 ORDER BY T2.q1 DESC, T1.driverid NULLS LAST, T2.qualifyid NULLS LAST LIMIT 5;

/*
Prediction Result:
('d1',)
('d2',)
('d3',)
('d4',)
('d5',)
*/