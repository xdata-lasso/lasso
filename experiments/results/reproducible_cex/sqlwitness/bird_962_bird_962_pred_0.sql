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
INSERT INTO status (statusid, status) VALUES (2005, 'default1'), (2, '1985'), (-1, '1985'), (101, 'default1'), (2001, 'default2'), (51, '1985'), (50, 'default1'), (2004, 'default1'), (0, 'default1');
INSERT INTO seasons (year, url) VALUES (2001, 'default2'), (2, 'default1'), (0, '1985'), (2004, '%Y'), (2005, 'unique_4'), (99, 'unique_5'), (51, 'unique_6'), (100, 'unique_7'), (1, 'unique_8'), (-1, 'unique_9'), (101, 'unique_10'), (2000, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2000, 'default1', -1, '%Y', 'default1', 'default2', '1985-10-27', '1985', '1985'), (2004, 'default2', 50, NULL, 'default1', '1985', NULL, '1985', 'default1'), (49, 'default2', 99, 'default2', 'default1', '%Y', NULL, NULL, '%Y'), (100, 'default1', 2001, '1985', 'default2', '1985', NULL, '%Y', 'default2'), (51, 'default1', 1, NULL, '1985', '%Y', '1985-10-27', 'default1', 'unique_4'), (2, 'default1', -1, '%Y', 'default2', '1985', '2023-01-02', '1985', 'unique_5'), (0, 'default2', 51, 'default1', 'default2', '%Y', '1985-10-27', 'default1', 'unique_6'), (-1, '%Y', 1999, '%Y', '1985', 'default1', '2023-01-01', '1985', 'unique_7');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (100, '1985', '1985', '%Y', '%Y'), (101, 'default2', 'default2', '%Y', '1985'), (0, '1985', '%Y', 'default2', '1985'), (2004, 'default2', 'default1', NULL, '%Y'), (2005, '%Y', 'unique_4', NULL, 'default2'), (-1, 'default1', 'unique_5', '1985', '%Y'), (1999, 'default2', 'unique_6', '%Y', 'default2'), (2000, '1985', 'unique_7', '1985', 'default2'), (2, 'default2', 'unique_8', '%Y', 'default2'), (1, 'default1', 'unique_9', 'default1', 'default1'), (99, '1985', 'unique_10', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2001, 'default1', '%Y', '%Y', 'default1', 2005.0, 2005.0, NULL, 'default1'), (2005, '1985', 'default1', '1985', '1985', 2001.0, 2005.0, 101, '%Y'), (100, 'default1', '%Y', 'default2', '1985', 50.0, 51.0, 101, 'default2'), (2, '1985', 'default1', 'default1', '%Y', 51.0, 1999.0, 99, '1985'), (49, '1985', 'default2', 'default2', 'default2', 2005.0, 2001.0, 99, 'unique_4'), (101, 'default1', '%Y', NULL, '%Y', 2006.0, NULL, 51, 'unique_5'), (99, 'default2', '%Y', '1985', '1985', 2000.0, 0.0, -1, 'unique_6'), (2006, '1985', 'default2', '%Y', 'default2', 1999.0, NULL, 0, 'unique_7'), (0, 'default1', '%Y', NULL, 'default1', 2006.0, NULL, 2006, 'unique_8'), (-1, '1985', '%Y', '%Y', '%Y', 2.0, 2.0, 2001, 'unique_9'), (1, 'default1', '1985', '1985', 'default2', 2006.0, -1.0, 0, 'unique_10'), (2000, '1985', '%Y', 'default1', NULL, 2.0, 49.0, 49, 'unique_11'), (1999, 'default1', '1985', NULL, NULL, 49.0, -1.0, 49, 'unique_12'), (50, '1985', '1985', '1985', 'default2', 51.0, 100.0, 2, 'unique_13'), (51, '1985', 'default1', 'default2', 'default1', 2005.0, 2001.0, 51, 'unique_14');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (100, 2, 99, 2001, 'default2', '2023-01-02', NULL, NULL), (51, 99, 1999, 2001, '%Y', '2023-01-01', 'default2', '1985'), (2000, 2001, 2006, 2004, 'default2', '2023-01-01', NULL, 'default1'), (50, -1, 100, 2001, 'default1', '2023-01-02', 'default1', '%Y');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (51, 50, 49, 2, -1, 99, 2000, 99, '%Y', 100, 2005.0, 2005, 'default1', 2000, 2, 1, '%Y', '1985'), (2005, 2000, 2, 0, -1, 50, 2004, 100, 'default1', 2000, 2001.0, 1999, NULL, 2004, 2000, NULL, 'default1', '%Y'), (100, 51, -1, -1, 50, 2, 2006, -1, '1985', 1999, 2000.0, 101, 'default2', 49, 1999, 2001, '%Y', 'default2'), (1999, 2000, 2, 1, 2, 0, 49, -1, '%Y', 2001, 101.0, 2001, 'default2', 51, 0, 1, '1985', '1985'), (99, 51, 51, 2, 2004, 50, 50, 0, 'default1', 2, 101.0, 49, 'default1', NULL, 2001, 101, 'default2', 'default2'), (101, 51, 0, 2005, 51, -1, 1999, 2005, '%Y', 2005, 2004.0, 100, 'default1', 99, 2004, 2001, NULL, '1985'), (50, 50, -1, 1999, 2004, 101, 101, 50, 'default1', -1, 100.0, 2001, '1985', 1, 49, 99, NULL, 'default1'), (1, 2000, -1, 1999, 2001, 2005, 2004, 100, 'default1', 101, 2000.0, 1999, '%Y', 0, -1, 2006, 'default2', '%Y'), (2004, 100, 49, 100, -1, 51, 0, 100, 'default2', 50, 51.0, 2005, NULL, 50, 0, 100, 'default1', '1985'), (2000, 2000, 2000, 101, 2004, 100, 1999, 51, 'default1', 1, 1.0, 2004, '%Y', 2004, 0, 2004, 'default1', '1985'), (2006, 100, 100, 2004, 0, 1, 100, NULL, '1985', 0, 2001.0, 2000, '%Y', -1, 2004, 2005, 'default2', '1985'), (0, 50, 0, 2005, 2, 50, 49, 100, 'default2', 99, 1999.0, 51, 'default1', 2, 2000, 2000, NULL, NULL), (-1, 51, 51, 99, 2004, 1999, 1999, 99, '%Y', -1, 50.0, 101, 'default2', 100, 100, NULL, NULL, NULL), (2, 2000, 49, 100, 51, NULL, 2001, -1, 'default2', 2005, 51.0, 2001, '1985', 50, 2, 0, 'default2', 'default2'), (2001, 50, 49, 0, 0, -1, 2000, 2006, 'default2', 2006, 2004.0, 100, '1985', 100, 0, 2006, '%Y', 'default1');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (50, 2004, 2006, 51, '%Y', 101), (50, 2000, 1, 2000, '%Y', 2006), (100, -1, 2006, 2001, '%Y', 2006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T3.dob) < '1985' AND T1.laps > 50, 1, 0)) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.year BETWEEN 2000 AND 2005;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', T2.dob) < '1985' AND T1.lap > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.driverId) FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.year BETWEEN 2000 AND 2005;

/*
Prediction Result:
(None,)
*/