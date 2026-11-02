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
-- DATASET 3
-- Tests join key mutations (e.g., joining on resultId, constructorId, position, round), DISTINCT vs ALL, and column confusion (fastestLapTime vs time)
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (10, 'melbourne', 'Melbourne Circuit', 'http://circuit.url/10');
INSERT INTO seasons (year, url) VALUES (2008, 'http://season.url/2008');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (10, 'bmw', 'BMW Sauber', 'http://constructor.url/10');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (50, 'williams', 'Williams', 'http://constructor.url/50');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
-- Driver 50 is the real driver for the matching result
INSERT INTO drivers (driverId, driverRef, number, forename, surname, url) VALUES (50, 'kubica', 4, 'Robert', 'Kubica', 'http://driver.url/50');
-- Decoy Driver 10 (matches constructorId 10 and resultId 10)
INSERT INTO drivers (driverId, driverRef, number, forename, surname, url) VALUES (10, 'decoy1', 50, 'Decoy', 'One', 'http://driver.url/10');
-- Decoy Driver 100 (matches raceId 100)
INSERT INTO drivers (driverId, driverRef, number, forename, surname, url) VALUES (100, 'decoy2', 99, 'Decoy', 'Two', 'http://driver.url/100');
-- Driver 60 has fastestLapTime matching the pattern, but results.time does not
INSERT INTO drivers (driverId, driverRef, number, forename, surname, url) VALUES (60, 'trulli', 11, 'Jarno', 'Trulli', 'http://driver.url/60');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (100, 2008, 1, 10, 'Australian Grand Prix', '2008-03-16', '04:30:00', 'http://race.url/100');
-- Decoy Race 50 (wrong race, but ID=50 matches driverId=50)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (50, 2008, 2, 10, 'Bahrain Grand Prix', '2008-04-06', '11:30:00', 'http://race.url/50');
-- Two matching results for the same driver (tests if mutant erroneously adds DISTINCT)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (10, 100, 50, 10, 4, 2, 1, '1', 1, 10, 58, '1:34:50.616', '1:27.452', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (11, 100, 50, 10, 4, 2, 2, '2', 2, 8, 58, '1:35:01.111', '1:27.452', 1);
-- Result where fastestLapTime matches '_:%:__.___' (artificially) and race.time matches, but results.time does not
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (12, 100, 60, 50, 11, 3, 3, '3', 3, 6, 58, '+12.345', '1:01:27.452', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname, T1.url FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T3.name = 'Australian Grand Prix' AND T2.time LIKE '_:%:__.___' AND T3.year = 2008;

/*
Gold Result:
('Robert', 'Kubica', 'http://driver.url/50')
('Robert', 'Kubica', 'http://driver.url/50')
*/

-- Prediction Query
SELECT d.forename, d.surname, d.url FROM results AS r JOIN races AS ra ON r.raceId = ra.raceId JOIN drivers AS d ON r.driverId = d.driverId WHERE ra.year = 2008 AND ra.name = 'Australian Grand Prix' AND r.positionText = '1';

/*
Prediction Result:
('Robert', 'Kubica', 'http://driver.url/50')
*/