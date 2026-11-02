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
INSERT INTO seasons (year, url) VALUES (2020, 'http://en.wikipedia.org/wiki/2020');
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021');
INSERT INTO seasons (year, url) VALUES (2022, 'http://en.wikipedia.org/wiki/2022');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (1, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 'http://monza');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (2, 'spa', 'Circuit de Spa-Francorchamps', 'Spa', 'Belgium', 'http://spa');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (3, 'silverstone', 'Silverstone Circuit', 'Silverstone', 'UK', 'http://silverstone');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'ham', 'Lewis', 'Hamilton', 'http://ham');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'ver', 'Max', 'Verstappen', 'http://ver');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'lec', 'Charles', 'Leclerc', 'http://lec');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2021, 1, 2, 'Belgian Grand Prix', '2021-08-29', 'http://race10');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 2020, 2, 1, 'Italian Grand Prix', '2020-09-06', 'http://race20');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (30, 2022, 3, 3, 'British Grand Prix', '2022-07-03', 'http://race30');
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (10, 1, 44, 2, '1:45.000', 105000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (20, 2, 78, 1, '1:21.000', 81000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (30, 3, 12, 3, '1:30.000', 90000);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (30, 3, 1, 99, '14:30:00', '25.000', 25000);
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'merc', 'Mercedes', 'German', 'http://merc');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionOrder, points, laps, fastestLap, statusId) VALUES (1, 30, 3, 1, 1, 1, 25.0, 95, 92, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.lap, T2.name, T2.year, T1.location FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId INNER JOIN lapTimes AS T3 ON T3.raceId = T2.raceId ORDER BY T3.lap DESC, T1.circuitid NULLS LAST, T2.raceid NULLS LAST, T3.raceid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(78, 'Italian Grand Prix', 2020, 'Monza')
*/

-- Prediction Query
SELECT T2.laps, T1.name, T1.year, T3.location FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T1.circuitId = T3.circuitId ORDER BY T2.laps DESC, T1.raceid NULLS LAST, T2.resultid NULLS LAST, T3.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
(95, 'British Grand Prix', 2022, 'Silverstone')
*/