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
INSERT INTO status (statusid, status) VALUES (0, 'default2'), (2, 'Lewis'), (1, 'Hamilton'), (3, 'default2'), (4, 'Lewis'), (5, 'default2'), (6, 'default2');
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'Lewis'), (2, 'default1'), (3, 'Hamilton');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Lewis', 0, 'Hamilton', 'Hamilton', 'Hamilton', '2023-01-02', NULL, 'Lewis'), (2, 'default1', 0, 'Hamilton', 'Lewis', 'Hamilton', NULL, 'default1', 'default2'), (1, 'default2', NULL, 'Hamilton', 'default2', 'Lewis', NULL, NULL, 'Hamilton'), (3, 'Hamilton', 1, NULL, 'default1', 'Lewis', '2023-01-01', 'default1', 'default1'), (4, 'default1', 2, 'Hamilton', 'Hamilton', 'default2', NULL, NULL, 'unique_4'), (5, 'default2', 1, NULL, 'Hamilton', 'default1', '2023-01-01', 'default1', 'unique_5'), (6, 'default2', 0, NULL, 'default2', 'Hamilton', NULL, 'Hamilton', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default1', 'default2', 'Lewis', 'Hamilton'), (0, 'Hamilton', 'Lewis', 'Hamilton', 'Lewis'), (1, 'Lewis', 'Hamilton', 'Hamilton', 'Lewis'), (3, 'Lewis', 'default1', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'Hamilton', 'Hamilton', 'default2', 0.0, 2.0, 1, 'Lewis'), (1, 'Hamilton', 'Hamilton', 'Lewis', 'default1', 2.0, 0.0, 2, 'default2'), (2, 'default2', 'Hamilton', 'default2', 'default2', 0.0, NULL, 1, 'Hamilton'), (3, 'default1', 'default2', NULL, 'Hamilton', 1.0, 2.0, 2, 'default1'), (4, 'default1', 'Lewis', 'Hamilton', 'default1', 2.0, 2.0, 2, 'unique_4'), (5, 'Hamilton', 'default2', 'default1', NULL, NULL, 0.0, NULL, 'unique_5'), (6, 'Lewis', 'Lewis', NULL, 'Hamilton', 0.0, 1.0, 2, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 0, 6, 1, 'default1', '2023-01-01', 'Lewis', 'default1'), (1, 0, 1, 1, 'default2', '2023-01-02', 'default2', 'default2'), (0, 3, 4, 2, 'default2', '2023-01-02', 'default2', 'Hamilton'), (3, 0, 4, 2, 'Lewis', '2023-01-02', 'Hamilton', NULL), (4, 3, 3, 2, 'Hamilton', '2023-01-02', 'Lewis', 'Lewis'), (5, 0, 2, 2, 'default2', '2023-01-02', 'default1', 'unique_5'), (6, 1, 3, 0, 'default2', '2023-01-02', NULL, 'unique_6'), (7, 3, 2, 0, 'default1', '2023-01-02', 'Lewis', 'unique_7'), (8, 2, 0, 2, 'default2', '2023-01-02', NULL, 'unique_8'), (9, 0, 3, 1, 'Lewis', '2023-01-02', NULL, 'unique_9'), (10, 0, 1, 0, 'Lewis', '2023-01-01', 'default1', 'unique_10');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 4, 3, 2, 1, NULL, 2, 1, 'default2', 2, 2.0, 1, 'default1', NULL, 1, 2, 'Hamilton', 'Hamilton'), (2, 0, 2, 3, 0, NULL, 0, 0, 'Lewis', 2, 0.0, 1, 'default1', 2, NULL, 1, NULL, 'Lewis'), (1, 2, 1, 1, 5, 1, 2, 0, 'default2', 0, 1.0, 2, 'default1', 0, 2, 0, 'default1', NULL), (3, 8, 6, 0, 6, 0, 2, 2, 'default1', 1, 1.0, 1, 'default1', 2, 2, 2, NULL, 'default2'), (4, 4, 5, 1, 6, NULL, 2, 0, 'default1', 1, 2.0, 2, 'Lewis', 0, 2, 2, 'default2', 'default1'), (5, 3, 2, 0, 3, 2, 0, 1, 'Hamilton', 1, 0.0, 2, NULL, 2, 2, 1, NULL, 'default1'), (6, 8, 4, 2, 5, 0, 0, NULL, 'default1', 1, 0.0, 2, NULL, 2, 1, 0, 'Lewis', 'default2'), (7, 3, 4, 2, 0, NULL, 2, 0, 'Lewis', 0, 2.0, 0, 'default1', NULL, 1, NULL, 'Lewis', 'default1'), (8, 6, 0, 3, 5, NULL, 1, NULL, 'Lewis', 1, 2.0, 0, 'default2', 1, 1, NULL, 'Lewis', 'Hamilton'), (9, 1, 6, 3, 0, 0, 1, 2, 'default2', 1, 2.0, 0, 'Lewis', 0, 0, NULL, 'default2', 'default2'), (10, 4, 3, 0, 3, NULL, 0, 2, 'Hamilton', 1, 2.0, 1, NULL, 1, 1, 2, 'default1', 'default1');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (1, 5, 0, 1.0, 2, 'default1', 0), (0, 9, 0, 1.0, 2, 'Hamilton', 0), (2, 3, 4, 1.0, 2, 'default1', 0), (3, 10, 2, 0.0, 0, 'default1', 0), (4, 7, 0, 2.0, NULL, 'default1', 0), (5, 10, 4, 0.0, NULL, NULL, 2), (6, 10, 2, 0.0, 1, 'default2', 2), (7, 3, 3, 2.0, 1, 'Hamilton', 1), (8, 10, 6, 0.0, NULL, 'Lewis', 1), (9, 0, 6, 1.0, NULL, 'default1', 0), (10, 1, 4, 1.0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Lewis' AND T3.surname = 'Hamilton' ORDER BY T1.year ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Lewis', 0.0)
*/

-- Prediction Query
SELECT "races"."name", "races"."year", "results"."points" FROM "drivers" INNER JOIN "results" ON "drivers"."driverId" = "results"."driverId" INNER JOIN "races" ON "results"."raceId" = "races"."raceId" WHERE "drivers"."forename" = 'Lewis' AND "drivers"."surname" = 'Hamilton' ORDER BY "races"."year" ASC, drivers.driverid NULLS LAST, results.resultid NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Lewis', 0, 0.0)
*/