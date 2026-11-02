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
INSERT INTO status (statusid, status) VALUES (9, 'Alex'), (0, 'default2'), (11, 'Yoong'), (1, 'Yoong'), (10, 'Alex');
INSERT INTO seasons (year, url) VALUES (11, 'default2'), (10, 'default1'), (1, 'Alex'), (9, 'Yoong');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Alex', 9, NULL, 'default2', 'Alex', NULL, 'Alex', 'Alex'), (9, 'Yoong', 10, 'Yoong', 'Alex', 'Yoong', '2023-01-01', 'Yoong', 'Yoong'), (11, 'default1', NULL, NULL, 'default2', 'default1', '2023-01-01', NULL, 'default2'), (10, 'default1', 1, 'Yoong', 'Yoong', 'default2', NULL, 'Alex', 'default1'), (1, 'default2', NULL, 'default1', 'Alex', 'Yoong', '2023-01-01', 'Alex', 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (11, 'Alex', 'default1', 'Alex', 'default1'), (9, 'default1', 'Alex', 'Alex', 'default2'), (1, 'default1', 'default2', NULL, 'default2'), (0, 'Alex', 'Yoong', 'Alex', 'Alex'), (10, 'default2', 'unique_4', 'default1', 'Alex'), (2, 'default2', 'unique_5', 'Alex', 'Yoong'), (3, 'default1', 'unique_6', 'default2', 'Alex'), (4, 'Yoong', 'unique_7', NULL, 'Yoong'), (5, 'Yoong', 'unique_8', 'default2', 'Yoong'), (6, 'default1', 'unique_9', 'default1', 'Alex');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'Yoong', NULL, 'Yoong', 11.0, NULL, 0, 'Alex'), (1, 'default2', 'default1', 'default1', 'default2', 11.0, 11.0, 1, 'default1'), (11, 'Alex', 'Yoong', NULL, 'Alex', 0.0, NULL, 1, 'default2'), (10, 'Alex', 'Alex', 'default2', 'Alex', 9.0, NULL, 11, 'Yoong'), (9, 'Yoong', 'default2', NULL, NULL, 1.0, NULL, NULL, 'unique_4'), (2, 'Alex', 'default1', 'default2', 'Yoong', 1.0, 9.0, NULL, 'unique_5'), (3, 'Yoong', 'default1', 'Yoong', 'default1', 10.0, 10.0, 10, 'unique_6'), (4, 'default2', 'default2', 'Yoong', NULL, 11.0, 11.0, 0, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (9, 11, 9, 9, 'default1', '2023-01-02', 'default1', 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 9, 0, 1, 9, 9, 10, NULL, 'default1', 0, 10.0, 1, 'default1', 1, 9, 11, 'Alex', 'default2'), (10, 9, 1, 10, 1, 0, 10, NULL, 'default2', 9, 0.0, 1, 'Yoong', NULL, 10, 9, NULL, 'Yoong');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (1, 9, 10, 11.0, 10, 'Yoong', 0), (11, 9, 10, 9.0, NULL, NULL, 10), (0, 9, 10, 1.0, 11, NULL, 0), (10, 9, 0, 1.0, 1, 'default1', 10), (9, 9, 9, 0.0, 0, 'default1', 10), (2, 9, 0, 11.0, 9, 'Yoong', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT races.name FROM results INNER JOIN drivers ON results.driverId = drivers.driverId INNER JOIN races ON results.raceId = races.raceId WHERE drivers.surname = 'Yoong' AND results.position < 10;

/*
Prediction Result:
*/