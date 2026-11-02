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
-- Tests:
-- 1. DISTINCT necessity (Circuit 1 hosts 'Malaysian Grand Prix' multiple times).
-- 2. Filtering on T2.name vs T1.name/country/location (Circuit 2 is named 'Malaysian Grand Prix' in 'Malaysia', but its race is 'Sepang Grand Prix').
-- 3. Substring/Prefix matching on T2.name (Circuit 3 hosts 'Malaysian Grand Prix 2020').
-- 4. Unjoined circuits (Circuit 4 has no races; kills LEFT JOIN without proper filtering or projection without join).
-- 5. Multiple valid circuits with distinct coordinates (Circuit 1 and Circuit 5).
INSERT INTO seasons (year, url) VALUES (2000, 'http://en.wikipedia.org/wiki/2000_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2001, 'http://en.wikipedia.org/wiki/2001_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
VALUES (1, 'sepang', 'Sepang International Circuit', 'Kuala Lumpur', 'Malaysia', 2.76083, 101.738, 18, 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
VALUES (2, 'malaysian_gp_circuit', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 'Malaysia', 3.139, 101.6869, 45, 'http://en.wikipedia.org/wiki/Dummy_Circuit_2');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
VALUES (3, 'johor', 'Johor Circuit', 'Pasir Gudang', 'Malaysia', 1.4486, 103.903, 25, 'http://en.wikipedia.org/wiki/Johor_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
VALUES (4, 'unraced_malaysia', 'Malaysian Grand Prix', 'Kuala Lumpur', 'Malaysian Grand Prix', 4.2105, 101.9758, 50, 'http://en.wikipedia.org/wiki/Dummy_Circuit_4');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
VALUES (5, 'shah_alam', 'Shah Alam Circuit', 'Shah Alam', 'Malaysia', 3.0738, 101.554, 15, 'http://en.wikipedia.org/wiki/Shah_Alam_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url)
VALUES (101, 2000, 1, 1, 'Malaysian Grand Prix', '2000-10-22', '07:00:00', 'http://en.wikipedia.org/wiki/2000_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url)
VALUES (102, 2001, 2, 1, 'Malaysian Grand Prix', '2001-03-18', '07:00:00', 'http://en.wikipedia.org/wiki/2001_Malaysian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url)
VALUES (103, 2000, 3, 2, 'Sepang Grand Prix', '2000-04-01', '07:00:00', 'http://en.wikipedia.org/wiki/2000_Sepang_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url)
VALUES (104, 2000, 4, 3, 'Malaysian Grand Prix 2000', '2000-05-01', '07:00:00', 'http://en.wikipedia.org/wiki/2000_Malaysian_Grand_Prix_Extra');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url)
VALUES (105, 2001, 5, 5, 'Malaysian Grand Prix', '2001-06-01', '07:00:00', 'http://en.wikipedia.org/wiki/2001_Malaysian_Grand_Prix_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.lat, T1.lng FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T2.name = 'Malaysian Grand Prix';

/*
Gold Result:
(2.76083, 101.738)
(3.0738, 101.554)
*/

-- Prediction Query
SELECT T1.lat, T1.lng FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T2.name = 'Malaysian Grand Prix';

/*
Prediction Result:
(2.76083, 101.738)
(2.76083, 101.738)
(3.0738, 101.554)
*/