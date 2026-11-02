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
INSERT INTO status (statusid, status) VALUES (51, 'French'), (50, 'default1'), (0, 'default2'), (1, 'default1'), (49, 'default2'), (2, 'French'), (3, 'default1'), (4, 'French'), (5, 'French'), (6, 'default2'), (7, 'default1'), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'French'), (12, 'default2'), (13, 'default1'), (14, 'French');
INSERT INTO seasons (year, url) VALUES (50, 'French'), (51, 'default2'), (1, 'default1'), (0, 'unique_3'), (49, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'French', 1, 'default2', 'default1', 'default1', '2023-01-02', NULL, 'French'), (50, 'default1', 0, 'default2', 'French', 'default1', '2023-01-02', 'French', 'default1'), (51, 'French', 49, 'French', 'default1', 'default1', '2023-01-01', 'default1', 'default2'), (49, 'default1', 0, 'default1', 'French', 'default2', '2023-01-01', 'default1', 'unique_3'), (1, 'default2', 0, 'default1', 'default2', 'default1', '2023-01-01', 'French', 'unique_4'), (2, 'default2', NULL, NULL, 'default2', 'default1', '2023-01-01', 'French', 'unique_5'), (3, 'default1', NULL, 'default2', 'French', 'French', '2023-01-02', 'default1', 'unique_6'), (4, 'default1', 50, 'French', 'French', 'default1', NULL, 'default1', 'unique_7'), (5, 'French', 51, 'default1', 'default2', 'default1', '2023-01-01', 'French', 'unique_8'), (6, 'French', NULL, NULL, 'default1', 'default2', '2023-01-02', 'French', 'unique_9'), (7, 'default1', 49, NULL, 'default1', 'default2', '2023-01-01', NULL, 'unique_10'), (8, 'French', 50, 'French', 'default2', 'default2', NULL, NULL, 'unique_11'), (9, 'default1', 51, 'French', 'default2', 'default1', '2023-01-02', NULL, 'unique_12'), (10, 'French', 51, 'French', 'default1', 'default2', '2023-01-01', 'default2', 'unique_13'), (11, 'French', 50, NULL, 'default1', 'default2', NULL, 'French', 'unique_14'), (12, 'French', 49, 'default1', 'default1', 'default2', '2023-01-01', 'default1', 'unique_15'), (13, 'default2', 49, 'French', 'default2', 'default2', '2023-01-01', 'default2', 'unique_16');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'default1', 'French', 'French');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (49, 'default1', 'default1', NULL, 'French', 49.0, 0.0, 51, 'default1'), (1, 'default2', 'default1', NULL, NULL, 51.0, 49.0, 1, 'default2'), (51, 'default2', 'default2', NULL, NULL, 50.0, 50.0, 51, 'French'), (50, 'French', 'French', 'default1', 'French', 49.0, 1.0, 50, 'unique_3'), (0, 'French', 'French', 'default2', 'default2', 1.0, 50.0, 0, 'unique_4'), (2, 'French', 'default2', 'French', 'default1', NULL, NULL, 49, 'unique_5'), (3, 'default2', 'French', 'default1', 'French', NULL, 51.0, NULL, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (49, 50, 49, 1, 'French', '2023-01-01', 'French', 'default1'), (0, 50, 51, 51, 'default2', '2023-01-02', 'default1', NULL), (1, 2, 50, 1, 'French', '2023-01-01', 'French', 'default2'), (50, 51, 50, 49, 'French', '2023-01-02', 'default2', 'French'), (51, 49, 1, 49, 'French', '2023-01-02', NULL, 'unique_4'), (2, 4, 3, 0, 'French', '2023-01-01', 'default1', 'unique_5'), (3, 3, 51, 0, 'French', '2023-01-02', 'French', 'unique_6'), (4, 50, 50, 0, 'French', '2023-01-02', 'default2', 'unique_7'), (5, 49, 3, 0, 'default2', '2023-01-02', 'French', 'unique_8'), (6, 6, 51, 50, 'default1', '2023-01-02', NULL, 'unique_9'), (7, 2, 51, 49, 'default1', '2023-01-01', 'French', 'unique_10'), (8, 0, 49, 1, 'default1', '2023-01-02', NULL, 'unique_11'), (9, 2, 49, 1, 'default2', '2023-01-02', 'default2', 'unique_12'), (10, 6, 50, 0, 'default2', '2023-01-01', 'default1', 'unique_13');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (49, 9, 3, 0, 5, 1, 51, 51, 'default2', 0, 51.0, 1, 'default2', 51, NULL, 50, 'French', 'French'), (1, 50, 1, 0, 11, 51, 49, 1, 'French', 50, 0.0, 1, NULL, 1, 1, NULL, 'French', 'default2'), (0, 51, 50, 0, 12, 50, 49, 50, 'default1', 51, 0.0, 1, 'default1', 50, 0, 49, 'default2', 'default2'), (50, 7, 8, 0, 12, NULL, 51, NULL, 'French', 49, 51.0, 50, 'French', 0, 51, NULL, 'default1', NULL);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (2, 51, 1, 0, 'default1', NULL), (49, 10, 49, 0, 'French', NULL), (7, 3, 51, NULL, 'default2', 0), (7, 13, 0, 50, 'default1', 49), (6, 7, 50, 49, 'default1', 1), (7, 5, 50, 50, 'default2', 51), (2, 4, 51, 51, 'default2', 1), (0, 5, 49, NULL, 'French', 1), (7, 50, 0, 50, 'French', 0), (6, 7, 49, 51, 'default2', 50), (6, 4, 49, 1, 'default1', NULL), (51, 4, 1, 1, NULL, 51), (3, 7, 49, 49, 'default2', NULL), (1, 6, 1, 51, 'default2', 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.constructorId) FROM results AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.laps > 50 AND T2.nationality = 'French';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.constructorId) FROM constructors AS T1 INNER JOIN results AS T2 ON T1.constructorId = T2.constructorId INNER JOIN lapTimes AS T3 ON T2.raceId = T3.raceId WHERE T1.nationality = 'French' AND T3.lap > 50;

/*
Prediction Result:
(1,)
*/