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
INSERT INTO seasons (year, url) VALUES (2021, 'http://en.wikipedia.org/wiki/2021_F1');
INSERT INTO seasons (year, url) VALUES (2022, 'http://en.wikipedia.org/wiki/2022_F1');
INSERT INTO seasons (year, url) VALUES (2023, 'http://en.wikipedia.org/wiki/2023_F1');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (1, 'monza', 'Autodromo Nazionale di Monza', 'Monza', 'Italy', 45.6156, 9.2811, 162, 'http://en.wikipedia.org/wiki/Monza');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (2, 'spa', 'Circuit de Spa-Francorchamps', 'Spa', 'Belgium', 50.4372, 5.9714, 401, 'http://en.wikipedia.org/wiki/Spa');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url) VALUES (3, 'silverstone', 'Silverstone Circuit', 'Silverstone', 'UK', 52.0786, -1.0169, 153, 'http://en.wikipedia.org/wiki/Silverstone');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (1, 'ferrari', 'Ferrari', 'Italian', 'http://en.wikipedia.org/wiki/Ferrari');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (2, 'mercedes', 'Mercedes', 'German', 'http://en.wikipedia.org/wiki/Mercedes');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (1, 'leclerc', 16, 'LEC', 'Charles', 'Leclerc', '1997-10-16', 'Monegasque', 'http://en.wikipedia.org/wiki/Leclerc');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url) VALUES (2, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', '1985-01-07', 'British', 'http://en.wikipedia.org/wiki/Hamilton');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2021, 1, 1, 'Italian Grand Prix', '2021-09-12', '12:00:00', 'http://en.wikipedia.org/wiki/2021_Italian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2022, 2, 2, 'Belgian Grand Prix', '2022-08-28', '13:00:00', 'http://en.wikipedia.org/wiki/2022_Belgian_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (3, 2023, 3, 3, 'British Grand Prix', '2023-07-09', '14:00:00', 'http://en.wikipedia.org/wiki/2023_British_GP');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (4, 2023, 4, 1, 'Imola Grand Prix', '2023-05-21', '11:00:00', 'http://en.wikipedia.org/wiki/2023_Imola_GP');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 1, 1, 16, 1, 1, '1', 1, 25.0, 50, '1:10:00.000', 4200000, 1, 1, NULL, '250.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 2, 1, 1, 16, 2, 2, '2', 2, 18.0, 44, '1:15:00.000', 4500000, 10, 2, '1:15.500', '210.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (3, 3, 2, 2, 44, 3, 3, '3', 3, 15.0, 52, '1:30:00.000', 5400000, 45, 3, '1:08.200', '240.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (4, 4, 2, 2, 44, 1, 1, '1', 1, 25.0, 60, '1:20:00.000', 4800000, 5, 1, '1:45.900', '260.000', 1);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 1, 1, 1, '1:01.000', 61000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (3, 2, 1, 1, '1:08.200', 68200);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (2, 1, 1, 10, '13:15:00', '20.100', 20100);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (3, 2, 1, 15, '14:25:00', '25.500', 25500);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 2, 1, 1, 16, 1, '1:04.000', '1:03.500', '1:03.000');
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (2, 3, 2, 2, 44, 2, '1:09.000', '1:08.500', '1:08.000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapTime ASC, T1.raceid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('British Grand Prix',)
*/

-- Prediction Query
SELECT races.name FROM races INNER JOIN results ON races.raceId = results.raceId ORDER BY results.fastestLapSpeed ASC, races.raceid NULLS LAST, results.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Belgian Grand Prix',)
*/