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
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'albert_park', 'Australian Grand Prix', 'http://circuit1');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (2, 'sepang', 'Sepang International Circuit', 'http://circuit2');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'mclaren', 'McLaren', 'http://cons1');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO seasons (year, url) VALUES (2007, 'http://season2007');
INSERT INTO seasons (year, url) VALUES (2008, 'http://season2008');
INSERT INTO seasons (year, url) VALUES (2009, 'http://season2009');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (1, 'hamilton', 44, 'HAM', 'Lewis', 'Hamilton', 'http://drv1');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (2, 'lewis_other', 99, 'OTH', 'Lewis', 'Alonso', 'http://drv2');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (3, 'duncan_hamilton', 88, 'DHM', 'Duncan', 'Hamilton', 'http://drv3');
INSERT INTO drivers (driverId, driverRef, number, code, forename, surname, url) VALUES (4, 'lewis_hamilton_ref', 77, 'LHM', 'Fernando', 'Alonso', 'http://drv4');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (1, 2008, 1, 2, 'Australian Grand Prix', '2008-03-16', 'http://race1');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (2, 2007, 1, 1, 'Australian Grand Prix', '2007-03-18', 'http://race2');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (3, 2009, 1, 1, 'Australian Grand Prix', '2009-03-29', 'http://race3');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (4, 2008, 2, 1, 'Malaysian Grand Prix', '2008-03-23', 'http://race4');
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (1, 1, 1, 1, 22, 1, 1, '1', 1, 10.0, 58, '1:34:50.616', 5690616, 39, 2, '1:27.452', '218.300', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (2, 2, 1, 1, 2, 4, 3, '3', 3, 6.0, 58, '1:25:00.000', 5100000, 41, 3, '1:26.000', '220.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (3, 3, 1, 1, 1, 18, 4, '4', 4, 5.0, 58, '1:34:00.000', 5640000, 42, 4, '1:28.000', '215.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (4, 4, 1, 1, 22, 9, 5, '5', 5, 4.0, 56, '1:31:00.000', 5460000, 53, 5, '1:35.000', '209.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (5, 1, 2, 1, 23, 2, 2, '2', 2, 8.0, 58, '1:34:55.000', 5695000, 12, 1, '1:27.000', '219.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (6, 1, 3, 1, 24, 3, 6, '6', 6, 3.0, 58, '1:35:00.000', 5700000, 15, 6, '1:28.500', '214.000', 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId) VALUES (7, 1, 4, 1, 25, 4, 7, '7', 7, 2.0, 58, '1:35:10.000', 5710000, 19, 7, '1:29.000', '213.000', 1);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 1, 99, 1, '1:27.452', 87452);
INSERT INTO pitStops (raceId, driverId, stop, lap, time, duration, milliseconds) VALUES (1, 1, 1, 88, '14:30:00', '22.500', 22500);
INSERT INTO qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3) VALUES (1, 1, 1, 1, 22, 1, '1:26.572', '1:25.187', '1:26.714');
INSERT INTO driverStandings (driverStandingsId, raceId, driverId, points, position, positionText, wins) VALUES (1, 1, 1, 10.0, 1, '1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.fastestLap FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.name = 'Australian Grand Prix' AND T2.year = 2008 AND T3.forename = 'Lewis' AND T3.surname = 'Hamilton';

/*
Gold Result:
(39,)
*/

-- Prediction Query
SELECT lap FROM lapTimes JOIN races ON lapTimes.raceId = races.raceId JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE races.year = 2008 AND races.name = 'Australian Grand Prix' AND drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' ORDER BY lapTimes.milliseconds, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST, races.raceid NULLS LAST, drivers.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
(99,)
*/