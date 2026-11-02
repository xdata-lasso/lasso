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
INSERT INTO status (statusid, status) VALUES (3, 'default1'), (2, 'Puncture'), (0, 'Puncture'), (1, 'Puncture'), (4, 'default1'), (5, 'default2'), (6, 'Puncture'), (7, 'default1'), (8, 'American'), (9, 'default2');
INSERT INTO seasons (year, url) VALUES (2, 'default2'), (3, 'American'), (0, 'default1'), (1, 'Puncture'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'American', 1, NULL, 'default1', 'Puncture', '2023-01-01', 'Puncture', 'default1'), (3, 'default2', 0, 'American', 'default1', 'default2', '2023-01-02', NULL, 'American'), (1, 'default2', NULL, 'Puncture', 'default2', 'default1', NULL, NULL, 'default2'), (2, 'default2', NULL, 'default1', 'default1', 'Puncture', '2023-01-01', 'default2', 'Puncture'), (4, 'Puncture', 0, NULL, 'Puncture', 'default2', '2023-01-01', 'default1', 'unique_4'), (5, 'Puncture', 1, 'default2', 'default1', 'American', '2023-01-01', 'American', 'unique_5'), (6, 'default2', NULL, NULL, 'default1', 'default2', '2023-01-02', 'American', 'unique_6'), (7, 'Puncture', 1, NULL, 'American', 'Puncture', '2023-01-01', NULL, 'unique_7'), (8, 'default2', NULL, 'Puncture', 'Puncture', 'American', '2023-01-02', 'default1', 'unique_8'), (9, 'default1', 2, 'Puncture', 'default2', 'default1', '2023-01-02', 'default2', 'unique_9'), (10, 'American', 2, 'Puncture', 'default2', 'default2', NULL, 'American', 'unique_10'), (11, 'default2', 3, 'default2', 'American', 'American', NULL, 'Puncture', 'unique_11'), (12, 'default1', 2, NULL, 'Puncture', 'default2', '2023-01-01', NULL, 'unique_12'), (13, 'default2', 0, 'default2', 'default2', 'Puncture', NULL, 'American', 'unique_13');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'Puncture', 'default1', 'default2', 'American');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'American', 'Puncture', NULL, NULL, 3.0, 0, 'default1'), (3, 'default2', 'American', 'default1', 'default1', 2.0, 3.0, 2, 'American'), (1, 'Puncture', 'default2', NULL, 'Puncture', 1.0, 1.0, 1, 'default2'), (2, 'default2', 'Puncture', 'Puncture', NULL, 3.0, 1.0, 2, 'Puncture'), (4, 'default1', 'Puncture', 'default2', 'default1', 1.0, NULL, NULL, 'unique_4'), (5, 'American', 'Puncture', 'default1', NULL, 2.0, 1.0, 3, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 12, 4, 0, 'Puncture', '2023-01-02', NULL, 'Puncture'), (3, 8, 5, 0, 'default2', '2023-01-01', 'default2', 'default2'), (1, 1, 1, 1, 'Puncture', '2023-01-01', 'American', 'default1'), (2, 0, 4, 0, 'Puncture', '2023-01-02', 'default2', NULL), (4, 0, 0, 0, 'American', '2023-01-01', 'Puncture', 'American'), (5, 4, 5, 3, 'default2', '2023-01-02', 'default1', 'unique_5'), (6, 4, 3, 2, 'default2', '2023-01-01', 'default1', 'unique_6'), (7, 13, 2, 2, 'American', '2023-01-02', NULL, 'unique_7'), (8, 0, 4, 1, 'default1', '2023-01-01', 'Puncture', 'unique_8'), (9, 12, 3, 1, 'default2', '2023-01-01', 'default2', 'unique_9'), (10, 12, 4, 1, 'Puncture', '2023-01-02', 'American', 'unique_10'), (11, 6, 0, 2, 'Puncture', '2023-01-02', 'default1', 'unique_11'), (12, 1, 1, 1, 'default2', '2023-01-02', 'default1', 'unique_12'), (13, 14, 0, 0, 'American', '2023-01-01', NULL, 'unique_13');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (3, 4, 13, 2, 2, 1, 1, 3, 'American', 0, 3.0, 2, 'default2', NULL, 3, 1, NULL, 'Puncture'), (1, 2, 0, 2, 7, 3, 0, 2, 'American', 0, 3.0, 3, 'Puncture', 3, 3, 1, 'Puncture', NULL), (2, 7, 9, 2, 4, 2, 1, NULL, 'Puncture', 0, 0.0, 1, 'default2', NULL, 3, 2, 'Puncture', 'default1'), (0, 11, 1, 2, 7, 1, 2, 3, 'American', 1, 1.0, 0, 'default1', 3, NULL, 2, 'American', 'default2'), (4, 6, 5, 2, 6, 1, 0, 1, 'Puncture', 2, 0.0, 2, 'default2', NULL, NULL, 1, 'default1', 'default2'), (5, 4, 13, 2, 8, NULL, 0, 2, 'default1', 2, 0.0, 1, 'American', NULL, NULL, 3, 'Puncture', 'default1'), (6, 12, 9, 2, 6, 1, 0, 1, 'default2', 1, 1.0, 0, 'default1', 3, 2, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN status AS T3 ON T2.statusId = T3.statusId WHERE T3.status = 2 AND T1.nationality = 'American';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN status AS T3 ON T2.statusId = T3.statusId WHERE T1.nationality = 'American' AND T3.status = 'Puncture';

/*
Prediction Result:
(2,)
*/