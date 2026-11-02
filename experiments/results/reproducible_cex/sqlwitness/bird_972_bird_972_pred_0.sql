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
INSERT INTO status (statusid, status) VALUES (0, 'default1'), (1, 'default1'), (2, 'default1'), (3, 'default1'), (4, '1971'), (5, '1971');
INSERT INTO seasons (year, url) VALUES (0, '1971'), (2, 'default1'), (1, 'default2'), (3, '%Y'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default1', 0, NULL, '%Y', 'default1', '1971-10-27', 'default2', 'default1'), (1, 'default2', NULL, 'default2', '%Y', '%Y', '1971-10-27', '%Y', '1971'), (0, 'default1', NULL, NULL, '1971', 'default2', '1971-10-27', '1971', '%Y'), (3, 'default2', 0, NULL, 'default1', '1971', NULL, 'default2', 'default2'), (4, 'default2', 0, 'default1', '1971', '%Y', '1971-10-27', 'default1', 'unique_4'), (5, 'default2', 2, NULL, 'default1', '1971', '2023-01-02', '%Y', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, '1971', 'default2', NULL, '1971'), (2, 'default1', '1971', '1971', '1971'), (0, '1971', '%Y', 'default1', 'default1'), (3, '%Y', 'default1', 'default1', 'default1'), (4, 'default2', 'unique_4', 'default1', '%Y'), (5, '%Y', 'unique_5', '%Y', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, '1971', 'default1', 'default1', NULL, 0.0, 0.0, 1, 'default1'), (1, 'default1', '1971', '%Y', 'default1', 1.0, 2.0, 0, '%Y'), (0, '%Y', '%Y', NULL, '1971', 0.0, NULL, 1, '1971'), (3, '%Y', 'default2', 'default2', 'default2', 2.0, 2.0, 2, 'default2'), (4, 'default2', '%Y', '%Y', NULL, 1.0, 2.0, NULL, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 0, 1, 0, 'default1', '2023-01-01', '1971', 'default1'), (1, 5, 2, 1, 'default2', '2023-01-02', '1971', NULL), (0, 6, 3, 1, '%Y', '2023-01-02', '1971', '%Y'), (3, 10, 2, 0, '1971', '1971-10-27', NULL, 'default2'), (4, 8, 4, 2, '1971', '2023-01-02', '%Y', '1971'), (5, 10, 4, 2, '1971', '1971-10-27', '%Y', 'unique_5'), (6, 11, 1, 2, 'default2', '2023-01-01', 'default1', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 2, 1, 3, 4, 0, 2, 0, '1971', 0, 0.0, 2, '1971', 0, 1, 2, 'default2', '%Y'), (1, 4, 3, 3, 5, NULL, 0, 1, 'default1', 2, 2.0, 0, '1971', 2, 2, 2, 'default2', '1971'), (2, 5, 3, 4, 2, 1, 2, 1, '1971', 0, 1.0, 1, '%Y', 0, 0, 1, NULL, '%Y'), (3, 0, 2, 4, 4, 0, 2, 0, 'default2', 1, 2.0, 1, '1971', 0, NULL, 2, 'default1', NULL), (4, 4, 4, 4, 0, 0, 0, 2, 'default1', 1, 2.0, 2, '%Y', NULL, NULL, 1, '%Y', NULL), (5, 5, 4, 3, 1, NULL, 1, 1, 'default2', 2, 2.0, 0, '1971', NULL, 1, 1, '%Y', '1971'), (6, 6, 4, 1, 1, 2, 2, 2, 'default2', 2, 1.0, 0, NULL, 0, 1, 2, 'default2', '1971'), (7, 1, 3, 4, 4, 0, 2, 1, '%Y', 2, 2.0, 1, '%Y', 0, 1, 0, NULL, '1971'), (8, 6, 3, 3, 3, 0, 2, 0, 'default1', 0, 2.0, 0, 'default1', NULL, NULL, 1, 'default1', 'default2'), (9, 0, 0, 5, 4, 0, 2, 0, '1971', 1, 2.0, 0, '%Y', NULL, NULL, 1, 'default1', '1971');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId, T2.code FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) = '1971' AND NOT T1.fastestLapTime IS NULL;

/*
Gold Result:
(1, 'default2')
(2, None)
(4, 'default1')
(4, 'default1')
(4, 'default1')
(0, None)
*/

-- Prediction Query
SELECT T1.driverId, T1.code FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T1.dob) = '1971' AND NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapTime, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
(4, 'default1')
*/