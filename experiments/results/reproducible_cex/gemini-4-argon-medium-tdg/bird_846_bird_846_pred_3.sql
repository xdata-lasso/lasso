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
-- DATASET 2
-- Tests tie-breaking on T1.q1 using T1.qualifyId ASC (when T2.driverId is ordered inversely to T1.qualifyId),
-- and tests NULL handling in T1.q1 DESC (in SQLite, NULLs are considered smallest, so DESC puts NULLs last).
INSERT INTO seasons (year, url) VALUES (2009, 'http://s2009.com');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'sepang', 'Sepang International Circuit', 'http://c1.com');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'ferrari', 'Ferrari', 'http://con1.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (18, 2009, 2, 1, 'Malaysian Grand Prix', '2009-04-05', 'http://r18.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'driver_10', 'A', 'A', 'http://d10.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (20, 'driver_20', 'B', 'B', 'http://d20.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (30, 'driver_30', 'C', 'C', 'http://d30.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (40, 'driver_40', 'D', 'D', 'http://d40.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (50, 'driver_50', 'E', 'E', 'http://d50.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (60, 'driver_60', 'F', 'F', 'http://d60.com');
-- Three rows tied on q1 = '1:30.000'.
-- qualifyId order: 100 (driver 50), 200 (driver 40), 300 (driver 30).
-- Notice driverId is descending as qualifyId is ascending to catch mutants that sort by driverId before qualifyId or sort qualifyId DESC.
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (300, 18, 30, 1, 1, 1, '1:30.000', '1:20.000', '1:10.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (100, 18, 50, 1, 2, 2, '1:30.000', '1:25.000', '1:15.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (200, 18, 40, 1, 3, 3, '1:30.000', '1:22.000', '1:12.000');
-- One row with lower non-null q1
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (50, 18, 20, 1, 4, 4, '1:25.000', NULL, NULL);
-- Two rows with NULL q1 (tied on NULL, broken by qualifyId ASC: 10 then 20)
-- Because there are 4 non-null rows and LIMIT 5, only the first NULL row (qualifyId=10, driver_60) should make it into the top 5!
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (20, 18, 10, 1, 5, 5, NULL, NULL, NULL);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (10, 18, 60, 1, 6, 6, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 18 ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Gold Result:
('driver_50',)
('driver_40',)
('driver_30',)
('driver_20',)
('driver_60',)
*/

-- Prediction Query
SELECT T2.driverRef FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T1.raceId = 18 AND NOT T1.q1 IS NULL ORDER BY T1.q1 DESC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST LIMIT 5;

/*
Prediction Result:
('driver_50',)
('driver_40',)
('driver_30',)
('driver_20',)
*/