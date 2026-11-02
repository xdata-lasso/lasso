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
INSERT INTO status (statusid, status) VALUES (0, 'default1'), (2009, 'default2'), (100, 'default2'), (101, 'Hamilton'), (2, 'default1'), (1, 'Hamilton'), (-1, 'default2'), (2010, 'default1'), (2011, 'Hamilton'), (99, 'default2');
INSERT INTO seasons (year, url) VALUES (2011, 'default2'), (2009, 'Hamilton'), (2, 'default1'), (0, 'unique_3'), (-1, 'unique_4'), (1, 'unique_5'), (2010, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (99, 'default2', 100, 'default2', 'Hamilton', 'Hamilton', '2023-01-01', 'Hamilton', 'default2'), (2, 'default1', 100, 'default2', 'default1', 'default1', NULL, 'default1', 'Hamilton'), (1, 'Hamilton', 2011, 'default2', 'default2', 'Hamilton', '2023-01-01', 'Hamilton', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default2', 'default2', 'default1', 2010.0, 2.0, 100, 'Hamilton'), (0, 'default1', 'default1', 'default2', 'default1', -1.0, NULL, -1, 'default2'), (2, 'Hamilton', 'default2', 'Hamilton', NULL, -1.0, -1.0, 2009, 'default1'), (100, 'default1', 'default2', 'default1', 'Hamilton', 1.0, NULL, 2009, 'unique_3'), (2009, 'default1', 'Hamilton', 'Hamilton', NULL, 2.0, 2010.0, 2009, 'unique_4'), (-1, 'default2', 'default2', NULL, 'default1', 2.0, NULL, 99, 'unique_5'), (2011, 'default2', 'default1', 'default1', 'Hamilton', NULL, 99.0, 0, 'unique_6'), (99, 'default1', 'Hamilton', NULL, 'default1', 2010.0, 2010.0, 101, 'unique_7'), (2010, 'default2', 'Hamilton', 'default2', NULL, 100.0, 2011.0, 2010, 'unique_8'), (101, 'default2', 'default1', 'Hamilton', NULL, 2.0, 100.0, 2009, 'unique_9'), (3, 'default1', 'default1', 'default1', 'default2', 101.0, 2009.0, 0, 'unique_10'), (4, 'default2', 'default1', 'default1', 'Hamilton', 2.0, 2.0, 2011, 'unique_11'), (5, 'Hamilton', 'default1', 'default2', NULL, 1.0, 2011.0, 2009, 'unique_12'), (6, 'default1', 'default1', NULL, 'default2', 2.0, 2009.0, 1, 'unique_13'), (7, 'default2', 'default2', NULL, 'default1', 101.0, 2.0, 101, 'unique_14'), (8, 'Hamilton', 'default2', 'Hamilton', 'Hamilton', NULL, 1.0, 2011, 'unique_15'), (9, 'default2', 'Hamilton', NULL, 'default1', 99.0, 100.0, NULL, 'unique_16'), (10, 'default1', 'Hamilton', 'default2', NULL, 2009.0, NULL, 2010, 'unique_17');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (-1, 2011, 101, -1, 'Hamilton', '2023-01-02', NULL, 'Hamilton'), (1, -1, 0, 1, 'default1', '2023-01-02', 'Hamilton', 'default1'), (2009, 2, 2010, 1, 'default1', '2023-01-01', NULL, 'default2');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (1, 1, 2, 99.0, 2009, NULL, 2011), (2011, 2009, 2, 1.0, 0, 'default2', 2011), (2, 1, 99, 1.0, 99, 'default2', 2), (101, 1, 99, 2.0, NULL, 'default2', 2), (100, 2009, 1, 99.0, 99, 'default2', 101), (-1, -1, 1, 2011.0, 99, 'default1', 99), (0, -1, 2, 0.0, 2010, 'default2', 2011), (2010, -1, 1, -1.0, 2010, 'Hamilton', 2), (2009, 2009, 1, 1.0, 99, 'default2', 100), (99, -1, 2, 1.0, 99, 'Hamilton', 1), (3, 1, 1, 0.0, -1, 'default1', -1), (4, 2009, 2, 2011.0, 99, 'default1', 99), (5, 2009, 2, 2010.0, 1, 'Hamilton', 2009), (6, 1, 99, 100.0, 2011, NULL, -1), (7, -1, 99, 2011.0, 1, 'default1', 2011), (8, 1, 99, 101.0, 2010, NULL, 100), (9, 1, 1, 101.0, 2009, 'default2', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.position <> 1 THEN T2.position END) AS REAL) * 100 / COUNT(T2.driverStandingsId) FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.surname = 'Hamilton' AND T1.year >= 2010;

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN results.position > 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(results.raceid) AS percentage FROM drivers INNER JOIN results ON drivers.driverid = results.driverid INNER JOIN races ON results.raceid = races.raceid WHERE drivers.surname = 'Hamilton' AND races.year >= 2010;

/*
Prediction Result:
(None,)
*/