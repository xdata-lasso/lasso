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
-- DATASET 4
-- Tests adjacent dates ('1983-07-15' and '1983-07-17') to kill <, <=, >, >=, BETWEEN, or LIKE '1983-07%' mutations,
-- and tests 1 / 8 * 100 = 12.5 (fractional decimal result that differs from integer division 12 or 0).
INSERT INTO seasons (year, url) VALUES (1983, 'http://en.wikipedia.org/wiki/1983_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'silverstone', 'Silverstone Circuit', 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'ferrari', 'Ferrari', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'Driver', 'One', 'http://en.wikipedia.org/wiki/D1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'Driver', 'Two', 'http://en.wikipedia.org/wiki/D2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'Driver', 'Three', 'http://en.wikipedia.org/wiki/D3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'd4', 'Driver', 'Four', 'http://en.wikipedia.org/wiki/D4');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'd5', 'Driver', 'Five', 'http://en.wikipedia.org/wiki/D5');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'd6', 'Driver', 'Six', 'http://en.wikipedia.org/wiki/D6');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (7, 'd7', 'Driver', 'Seven', 'http://en.wikipedia.org/wiki/D7');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (8, 'd8', 'Driver', 'Eight', 'http://en.wikipedia.org/wiki/D8');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (5, 'Engine');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 1983, 8, 1, 'Day Before GP', '1983-07-15', '14:00:00', 'http://en.wikipedia.org/wiki/Day_Before');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 1983, 9, 1, 'British Grand Prix', '1983-07-16', '14:00:00', 'http://en.wikipedia.org/wiki/1983_British_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 1983, 10, 1, 'Day After GP', '1983-07-17', '14:00:00', 'http://en.wikipedia.org/wiki/Day_After');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (1, 1, 1, 1, 1, 1, 1, '1:20:00.000');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (2, 1, 2, 1, 2, 2, 1, '+1.000');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (3, 2, 1, 1, 1, 1, 1, '1:24:39.780');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (4, 2, 2, 1, 2, 2, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (5, 2, 3, 1, 3, 3, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (6, 2, 4, 1, 4, 4, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (7, 2, 5, 1, 5, 5, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (8, 2, 6, 1, 6, 6, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (9, 2, 7, 1, 7, 7, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (10, 2, 8, 1, 8, 8, 5, NULL);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (11, 3, 1, 1, 1, 1, 1, '1:30:00.000');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, statusId, time) VALUES (12, 3, 2, 1, 2, 2, 1, '+2.000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN NOT T2.time IS NULL THEN T2.driverId END) AS REAL) * 100 / COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '1983-07-16';

/*
Gold Result:
(12.5,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT T2.milliseconds IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.driverId) FROM drivers AS T1 LEFT JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId IN (SELECT raceId FROM races WHERE "date" = '1983-07-16');

/*
Prediction Result:
(0.0,)
*/