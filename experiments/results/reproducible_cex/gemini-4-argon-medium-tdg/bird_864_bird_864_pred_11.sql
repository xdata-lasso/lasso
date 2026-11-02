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
-- 1. COUNT(driverId) vs COUNT(DISTINCT driverId) (same driver in multiple results on the target date)
-- 2. T2.time IS NOT NULL vs T2.time IS NULL
-- 3. T1.date = '2015-11-29' vs other dates or year = 2015
-- 4. T2.time vs T1.time or T2.fastestLapTime or T2.milliseconds
-- 5. INNER JOIN vs LEFT JOIN (race on target date with no results)
-- 6. Wrong join keys (e.g. T1.raceId = T2.resultId or T1.raceId = T2.driverId)
INSERT INTO seasons (year, url) VALUES (2015, 'http://en.wikipedia.org/wiki/2015_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (2016, 'http://en.wikipedia.org/wiki/2016_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'yas_marina', 'Yas Marina Circuit', 'http://en.wikipedia.org/wiki/Yas_Marina_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mercedes', 'Mercedes', 'http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Collision');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (10, 'hamilton', 'Lewis', 'Hamilton', 'http://en.wikipedia.org/wiki/Lewis_Hamilton');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (20, 'rosberg', 'Nico', 'Rosberg', 'http://en.wikipedia.org/wiki/Nico_Rosberg');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (100, 'vettel', 'Sebastian', 'Vettel', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (100, 2015, 19, 1, 'Abu Dhabi Grand Prix', '2015-11-29', NULL, 'http://en.wikipedia.org/wiki/2015_Abu_Dhabi_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (101, 2015, 20, 1, 'Abu Dhabi Grand Prix 2', '2015-11-29', '13:00:00', 'http://en.wikipedia.org/wiki/2015_Abu_Dhabi_Grand_Prix_2');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (102, 2015, 18, 1, 'Brazilian Grand Prix', '2015-11-15', '14:00:00', 'http://en.wikipedia.org/wiki/2015_Brazilian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (103, 2016, 1, 1, 'Australian Grand Prix', '2016-03-20', '05:00:00', 'http://en.wikipedia.org/wiki/2016_Australian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (104, 2015, 21, 1, 'Empty Race', '2015-11-29', '15:00:00', 'http://en.wikipedia.org/wiki/Empty_Race');
-- Valid match 1: race 100 (date '2015-11-29', T1.time IS NULL), driver 10, T2.time NOT NULL (while milliseconds and fastestLapTime are NULL)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (1, 100, 10, 1, 1, '1', 1, 25.0, 55, '1:38:04.013', NULL, NULL, 1);
-- Valid match 2: race 101 (date '2015-11-29'), SAME driver 10 (tests COUNT vs COUNT DISTINCT), T2.time NOT NULL
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (2, 101, 10, 1, 1, '1', 1, 25.0, 55, '1:38:05.000', 5885000, '1:44.000', 1);
-- Invalid match (NULL T2.time): race 100 (date '2015-11-29'), driver 20, T2.time IS NULL (but milliseconds and fastestLapTime are NOT NULL, and race 101 has T1.time NOT NULL)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (3, 101, 20, 1, 2, 'R', 2, 0.0, 10, NULL, 100000, '1:45.000', 2);
-- Invalid match (wrong date, same year): race 102 (date '2015-11-15'), driver 20, T2.time NOT NULL. Also resultId = 100 (tests join on T1.raceId = T2.resultId) and driverId = 100 (tests join on T1.raceId = T2.driverId)
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (100, 102, 100, 1, 1, '1', 1, 25.0, 71, '1:31:09.090', 5469090, '1:14.000', 1);
-- Invalid match (wrong year & date): race 103 (date '2016-03-20'), driver 20, T2.time NOT NULL
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, time, milliseconds, fastestLapTime, statusId) VALUES (4, 103, 20, 1, 1, '1', 1, 25.0, 57, '1:48:15.565', 6495565, '1:28.997', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '2015-11-29' AND NOT T2.time IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T2.date = '2015-11-29' AND T3.status <> 'Finished';

/*
Prediction Result:
(1,)
*/