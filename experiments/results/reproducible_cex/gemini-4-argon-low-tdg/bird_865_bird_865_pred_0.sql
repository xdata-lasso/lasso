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
INSERT INTO seasons (year, url) VALUES (1975, 'http://en.wikipedia.org/wiki/1975');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://monza');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'ferrari', 'Ferrari', 'http://ferrari');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (591, 1975, 1, 1, 'Race 591', '1975-01-01', 'http://r591');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (592, 1975, 2, 1, 'Race 592', '1975-02-01', 'http://r592');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (593, 1975, 3, 1, 'Race 593', '1975-03-01', 'http://r593');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (1, 'd1', 'Null', 'Dob', NULL, 'http://d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (2, 'd2', 'Wrong', 'RaceLow', '1930-01-01', 'http://d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (3, 'd3', 'Wrong', 'RaceHigh', '1931-01-01', 'http://d3');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (4, 'd4', 'Null', 'Time', '1935-01-01', 'http://d4');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (5, 'd5', 'No', 'Result', '1920-01-01', 'http://d5');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (6, 'd6', 'Oldest', 'Valid', '1940-05-10', 'http://d6');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (7, 'd7', 'Middle', 'Valid', '1945-06-15', 'http://d7');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (8, 'd8', 'Youngest', 'Valid', '1950-07-20', 'http://d8');
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (1, 592, 1, 1, 1, '1:30:00', 5400000, '1:20.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (2, 591, 2, 1, 1, '1:30:00', 5400000, '1:20.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (3, 593, 3, 1, 1, '1:30:00', 5400000, '1:20.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (4, 592, 4, 1, 4, NULL, 5400000, '1:20.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (5, 592, 6, 1, 2, '1:31:00', NULL, NULL, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (6, 592, 7, 1, 3, '+10.5s', 5410500, '1:21.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, positionOrder, time, milliseconds, fastestLapTime, statusId) VALUES (7, 592, 8, 1, 1, '1:29:00', 5340000, '1:19.0', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 592 AND NOT T2.time IS NULL AND NOT T1.dob IS NULL ORDER BY T1.dob ASC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Oldest', 'Valid')
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 592 AND NOT T2.time IS NULL ORDER BY T1.dob, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Null', 'Dob')
*/