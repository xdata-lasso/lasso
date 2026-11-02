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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (0, '2015-11-29');
INSERT INTO seasons (year, url) VALUES (2, '2015-11-29');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default2', 2, 'default2', '2015-11-29', 'default2', '2023-01-02', 'default2', '2015-11-29'), (0, 'default2', 2, NULL, 'default1', 'default2', '2015-11-29', NULL, 'default2'), (1, '2015-11-29', 2, 'default2', '2015-11-29', '2015-11-29', '2015-11-29', '2015-11-29', 'default1'), (3, 'default1', NULL, 'default1', 'default2', 'default2', '2015-11-29', 'default1', 'unique_3'), (4, '2015-11-29', 2, 'default1', 'default2', '2015-11-29', '2023-01-01', 'default2', 'unique_4'), (5, 'default2', 0, NULL, '2015-11-29', 'default2', NULL, 'default1', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'default2', NULL, '2015-11-29'), (2, 'default2', '2015-11-29', '2015-11-29', 'default2'), (1, 'default2', 'default1', '2015-11-29', 'default2'), (3, 'default2', 'unique_3', NULL, 'default1'), (4, 'default2', 'unique_4', NULL, 'default1'), (5, 'default2', 'unique_5', NULL, '2015-11-29'), (6, '2015-11-29', 'unique_6', NULL, 'default2'), (7, 'default1', 'unique_7', 'default2', 'default2'), (8, '2015-11-29', 'unique_8', 'default1', 'default2'), (9, '2015-11-29', 'unique_9', NULL, 'default2'), (10, 'default1', 'unique_10', NULL, '2015-11-29'), (11, '2015-11-29', 'unique_11', '2015-11-29', '2015-11-29'), (12, 'default2', 'unique_12', 'default1', '2015-11-29'), (13, 'default1', 'unique_13', NULL, '2015-11-29'), (14, 'default1', 'unique_14', 'default2', '2015-11-29'), (15, 'default1', 'unique_15', '2015-11-29', '2015-11-29'), (16, 'default2', 'unique_16', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', '2015-11-29', NULL, 'default1', 0.0, 1.0, 1, 'default2'), (2, 'default1', '2015-11-29', 'default1', NULL, 0.0, 0.0, 1, '2015-11-29'), (0, 'default2', 'default1', '2015-11-29', NULL, NULL, 2.0, 2, 'default1'), (3, 'default2', 'default1', 'default1', NULL, 2.0, 1.0, 2, 'unique_3'), (4, 'default1', 'default1', NULL, 'default2', 1.0, 0.0, NULL, 'unique_4'), (5, '2015-11-29', '2015-11-29', 'default2', 'default1', 2.0, 0.0, 1, 'unique_5'), (6, 'default1', '2015-11-29', 'default1', NULL, 0.0, 1.0, 0, 'unique_6'), (7, 'default2', 'default2', NULL, 'default2', NULL, NULL, 0, 'unique_7'), (8, 'default2', 'default1', 'default1', 'default1', 0.0, 0.0, 2, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2, 3, 1, '2015-11-29', '2015-11-28', 'default2', 'default2'), (2, 2, 4, 1, 'default1', '2023-01-01', '2015-11-29', '2015-11-29'), (0, 2, 5, 1, 'default1', '2015-11-29', NULL, 'default1'), (3, 2, 8, 2, 'default1', '2015-11-30', 'default2', NULL);
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 0, 1, 13, 0, 2, 1, NULL, 'default1', 0, 1.0, 1, '2015-11-29', 0, 1, 1, '2015-11-29', '2015-11-29'), (2, 0, 1, 5, 1, 1, 0, NULL, '2015-11-29', 2, 1.0, 1, 'default1', 1, NULL, NULL, 'default1', 'default2'), (0, 1, 3, 7, 1, 1, 1, 2, '2015-11-29', 1, 2.0, 1, 'default1', 0, 1, 2, 'default1', NULL), (3, 2, 4, 14, 0, NULL, 2, 2, '2015-11-29', 2, 2.0, 1, 'default1', NULL, NULL, 0, NULL, '2015-11-29'), (4, 1, 1, 13, 0, NULL, 0, 0, 'default1', 2, 1.0, 1, NULL, 1, 1, 1, '2015-11-29', NULL), (5, 0, 4, 3, 0, NULL, 2, 0, '2015-11-29', 1, 1.0, 2, 'default1', 0, NULL, 2, NULL, 'default2'), (6, 2, 4, 11, 0, NULL, 2, 0, 'default2', 2, 0.0, 2, 'default2', 0, 2, 1, 'default2', '2015-11-29'), (7, 0, 5, 14, 1, 1, 1, 2, 'default1', 2, 2.0, 1, 'default2', 2, 1, 1, 'default1', NULL), (8, 3, 2, 9, 0, 2, 2, 1, 'default2', 2, 0.0, 0, NULL, 1, 1, 1, NULL, 'default2'), (9, 3, 4, 13, 0, 0, 1, 1, '2015-11-29', 0, 2.0, 0, 'default1', 1, 2, 0, 'default1', 'default2'), (10, 3, 3, 10, 0, 1, 0, 0, 'default2', 2, 2.0, 2, 'default2', 2, 2, 1, '2015-11-29', 'default1'), (11, 0, 0, 15, 1, 1, 1, NULL, '2015-11-29', 1, 0.0, 0, '2015-11-29', 2, NULL, NULL, 'default1', '2015-11-29'), (12, 0, 1, 10, 0, 0, 1, 2, '2015-11-29', 0, 0.0, 1, 'default1', NULL, 0, 2, 'default1', NULL), (13, 1, 2, 16, 0, 1, 2, NULL, 'default1', 0, 2.0, 2, 'default1', NULL, NULL, 1, NULL, 'default1'), (14, 3, 5, 5, 0, 0, 0, 2, '2015-11-29', 0, 0.0, 0, 'default2', 0, 0, NULL, 'default1', 'default1'), (15, 0, 0, 10, 0, 2, 2, 2, 'default1', 2, 0.0, 2, NULL, NULL, NULL, 2, NULL, NULL), (16, 0, 3, 9, 0, 2, 1, 2, 'default2', 2, 0.0, 1, '2015-11-29', 0, NULL, 1, 'default1', 'default2'), (17, 3, 4, 7, 1, 2, 2, NULL, '2015-11-29', 0, 2.0, 0, 'default2', 0, NULL, 0, '2015-11-29', 'default2'), (18, 2, 3, 7, 1, 2, 1, 1, '2015-11-29', 0, 0.0, 1, NULL, 2, 2, 2, '2015-11-29', '2015-11-29');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '2015-11-29' AND NOT T2.time IS NULL;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT COUNT(*) - COUNT(CASE WHEN NOT results.time IS NULL THEN 1 ELSE NULL END) AS drivers_not_finishing FROM races INNER JOIN results ON races.raceid = results.raceid WHERE races.date = '2015-11-29';

/*
Prediction Result:
(1,)
*/