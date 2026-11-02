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
INSERT INTO status (statusid, status) VALUES (-1, 'default2'), (1, 'Japanese'), (100, 'default2'), (2, 'default1'), (99, 'default1'), (101, 'default2'), (2008, 'default2'), (2006, 'default1'), (0, 'Japanese'), (2007, 'default1'), (2009, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (2007, 'default1'), (2010, 'Japanese'), (-1, 'unique_3'), (101, 'unique_4'), (0, 'unique_5'), (2, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (101, 'default1', NULL, 'default2', 'default1', 'default2', NULL, 'Japanese', 'Japanese'), (2, 'default2', 0, NULL, 'default2', 'default1', NULL, 'default1', 'default2'), (2010, 'Japanese', 2010, NULL, 'Japanese', 'Japanese', '2023-01-02', 'Japanese', 'default1'), (2008, 'Japanese', 2, 'default2', 'default1', 'Japanese', NULL, NULL, 'unique_3'), (2006, 'default1', 99, NULL, 'Japanese', 'default2', '2023-01-01', 'default2', 'unique_4'), (2007, 'default2', 2, 'default2', 'Japanese', 'Japanese', '2023-01-01', 'Japanese', 'unique_5'), (0, 'default1', 2010, 'default1', 'Japanese', 'default2', NULL, 'Japanese', 'unique_6'), (-1, 'Japanese', 2009, 'default1', 'default2', 'default2', '2023-01-01', NULL, 'unique_7'), (1, 'default2', -1, 'default1', 'Japanese', 'default2', '2023-01-02', 'default1', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (101, 'default1', 'Japanese', 'Japanese', 'default1'), (2008, 'default2', 'default2', 'default2', 'default1'), (2006, 'Japanese', 'default1', 'default1', 'default2'), (0, 'Japanese', 'unique_3', 'Japanese', 'Japanese'), (2010, 'Japanese', 'unique_4', 'default1', 'default1'), (-1, 'Japanese', 'unique_5', 'default1', 'default2'), (1, 'Japanese', 'unique_6', 'default1', 'default2'), (2, 'Japanese', 'unique_7', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2007, 'default2', 'Japanese', 'default2', 'default1', 2008.0, 2.0, 99, 'default2'), (100, 'Japanese', 'default1', 'default2', NULL, 2008.0, 2008.0, 2006, 'default1'), (2009, 'Japanese', 'default2', 'default1', 'default2', 100.0, 1.0, 2010, 'Japanese'), (-1, 'default1', 'Japanese', NULL, 'default1', -1.0, 100.0, 100, 'unique_3'), (2, 'default1', 'default2', 'Japanese', 'default2', 0.0, 2.0, 2008, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2006, 101, -1, 2009, 'Japanese', '2023-01-01', 'default1', 'Japanese'), (1, 2007, 2007, -1, 'Japanese', '2023-01-01', NULL, 'default1'), (2, 2007, 100, 101, 'default2', '2023-01-01', 'default2', 'default2'), (-1, 101, 2009, -1, 'default1', '2023-01-01', NULL, NULL), (2007, 1, 100, 2007, 'Japanese', '2023-01-02', NULL, 'unique_4'), (0, 2010, 2007, -1, 'default1', '2023-01-02', 'Japanese', 'unique_5'), (100, 0, -1, -1, 'default2', '2023-01-01', 'default2', 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (101, 1, 101, 2, 2009, NULL, 100, 2009, 'default2', 1, 2010.0, 1, 'default1', 2007, 2008, NULL, NULL, 'default2'), (100, 1, 2010, 2008, 2007, 99, 2010, 1, 'Japanese', 101, 2006.0, 2008, 'default2', 2008, 2010, 100, 'Japanese', 'default2'), (2009, 2, 2010, 2, 1, 100, 2007, 2008, 'Japanese', 99, 101.0, 2, 'default2', 2006, 2009, 101, 'default2', NULL), (0, 100, 2010, 1, 99, 2009, 2006, 2009, 'Japanese', 100, 2008.0, 2007, NULL, -1, 0, NULL, 'default1', 'default2'), (1, 2006, 2, 2, 1, 101, 101, 2007, 'default1', -1, 2006.0, 2009, 'Japanese', 99, 99, 101, 'Japanese', 'Japanese'), (2, 100, 2010, 0, 100, 2010, 2010, 2006, 'default2', -1, 99.0, 2009, NULL, 2008, 2006, 1, 'default1', 'Japanese'), (2008, 0, 2010, 0, 99, 2006, 2007, 2008, 'Japanese', 2, 2.0, 0, 'default1', 2010, 100, 2010, NULL, 'default2'), (2006, 2007, 2007, 2008, 2008, 0, 101, 2006, 'default1', 100, 2006.0, 0, 'default2', 2006, 2007, 0, 'default2', NULL), (2007, 2007, 2010, 2, 0, 0, -1, NULL, 'Japanese', 2007, 2.0, 0, NULL, 1, 2007, 2007, 'default2', NULL), (-1, 2, 1, 2008, 100, 1, 2, 0, 'Japanese', 2010, -1.0, 2010, 'default1', 2010, 2006, 1, 'default1', 'Japanese');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(NOT T1.time IS NULL, 1, 0)) AS REAL) * 100 / COUNT(T1.raceId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T3.nationality = 'Japanese' AND T2.year BETWEEN 2007 AND 2009;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN NOT r.time IS NULL THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS percentage FROM races AS r INNER JOIN results AS res ON r.raceId = res.raceId INNER JOIN drivers AS d ON res.driverId = d.driverId WHERE r.year BETWEEN 2007 AND 2009 AND d.nationality = 'Japanese';

/*
Prediction Result:
(33.333333333333336,)
*/