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
INSERT INTO status (statusid, status) VALUES (-1, '1983-07-16'), (2, 'default2');
INSERT INTO seasons (year, url) VALUES (-1, 'default2'), (0, 'default1'), (101, '1983-07-16'), (1, 'unique_3'), (99, 'unique_4'), (2, 'unique_5');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default1', 1, 'default1', 'default2', '1983-07-16', NULL, '1983-07-16', 'default1'), (2, 'default2', 0, 'default2', 'default2', 'default1', '1983-07-17', '1983-07-16', 'default2'), (101, '1983-07-16', 100, 'default1', 'default1', 'default1', '2023-01-02', 'default1', '1983-07-16'), (-1, 'default2', 0, '1983-07-16', '1983-07-16', 'default2', '1983-07-16', '1983-07-16', 'unique_3'), (99, 'default1', 101, '1983-07-16', '1983-07-16', 'default1', '1983-07-17', '1983-07-16', 'unique_4'), (1, 'default1', 100, 'default2', '1983-07-16', 'default2', NULL, '1983-07-16', 'unique_5'), (100, 'default2', 99, 'default1', 'default2', '1983-07-16', '2023-01-02', 'default1', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (100, '1983-07-16', 'default1', 'default1', 'default1'), (-1, 'default2', '1983-07-16', '1983-07-16', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '1983-07-16', '1983-07-16', 'default2', 'default2', 2.0, NULL, 1, 'default2'), (99, '1983-07-16', 'default2', 'default1', 'default2', -1.0, 100.0, -1, '1983-07-16'), (-1, 'default2', 'default1', NULL, '1983-07-16', 2.0, -1.0, 100, 'default1'), (2, '1983-07-16', 'default1', 'default2', 'default2', NULL, 2.0, 99, 'unique_3'), (100, 'default2', 'default2', 'default2', NULL, 2.0, -1.0, -1, 'unique_4'), (101, '1983-07-16', '1983-07-16', 'default1', NULL, 2.0, 2.0, 2, 'unique_5'), (0, '1983-07-16', '1983-07-16', '1983-07-16', 'default2', -1.0, 2.0, 2, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 99, 101, 0, 'default2', '1983-07-16', 'default1', 'default1'), (-1, 101, 99, 0, 'default2', '2023-01-01', 'default1', 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (-1, -1, -1, -1, -1, 0, 100, 99, 'default2', 99, -1.0, 0, '1983-07-16', 1, 0, 100, NULL, NULL), (2, -1, 0, -1, -1, NULL, 101, 1, 'default1', 100, 2.0, 2, 'default2', NULL, 99, 101, 'default2', NULL), (100, 2, 0, 100, -1, 99, 99, NULL, '1983-07-16', 1, 1.0, 1, 'default1', 2, 2, -1, '1983-07-16', '1983-07-16'), (99, 2, 99, -1, -1, NULL, -1, 0, 'default2', 100, 2.0, -1, NULL, 100, 100, 99, 'default1', 'default1'), (0, -1, 2, 100, 2, -1, 99, 100, 'default2', 1, 101.0, 99, 'default1', 2, 2, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN NOT T2.time IS NULL THEN T2.driverId END) AS REAL) * 100 / COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '1983-07-16';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT T2.milliseconds IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.driverId) FROM drivers AS T1 LEFT JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId IN (SELECT raceId FROM races WHERE "date" = '1983-07-16');

/*
Prediction Result:
(100.0,)
*/