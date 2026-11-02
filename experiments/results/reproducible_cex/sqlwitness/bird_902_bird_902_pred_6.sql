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
INSERT INTO status (statusid, status) VALUES (20, 'default1'), (0, 'Alex'), (19, 'default1'), (11, 'default2'), (1, 'default1'), (21, 'default2'), (10, 'Yoong'), (9, 'Yoong'), (2, 'Alex'), (3, 'Alex'), (4, 'Yoong'), (5, 'Yoong'), (6, 'Alex'), (7, 'Yoong'), (8, 'default1'), (12, 'default1'), (13, 'default1'), (14, 'Alex');
INSERT INTO seasons (year, url) VALUES (19, 'Yoong'), (21, 'default2'), (10, 'default1'), (9, 'Alex'), (0, 'unique_4'), (20, 'unique_5'), (11, 'unique_6'), (1, 'unique_7'), (2, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12'), (7, 'unique_13'), (8, 'unique_14');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (19, 'default2', 9, 'Alex', 'default2', 'default2', '2023-01-01', 'Alex', 'Yoong'), (10, 'default1', 0, 'Yoong', 'default2', 'default1', '2023-01-02', 'Yoong', 'Alex'), (20, 'default2', 1, NULL, 'Alex', 'default1', '2023-01-01', 'Alex', 'default2'), (21, 'default2', 20, 'default2', 'Yoong', 'default2', '2023-01-02', 'Alex', 'default1'), (9, 'default1', 10, 'Yoong', 'Alex', 'Yoong', NULL, 'Yoong', 'unique_4'), (11, 'default2', 21, 'Alex', 'default2', 'Yoong', '2023-01-02', 'default2', 'unique_5'), (0, 'default1', 10, 'default1', 'default1', 'default1', '2023-01-01', 'Yoong', 'unique_6'), (1, 'Alex', 21, 'default1', 'default1', 'Yoong', '2023-01-01', 'default1', 'unique_7'), (2, 'default2', 20, NULL, 'Alex', 'default2', '2023-01-01', 'default1', 'unique_8'), (3, 'Alex', 10, 'default2', 'default1', 'default1', '2023-01-01', 'Yoong', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (19, 'Yoong', 'Alex', 'default1', 'Yoong'), (0, 'Yoong', 'default2', 'Alex', 'default1'), (10, 'default2', 'Yoong', 'Yoong', 'Alex'), (11, 'Yoong', 'default1', 'default2', 'default2'), (9, 'default1', 'unique_4', 'Alex', 'default2'), (20, 'default1', 'unique_5', NULL, 'Alex'), (21, 'default2', 'unique_6', 'default1', 'Alex');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (21, 'Alex', 'default2', NULL, 'Yoong', 11.0, 10.0, 1, 'Yoong'), (0, 'Yoong', 'default1', 'default1', 'Alex', 21.0, 19.0, 10, 'default2'), (11, 'Alex', 'Alex', 'Yoong', 'default2', 0.0, NULL, 19, 'default1'), (20, 'default2', 'default1', 'default1', NULL, 1.0, 10.0, 10, 'Alex');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (9, 11, 11, 19, 'default2', '2023-01-02', 'Alex', 'default2'), (0, 21, 11, 1, 'default2', '2023-01-01', 'default1', 'Yoong'), (19, 20, 11, 1, 'Yoong', '2023-01-02', 'default2', 'Alex'), (1, 11, 11, 9, 'default1', '2023-01-01', 'default2', 'default1'), (21, 11, 11, 20, 'default1', '2023-01-02', 'default1', NULL), (11, 5, 20, 10, 'default2', '2023-01-01', 'Alex', 'unique_5'), (10, 2, 11, 0, 'Yoong', '2023-01-01', 'default2', 'unique_6'), (20, 6, 0, 11, 'Yoong', '2023-01-01', 'Yoong', 'unique_7'), (2, 1, 11, 20, 'default2', '2023-01-02', 'Alex', 'unique_8'), (3, 19, 0, 20, 'Yoong', '2023-01-02', 'default2', 'unique_9'), (4, 3, 21, 10, 'Yoong', '2023-01-01', 'default2', 'unique_10'), (5, 20, 21, 10, 'default1', '2023-01-01', 'default2', 'unique_11'), (6, 7, 11, 0, 'Yoong', '2023-01-01', 'default2', 'unique_12'), (7, 6, 20, 19, 'default1', '2023-01-02', 'default2', 'unique_13'), (8, 21, 0, 1, 'default2', '2023-01-01', 'Yoong', 'unique_14'), (12, 10, 21, 21, 'default2', '2023-01-02', 'Yoong', 'unique_15'), (13, 5, 11, 10, 'Yoong', '2023-01-02', NULL, 'unique_16');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (11, 4, 19, 20, 6, 0, 10, 1, 'default1', 0, 9.0, 20, 'default1', 20, 9, 19, 'default1', 'Alex'), (1, 12, 0, 9, 7, NULL, 19, 1, 'default2', 10, 20.0, 9, 'default2', 21, 21, 19, 'Alex', 'Alex'), (21, 8, 19, 9, 2, 10, 0, 11, 'default1', 20, 10.0, 0, 'Alex', 11, 20, 9, 'Yoong', 'default2'), (10, 4, 1, 0, 19, 0, 10, 10, 'Alex', 20, 1.0, 1, 'Yoong', 10, 9, 9, 'default1', 'Yoong'), (0, 19, 9, 21, 6, 21, 11, 10, 'Yoong', 10, 20.0, 11, 'default2', 0, 19, 0, NULL, 'default1'), (9, 0, 9, 0, 2, 0, 20, 19, 'default2', 20, 21.0, 20, 'Alex', 19, 0, NULL, 'default2', 'Yoong'), (20, 13, 19, 19, 2, 0, 19, 10, 'Alex', 20, 19.0, 11, 'Alex', 20, 11, 11, 'Yoong', 'default2');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (19, 9, 10, 11.0, 1, 'default2', 0), (20, 21, 10, 0.0, 20, 'Yoong', 10), (9, 20, 21, 10.0, 19, 'Yoong', 1), (0, 11, 3, 0.0, NULL, NULL, 19), (11, 9, 10, 21.0, 9, 'default1', 11), (10, 5, 2, 20.0, 10, 'Alex', 11), (21, 20, 20, 20.0, 9, 'default1', 11), (1, 6, 19, 19.0, 0, 'default2', 19), (2, 10, 10, 19.0, 0, 'Alex', 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.name FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T1.forename = 'Alex' AND T1.surname = 'Yoong' AND T2.position < 20;

/*
Prediction Result:
('Yoong',)
('default2',)
*/