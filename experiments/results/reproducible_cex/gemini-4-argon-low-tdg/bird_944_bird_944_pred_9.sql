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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park Grand Prix Circuit', 'http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://en.wikipedia.org/wiki/McLaren');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'heidfeld', 'Nick', 'Heidfeld', 'http://en.wikipedia.org/wiki/Nick_Heidfeld');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'rosberg', 'Nico', 'Rosberg', 'http://en.wikipedia.org/wiki/Nico_Rosberg');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'alonso', 'Fernando', 'Alonso', 'http://en.wikipedia.org/wiki/Fernando_Alonso');
INSERT INTO seasons (year, url) VALUES (2008, 'http://en.wikipedia.org/wiki/2008_Formula_One_season');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Collision');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (18, 2008, 1, 1, 'Australian Grand Prix', '2008-03-16', 'http://en.wikipedia.org/wiki/2008_Australian_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, statusId) VALUES (1, 18, 1, 1, 1, 1, '1', 1, 10.0, 58, '1:34:50.616', 5690616, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, statusId) VALUES (2, 18, 2, 1, 5, 2, '2', 2, 8.0, 58, '+5.478', 5696094, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, statusId) VALUES (3, 18, 3, 1, 7, 3, '3', 3, 6.0, 58, '+8.163', 5698779, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, statusId) VALUES (4, 18, 4, 1, 11, NULL, 'R', 15, 0.0, 10, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian Grand Prix' AND NOT T1.time IS NULL AND T2.year = 2008), champion_time AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = 1), last_driver_incremental AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = (SELECT MAX(positionOrder) FROM time_in_seconds)) SELECT (CAST((SELECT time_seconds FROM last_driver_incremental) AS REAL) * 100) / (SELECT time_seconds + (SELECT time_seconds FROM last_driver_incremental) FROM champion_time);

/*
Gold Result:
(0.14324121009079316,)
*/

-- Prediction Query
SELECT ((MAX(r1.milliseconds) - MIN(r1.milliseconds)) / MAX(r1.milliseconds)) * 100 AS percentage_faster FROM races AS r JOIN results AS r1 ON r.raceId = r1.raceId JOIN drivers AS d1 ON r1.driverId = d1.driverId WHERE r.name = 'Australian Grand Prix' AND r.year = 2008 AND NOT r1.time IS NULL;

/*
Prediction Result:
(0,)
*/