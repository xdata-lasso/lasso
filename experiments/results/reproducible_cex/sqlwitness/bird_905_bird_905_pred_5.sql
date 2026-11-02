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
INSERT INTO status (statusid, status) VALUES (1, 'default2'), (2000, 'Irvine'), (2001, 'default1'), (0, 'Eddie'), (1999, 'default1'), (2, 'Irvine'), (3, 'Irvine'), (4, 'Eddie'), (5, 'default1');
INSERT INTO seasons (year, url) VALUES (2000, 'default1'), (0, 'Eddie'), (1, 'default2'), (1999, 'Irvine'), (2001, 'unique_4'), (2, 'unique_5'), (3, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2000, 'Irvine', 0, NULL, 'default1', 'Irvine', '2023-01-01', NULL, 'default1'), (1, 'Irvine', 2001, 'default1', 'Eddie', 'Irvine', '2023-01-01', 'Irvine', 'Irvine'), (2001, 'Eddie', 1, 'default1', 'default2', 'default1', '2023-01-02', 'default1', 'default2'), (1999, 'default1', 1, 'default1', 'default2', 'Irvine', NULL, 'Irvine', 'Eddie'), (0, 'Irvine', 2000, NULL, 'Irvine', 'Irvine', '2023-01-02', 'default2', 'unique_4'), (2, 'Irvine', 2001, 'Irvine', 'default2', 'default2', NULL, NULL, 'unique_5'), (3, 'default1', 2000, 'Irvine', 'default2', 'default1', '2023-01-01', 'default2', 'unique_6'), (4, 'default2', 0, 'default1', 'Eddie', 'default1', '2023-01-02', 'Eddie', 'unique_7'), (5, 'Irvine', NULL, NULL, 'Eddie', 'Eddie', '2023-01-02', 'Eddie', 'unique_8'), (6, 'Irvine', 2001, NULL, 'default1', 'Irvine', '2023-01-01', 'Eddie', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2000, 'default2', 'default2', 'default2', 'Irvine'), (1, 'default2', 'Irvine', 'Eddie', 'Irvine'), (2001, 'Eddie', 'default1', 'Irvine', 'default2'), (1999, 'Irvine', 'Eddie', 'default1', 'default2'), (0, 'default1', 'unique_4', 'Irvine', 'default2'), (2, 'default1', 'unique_5', 'Eddie', 'Eddie'), (3, 'Irvine', 'unique_6', 'Eddie', 'default2'), (4, 'default1', 'unique_7', 'Irvine', 'default1'), (5, 'Eddie', 'unique_8', NULL, 'Irvine'), (6, 'default1', 'unique_9', 'Irvine', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1999, 'Irvine', 'default2', NULL, 'Eddie', 0.0, 2000.0, 2001, 'Eddie'), (2001, 'Irvine', 'Eddie', 'default1', 'Eddie', 1999.0, 0.0, 2001, 'Irvine'), (1, 'Irvine', 'Irvine', 'default1', 'default1', NULL, 2001.0, 2001, 'default1'), (0, 'Irvine', 'Irvine', 'Eddie', 'Eddie', 0.0, 2001.0, 2000, 'default2'), (2000, 'Eddie', 'Irvine', NULL, 'default1', 1999.0, 2000.0, 2000, 'unique_4'), (2, 'Eddie', 'default2', 'Eddie', 'default1', 2001.0, NULL, 2000, 'unique_5'), (3, 'default1', 'Irvine', 'Irvine', 'Irvine', 2000.0, 0.0, NULL, 'unique_6'), (4, 'default1', 'default2', 'default1', 'default2', NULL, 1.0, 0, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2001, 3, 1999, 0, 'default1', '2023-01-02', 'Irvine', NULL), (1, 2000, 4, 2000, 'default1', '2023-01-02', 'Irvine', 'default1'), (1999, 2, 4, 0, 'default1', '2023-01-01', NULL, 'Eddie'), (0, 2001, 3, 1999, 'Eddie', '2023-01-01', 'default2', 'default2'), (2000, 2000, 1, 2000, 'Irvine', '2023-01-01', 'default2', 'Irvine'), (2, 2000, 2, 2001, 'default2', '2023-01-02', 'default1', 'unique_5'), (3, 2, 0, 1999, 'Irvine', '2023-01-02', 'default2', 'unique_6'), (4, 1, 1999, 1, 'Irvine', '2023-01-02', 'default1', 'unique_7'), (5, 2, 1999, 1999, 'Eddie', '2023-01-02', 'Eddie', 'unique_8'), (6, 0, 3, 0, 'Irvine', '2023-01-01', 'default1', 'unique_9'), (7, 1, 1999, 0, 'default2', '2023-01-02', 'Eddie', 'unique_10'), (8, 3, 2000, 1, 'Eddie', '2023-01-02', 'default1', 'unique_11'), (9, 2000, 0, 2000, 'Irvine', '2023-01-01', 'default2', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2000, 7, 1999, 3, 0, NULL, 0, NULL, 'default1', 2000, 1.0, 2000, 'Eddie', NULL, 0, 0, 'Eddie', NULL), (1, 2, 4, 3, 2, 0, 2001, 2000, 'Eddie', 2000, 1.0, 1, NULL, 2001, 2001, 2001, 'Irvine', 'Irvine'), (2001, 1, 0, 6, 2001, 1999, 1, 0, 'Eddie', 1999, 1999.0, 1, 'default1', 2000, 1, 1, 'default2', 'Irvine'), (1999, 2000, 1999, 1999, 3, 1, 2001, NULL, 'default1', 1999, 1999.0, 2000, NULL, 2001, 1, 2001, 'default2', NULL), (0, 1999, 6, 3, 4, 1999, 0, 1999, 'Irvine', 1999, 1.0, 1999, 'default2', NULL, 2001, 1, 'Eddie', 'default2'), (2, 4, 1, 4, 1999, 1999, 1, 2000, 'Eddie', 2001, 0.0, 2001, 'Irvine', 2001, 2001, 2000, 'default1', 'default1'), (3, 0, 1, 5, 4, 1, 0, 2001, 'Eddie', 2000, 1999.0, 2000, NULL, 0, 0, 2000, 'default1', 'default2'), (4, 4, 4, 2000, 2, 1, 1999, 1, 'default1', 2000, 2001.0, 0, 'Irvine', 2001, 1999, 1, NULL, NULL), (5, 1, 4, 3, 1999, 1, 1, NULL, 'default1', 1, 2001.0, 0, 'Eddie', 0, 2001, 2000, 'default2', 'Irvine'), (6, 2000, 1999, 2, 2001, 2000, 1, NULL, 'Irvine', 1999, 1.0, 0, 'Irvine', NULL, 1, 0, NULL, NULL);
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (1, 5, 4, 2001.0, 2001, NULL, 2000), (2000, 9, 4, 2000.0, 1999, 'Eddie', 2000), (0, 3, 1, 2000.0, 2001, 'default1', 1), (2001, 9, 4, 0.0, 1, NULL, 1999), (1999, 2, 2000, 2001.0, 0, 'default2', 1999), (2, 2001, 1, 1.0, 2001, 'Eddie', 2000), (3, 1, 4, 2000.0, NULL, 'default1', 0), (4, 5, 2, 2001.0, 0, 'default2', 2001), (5, 1999, 1, 1.0, 2001, 'Irvine', 0), (6, 1, 6, 2001.0, 1, NULL, 0), (7, 6, 4, 1.0, 1999, 'default1', 2000), (8, 9, 6, 2000.0, NULL, 'Irvine', 1), (9, 2000, 1, 0.0, 2000, 'default2', 2001), (10, 6, 3, 2000.0, 0, NULL, 1), (11, 2000, 0, 1999.0, 0, 'Irvine', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T2.driverId = T1.driverId INNER JOIN races AS T3 ON T3.raceId = T2.raceId WHERE T1.forename = 'Eddie' AND T1.surname = 'Irvine' AND T3.year = 2000;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT AVG(T1.points) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T3.forename = 'Eddie' AND T3.surname = 'Irvine' AND T2.year = 2000;

/*
Prediction Result:
(None,)
*/