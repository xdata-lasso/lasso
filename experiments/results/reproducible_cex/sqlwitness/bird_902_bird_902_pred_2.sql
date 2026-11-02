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
INSERT INTO status (statusid, status) VALUES (0, 'Yoong'), (10, 'Alex'), (9, 'default1'), (11, 'default2'), (1, 'Alex'), (2, 'default1'), (3, 'Alex'), (4, 'default2'), (5, 'Yoong');
INSERT INTO seasons (year, url) VALUES (1, 'Alex'), (11, 'default2'), (9, 'Yoong'), (0, 'default1'), (10, 'unique_4');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Alex', NULL, 'default2', 'Alex', 'Yoong', '2023-01-02', 'default1', 'default1'), (11, 'Yoong', NULL, 'default2', 'default2', 'Alex', NULL, 'default2', 'default2'), (9, 'default1', NULL, 'default2', 'Yoong', 'Alex', '2023-01-01', NULL, 'Alex'), (1, 'Alex', 0, 'default2', 'default2', 'Alex', '2023-01-01', 'default2', 'Yoong'), (10, 'Alex', 1, 'default1', 'default2', 'Yoong', '2023-01-01', NULL, 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (9, 'Alex', 'default1', 'default1', 'default2'), (1, 'default1', 'default2', 'default1', 'Alex'), (10, 'Yoong', 'Alex', 'default1', 'default1'), (0, 'Alex', 'Yoong', 'default1', 'default1'), (11, 'Yoong', 'unique_4', 'Alex', 'Alex'), (2, 'Alex', 'unique_5', 'default2', 'Yoong'), (3, 'default1', 'unique_6', 'default2', 'default2'), (4, 'Yoong', 'unique_7', 'default1', 'Alex'), (5, 'Yoong', 'unique_8', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (9, 'default2', 'Alex', 'default2', 'default2', 11.0, 11.0, NULL, 'Yoong'), (0, 'default1', 'default2', 'default1', 'Alex', NULL, 1.0, 0, 'default2'), (11, 'default2', 'Yoong', 'Alex', 'default1', 10.0, 0.0, 11, 'Alex'), (1, 'default1', 'default1', 'default2', 'Yoong', 0.0, 11.0, 0, 'default1'), (10, 'Yoong', 'Alex', 'Alex', 'default1', NULL, 11.0, NULL, 'unique_4'), (2, 'default1', 'default1', 'default1', NULL, 9.0, NULL, NULL, 'unique_5'), (3, 'default1', 'default2', 'Alex', 'Yoong', 1.0, 9.0, 1, 'unique_6'), (4, 'Yoong', 'Alex', 'default1', NULL, 10.0, 0.0, NULL, 'unique_7'), (5, 'Alex', 'Alex', 'default1', 'default1', 9.0, 11.0, NULL, 'unique_8'), (6, 'default1', 'default2', NULL, 'default1', NULL, 0.0, 9, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (9, 10, 6, 10, 'default2', '2023-01-02', 'Alex', 'default2'), (11, 11, 3, 0, 'default2', '2023-01-01', 'default1', 'Alex'), (10, 10, 4, 11, 'default2', '2023-01-01', NULL, 'Yoong'), (0, 1, 0, 11, 'default1', '2023-01-02', 'default2', 'default1'), (1, 1, 9, 9, 'default2', '2023-01-01', 'Yoong', NULL);
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1, 11, 1, 1, 9, 0, 9, 'default2', 1, 9.0, 11, 'Yoong', 1, 0, 10, 'default1', 'Alex'), (11, 11, 11, 2, 3, 10, 11, 10, 'default1', 10, 9.0, 0, NULL, NULL, 10, 1, 'default2', 'default2'), (9, 1, 1, 10, 1, NULL, 11, 11, 'default2', 10, 11.0, 11, 'default1', NULL, 11, 9, 'default2', 'Yoong'), (10, 0, 0, 4, 9, 0, 9, 0, 'Alex', 0, 11.0, 10, 'Yoong', 0, 1, 9, 'default2', 'default2');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 0, 9, 11.0, NULL, 'Yoong', 11), (9, 0, 11, 1.0, 11, NULL, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.name FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T1.forename = 'Alex' AND T1.surname = 'Yoong' AND T2.position < 10;

/*
Prediction Result:
('default1',)
*/