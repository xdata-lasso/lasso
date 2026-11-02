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
INSERT INTO status (statusid, status) VALUES (2, 'default2'), (1, 'Puncture'), (0, 'Puncture');
INSERT INTO seasons (year, url) VALUES (1, 'Puncture'), (2, 'default2'), (0, 'default1'), (3, 'American'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16'), (17, 'unique_17'), (18, 'unique_18'), (19, 'unique_19'), (20, 'unique_20'), (21, 'unique_21'), (22, 'unique_22'), (23, 'unique_23');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'Puncture', 2, 'default2', 'default2', 'American', '2023-01-01', NULL, 'default2'), (3, 'American', 3, 'Puncture', 'default1', 'default1', '2023-01-01', NULL, 'American'), (1, 'American', 1, 'Puncture', 'American', 'American', '2023-01-01', 'default2', 'Puncture'), (0, 'Puncture', 3, NULL, 'American', 'American', '2023-01-01', 'default1', 'default1'), (4, 'default2', 2, 'default1', 'default2', 'default2', '2023-01-01', 'default2', 'unique_4'), (5, 'default1', NULL, 'default2', 'default1', 'American', '2023-01-01', NULL, 'unique_5'), (6, 'American', 2, 'Puncture', 'American', 'default1', '2023-01-01', NULL, 'unique_6'), (7, 'default1', 2, 'default2', 'default2', 'American', NULL, 'default1', 'unique_7'), (8, 'American', 1, 'default2', 'default1', 'Puncture', '2023-01-02', 'default2', 'unique_8'), (9, 'default1', NULL, 'default1', 'American', 'Puncture', NULL, 'American', 'unique_9'), (10, 'default2', NULL, 'Puncture', 'Puncture', 'default1', '2023-01-01', 'American', 'unique_10'), (11, 'default1', NULL, 'Puncture', 'default1', 'American', NULL, 'Puncture', 'unique_11'), (12, 'default1', 1, 'default2', 'default2', 'default2', NULL, NULL, 'unique_12'), (13, 'American', 0, 'American', 'default1', 'default2', NULL, 'default2', 'unique_13'), (14, 'American', 3, 'default2', 'American', 'default1', NULL, 'American', 'unique_14'), (15, 'American', 0, 'default1', 'Puncture', 'Puncture', '2023-01-01', NULL, 'unique_15'), (16, 'default1', 3, 'default1', 'American', 'default2', '2023-01-02', 'Puncture', 'unique_16');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default1', 'default2', 'default2', 'Puncture'), (1, 'default2', 'default1', 'Puncture', 'default2'), (0, 'default2', 'American', NULL, 'default1'), (3, 'default1', 'Puncture', 'default1', 'default2'), (4, 'default2', 'unique_4', 'American', 'American'), (5, 'default1', 'unique_5', 'default1', 'Puncture'), (6, 'default1', 'unique_6', 'American', 'American'), (7, 'Puncture', 'unique_7', 'Puncture', 'Puncture'), (8, 'default1', 'unique_8', NULL, 'default2'), (9, 'default2', 'unique_9', 'default2', 'Puncture'), (10, 'Puncture', 'unique_10', 'Puncture', 'American'), (11, 'American', 'unique_11', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'American', 'Puncture', 'default2', NULL, 2.0, 2.0, 1, 'American'), (2, 'Puncture', 'default2', 'Puncture', 'American', NULL, 2.0, 0, 'Puncture');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (3, 2, 2, 0, 'American', '2023-01-02', 'Puncture', NULL), (1, 20, 1, 1, 'default2', '2023-01-01', 'American', 'American'), (2, 14, 2, 2, 'default2', '2023-01-02', NULL, 'Puncture'), (0, 6, 1, 3, 'American', '2023-01-01', NULL, 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (3, 1, 9, 3, 0, 3, 2, 3, 'default2', 2, 1.0, 2, 'American', 3, 3, 1, 'default2', 'American'), (1, 1, 10, 7, 2, 3, 3, 1, 'American', 0, 2.0, 1, 'American', 1, 1, 0, 'Puncture', 'Puncture'), (2, 2, 16, 9, 2, NULL, 0, 0, 'default1', 1, 1.0, 1, NULL, 1, 0, 1, 'American', 'Puncture'), (0, 3, 12, 6, 1, NULL, 3, 0, 'default2', 3, 2.0, 0, 'American', 3, 1, 3, NULL, 'default1'), (4, 3, 11, 7, 0, 3, 0, NULL, 'default2', 3, 3.0, 0, 'Puncture', 3, 0, 2, 'American', 'default1'), (5, 2, 14, 1, 0, 2, 3, 0, 'American', 0, 3.0, 3, 'default2', 3, 1, 0, NULL, 'American'), (6, 3, 3, 2, 2, 0, 1, 0, 'default2', 2, 1.0, 2, 'American', 3, 1, 1, 'American', NULL), (7, 2, 0, 10, 2, 0, 0, 0, 'American', 3, 3.0, 3, 'Puncture', 2, 0, NULL, 'default2', 'default1'), (8, 3, 3, 6, 2, 2, 1, 1, 'default1', 2, 0.0, 2, 'default2', 2, 0, 2, 'Puncture', 'Puncture'), (9, 3, 12, 10, 2, NULL, 2, 2, 'default2', 2, 1.0, 2, NULL, 1, 1, 0, 'default2', 'default2'), (10, 1, 16, 3, 2, 1, 0, NULL, 'Puncture', 1, 0.0, 3, 'default1', NULL, NULL, 3, 'default1', 'American'), (11, 1, 8, 11, 0, 0, 0, NULL, 'Puncture', 2, 0.0, 1, NULL, NULL, 1, 1, 'default1', 'Puncture'), (12, 2, 8, 5, 1, NULL, 3, 0, 'Puncture', 1, 3.0, 0, 'American', 2, NULL, 1, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN status AS T3 ON T2.statusId = T3.statusId WHERE T3.status = 2 AND T1.nationality = 'American';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT d.driverId) FROM drivers AS d JOIN results AS r ON d.driverId = r.driverId JOIN status AS s ON r.statusId = s.statusId WHERE s.status = 'Puncture' AND d.nationality = 'American';

/*
Prediction Result:
(2,)
*/