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
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'Melbourne', 'Australia', -37.8497, 144.968, 10, 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (2, 'sepang', 'Sepang International Circuit', 'Kuala Lumpur', 'Malaysia', 2.76083, 101.738, 18, 'http://en.wikipedia.org/wiki/Sepang_International_Circuit');
INSERT INTO seasons (year, url) VALUES (2010, 'http://en.wikipedia.org/wiki/2010_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2011, 'http://en.wikipedia.org/wiki/2011_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2012, 'http://en.wikipedia.org/wiki/2012_Formula_One_season');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (10, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (11, 'anthony_h', 45, 'ANH', 'Anthony', 'Hamilton', '1960-01-01', 'British', 'http://en.wikipedia.org/wiki/Anthony_Hamilton');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (12, 'lewis_s', 46, 'LES', 'Lewis', 'Smith', '1986-02-02', 'British', 'http://en.wikipedia.org/wiki/Lewis_Smith');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (13, 'swapped_h', 47, 'SWH', 'Hamilton', 'Lewis', '1987-03-03', 'British', 'http://en.wikipedia.org/wiki/Hamilton_Lewis');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (100, 2011, 1, 1, 'Australian Grand Prix', '2011-03-27', '06:00:00', 'http://en.wikipedia.org/wiki/2011_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (101, 2010, 2, 1, 'Australian Grand Prix', '2010-03-28', '06:00:00', 'http://en.wikipedia.org/wiki/2010_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (102, 2012, 1, 1, 'Australian Grand Prix', '2012-03-18', '06:00:00', 'http://en.wikipedia.org/wiki/2012_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (103, 2011, 2, 2, 'Malaysian Grand Prix', '2011-04-10', '08:00:00', 'http://en.wikipedia.org/wiki/2011_Malaysian_Grand_Prix');
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (100, 10, 1, 16, '14:30:00', '22.500', 22500);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (100, 10, 2, 36, '15:00:00', '23.100', 23100);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (100, 11, 1, 12, '14:20:00', '24.000', 24000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (100, 12, 1, 22, '14:40:00', '25.000', 25000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (100, 13, 1, 42, '15:10:00', '21.000', 21000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (101, 10, 1, 14, '14:25:00', '22.000', 22000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (102, 10, 1, 18, '14:35:00', '23.000', 23000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (103, 10, 1, 25, '16:40:00', '24.500', 24500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.lap FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' AND T3.year = 2011 AND T3.name = 'Australian Grand Prix';

/*
Gold Result:
(16,)
(36,)
*/

-- Prediction Query
SELECT T3.lap FROM races AS T1 INNER JOIN drivers AS T2 ON T1.name = 'Australian Grand Prix' INNER JOIN pitstops AS T3 ON T1.raceid = T3.raceid INNER JOIN drivers AS T4 ON T3.driverid = T4.driverid WHERE T1.year = 2011 AND T4.forename = 'Lewis' AND T4.surname = 'Hamilton';

/*
Prediction Result:
(16,)
(36,)
(16,)
(36,)
(16,)
(36,)
(16,)
(36,)
*/