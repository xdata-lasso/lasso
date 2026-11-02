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
INSERT INTO status (statusid, status) VALUES (1, 'Finished'), (0, 'default1'), (2, 'default2'), (3, 'default2'), (4, 'default1'), (5, 'Finished'), (6, 'Finished'), (7, 'default2'), (8, 'Finished'), (9, 'Finished'), (10, 'Finished'), (11, 'default2'), (12, 'Finished'), (13, 'default1'), (14, 'default2');
INSERT INTO seasons (year, url) VALUES (0, '2015-11-29'), (1, 'Finished'), (2, 'default2'), (3, 'default1'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Finished', NULL, NULL, '2015-11-29', 'default2', '2023-01-02', 'Finished', 'Finished'), (1, 'default2', 1, NULL, 'default2', 'default2', '2015-11-30', '2015-11-29', 'default1'), (2, '2015-11-29', 1, 'Finished', 'default1', 'default2', '2015-11-30', 'Finished', '2015-11-29'), (3, 'default2', NULL, 'default1', 'Finished', 'default1', '2015-11-29', '2015-11-29', 'default2'), (4, '2015-11-29', 0, '2015-11-29', '2015-11-29', 'default2', '2015-11-28', NULL, 'unique_4'), (5, '2015-11-29', 0, NULL, '2015-11-29', '2015-11-29', NULL, NULL, 'unique_5'), (6, 'default2', 0, 'default1', 'default2', 'default2', '2015-11-30', 'default1', 'unique_6'), (7, '2015-11-29', NULL, '2015-11-29', 'Finished', 'default2', '2023-01-02', 'default1', 'unique_7'), (8, 'default1', NULL, '2015-11-29', '2015-11-29', 'default1', '2015-11-28', 'Finished', 'unique_8'), (9, 'default2', 1, 'default2', 'default2', '2015-11-29', '2023-01-02', 'Finished', 'unique_9'), (10, 'default2', NULL, 'default1', 'default1', 'default1', '2023-01-01', 'default2', 'unique_10'), (11, 'default1', 1, 'Finished', 'default1', 'Finished', '2015-11-29', 'default1', 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, '2015-11-29', 'default2', 'default1', '2015-11-29'), (0, 'default2', 'Finished', '2015-11-29', 'Finished'), (2, '2015-11-29', '2015-11-29', NULL, 'default1'), (3, 'default1', 'default1', 'default1', '2015-11-29'), (4, '2015-11-29', 'unique_4', 'default1', 'default1'), (5, 'Finished', 'unique_5', 'Finished', 'default1'), (6, 'default2', 'unique_6', NULL, '2015-11-29'), (7, 'default2', 'unique_7', '2015-11-29', '2015-11-29'), (8, 'default2', 'unique_8', 'Finished', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Finished', 'default1', 'default1', 'Finished', 0.0, NULL, 0, 'Finished'), (0, 'default2', 'default2', NULL, '2015-11-29', 0.0, 1.0, NULL, '2015-11-29');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 4, 0, 0, 'Finished', '2015-11-30', '2015-11-29', 'Finished'), (0, 10, 1, 1, 'Finished', '2015-11-30', 'Finished', 'default1'), (2, 10, 0, 1, 'default1', '2015-11-29', 'Finished', NULL), (3, 6, 0, 0, 'Finished', '2023-01-02', NULL, '2015-11-29'), (4, 9, 1, 0, 'Finished', '2015-11-29', 'default1', 'default2'), (5, 8, 0, 0, 'Finished', '2015-11-30', 'default2', 'unique_5'), (6, 4, 1, 1, '2015-11-29', '2015-11-29', NULL, 'unique_6'), (7, 1, 1, 1, 'default1', '2023-01-02', 'Finished', 'unique_7'), (8, 5, 0, 1, '2015-11-29', '2015-11-29', 'Finished', 'unique_8');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1, 5, 6, 8, NULL, 1, 0, '2015-11-29', 0, 0.0, 1, NULL, NULL, NULL, NULL, 'default2', 'default2'), (0, 2, 8, 5, 5, 0, 0, 1, '2015-11-29', 0, 0.0, 1, NULL, 1, 1, 0, 'Finished', 'Finished'), (2, 6, 3, 2, 12, 0, 0, NULL, '2015-11-29', 0, 0.0, 0, '2015-11-29', NULL, 0, 0, 'default1', 'Finished'), (3, 8, 3, 1, 5, NULL, 0, 1, 'Finished', 0, 0.0, 0, 'Finished', NULL, 1, 1, NULL, 'default2'), (4, 0, 5, 3, 4, 0, 0, 0, 'Finished', 1, 1.0, 0, 'default1', 1, 1, NULL, '2015-11-29', 'default1'), (5, 3, 7, 2, 11, NULL, 1, 0, 'default1', 0, 1.0, 0, '2015-11-29', 0, 1, 1, 'Finished', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '2015-11-29' AND NOT T2.time IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT("results"."driverid") FROM "races" JOIN "results" ON "races"."raceid" = "results"."raceid" JOIN "status" ON "results"."statusid" = "status"."statusid" WHERE "races"."date" = '2015-11-29' AND "status"."status" = 'Finished';

/*
Prediction Result:
(3,)
*/