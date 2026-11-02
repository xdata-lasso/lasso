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
INSERT INTO status (statusid, status) VALUES (1, 'default2'), (-1, 'default1'), (2011, 'default1'), (101, 'default2'), (0, 'Hamilton'), (2, 'default2'), (2010, 'default2'), (2009, 'default2');
INSERT INTO seasons (year, url) VALUES (101, 'default2'), (1, 'Hamilton'), (2010, 'default1'), (-1, 'unique_3'), (0, 'unique_4'), (2, 'unique_5');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (101, 'Hamilton', 2010, 'Hamilton', 'default1', 'default2', '2023-01-02', 'default1', 'default2'), (-1, 'default2', 101, NULL, 'default2', 'default2', '2023-01-02', 'Hamilton', 'default1'), (2, 'default1', NULL, 'default2', 'Hamilton', 'Hamilton', '2023-01-02', 'default1', 'Hamilton'), (100, 'Hamilton', 1, NULL, 'default2', 'default2', '2023-01-01', 'default2', 'unique_3'), (2010, 'Hamilton', 2011, 'Hamilton', 'default2', 'default1', NULL, 'Hamilton', 'unique_4'), (0, 'default1', -1, 'default1', 'default2', 'Hamilton', '2023-01-01', NULL, 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'default2', 'Hamilton', 'default1'), (101, 'default1', 'default1', 'default1', 'Hamilton'), (2011, 'default2', 'Hamilton', 'Hamilton', 'default1'), (99, 'default2', 'unique_3', 'Hamilton', 'Hamilton'), (2009, 'default2', 'unique_4', 'Hamilton', 'default2'), (-1, 'default1', 'unique_5', NULL, 'Hamilton'), (1, 'default1', 'unique_6', 'default1', 'Hamilton'), (2, 'Hamilton', 'unique_7', 'Hamilton', 'default2'), (2010, 'Hamilton', 'unique_8', NULL, 'default2'), (100, 'default1', 'unique_9', 'default2', 'default2'), (3, 'Hamilton', 'unique_10', 'default2', 'default1'), (4, 'default1', 'unique_11', NULL, 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2009, 'Hamilton', 'Hamilton', 'default2', NULL, 101.0, -1.0, 1, 'default2'), (0, 'default2', 'Hamilton', 'default2', 'default1', 1.0, 99.0, 99, 'Hamilton'), (2, 'default2', 'default1', 'Hamilton', 'Hamilton', 100.0, 2.0, 101, 'default1'), (101, 'default2', 'default2', NULL, 'default1', 2010.0, 2009.0, 1, 'unique_3'), (100, 'Hamilton', 'default1', 'default2', 'default1', 2011.0, 2.0, 0, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (-1, 2, 2, 100, 'default1', '2023-01-01', 'Hamilton', 'default1'), (100, 2, 2009, 1, 'default1', '2023-01-01', 'Hamilton', 'default2'), (1, 0, 101, 2009, 'default1', '2023-01-02', NULL, NULL), (2010, 2010, 2, 2009, 'default1', '2023-01-01', NULL, 'Hamilton'), (2009, 1, 101, 0, 'default2', '2023-01-01', 'default1', 'unique_4'), (101, 2010, 2, 100, 'Hamilton', '2023-01-01', NULL, 'unique_5'), (0, 0, 100, 2010, 'Hamilton', '2023-01-02', 'default1', 'unique_6'), (2, 1, 0, 2009, 'default2', '2023-01-01', 'default1', 'unique_7'), (2011, 0, 0, -1, 'default1', '2023-01-01', NULL, 'unique_8'), (99, 2010, 101, 100, 'default1', '2023-01-02', NULL, 'unique_9'), (3, 101, 2, 99, 'default2', '2023-01-02', 'Hamilton', 'unique_10'), (4, 2, 100, -1, 'default2', '2023-01-02', NULL, 'unique_11'), (5, 2, 2, 2, 'default2', '2023-01-01', 'default2', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (99, 101, 100, 100, 0, 2011, 0, 99, 'default1', 100, 2011.0, 99, 'default2', 2009, NULL, 99, 'default2', 'Hamilton'), (100, 100, -1, 99, 2009, 0, 2009, 2010, 'Hamilton', 101, 0.0, 2, NULL, 0, 0, 2011, NULL, 'default2'), (1, 2, 2, 2009, -1, 2009, 2, 2009, 'Hamilton', 100, 2009.0, 2, 'default2', 100, NULL, 100, 'Hamilton', NULL), (101, 4, -1, 2011, 2009, 100, 2010, 2, 'default1', 2009, 2011.0, 1, 'default2', 99, -1, 100, 'default1', NULL), (2, 2009, 2010, 99, 2009, 101, 99, 2011, 'default1', 100, 2010.0, -1, 'default1', NULL, 100, 99, 'default2', 'default1'), (0, 4, 101, 2010, 1, NULL, 1, -1, 'Hamilton', 2011, 0.0, 2, NULL, 100, NULL, 100, 'Hamilton', NULL), (-1, 0, -1, 0, 2009, 2010, 2, 2010, 'default2', 99, 2010.0, 101, 'default2', NULL, NULL, 2010, 'default1', 'Hamilton'), (2010, 0, -1, 2009, 2, -1, 1, 99, 'default1', -1, 1.0, -1, 'Hamilton', 2010, -1, 99, 'Hamilton', 'default1'), (2009, 2009, 2, 4, 2, 1, 2, NULL, 'default1', 101, 0.0, 2011, 'default2', 100, 100, 2010, 'Hamilton', 'Hamilton'), (2011, 2011, 2, 4, 2, 2009, 1, 100, 'default1', 99, 99.0, 2011, NULL, 2011, NULL, 2, 'Hamilton', NULL);
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 2010, 2, 0.0, 101, 'Hamilton', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.position <> 1 THEN T2.position END) AS REAL) * 100 / COUNT(T2.driverStandingsId) FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.surname = 'Hamilton' AND T1.year >= 2010;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "results"."position" > 1 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("results"."raceid") FROM "drivers" INNER JOIN "results" ON "drivers"."driverid" = "results"."driverid" INNER JOIN "races" ON "results"."raceid" = "races"."raceid" WHERE "drivers"."surname" = 'Hamilton' AND "races"."year" >= 2010;

/*
Prediction Result:
(None,)
*/