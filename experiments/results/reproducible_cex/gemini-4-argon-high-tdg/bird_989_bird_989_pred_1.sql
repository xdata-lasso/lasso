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
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'villeneuve', 'Circuit Gilles Villeneuve', 'Montreal', 'Canada', 'http://en.wikipedia.org/wiki/Circuit_Gilles_Villeneuve');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'kubica', 'Robert', 'Kubica', 'http://en.wikipedia.org/wiki/Robert_Kubica');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'heidfeld', 'Nick', 'Heidfeld', 'http://en.wikipedia.org/wiki/Nick_Heidfeld');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'bmw_sauber', 'BMW Sauber', 'http://en.wikipedia.org/wiki/BMW_Sauber');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2008, 7, 1, 'Canadian Grand Prix', '2008-06-08', '17:00:00', 'http://en.wikipedia.org/wiki/2008_Canadian_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (1, 1, 1, 1, 1, 1, '1', 1, 10, 70, '1:36:24.227', '1:17.387', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (2, 1, 2, 1, 2, 2, '2', 2, 8, 70, '+16.495', '1:17.400', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (3, 1, 2, 1, 3, 3, '3', 3, 6, 70, NULL, '1:18.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (4, 1, 2, 1, 4, 4, '4', 4, 5, 70, '12:36:24.227', '1:18.100', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (5, 1, 2, 1, 5, 5, '5', 5, 4, 70, '1:36:4.227', '1:18.200', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (6, 1, 2, 1, 6, 6, '6', 6, 3, 70, '1:36:24.22', '1:18.300', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (7, 1, 2, 1, 7, 7, '7', 7, 2, 70, '1:36:24.2278', '1:18.400', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (8, 1, 2, 1, 8, 8, '8', 8, 1, 70, '1:24.227', '1:18.500', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, fastestLapTime, statusId) VALUES (9, 1, 2, 1, 9, 9, '9', 9, 0, 70, '1:36:24:227', '1:18.600', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.time FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Canadian Grand Prix' AND T2.year = 2008 AND T1.time LIKE '_:%:__.___';

/*
Gold Result:
('1:36:24.227',)
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname, results.time FROM races INNER JOIN results ON races.raceId = results.raceId INNER JOIN drivers ON results.driverId = drivers.driverId WHERE races.name = 'Canadian Grand Prix' AND races.year = 2008 ORDER BY results.time ASC, races.raceid NULLS LAST, results.resultid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Nick', 'Heidfeld', None)
*/