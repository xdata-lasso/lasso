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
INSERT INTO seasons (year, url) VALUES (2021, 'http://example.com/seasons/2021');
INSERT INTO seasons (year, url) VALUES (2022, 'http://example.com/seasons/2022');
INSERT INTO seasons (year, url) VALUES (2023, 'http://example.com/seasons/2023');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (501, 'villeneuve', 'Circuit Gilles Villeneuve', 'Montreal', 'Canada', 'http://example.com/circuits/501');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (51, 2021, 1, 501, 'Canadian Grand Prix', '2021-06-13', 'http://example.com/races/51');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (52, 2022, 1, 501, 'Canadian Grand Prix', '2022-06-19', 'http://example.com/races/52');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (53, 2023, 1, 501, 'Canadian Grand Prix', '2023-06-18', 'http://example.com/races/53');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (10, 'driver_a', 'Alice', 'Alpha', 'British', 'http://example.com/drivers/10');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (20, 'driver_b', 'Bob', 'Beta', 'Canadian', 'http://example.com/drivers/20');
INSERT INTO drivers (driverId, driverRef, forename, surname, nationality, url) VALUES (30, 'driver_c', 'Charlie', 'Gamma', 'French', 'http://example.com/drivers/30');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (201, 'team_a', 'Team Alpha', 'British', 'http://example.com/constructors/201');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (202, 'team_b', 'Team Beta', 'Italian', 'http://example.com/constructors/202');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (203, 'team_c', 'Team Gamma', 'German', 'http://example.com/constructors/203');
INSERT INTO status (statusId, status) VALUES (3, 'Accident');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (101, 51, 10, 201, 1, 10, 'R', 10, 0, 12, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (102, 51, 20, 201, 2, 11, 'R', 11, 0, 15, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (103, 52, 20, 202, 3, 12, 'R', 12, 0, 20, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (104, 52, 30, 202, 4, 13, 'R', 13, 0, 22, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (105, 53, 20, 203, 5, 14, 'R', 14, 0, 30, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, position, positionText, positionOrder, points, laps, statusId) VALUES (106, 53, 30, 203, 6, 15, 'R', 15, 0, 35, 3);
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
(6,)
*/