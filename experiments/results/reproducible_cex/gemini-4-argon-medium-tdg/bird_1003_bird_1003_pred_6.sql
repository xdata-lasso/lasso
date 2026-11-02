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
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (1, 'villeneuve', 'Circuit Gilles Villeneuve', 'Canada', 'http://circuit1.com');
INSERT INTO circuits (circuitId, circuitRef, name, country, url) VALUES (2, 'monza', 'Autodromo Nazionale di Monza', 'Italy', 'http://circuit2.com');
INSERT INTO constructors (constructorId, constructorRef, name, url) VALUES (1, 'ferrari', 'Ferrari', 'http://constructor1.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (1, 'd1', 'John', 'Doe', 'http://driver1.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (2, 'd2', 'Jane', 'Smith', 'http://driver2.com');
INSERT INTO drivers (driverId, driverRef, forename, surname, url) VALUES (3, 'd3', 'Max', 'Power', 'http://driver3.com');
INSERT INTO seasons (year, url) VALUES (2020, 'http://season2020.com');
INSERT INTO seasons (year, url) VALUES (2021, 'http://season2021.com');
INSERT INTO seasons (year, url) VALUES (2022, 'http://season2022.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (10, 2020, 1, 1, 'Canadian Grand Prix', '2020-06-01', 'http://race10.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (20, 2021, 1, 1, 'Canadian Grand Prix', '2021-06-01', 'http://race20.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (30, 2022, 1, 1, 'Canadian Grand Prix', '2022-06-01', 'http://race30.com');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (40, 2020, 2, 2, 'Italian Grand Prix', '2020-09-01', 'http://race40.com');
INSERT INTO status (statusId, status) VALUES (1, 'Finished');
INSERT INTO status (statusId, status) VALUES (2, 'Disqualified');
INSERT INTO status (statusId, status) VALUES (3, 'Accident');
INSERT INTO status (statusId, status) VALUES (4, 'Collision');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (101, 10, 1, 1, 1, 'R', 20, 0, 10, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (102, 20, 1, 1, 2, 'R', 19, 0, 15, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (103, 30, 1, 1, 3, 'R', 18, 0, 20, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (104, 10, 2, 1, 4, 'R', 17, 0, 12, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (105, 20, 2, 1, 5, '1', 1, 25, 70, 1);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (106, 30, 2, 1, 6, '2', 2, 18, 70, 2);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (107, 40, 2, 1, 1, 'R', 20, 0, 5, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (108, 40, 2, 1, 2, 'R', 19, 0, 6, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (109, 40, 2, 1, 3, 'R', 18, 0, 7, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (110, 10, 3, 1, 7, 'R', 16, 0, 5, 4);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (111, 20, 3, 1, 8, 'R', 15, 0, 5, 4);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (112, 30, 3, 1, 9, 'R', 14, 0, 5, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T3.statusId = 3 AND T2.name = 'Canadian Grand Prix' GROUP BY T1.driverId ORDER BY COUNT(T1.driverId) DESC LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) AS number_of_accidents FROM status AS s INNER JOIN results AS r ON s.statusId = r.statusId INNER JOIN races AS ra ON r.raceId = ra.raceId WHERE s.statusId = 3 AND ra.name = 'Canadian Grand Prix';

/*
Prediction Result:
(4,)
*/