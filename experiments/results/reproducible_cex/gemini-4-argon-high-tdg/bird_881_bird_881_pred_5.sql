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
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'silverstone', 'Silverstone Circuit', 'Silverstone', 'UK', 52.0786, -1.01694, 153, 'http://en.wikipedia.org/wiki/Silverstone_Circuit');
INSERT INTO seasons (year, url) VALUES (1983, 'http://en.wikipedia.org/wiki/1983_Formula_One_season');
INSERT INTO seasons (year, url) VALUES (1984, 'http://en.wikipedia.org/wiki/1984_Formula_One_season');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Scuderia_Ferrari');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'prost', 15, 'PRO', 'Alain', 'Prost', '1955-02-24', 'French', 'http://en.wikipedia.org/wiki/Alain_Prost');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'piquet', 5, 'PIQ', 'Nelson', 'Piquet', '1952-08-17', 'Brazilian', 'http://en.wikipedia.org/wiki/Nelson_Piquet');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (3, 'arnoux', 28, 'ARN', 'Rene', 'Arnoux', '1948-07-04', 'French', 'http://en.wikipedia.org/wiki/Rene_Arnoux');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Disqualified');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 1983, 9, 1, 'British Grand Prix', '1983-07-16', NULL, 'http://en.wikipedia.org/wiki/1983_British_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 1983, 10, 1, 'German Grand Prix', '1983-07-17', '14:00:00', 'http://en.wikipedia.org/wiki/1983_German_Grand_Prix');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 1984, 9, 1, 'Dallas Grand Prix', '1984-07-16', '14:00:00', 'http://en.wikipedia.org/wiki/1984_Dallas_Grand_Prix');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 1, 1, NULL, 1, NULL, 'D', 1, 9.0, 67, '1:24:39.780', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 1, 2, 1, 5, 2, 1, '1', 2, 6.0, 67, NULL, 5079780, 10, 1, '1:14.200', '220.5', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (3, 1, 3, 1, 28, 3, 2, '2', 3, 4.0, 66, NULL, 5089780, 12, 2, '1:15.100', '218.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (4, 2, 1, 1, 15, 1, 1, '1', 1, 9.0, 45, '1:27:10.000', 5230000, 5, 1, '1:55.000', '210.0', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (5, 3, 2, 1, 5, 1, 1, '1', 1, 9.0, 67, '2:01:00.000', 7260000, 8, 1, '1:45.000', '160.0', 1);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 1, 1, 1, '1:16.000', 76000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 2, 1, 2, '1:17.000', 77000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 1, 30, '14:40:00', '25.000', 25000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 2, 1, 31, '14:41:00', '26.000', 26000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN NOT T2.time IS NULL THEN T2.driverId END) AS REAL) * 100 / COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '1983-07-16';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT results.driverId) AS REAL) * 100.0 / COUNT(*) AS completion_rate FROM races JOIN results ON races.raceId = results.raceId WHERE races.date = '1983-07-16';

/*
Prediction Result:
(100.0,)
*/