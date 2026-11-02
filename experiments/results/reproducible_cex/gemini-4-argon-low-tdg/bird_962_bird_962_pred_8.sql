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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'c1', 'C1', 'http://c1');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'con1', 'Con1', 'http://con1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (1999, 'http://s1999');
INSERT INTO seasons (year, url) VALUES (2000, 'http://s2000');
INSERT INTO seasons (year, url) VALUES (2003, 'http://s2003');
INSERT INTO seasons (year, url) VALUES (2005, 'http://s2005');
INSERT INTO seasons (year, url) VALUES (2006, 'http://s2006');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (1, 'd1', 'F1', 'S1', '1984-12-31', 'http://d1');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (2, 'd2', 'F2', 'S2', '1985-01-01', 'http://d2');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (3, 'd3', 'F3', 'S3', '1986-05-05', 'http://d3');
INSERT INTO drivers (driverId, driverRef, forename, surname, dob, url) VALUES (4, 'd4', 'F4', 'S4', NULL, 'http://d4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 1999, 1, 1, 'R1999', '1999-05-01', 'http://r1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2000, 1, 1, 'R2000', '2000-05-01', 'http://r2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2003, 1, 1, 'R2003', '2003-05-01', 'http://r3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2005, 1, 1, 'R2005', '2005-05-01', 'http://r4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (5, 2006, 1, 1, 'R2006', '2006-05-01', 'http://r5');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (1, 1, 1, 1, 1, '1', 1, 10, 60, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (2, 5, 1, 1, 1, '1', 1, 10, 60, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (3, 2, 1, 1, 1, '1', 1, 10, 51, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (4, 2, 1, 1, 2, '2', 2, 8, 50, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (5, 3, 1, 1, 1, '1', 1, 10, 49, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (6, 3, 2, 1, 2, '2', 2, 8, 51, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (7, 4, 2, 1, 1, '1', 1, 10, 50, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (8, 4, 3, 1, 2, '2', 2, 8, 60, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (9, 4, 4, 1, 3, '3', 3, 6, 60, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T3.dob) < '1985' AND T1.laps > 50, 1, 0)) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.year BETWEEN 2000 AND 2005;

/*
Gold Result:
(14.285714285714286,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.laps > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.year BETWEEN 2000 AND 2005 AND (STRFTIME('%Y', T2.dob) < '1985') OR (STRFTIME('%Y', T2.dob) BETWEEN '2000' AND '2005');

/*
Prediction Result:
(33.333333333333336,)
*/