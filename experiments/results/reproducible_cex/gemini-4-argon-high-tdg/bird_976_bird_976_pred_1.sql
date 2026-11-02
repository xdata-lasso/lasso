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
INSERT INTO seasons (year, url) VALUES (2020, 'http://example.com/season/2020');
INSERT INTO circuits (circuitId, circuitRef, name, url) VALUES (1, 'monza', 'Monza', 'http://example.com/circuit/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (1, 2020, 1, 1, 'Italian GP', '2020-09-06', '15:00:00', 'http://example.com/race/1');
INSERT INTO races (raceId, year, round, circuitId, name, date, time, url) VALUES (2, 2020, 2, 1, 'Tuscan GP', '2020-09-13', '09:00:00', 'http://example.com/race/2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'Driver', 'One', 'http://example.com/driver/1');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'Driver', 'Two', 'http://example.com/driver/2');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'Driver', 'Three', 'http://example.com/driver/3');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (4, 'd4', 'Driver', 'Four', 'http://example.com/driver/4');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (5, 'd5', 'Driver', 'Five', 'http://example.com/driver/5');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (6, 'd6', 'Driver', 'Six', 'http://example.com/driver/6');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (7, 'd7', 'Driver', 'Seven', 'http://example.com/driver/7');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (8, 'd8', 'Driver', 'Eight', 'http://example.com/driver/8');
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 1, 1, 7, '10:00.000', 600000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 2, 1, 6, '1:15.000', 75000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 3, 1, 5, '1:20.000', 80000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 4, 1, 4, '1:30.000', 90000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 5, 1, 3, '2:00.000', 70000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 6, 1, 2, '3:00.000', 65000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 7, 1, 1, '4:00.000', 60000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (1, 8, 2, 1, '0:50.000', 50000);
INSERT INTO lapTimes (raceId, driverId, lap, position, time, milliseconds) VALUES (2, 8, 3, 1, '0:55.000', 55000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY time, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Gold Result:
(1,)
(2,)
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY milliseconds ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 5;

/*
Prediction Result:
(7,)
(6,)
(5,)
(2,)
(3,)
*/