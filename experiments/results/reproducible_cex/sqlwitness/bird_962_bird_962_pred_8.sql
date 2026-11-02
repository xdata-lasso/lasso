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
INSERT INTO status (statusid, status) VALUES (1999, '1985'), (49, '2005'), (100, 'default1'), (50, '2000'), (0, '2000');
INSERT INTO seasons (year, url) VALUES (-1, 'default1'), (0, '1985');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default2', 2001, 'default1', '%Y', '%Y', NULL, NULL, 'default1'), (2006, '%Y', 2004, '2000', 'default2', 'default1', '2023-01-01', '%Y', 'default2'), (100, 'default1', -1, '1985', '2005', '2000', '2005-10-27', 'default1', '1985'), (-1, '1985', 100, '2000', '1985', '%Y', '2005-10-27', '2005', '%Y'), (2001, 'default2', -1, 'default1', '2005', 'default2', '2023-01-01', '%Y', '2000');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (50, '%Y', '%Y', 'default2', '2005'), (51, 'default1', 'default1', '%Y', '2000'), (2005, '2000', '1985', '2000', '2000'), (100, '1985', '2000', 'default2', '2000'), (0, '%Y', '2005', 'default2', '%Y');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (49, 'default1', '2005', 'default1', NULL, 2005.0, 2000.0, NULL, '%Y'), (2006, '1985', 'default1', 'default2', '2000', 2.0, 101.0, 2006, 'default1'), (1999, 'default1', '2005', 'default1', '1985', 101.0, 1999.0, 99, '2005'), (99, 'default2', 'default1', 'default2', NULL, 2000.0, 2006.0, 1, '2000'), (0, '1985', '%Y', '2000', 'default2', 1.0, 100.0, 99, '1985'), (-1, '2005', '1985', '2005', 'default2', 50.0, NULL, 2006, 'default2'), (1, 'default1', '%Y', '%Y', 'default2', NULL, 2004.0, 2006, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (99, 0, 99, 1, '%Y', '2005-10-27', 'default2', '%Y'), (2001, 0, 99, 2001, 'default1', '2023-01-02', '2000', 'default1'), (1999, -1, 99, 1999, '2000', '2023-01-02', 'default1', 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2000, 1999, 2, 100, 100, 1, 2005, 99, 'default2', 1, 2001.0, -1, NULL, 2001, -1, 2005, '1985', '2005'), (50, 1999, -1, 51, 49, 50, 1, 2004, 'default2', 51, 2000.0, -1, NULL, 2005, NULL, 49, NULL, '2005'), (51, 99, -1, 51, 100, 2006, -1, -1, '1985', 2006, 51.0, 101, 'default2', 2001, NULL, 0, '2000', '2005'), (0, 99, 2001, 50, 0, 2000, 51, 2006, '1985', -1, 101.0, -1, 'default1', 99, 2, 100, '%Y', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T3.dob) < '1985' AND T1.laps > 50, 1, 0)) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.year BETWEEN 2000 AND 2005;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.laps > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.year BETWEEN 2000 AND 2005 AND (STRFTIME('%Y', T2.dob) < '1985') OR (STRFTIME('%Y', T2.dob) BETWEEN '2000' AND '2005');

/*
Prediction Result:
(50.0,)
*/