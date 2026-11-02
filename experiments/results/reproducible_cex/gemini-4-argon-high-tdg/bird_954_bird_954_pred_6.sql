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
INSERT INTO seasons (year, url) VALUES (2006, 'http://seasons/2006');
INSERT INTO seasons (year, url) VALUES (2007, 'http://seasons/2007');
INSERT INTO seasons (year, url) VALUES (2008, 'http://seasons/2008');
INSERT INTO seasons (year, url) VALUES (2009, 'http://seasons/2009');
INSERT INTO seasons (year, url) VALUES (2010, 'http://seasons/2010');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (1, 'suzuka', 'Suzuka', 'Japan', 'http://circuits/1');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'super_aguri', 'Super Aguri', 'Japanese', 'http://constructors/1');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (1, 'sato', 'Takuma', 'Sato', 'Japanese', 'http://drivers/1');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (2, 'nakajima', 'Kazuki', 'Nakajima', 'Japanese', 'http://drivers/2');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (3, 'kobayashi', 'Kamui', 'Kobayashi', 'Japanese', 'http://drivers/3');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (4, 'hamilton', 'Lewis', 'Hamilton', 'British', 'http://drivers/4');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Engine');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2006, 1, 1, '2006 GP', '2006-03-12', '14:00:00', 'http://races/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2007, 1, 1, '2007 GP', '2007-03-18', '14:00:00', 'http://races/2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2008, 1, 1, '2008 GP', '2008-03-16', '14:00:00', 'http://races/3');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (4, 2009, 1, 1, '2009 GP', '2009-03-29', '14:00:00', 'http://races/4');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (5, 2010, 1, 1, '2010 GP', '2010-03-14', '14:00:00', 'http://races/5');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (1, 1, 1, 1, 10, 8, '8', 8, 1.0, 58, '1:30:00.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (2, 2, 1, 1, 12, 6, '6', 6, 3.0, 58, '1:31:00.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (3, 2, 2, 1, 14, 7, '7', 7, 2.0, 58, '1:31:15.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (4, 3, 1, 1, 15, NULL, 'R', 18, 0.0, 20, NULL, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (5, 3, 2, 1, 16, NULL, 'R', 19, 0.0, 15, NULL, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (6, 4, 1, 1, 11, 5, '5', 5, 4.0, 58, '1:32:00.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (7, 4, 2, 1, 13, NULL, 'R', 17, 0.0, 30, NULL, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (8, 4, 3, 1, 17, NULL, 'R', 20, 0.0, 10, NULL, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (9, 5, 3, 1, 9, 4, '4', 4, 12.0, 58, '1:29:00.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, time, statusId) VALUES (10, 3, 4, 1, 1, 1, '1', 1, 10.0, 58, '1:28:00.000', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(NOT T1.time IS NULL, 1, 0)) AS REAL) * 100 / COUNT(T1.raceId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T3.nationality = 'Japanese' AND T2.year BETWEEN 2007 AND 2009;

/*
Gold Result:
(42.857142857142854,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT r.time IS NULL THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM races AS r INNER JOIN results AS res ON r.raceId = res.raceId INNER JOIN drivers AS d ON res.driverId = d.driverId WHERE r.year BETWEEN 2007 AND 2009 AND d.nationality = 'Japanese';

/*
Prediction Result:
(100.0,)
*/