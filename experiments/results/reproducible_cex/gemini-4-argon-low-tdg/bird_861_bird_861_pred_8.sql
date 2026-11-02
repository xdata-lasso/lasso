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
-- Tests column selection (drivers.number vs qualifying.number vs driverId/position), exact vs prefix LIKE, q1/q2 vs q3, and raceId boundaries.
INSERT INTO seasons (year, url) VALUES (2014, 'http://en.wikipedia.org/wiki/2014_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'spa', 'Circuit de Spa-Francorchamps', 'http://en.wikipedia.org/wiki/Circuit_de_Spa-Francorchamps');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mercedes', 'Mercedes', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (902, 2014, 1, 1, 'Race 902', '2014-03-16', 'http://race902');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (903, 2014, 2, 1, 'Race 903', '2014-03-30', 'http://race903');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (904, 2014, 3, 1, 'Race 904', '2014-04-06', 'http://race904');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (10, 'ham', 44, 'HAM', 'Lewis', 'Hamilton', 'http://ham');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (11, 'ros', 6, 'ROS', 'Nico', 'Rosberg', 'http://ros');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (12, 'vet', 5, 'VET', 'Sebastian', 'Vettel', 'http://vet');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (13, 'alo', 14, 'ALO', 'Fernando', 'Alonso', 'http://alo');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (14, 'ric', 3, 'RIC', 'Daniel', 'Ricciardo', 'http://ric');
-- Matching row: raceId=903, q3 starts with '1:54'. Distinct T2.number (44) vs T1.number (99).
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 903, 10, 1, 99, 1, '1:55.100', '1:55.200', '1:54.123');
-- Wrong raceId (902), but q3 matches '1:54%'
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 902, 11, 1, 6, 2, '1:55.000', '1:55.000', '1:54.456');
-- Wrong raceId (904), but q3 matches '1:54%'
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (3, 904, 12, 1, 5, 3, '1:55.000', '1:55.000', '1:54.789');
-- Right raceId (903), q1 and q2 match '1:54%', but q3 does NOT match
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (4, 903, 13, 1, 14, 4, '1:54.111', '1:54.222', '1:55.000');
-- Right raceId (903), q3 contains '1:54' in the middle (tests '%1:54%' vs '1:54%')
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (5, 903, 14, 1, 3, 5, '1:55.000', '1:55.000', '01:54.321');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.number FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 903 AND T1.q3 LIKE '1:54%';

/*
Gold Result:
(44,)
*/

-- Prediction Query
SELECT T1.number FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 903 AND STRFTIME('%M:%S', T2.q3) = '01:54';

/*
Prediction Result:
*/