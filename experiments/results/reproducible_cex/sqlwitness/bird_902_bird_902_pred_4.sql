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
INSERT INTO status (statusid, status) VALUES (11, 'Alex');
INSERT INTO seasons (year, url) VALUES (10, 'Yoong'), (19, 'default1'), (21, 'default2'), (0, 'Alex'), (1, 'unique_4'), (9, 'unique_5'), (11, 'unique_6'), (20, 'unique_7'), (2, 'unique_8'), (3, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default2', 0, 'default2', 'Alex', 'Yoong', NULL, 'default2', 'default2'), (10, 'Alex', 20, 'Yoong', 'Alex', 'default2', NULL, 'default2', 'Alex'), (19, 'Alex', 10, 'default2', 'default1', 'Yoong', '2023-01-01', NULL, 'default1'), (9, 'default2', 1, 'default1', 'Yoong', 'default2', '2023-01-02', NULL, 'Yoong'), (20, 'Yoong', 9, NULL, 'default2', 'default1', NULL, 'default2', 'unique_4'), (11, 'Yoong', 21, 'default1', 'Yoong', 'Yoong', '2023-01-01', 'Alex', 'unique_5'), (21, 'Yoong', 0, 'Yoong', 'Alex', 'Alex', '2023-01-02', 'Yoong', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (10, 'Yoong', 'Alex', 'default1', 'default2'), (20, 'Yoong', 'default1', 'Yoong', 'Alex'), (1, 'Alex', 'default2', 'default2', 'default1'), (21, 'default2', 'Yoong', 'Alex', 'default1'), (0, 'Yoong', 'unique_4', NULL, 'default1'), (9, 'Alex', 'unique_5', NULL, 'Yoong'), (11, 'Alex', 'unique_6', 'default1', 'default2'), (19, 'Alex', 'unique_7', 'Yoong', 'Alex'), (2, 'default2', 'unique_8', NULL, 'default1'), (3, 'Yoong', 'unique_9', 'Yoong', 'Yoong');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (9, 'default2', 'Yoong', NULL, 'Alex', NULL, 1.0, 11, 'Alex'), (20, 'Alex', 'Alex', 'default1', 'default2', 11.0, 10.0, NULL, 'default2'), (11, 'Yoong', 'Yoong', NULL, NULL, 21.0, NULL, 0, 'Yoong'), (19, 'Yoong', 'default1', 'default1', 'Alex', 10.0, NULL, 19, 'default1'), (10, 'default1', 'default1', 'Yoong', 'Alex', 1.0, 21.0, 11, 'unique_4'), (21, 'Yoong', 'default1', NULL, 'default1', 0.0, 20.0, NULL, 'unique_5'), (1, 'default2', 'Alex', 'Alex', 'default2', 20.0, NULL, 19, 'unique_6'), (0, 'Yoong', 'Yoong', NULL, 'Alex', 21.0, 20.0, 19, 'unique_7'), (2, 'default1', 'default2', NULL, NULL, 1.0, 19.0, 20, 'unique_8'), (3, 'Alex', 'default2', NULL, 'default1', 20.0, 19.0, 21, 'unique_9'), (4, 'default2', 'Alex', 'default2', 'default1', 1.0, 10.0, 10, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (9, 0, 9, 21, 'default2', '2023-01-02', 'default2', NULL), (20, 11, 10, 10, 'default2', '2023-01-02', 'Alex', 'Alex'), (0, 20, 20, 11, 'default1', '2023-01-02', 'default2', 'default2'), (10, 3, 9, 19, 'default2', '2023-01-01', 'default2', 'Yoong');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (21, 20, 1, 19, 11, 9, 20, 19, 'Yoong', 1, 1.0, 21, 'Alex', 21, NULL, 20, 'Alex', 'default1'), (11, 10, 9, 19, 11, 10, 0, 10, 'default1', 9, 19.0, 1, 'Yoong', 1, 19, 19, 'default1', NULL);
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (19, 20, 11, 11.0, 0, NULL, 21), (11, 0, 20, 10.0, 19, 'Alex', 19), (10, 9, 19, 21.0, 9, 'default2', 11), (20, 10, 1, 19.0, 19, 'Yoong', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.name FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T2.driverId = T3.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 20;

/*
Prediction Result:
('default2',)
*/