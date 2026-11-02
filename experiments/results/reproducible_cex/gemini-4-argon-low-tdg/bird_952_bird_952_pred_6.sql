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
-- 1. DISTINCT keyword (Constructor 1 has multiple rows with rank = 1).
-- 2. WHERE T1.rank = 1 vs rank > 1, rank < 1, rank IS NULL, or missing WHERE.
-- 3. Column confusion in results: rank vs position, positionOrder, grid, number, fastestLap.
-- 4. Join condition: T1.constructorId = T2.constructorId vs joining on resultId, raceId, driverId.
-- 5. INNER JOIN vs RIGHT/FULL OUTER JOIN (Constructor 4 has no results).
-- 6. Column selection: T2.name vs T2.constructorRef, T2.nationality, or T1 columns.
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_Formula_One_World_Championship');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'bahrain', 'Bahrain International Circuit', 'http://en.wikipedia.org/wiki/Bahrain_International_Circuit');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2021, 1, 1, 'Bahrain Grand Prix', '2021-03-28', 'http://en.wikipedia.org/wiki/2021_Bahrain_Grand_Prix');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'red_bull', 'Red Bull', 'Austrian', 'http://en.wikipedia.org/wiki/Red_Bull_Racing');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (3, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (4, 'mclaren', 'McLaren', 'British', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (10, 'aston_martin', 'Aston Martin', 'British', 'http://en.wikipedia.org/wiki/Aston_Martin_in_Formula_One');
-- Constructor 1 (Mercedes): Two rows with rank = 1, but position/grid/number/positionOrder are NOT 1.
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (101, 10, 10, 1, 44, 2, 2, '2', 2, 18.0, 56, 40, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (102, 10, 10, 1, 77, 3, 3, '3', 3, 15.0, 56, 50, 1, 1);
-- Constructor 2 (Red Bull): position = 1, grid = 1, positionOrder = 1, number = 1, fastestLap = 1, resultId = 1, but rank = 2.
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (1, 10, 10, 2, 1, 1, 1, '1', 1, 25.0, 56, 1, 2, 1);
-- Constructor 3 (Ferrari): rank = 0 and rank IS NULL.
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (3, 10, 10, 3, 16, 4, 4, '4', 4, 12.0, 56, 30, 0, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, fastestLap, rank, statusId) VALUES (4, 10, 10, 3, 55, 5, 5, '5', 5, 10.0, 56, 20, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name FROM results AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.rank = 1;

/*
Gold Result:
('Mercedes',)
*/

-- Prediction Query
SELECT constructors.name FROM constructorStandings INNER JOIN constructors ON constructorStandings.constructorId = constructors.constructorId WHERE constructorStandings.positionText = '1';

/*
Prediction Result:
*/