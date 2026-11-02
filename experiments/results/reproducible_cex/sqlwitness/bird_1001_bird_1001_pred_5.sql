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
INSERT INTO seasons (year, url) VALUES (2, 'default2'), (59, '.'), (2007, 'Marina Bay Street Circuit'), (1, ':'), (2008, 'default1'), (999, 'unique_5'), (61, 'unique_6'), (2009, 'unique_7'), (0, 'unique_8'), (60, 'unique_9'), (1000, 'unique_10'), (1001, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1001, 'default2', 0, 'default2', ':', ':', '2023-01-02', 'default2', 'default2'), (2, 'Marina Bay Street Circuit', NULL, 'default2', 'default2', ':', NULL, '.', '.'), (61, 'Marina Bay Street Circuit', 60, 'Marina Bay Street Circuit', ':', 'Marina Bay Street Circuit', NULL, 'default2', 'default1'), (0, ':', 1000, 'Marina Bay Street Circuit', 'default2', '.', '2023-01-01', 'default2', ':'), (1000, 'Marina Bay Street Circuit', 60, 'default1', 'default2', ':', '2023-01-01', 'Marina Bay Street Circuit', 'Marina Bay Street Circuit'), (1, 'default1', NULL, 'default2', 'Marina Bay Street Circuit', ':', '2023-01-02', 'Marina Bay Street Circuit', 'unique_5'), (59, 'default1', 2008, NULL, 'default1', 'default1', '2023-01-02', ':', 'unique_6'), (2008, '.', 2008, NULL, '.', 'Marina Bay Street Circuit', '2023-01-02', 'default1', 'unique_7'), (2007, ':', 0, 'default2', ':', '.', '2023-01-02', NULL, 'unique_8'), (2009, 'Marina Bay Street Circuit', 60, 'Marina Bay Street Circuit', '.', 'Marina Bay Street Circuit', NULL, NULL, 'unique_9'), (60, ':', 2008, 'default1', ':', 'Marina Bay Street Circuit', '2023-01-01', 'default2', 'unique_10'), (999, ':', 2, NULL, '.', ':', '2023-01-01', ':', 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, '.', '.', ':', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, '.', ':', '.', 'default2', 2009.0, 0.0, 60, 'default2'), (0, ':', 'Marina Bay Street Circuit', 'default1', ':', 1.0, 999.0, 1, 'Marina Bay Street Circuit'), (2008, 'Marina Bay Street Circuit', 'Marina Bay Street Circuit', 'default2', ':', 59.0, 1000.0, 1000, '.'), (1, 'default1', 'Marina Bay Street Circuit', NULL, 'Marina Bay Street Circuit', 2007.0, 1000.0, NULL, ':'), (2007, 'default2', 'default1', '.', ':', 59.0, 1001.0, 2007, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (999, 59, 1, 1000, ':', '2023-01-02', ':', 'Marina Bay Street Circuit'), (2007, 59, 0, 2009, 'default2', '2023-01-02', 'default2', 'default2'), (61, 2, 2007, 1001, '.', '2023-01-01', 'Marina Bay Street Circuit', ':'), (2008, 1001, 2008, 0, 'Marina Bay Street Circuit', '2023-01-01', '.', NULL), (2, 2008, 1, 2007, 'Marina Bay Street Circuit', '2023-01-02', NULL, 'default1'), (60, 1000, 2008, 0, 'default2', '2023-01-02', NULL, '.'), (1, 0, 2, 61, '.', '2023-01-01', 'default1', 'unique_6'), (2009, 2, 1, 1000, 'default1', '2023-01-02', 'default1', 'unique_7'), (0, 60, 0, 59, ':', '2023-01-02', 'default1', 'unique_8'), (59, 2009, 0, 999, 'default1', '2023-01-02', 'default1', 'unique_9'), (1000, 999, 0, 60, 'default2', '2023-01-01', ':', 'unique_10');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (999, 2008, 2009, 0, 1, 61, NULL, 'default1', ':'), (1000, 59, 1, 0, 1, 999, NULL, ':', 'default1'), (2008, 0, 1001, 0, 2008, 2008, '.', '.', 'Marina Bay Street Circuit'), (0, 61, 1000, 0, 61, 2008, 'default1', ':', NULL), (61, 2, 2008, 0, 0, 2, 'default1', 'default2', 'default2'), (2007, 1, 2007, 0, 60, NULL, ':', '.', ':'), (2, 59, 61, 0, 61, 0, 'default2', 'default1', 'Marina Bay Street Circuit'), (1, 999, 0, 0, 2, 60, '.', 'Marina Bay Street Circuit', 'default1'), (60, 0, 1, 0, 1000, 2009, ':', 'default1', '.'), (1001, 1, 999, 0, 2009, 2008, ':', 'Marina Bay Street Circuit', 'default1'), (59, 1, 59, 0, 61, 999, ':', 'default1', NULL), (2009, 0, 2007, 0, 61, 61, 'default2', ':', 'default2'), (3, 2007, 2008, 0, 1000, 60, ':', 'default1', 'default1'), (4, 60, 999, 0, 2009, 1, 'default2', NULL, ':'), (5, 1, 999, 0, 60, 60, NULL, 'Marina Bay Street Circuit', 'Marina Bay Street Circuit'), (6, 1, 2, 0, 1001, 61, ':', 'default2', 'Marina Bay Street Circuit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('.', 'Marina Bay Street Circuit')
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId INNER JOIN circuits AS T4 ON T3.circuitId = T4.circuitId WHERE T4.name = 'Marina Bay Street Circuit' AND T3.year = 2008 AND T2.position = 1 ORDER BY T2.q3, T1.driverid NULLS LAST, T2.qualifyid NULLS LAST, T3.raceid NULLS LAST, T4.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/