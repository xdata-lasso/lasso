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
-- DATASET 3
INSERT INTO seasons (year, url) VALUES (2019, 'http://example.com/seasons/2019');
INSERT INTO seasons (year, url) VALUES (2020, 'http://example.com/seasons/2020');
INSERT INTO seasons (year, url) VALUES (2021, 'http://example.com/seasons/2021');
INSERT INTO seasons (year, url) VALUES (2022, 'http://example.com/seasons/2022');
INSERT INTO seasons (year, url) VALUES (2023, 'http://example.com/seasons/2023');
INSERT INTO circuits (circuitId, circuitRef, name, location, country, url) VALUES (501, 'villeneuve', 'Circuit Gilles Villeneuve', 'Montreal', 'Canada', 'http://example.com/circuits/501');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (51, 2019, 1, 501, 'Canadian Grand Prix', '2019-06-09', 'http://example.com/races/51');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (52, 2020, 1, 501, 'Canadian Grand Prix', '2020-06-14', 'http://example.com/races/52');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (53, 2021, 1, 501, 'Canadian Grand Prix', '2021-06-13', 'http://example.com/races/53');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (54, 2022, 1, 501, 'Canadian Grand Prix', '2022-06-19', 'http://example.com/races/54');
INSERT INTO races (raceId, year, round, circuitId, name, date, url) VALUES (55, 2023, 1, 501, 'Canadian Grand Prix', '2023-06-18', 'http://example.com/races/55');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, nationality, url) VALUES (10, 'dup_drv', 'DUP', 'John', 'Smith', 'British', 'http://example.com/drivers/10');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, nationality, url) VALUES (11, 'dup_drv', 'DUP', 'John', 'Smith', 'British', 'http://example.com/drivers/11');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, nationality, url) VALUES (20, 'true_max', 'TRU', 'Lewis', 'Hamilton', 'German', 'http://example.com/drivers/20');
INSERT INTO drivers (driverId, driverRef, code, forename, surname, nationality, url) VALUES (30, 'acc_text', 'ACC', 'Max', 'Verstappen', 'Dutch', 'http://example.com/drivers/30');
INSERT INTO constructors (constructorId, constructorRef, name, nationality, url) VALUES (201, 'team_a', 'Team Alpha', 'British', 'http://example.com/constructors/201');
INSERT INTO status (statusId, status) VALUES (3, 'Collision');
INSERT INTO status (statusId, status) VALUES (4, 'Accident');
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (101, 51, 10, 201, 1, 'R', 10, 0, 10, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (102, 52, 10, 201, 1, 'R', 10, 0, 10, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (103, 53, 11, 201, 2, 'R', 11, 0, 10, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (104, 54, 11, 201, 2, 'R', 11, 0, 10, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (105, 51, 20, 201, 3, 'R', 12, 0, 15, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (106, 52, 20, 201, 3, 'R', 12, 0, 15, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (107, 53, 20, 201, 3, 'R', 12, 0, 15, 3);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (108, 51, 30, 201, 4, 'R', 13, 0, 20, 4);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (109, 52, 30, 201, 4, 'R', 13, 0, 20, 4);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (110, 53, 30, 201, 4, 'R', 13, 0, 20, 4);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (111, 54, 30, 201, 4, 'R', 13, 0, 20, 4);
INSERT INTO results (resultId, raceId, driverId, constructorId, grid, positionText, positionOrder, points, laps, statusId) VALUES (112, 55, 30, 201, 4, 'R', 13, 0, 20, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T3.statusId = 3 AND T2.name = 'Canadian Grand Prix' GROUP BY T1.driverId ORDER BY COUNT(T1.driverId) DESC LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T2.name = 'Canadian Grand Prix' AND T3.status = 'Accident' GROUP BY T1.driverId ORDER BY COUNT(*) DESC LIMIT 1;

/*
Prediction Result:
(5,)
*/