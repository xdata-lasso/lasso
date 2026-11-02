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
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020_F1');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'monaco', 'Circuit de Monaco', 'Monte-Carlo', 'Monaco', 43.7347, 7.4205, 7, 'http://en.wikipedia.org/wiki/Monaco');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'red_bull', 'Red Bull', 'Austrian', 'http://en.wikipedia.org/wiki/Red_Bull');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'verstappen', 33, 'VER', 'Max', 'Verstappen', '1997-09-30', 'Dutch', 'http://en.wikipedia.org/wiki/Verstappen');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (10, 2020, 2, 1, 'Monaco Grand Prix', '2020-05-24', '13:10:00', 'http://en.wikipedia.org/wiki/2020_Monaco_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (20, 2020, 1, 1, 'French Grand Prix', '2020-06-28', '13:10:00', 'http://en.wikipedia.org/wiki/2020_French_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (30, 2020, 3, 1, 'Spanish Grand Prix', '2020-08-16', '13:10:00', 'http://en.wikipedia.org/wiki/2020_Spanish_GP');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (5, 20, 1, 1, 33, 1, 1, '1', 1, 25.0, 70, '1:25:00.000', 5100000, 50, 1, '1:11.111', '205.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (50, 10, 1, 1, 33, 2, 2, '2', 2, 18.0, 78, '1:35:00.000', 5700000, 60, 2, '1:11.111', '165.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 30, 1, 1, 33, 1, 1, '1', 1, 25.0, 66, '1:20:00.000', 4800000, 40, 1, '1:19.999', '215.000', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapTime ASC, T1.raceid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('Monaco Grand Prix',)
*/

-- Prediction Query
SELECT T3.name FROM results AS T1 INNER JOIN laptimes AS T2 ON T1.raceId = T2.raceId INNER JOIN races AS T3 ON T1.raceId = T3.raceId GROUP BY T1.fastestLapTime ORDER BY T1.fastestLapTime ASC, T3.name NULLS LAST LIMIT 1;

/*
Prediction Result:
*/