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
INSERT INTO seasons (year, url) VALUES (2011, 'http://en.wikipedia.org/wiki/2011_Formula_One_season');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://en.wikipedia.org/wiki/Autodromo_Nazionale_Monza');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (10, 'force_india', 'Force India', 'Indian', 'http://en.wikipedia.org/wiki/Force_India');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (853, 2011, 13, 1, 'Italian Grand Prix', '2011-09-11', 'http://en.wikipedia.org/wiki/2011_Italian_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (854, 2011, 14, 1, 'Singapore Grand Prix', '2011-09-25', 'http://en.wikipedia.org/wiki/2011_Singapore_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (855, 2011, 15, 1, 'Japanese Grand Prix', '2011-10-09', 'http://en.wikipedia.org/wiki/2011_Japanese_Grand_Prix');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (18, 'resta', 15, 'DIR', 'Paul', 'di Resta', '1986-04-16', 'British', 'http://en.wikipedia.org/wiki/Paul_di_Resta');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (19, 'stewart', 16, 'STE', 'Paul', 'Stewart', '1965-10-29', 'British', 'http://en.wikipedia.org/wiki/Paul_Stewart');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (20, 'lucas_resta', 17, 'LDR', 'Lucas', 'di Resta', '1988-01-01', 'British', 'http://en.wikipedia.org/wiki/Lucas_di_Resta');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'vettel', 1, 'VET', 'Sebastian', 'Vettel', '1987-07-03', 'German', 'http://en.wikipedia.org/wiki/Sebastian_Vettel');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (101, 853, 18, 10, 15, 11, 8, '8', 8, 4.0, 53, '+1:10.000', 5000000, 48, 9, '1:26.100', '205.5', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (102, 854, 18, 10, 15, 10, 6, '6', 6, 8.0, 61, '+1:05.000', 6000000, 55, 7, '1:50.200', '184.95', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (103, 855, 18, 10, 15, 12, 12, '12', 12, 0.0, 53, '+1:30.000', 5500000, 40, 11, '1:36.500', '210.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (104, 853, 19, 10, 16, 14, 10, '10', 10, 1.0, 53, '+1:20.000', 5010000, 45, 10, '1:27.000', '240.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (105, 854, 19, 10, 16, 15, 11, '11', 11, 0.0, 61, '+1:25.000', 6020000, 50, 12, '1:52.000', '120.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (106, 853, 20, 10, 17, 16, 13, '13', 13, 0.0, 52, '+1 Lap', 5030000, 42, 14, '1:28.000', '250.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (107, 854, 20, 10, 17, 17, 14, '14', 14, 0.0, 60, '+1 Lap', 6040000, 49, 15, '1:53.000', '100.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (108, 853, 1, 10, 1, 1, 1, '1', 1, 25.0, 53, '1:20:00.000', 4800000, 52, 1, '1:24.000', '248.5', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (109, 854, 1, 10, 1, 1, 1, '1', 1, 25.0, 61, '1:59:00.000', 7140000, 58, 1, '1:48.000', '175.0', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SUM(IIF(T2.raceId = 853, T2.fastestLapSpeed, 0)) - SUM(IIF(T2.raceId = 854, T2.fastestLapSpeed, 0))) * 100 / SUM(IIF(T2.raceId = 853, T2.fastestLapSpeed, 0)) FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T1.forename = 'Paul' AND T1.surname = 'di Resta';

/*
Gold Result:
(10.000000000000004,)
*/

-- Prediction Query
SELECT (COALESCE(r1.fastestLapSpeed, 0) - COALESCE(r2.fastestLapSpeed, 0)) * 100.0 / COALESCE(r2.fastestLapSpeed, 0) AS percentage_difference FROM results AS r1 JOIN results AS r2 ON r1.raceId = r2.raceId JOIN drivers AS d ON r1.driverId = d.driverId WHERE d.forename = 'Paul' AND d.surname = 'di Resta' AND r1.raceId = 853 AND r2.raceId = 854;

/*
Prediction Result:
*/