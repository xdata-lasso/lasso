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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Albert Park', 'http://circuit1');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://constructor1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'hamilton', 'Lewis', 'Hamilton', 'http://driver1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'alonso', 'Fernando', 'Alonso', 'http://driver2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'raikkonen', 'Kimi', 'Raikkonen', 'http://driver3');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Collision');
INSERT INTO seasons (year, url) VALUES (2008, 'http://season2008');
INSERT INTO seasons (year, url) VALUES (2009, 'http://season2009');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2008, 1, 1, 'Australian GrAND Prix', '2008-03-16', '04:30:00', 'http://race1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2009, 1, 1, 'Australian GrAND Prix', '2009-03-29', '06:00:00', 'http://race2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2008, 2, 1, 'Malaysian Grand Prix', '2008-03-23', NULL, 'http://race3');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (1, 1, 1, 1, 1, '1', 1, 10, 58, '1:34:50.616', 5690616, '1:27.452', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (2, 1, 2, 1, 2, '2', 2, 8, 58, '1:34:50.616', 5690616, '1:27.452', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (3, 1, 3, 1, 3, 'R', 3, 0, 50, NULL, 5000000, '1:28.000', 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (4, 2, 1, 1, 1, '1', 1, 10, 58, '1:34:15.784', 5655784, '1:27.706', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (5, 3, 1, 1, 1, 'R', 1, 0, 10, NULL, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(NOT T1.time IS NULL, 1, 0)) AS REAL) * 100 / COUNT(T1.resultId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian GrAND Prix' AND T2.year = 2008;

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT time IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS completion_rate FROM results WHERE raceId = (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix');

/*
Prediction Result:
(None,)
*/