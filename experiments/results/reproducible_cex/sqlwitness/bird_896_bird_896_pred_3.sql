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
INSERT INTO status (statusid, status) VALUES (0, 'Hamilton'), (2010, 'default2'), (1, 'default1'), (-1, 'Hamilton'), (2009, 'default2'), (2011, 'Hamilton'), (2, 'Hamilton'), (99, 'default1'), (100, 'default1'), (101, 'default2'), (3, 'default1'), (4, 'Hamilton'), (5, 'default1'), (6, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (0, 'Hamilton'), (99, 'default1'), (100, 'unique_3'), (2, 'unique_4'), (101, 'unique_5'), (-1, 'unique_6'), (2010, 'unique_7'), (2009, 'unique_8'), (2011, 'unique_9'), (3, 'unique_10'), (4, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (101, 'default2', NULL, NULL, 'Hamilton', 'Hamilton', '2023-01-01', 'default2', 'default1'), (99, 'default2', 100, 'default1', 'Hamilton', 'Hamilton', '2023-01-02', 'default1', 'default2'), (-1, 'Hamilton', 2011, 'Hamilton', 'default2', 'default2', '2023-01-02', 'Hamilton', 'Hamilton');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'default1', NULL, 'default2'), (2009, 'default1', 'Hamilton', 'Hamilton', 'Hamilton'), (0, 'default2', 'default2', 'default2', 'Hamilton'), (-1, 'default2', 'unique_3', 'Hamilton', 'default1'), (101, 'default1', 'unique_4', 'default2', 'default1'), (2, 'default1', 'unique_5', 'default1', 'Hamilton'), (2010, 'Hamilton', 'unique_6', 'default1', 'Hamilton'), (2011, 'Hamilton', 'unique_7', NULL, 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2011, 'default2', 'default1', 'default2', 'Hamilton', 2010.0, 101.0, 0, 'Hamilton'), (99, 'default1', 'Hamilton', 'default1', 'default1', 2011.0, NULL, NULL, 'default1'), (2010, 'default2', 'default2', 'Hamilton', 'Hamilton', 2011.0, 2010.0, 2009, 'default2'), (101, 'Hamilton', 'default1', NULL, 'default2', 1.0, 99.0, 0, 'unique_3'), (2009, 'Hamilton', 'default1', 'default2', 'default2', 2.0, 101.0, 2, 'unique_4'), (2, 'Hamilton', 'Hamilton', 'default1', NULL, 2.0, 2010.0, 2, 'unique_5'), (100, 'Hamilton', 'default1', 'Hamilton', NULL, 2010.0, 2009.0, -1, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (99, 99, 100, 101, 'Hamilton', '2023-01-01', 'default1', 'default1'), (2, 2010, 2009, -1, 'default1', '2023-01-02', 'default1', 'Hamilton'), (101, 3, 99, 2010, 'Hamilton', '2023-01-01', NULL, 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (-1, 2, 101, 2, 6, 99, 2, 2010, 'default1', 1, 2010.0, 2010, NULL, 101, 1, 101, 'default1', 'default2'), (2009, 99, 99, 2011, 5, 99, 2011, 2, 'default1', 100, 101.0, 100, NULL, NULL, 100, 100, 'default1', NULL), (100, 2, -1, 101, 3, 2011, 2010, 100, 'default2', 2009, 0.0, 2, 'default1', 1, 2, 2011, 'default1', 'Hamilton'), (101, 2, 101, 0, 2010, 2011, 1, 2009, 'Hamilton', 2, 2010.0, 1, NULL, -1, 2, 99, NULL, 'Hamilton'), (99, 99, -1, 1, 1, 100, 2009, 99, 'default2', 100, 100.0, 100, 'default2', NULL, 2010, -1, 'default2', 'Hamilton'), (2, 99, 99, 2009, 4, NULL, 1, 99, 'Hamilton', 1, 2010.0, 2, 'default1', -1, 2009, 99, 'Hamilton', 'default1'), (0, 101, 101, -1, 2011, 0, 2009, -1, 'Hamilton', 100, 2.0, 0, NULL, 2011, 1, -1, 'default2', NULL), (1, 2, 101, 1, 2010, 2010, 99, NULL, 'default1', 100, 1.0, 0, NULL, 1, 2011, 2009, NULL, NULL), (2010, 99, 99, 2010, 2009, 2009, 101, -1, 'default1', 2, 2.0, 2010, 'Hamilton', 2009, 1, 101, 'default1', 'default1');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 99, 99, 2011.0, 2011, 'default2', 2009), (2011, 99, -1, 2010.0, 101, 'default2', 2009), (-1, 101, 99, 2010.0, 2011, 'default2', 2), (101, 2, 101, 2011.0, 2009, 'default1', 1), (100, 101, -1, 100.0, 2010, 'default1', 99), (2009, 101, 101, 100.0, 2011, 'default2', 101), (99, 2, 99, 100.0, 2, 'default2', 0), (1, 99, 99, 99.0, 100, 'Hamilton', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.position <> 1 THEN T2.position END) AS REAL) * 100 / COUNT(T2.driverStandingsId) FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.surname = 'Hamilton' AND T1.year >= 2010;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T3.position > 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage FROM drivers AS T1 INNER JOIN results AS T3 ON T1.driverId = T3.driverId INNER JOIN races AS T2 ON T3.raceId = T2.raceId WHERE T1.surname = 'Hamilton' AND T2.year >= 2010;

/*
Prediction Result:
(66.66666666666667,)
*/