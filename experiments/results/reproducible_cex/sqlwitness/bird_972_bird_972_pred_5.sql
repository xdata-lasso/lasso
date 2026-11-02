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
INSERT INTO status (statusid, status) VALUES (0, 'default1'), (1, '%Y'), (2, '1971'), (3, '1971'), (4, '1971'), (5, '1971'), (6, '1971'), (7, '%Y'), (8, 'default2'), (9, '%Y'), (10, '1971');
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (0, '1971'), (2, 'default2'), (3, '%Y'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', 1, 'default2', 'default2', 'default1', NULL, '%Y', '%Y'), (0, 'default1', 0, 'default1', '1971', 'default2', '1971-10-27', '%Y', 'default2'), (2, '1971', NULL, 'default2', 'default1', '%Y', '2023-01-01', '1971', '1971'), (3, 'default1', 1, '%Y', '%Y', 'default1', NULL, 'default1', 'default1'), (4, 'default1', 0, 'default2', 'default2', '%Y', '2023-01-01', 'default1', 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default1', 'default2', '1971', 'default1'), (0, '1971', '1971', NULL, 'default2'), (2, 'default2', '%Y', '%Y', 'default1'), (3, '%Y', 'default1', 'default1', 'default1'), (4, 'default1', 'unique_4', '1971', 'default1'), (5, '1971', 'unique_5', 'default2', 'default1'), (6, 'default1', 'unique_6', NULL, 'default2'), (7, '%Y', 'unique_7', 'default2', '%Y'), (8, 'default1', 'unique_8', '%Y', 'default1'), (9, 'default1', 'unique_9', '%Y', '%Y'), (10, 'default2', 'unique_10', 'default1', '%Y'), (11, '%Y', 'unique_11', NULL, 'default2'), (12, '1971', 'unique_12', NULL, 'default1'), (13, '1971', 'unique_13', NULL, 'default2'), (14, 'default2', 'unique_14', 'default1', '1971'), (15, 'default1', 'unique_15', '1971', 'default1'), (16, 'default1', 'unique_16', 'default2', 'default1'), (17, 'default2', 'unique_17', '1971', '1971');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '%Y', '%Y', 'default2', '1971', 1.0, NULL, 1, 'default2'), (0, '%Y', 'default2', '%Y', NULL, 1.0, 1.0, 1, '%Y'), (2, 'default1', '1971', '%Y', '1971', 1.0, 1.0, 1, 'default1'), (3, '%Y', '%Y', '1971', NULL, 1.0, NULL, 0, '1971'), (4, 'default1', '1971', NULL, 'default1', 1.0, 0.0, NULL, 'unique_4'), (5, '1971', '1971', NULL, 'default2', NULL, NULL, NULL, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 1, 1, '%Y', '1971-10-27', NULL, 'default1'), (0, 0, 1, 1, 'default1', '2023-01-02', '%Y', '%Y'), (2, 9, 4, 1, 'default1', '2023-01-02', 'default2', 'default2'), (3, 2, 2, 0, 'default2', '1971-10-27', '1971', NULL), (4, 8, 4, 1, 'default1', '2023-01-01', '%Y', '1971'), (5, 3, 0, 0, 'default2', '2023-01-02', 'default1', 'unique_5'), (6, 0, 2, 1, '%Y', '1971-10-27', 'default2', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 6, 0, 0, 1, 0, 1, 0, '%Y', 0, 0.0, 0, 'default2', NULL, 1, 1, 'default2', '1971'), (0, 6, 1, 1, 5, 1, 1, 1, '%Y', 1, 1.0, 0, '1971', 0, 0, 1, NULL, '%Y'), (2, 3, 3, 6, 4, 1, 0, 1, '%Y', 0, 0.0, 1, '1971', NULL, NULL, 1, '%Y', 'default1'), (3, 5, 0, 8, 3, 0, 0, NULL, 'default1', 0, 1.0, 1, '1971', 0, NULL, NULL, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId, T2.code FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) = '1971' AND NOT T1.fastestLapTime IS NULL;

/*
Gold Result:
(0, 'default1')
(0, 'default1')
*/

-- Prediction Query
SELECT DISTINCT D.driverId, D.code FROM drivers AS D INNER JOIN results AS R ON D.driverId = R.driverId WHERE STRFTIME('%Y', D.dob) = '1971' AND NOT R.fastestLapTime IS NULL;

/*
Prediction Result:
(0, 'default1')
*/