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
INSERT INTO status (statusid, status) VALUES (2, 'default1'), (1, 'default2'), (0, 'default2'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default1'), (7, 'default1');
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (1, 'default2'), (2, 'unique_2'), (3, 'unique_3');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 2, 'default2', 'default2', 'default2', '2023-01-02', 'default1', 'default1'), (1, 'default1', 0, 'default1', 'default2', 'default1', '2023-01-02', 'default2', 'default2'), (2, 'default1', 0, 'default1', 'default2', 'default1', '2023-01-02', 'default1', 'unique_2'), (3, 'default2', 2, 'default1', 'default1', 'default2', '2023-01-02', 'default1', 'unique_3'), (4, 'default1', NULL, NULL, 'default1', 'default1', NULL, 'default2', 'unique_4'), (5, 'default2', 0, 'default2', 'default1', 'default1', NULL, 'default2', 'unique_5'), (6, 'default2', 0, NULL, 'default2', 'default1', '2023-01-02', 'default2', 'unique_6'), (7, 'default1', NULL, 'default1', 'default1', 'default2', NULL, 'default1', 'unique_7'), (8, 'default2', 0, 'default2', 'default1', 'default1', '2023-01-01', 'default1', 'unique_8');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default2', 'default2', 'default2', 1.0, 1.0, 2, 'default2'), (2, 'default2', 'default1', NULL, 'default2', NULL, 2.0, NULL, 'default1'), (1, 'default1', 'default2', 'default2', NULL, 2.0, 1.0, NULL, 'unique_2'), (3, 'default1', 'default2', 'default2', NULL, 0.0, 0.0, NULL, 'unique_3');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 1, 2, 1, 'default2', '2023-01-02', 'default1', 'default1'), (1, 2, 2, 0, 'default2', '2023-01-01', 'default2', NULL), (2, 3, 3, 1, 'default1', '2023-01-01', 'default1', 'default2'), (3, 2, 3, 0, 'default2', '2023-01-01', 'default2', 'unique_3'), (4, 0, 1, 2, 'default1', '2023-01-02', 'default2', 'unique_4'), (5, 0, 1, 2, 'default2', '2023-01-02', 'default1', 'unique_5');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (1, 2, 0, 0.0, 2, 'default2', 2), (0, 2, 2, 2.0, 0, 'default1', 0), (2, 2, 6, 2.0, 2, NULL, 2), (3, 5, 1, 0.0, 0, 'default1', 0), (4, 5, 5, 2.0, 0, 'default2', 0), (5, 3, 8, 2.0, 1, 'default2', 1), (6, 5, 4, 2.0, 2, 'default2', 2), (7, 5, 7, 2.0, NULL, 'default2', 2), (8, 4, 4, 1.0, 1, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2', 'default1', 2.0)
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname, SUM(results.points) AS total_points FROM drivers INNER JOIN results ON drivers.driverId = results.driverId GROUP BY drivers.driverId ORDER BY total_points DESC, drivers.forename NULLS LAST, drivers.surname NULLS LAST LIMIT 1;

/*
Prediction Result:
*/