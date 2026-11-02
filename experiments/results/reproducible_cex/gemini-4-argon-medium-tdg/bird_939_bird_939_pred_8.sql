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
-- Tests predicate boundary conditions (year, race name, nationality) and COUNT(*) vs COUNT(nullable_col).
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'toro_rosso', 'Toro Rosso', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Toro_Rosso');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (2007, 'http://en.wikipedia.org/wiki/2007_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2009, 'http://en.wikipedia.org/wiki/2009_Formula_One_season');
-- Driver 1: Target match ('American') with NULLs in optional columns
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'speed', NULL, NULL, 'Scott', 'Speed', NULL, 'American', 'http://en.wikipedia.org/wiki/Scott_Speed');
-- Driver 2: Wrong nationality ('British')
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
-- Driver 3: NULL nationality
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (3, 'unknown', 99, 'UNK', 'John', 'Doe', '1980-01-01', NULL, 'http://en.wikipedia.org/wiki/John_Doe');
-- Race 1: Target match ('Australian GrAND Prix', 2008)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2008, 1, 1, 'Australian GrAND Prix', '2008-03-16', NULL, 'http://en.wikipedia.org/wiki/2008_Australian_Grand_Prix');
-- Race 2: Wrong year (2007)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2007, 1, 1, 'Australian GrAND Prix', '2007-03-18', '03:00:00', 'http://en.wikipedia.org/wiki/2007_Australian_Grand_Prix');
-- Race 3: Wrong year (2009)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2009, 1, 1, 'Australian GrAND Prix', '2009-03-29', '06:00:00', 'http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix');
-- Race 4: Wrong name ('Malaysian Grand Prix', 2008)
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (4, 2008, 2, 1, 'Malaysian Grand Prix', '2008-03-23', '07:00:00', 'http://en.wikipedia.org/wiki/2008_Malaysian_Grand_Prix');
-- Race 5: Case variation in name ('Australian Grand Prix', 2008) to kill case-insensitive LIKE/GLOB mutants
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (5, 2008, 3, 1, 'Australian Grand Prix', '2008-04-06', '11:30:00', 'http://en.wikipedia.org/wiki/2008_Australian_Grand_Prix_Alt');
-- Result 1: Matches all conditions (Driver 1, Race 1) with NULLs in optional columns (kills COUNT(position), COUNT(time), etc.)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 1, 1, NULL, 1, NULL, 'R', 20, 0, 10, NULL, NULL, NULL, NULL, NULL, NULL, 1);
-- Result 2: Wrong driver nationality (Driver 2, Race 1)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (2, 1, 2, 1, 22, 1, 1, '1', 1, 10, 58, 1);
-- Result 3: NULL driver nationality (Driver 3, Race 1)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (3, 1, 3, 1, 99, 2, 2, '2', 2, 8, 58, 1);
-- Result 4: Wrong race year < 2008 (Driver 1, Race 2)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (4, 2, 1, 1, 10, 3, 3, '3', 3, 6, 58, 1);
-- Result 5: Wrong race year > 2008 (Driver 1, Race 3)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (5, 3, 1, 1, 10, 4, 4, '4', 4, 5, 58, 1);
-- Result 6: Wrong race name (Driver 1, Race 4)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (6, 4, 1, 1, 10, 5, 5, '5', 5, 4, 58, 1);
-- Result 7: Case variation race name (Driver 1, Race 5)
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (7, 5, 1, 1, 10, 6, 6, '6', 6, 3, 58, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T3.name = 'Australian GrAND Prix' AND T1.nationality = 'American' AND T3.year = 2008;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DR.driverId) FROM drivers AS DR INNER JOIN results AS RS ON DR.driverId = RS.driverId INNER JOIN races AS RC ON RS.raceId = RC.raceId WHERE DR.nationality = 'British' AND RC."year" = 2008 AND RC.name = 'Australian Grand Prix';

/*
Prediction Result:
(0,)
*/