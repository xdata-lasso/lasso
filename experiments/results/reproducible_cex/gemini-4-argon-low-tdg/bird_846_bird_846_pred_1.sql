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
-- Tests: LIMIT 5 boundary (7 qualifying rows for raceId 18), WHERE raceId = 18 filter (excludes raceId 17 and 19),
-- ORDER BY q1 DESC vs ASC, tie-breaking with qualifyId ASC vs DESC when q1 is identical,
-- and distinguishing q1 from q2, q3, position, or number.
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (17, 2008, 1, 1, 'Race 17', '2008-03-10', 'http://race17');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (18, 2008, 2, 1, 'Australian Grand Prix', '2008-03-16', 'http://race18');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (19, 2008, 3, 1, 'Race 19', '2008-03-23', 'http://race19');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (10, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', 'http://d10');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (20, 'massa', 19, 'MAS', 'Felipe', 'Massa', 'http://d20');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (30, 'raikkonen', 7, 'RAI', 'Kimi', 'Raikkonen', 'http://d30');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (40, 'kubica', 88, 'KUB', 'Robert', 'Kubica', 'http://d40');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (50, 'alonso', 14, 'ALO', 'Fernando', 'Alonso', 'http://d50');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (60, 'kovalainen', 23, 'KOV', 'Heikki', 'Kovalainen', 'http://d60');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (70, 'vettel', 5, 'VET', 'Sebastian', 'Vettel', 'http://d70');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (80, 'rosberg', 6, 'ROS', 'Nico', 'Rosberg', 'http://d80');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (105, 18, 10, 1, 22, 7, '1:26.500', '1:25.100', '1:24.900');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (102, 18, 20, 1, 2, 6, '1:26.500', '1:25.900', '1:24.100');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (108, 18, 30, 1, 1, 5, '1:26.400', '1:25.800', '1:24.800');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (101, 18, 40, 1, 4, 4, '1:26.300', '1:25.700', '1:24.700');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (109, 18, 50, 1, 5, 3, '1:26.200', '1:25.600', '1:24.600');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (103, 18, 60, 1, 23, 2, '1:26.200', '1:25.500', '1:24.500');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (104, 18, 70, 1, 15, 1, '1:26.100', '1:25.400', '1:24.400');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (201, 17, 80, 1, 7, 1, '1:29.999', '1:29.999', '1:29.999');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (202, 19, 80, 1, 7, 1, '1:29.999', '1:29.999', '1:29.999');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('massa',)
('hamilton',)
('raikkonen',)
('kubica',)
('kovalainen',)
*/

-- Prediction Query
SELECT d.driverRef FROM qualifying AS q INNER JOIN drivers AS d ON q.driverId = d.driverId WHERE q.raceId = 20 ORDER BY q.q1 DESC, q.qualifyid NULLS LAST, d.driverid NULLS LAST LIMIT 5;

/*
Prediction Result:
*/