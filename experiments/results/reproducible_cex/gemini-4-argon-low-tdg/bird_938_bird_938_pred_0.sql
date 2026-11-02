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
-- DATASET 2
-- Tests edge cases of the LIKE pattern '_:%:__.___' and NULL time values
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park', 'http://circuit.url/1');
INSERT INTO seasons (year, url) VALUES (2008, 'http://season.url/2008');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'ferrari', 'Ferrari', 'http://constructor.url/1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'John', 'Doe', 'http://driver.url/1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'Jane', 'Smith', 'http://driver.url/2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'Max', 'Power', 'http://driver.url/3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'd4', 'Sam', 'Hill', 'http://driver.url/4');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'd5', 'Tom', 'Ford', 'http://driver.url/5');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'd6', 'Bob', 'Lee', 'http://driver.url/6');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2008, 1, 1, 'Australian Grand Prix', '2008-03-16', '1:30:00.000', 'http://race.url/1');
-- Match with empty % wildcard in '_:%:__.___' (e.g., '1::20.123')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (1, 1, 1, 1, 1, '1', 1, 10, 58, '1::20.123', 1);
-- Non-match: 2 digits before first colon ('12:34:56.789')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (2, 1, 2, 1, 2, '2', 2, 8, 58, '12:34:56.789', 1);
-- Non-match: only 1 digit between second colon and dot ('1:34:5.678')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (3, 1, 3, 1, 3, '3', 3, 6, 58, '1:34:5.678', 1);
-- Non-match: only 2 digits after dot ('1:34:56.78')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (4, 1, 4, 1, 4, '4', 4, 5, 58, '1:34:56.78', 1);
-- Non-match: 4 digits after dot ('1:34:56.7890')
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (5, 1, 5, 1, 5, '5', 5, 4, 58, '1:34:56.7890', 1);
-- Non-match: NULL time (Note: races.time is '1:30:00.000' to catch mutants checking T3.time instead of T2.time)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, statusId) VALUES (6, 1, 6, 1, 6, 'R', 6, 0, 10, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname, T1.url FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T3.name = 'Australian Grand Prix' AND T2.time LIKE '_:%:__.___' AND T3.year = 2008;

/*
Gold Result:
('John', 'Doe', 'http://driver.url/1')
*/

-- Prediction Query
SELECT T2.forename, T2.surname, T2.url FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.year = 2008 AND T3.name = 'Australian Grand Prix' AND T1.time LIKE '%:%:%.%';

/*
Prediction Result:
('John', 'Doe', 'http://driver.url/1')
('Jane', 'Smith', 'http://driver.url/2')
('Max', 'Power', 'http://driver.url/3')
('Sam', 'Hill', 'http://driver.url/4')
('Tom', 'Ford', 'http://driver.url/5')
*/