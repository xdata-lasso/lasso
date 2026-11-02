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
-- Tests LIMIT 5 boundary (7 matching rows), WHERE T1.raceId = 18 boundary (rows with 17, 18, 19),
-- ORDER BY T1.q1 DESC (inverse correlation with q2, q3, position, number),
-- and column selection (driverRef distinct from code, forename, surname).
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (17, 2008, 17, 1, 'Race 17', '2008-03-15', 'http://race17.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (18, 2008, 18, 1, 'Australian Grand Prix', '2008-03-16', 'http://race18.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (19, 2008, 19, 1, 'Race 19', '2008-03-17', 'http://race19.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (1, 'hamilton_ref', 44, 'HAM', 'Lewis', 'Hamilton', 'http://d1.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (2, 'heidfeld_ref', 6, 'HEI', 'Nick', 'Heidfeld', 'http://d2.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (3, 'rosberg_ref', 7, 'ROS', 'Nico', 'Rosberg', 'http://d3.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (4, 'alonso_ref', 5, 'ALO', 'Fernando', 'Alonso', 'http://d4.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (5, 'kovalainen_ref', 23, 'KOV', 'Heikki', 'Kovalainen', 'http://d5.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (6, 'nakajima_ref', 8, 'NAK', 'Kazuki', 'Nakajima', 'http://d6.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (7, 'bourdais_ref', 14, 'BOU', 'Sebastien', 'Bourdais', 'http://d7.com');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (8, 'raikkonen_ref', 1, 'RAI', 'Kimi', 'Raikkonen', 'http://d8.com');
-- Non-matching races (should be filtered out despite having highest q1)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 17, 8, 1, 1, 1, '1:99.999', '1:20.000', '1:20.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 19, 8, 1, 1, 1, '1:99.998', '1:20.000', '1:20.000');
-- Matching raceId = 18 (7 rows, distinct q1, inversely ordered against q2, q3, position, and qualifyId)
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (10, 18, 1, 1, 10, 7, '1:29.000', '1:21.000', '1:21.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (20, 18, 2, 1, 20, 6, '1:28.000', '1:22.000', '1:22.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (30, 18, 3, 1, 30, 5, '1:27.000', '1:23.000', '1:23.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (40, 18, 4, 1, 40, 4, '1:26.000', '1:24.000', '1:24.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (50, 18, 5, 1, 50, 3, '1:25.000', '1:25.000', '1:25.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (60, 18, 6, 1, 60, 2, '1:24.000', '1:26.000', '1:26.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (70, 18, 7, 1, 70, 1, '1:23.000', '1:27.000', '1:27.000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('hamilton_ref',)
('heidfeld_ref',)
('rosberg_ref',)
('alonso_ref',)
('kovalainen_ref',)
*/

-- Prediction Query
SELECT T1.driverRef FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 20 ORDER BY T2.q1 DESC, T1.driverid NULLS LAST, T2.qualifyid NULLS LAST LIMIT 5;

/*
Prediction Result:
*/