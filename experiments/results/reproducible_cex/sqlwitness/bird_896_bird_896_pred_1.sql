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
INSERT INTO status (statusid, status) VALUES (2010, 'Hamilton'), (101, 'Hamilton'), (2, 'default1'), (-1, 'default1'), (1, 'default1'), (100, 'Hamilton'), (2009, 'Hamilton'), (0, 'default1'), (2011, 'Hamilton');
INSERT INTO seasons (year, url) VALUES (2011, 'default2'), (101, 'Hamilton'), (99, 'default1'), (2, 'unique_3'), (1, 'unique_4'), (2009, 'unique_5'), (2010, 'unique_6'), (100, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2010, 'Hamilton', NULL, 'default2', 'default1', 'default2', '2023-01-01', 'Hamilton', 'default2'), (100, 'default1', 99, 'Hamilton', 'default2', 'Hamilton', NULL, 'Hamilton', 'Hamilton'), (0, 'Hamilton', 101, NULL, 'default1', 'default1', '2023-01-02', 'Hamilton', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2011, 'default2', 'Hamilton', 'Hamilton', 'default2'), (99, 'Hamilton', 'default1', NULL, 'default2'), (100, 'default1', 'default2', NULL, 'Hamilton'), (-1, 'default1', 'unique_3', NULL, 'default2'), (2, 'Hamilton', 'unique_4', 'default2', 'default2'), (0, 'default2', 'unique_5', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2010, 'default1', 'default1', NULL, 'default1', 2011.0, 0.0, 2010, 'default2'), (0, 'default2', 'Hamilton', NULL, 'default2', 101.0, NULL, 99, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2010, 100, 2010, 0, 'default2', '2023-01-01', 'Hamilton', 'default2'), (2, 2, 2010, 2010, 'default1', '2023-01-02', 'default2', NULL), (1, 100, 2010, 100, 'default1', '2023-01-02', NULL, 'default1'), (2011, 2009, 0, 0, 'default2', '2023-01-01', 'Hamilton', 'Hamilton'), (100, 2009, 2010, 1, 'default2', '2023-01-01', 'default1', 'unique_4'), (2009, 2011, 0, -1, 'Hamilton', '2023-01-01', 'default2', 'unique_5'), (0, 2, 0, 1, 'default2', '2023-01-02', 'default2', 'unique_6'), (-1, 2, 2010, 2011, 'default1', '2023-01-01', 'default1', 'unique_7');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (100, 2, 100, 99, -1, 100, 100, 101, 'default2', 100, 2011.0, 2009, NULL, 100, 2010, 0, 'Hamilton', NULL), (0, 1, 0, 99, 1, 2, -1, 101, 'default2', 2011, 2010.0, 99, 'Hamilton', NULL, 2011, 99, 'default1', 'Hamilton'), (2011, 2, 0, 100, 2011, 99, 100, 2, 'Hamilton', 0, 2011.0, 1, 'default2', 2009, 101, 2010, 'default2', 'default1'), (2010, 1, 100, -1, 2010, 100, 99, 100, 'Hamilton', 100, 2011.0, 101, 'default1', 0, 99, 2009, 'default1', 'Hamilton'), (2, 2, 100, -1, 2010, 2011, 2010, 101, 'default2', 0, 2011.0, 100, NULL, -1, 2011, 2010, 'default2', NULL);
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 2011, 0, 1.0, NULL, 'default1', 2), (2010, 2, 0, 101.0, 2011, 'Hamilton', 1), (2, 2009, 2010, 1.0, 101, 'default1', 2), (1, 2010, 0, 2011.0, NULL, 'default2', 0), (99, 2009, 100, 2.0, 101, 'Hamilton', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.position <> 1 THEN T2.position END) AS REAL) * 100 / COUNT(T2.driverStandingsId) FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.surname = 'Hamilton' AND T1.year >= 2010;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN rs.position > 1 THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(rs.raceId) AS percentage FROM drivers AS d INNER JOIN results AS rs ON d.driverId = rs.driverId INNER JOIN races AS r ON rs.raceId = r.raceId WHERE d.surname = 'Hamilton' AND r.year >= 2010;

/*
Prediction Result:
(None,)
*/