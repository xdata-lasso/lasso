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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://monza');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'ferrari', 'Ferrari', 'http://ferrari');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'leclerc', 'Charles', 'Leclerc', 'http://leclerc');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (2020, 'http://2020');
INSERT INTO seasons (year, url) VALUES (2021, 'http://2021');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2020, 1, 1, 'Italian GP', '2020-09-06', '14:00:00', 'http://race1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2020, 2, 1, 'Tuscan GP', '2020-09-13', '14:00:00', 'http://race2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2021, 1, 1, 'Bahrain GP', '2021-03-28', '15:00:00', 'http://race3');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, rank, statusId) VALUES (1, 1, 1, 1, 1, 1, '1', 1, 25, 53, '1:20:30.500', 4830500, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, rank, statusId) VALUES (2, 1, 1, 1, 2, 2, '2', 2, 18, 53, '+5.123', 4835623, 2, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, rank, statusId) VALUES (3, 2, 1, 1, 1, 1, '1', 1, 25, 59, '2:10:15.250', 7815250, 1, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, milliseconds, rank, statusId) VALUES (4, 3, 1, 1, 1, 1, '1', 1, 25, 56, '1:32:03.897', 5523897, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
(2020, 6322.875)
(2021, 5523.897)
*/

-- Prediction Query
SELECT T1.year, AVG(STRFTIME('%H', T2.time) * 3600 + STRFTIME('%M', T2.time) * 60 + STRFTIME('%S', T2.time)) AS average_time_seconds FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE T2.position = 1 AND T1.year < 1975 GROUP BY T1.year;

/*
Prediction Result:
*/