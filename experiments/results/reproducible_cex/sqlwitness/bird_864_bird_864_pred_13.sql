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
INSERT INTO status (statusid, status) VALUES (2016, 'default2'), (2014, 'default2'), (0, 'default1'), (1, '2015-11-29'), (2015, '2015-11-29'), (2, 'default1'), (3, 'default1'), (4, 'default2'), (5, '2015-11-29'), (6, '2015-11-29');
INSERT INTO seasons (year, url) VALUES (2014, 'default2'), (2015, 'default1'), (1, '2015-11-29'), (2016, 'unique_3');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2014, 'default1', 0, 'default1', '2015-11-29', 'default2', '2023-01-01', '2015-11-29', 'default2'), (0, 'default2', 2016, 'default1', 'default1', 'default2', '2023-01-01', NULL, '2015-11-29'), (2016, '2015-11-29', 1, 'default1', 'default2', 'default2', '2015-11-30', 'default1', 'default1'), (2015, 'default2', 2016, 'default1', '2015-11-29', 'default2', '2015-11-28', 'default2', 'unique_3'), (1, '2015-11-29', 2016, '2015-11-29', '2015-11-29', 'default1', '2015-11-29', 'default2', 'unique_4'), (2, 'default2', 2015, NULL, 'default2', '2015-11-29', '2015-11-28', 'default2', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2015, '2015-11-29', 'default1', NULL, '2015-11-29'), (2014, '2015-11-29', '2015-11-29', 'default2', 'default1'), (2016, 'default1', 'default2', NULL, 'default2'), (0, '2015-11-29', 'unique_3', 'default2', 'default2'), (1, 'default2', 'unique_4', NULL, '2015-11-29'), (2, 'default1', 'unique_5', '2015-11-29', 'default2'), (3, 'default1', 'unique_6', 'default2', '2015-11-29'), (4, '2015-11-29', 'unique_7', '2015-11-29', 'default1'), (5, '2015-11-29', 'unique_8', '2015-11-29', '2015-11-29');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '2015-11-29', 'default2', 'default2', NULL, 2014.0, 0.0, 2015, 'default2'), (2014, '2015-11-29', 'default1', 'default1', 'default2', 1.0, 0.0, NULL, 'default1'), (0, 'default1', '2015-11-29', NULL, NULL, 2015.0, 2014.0, 2015, '2015-11-29'), (2016, 'default2', 'default1', '2015-11-29', NULL, 2015.0, 2015.0, 0, 'unique_3'), (2015, 'default2', 'default1', NULL, 'default1', 0.0, 2015.0, 2016, 'unique_4'), (2, 'default1', '2015-11-29', '2015-11-29', '2015-11-29', 2015.0, 2015.0, 2016, 'unique_5'), (3, 'default2', '2015-11-29', NULL, 'default2', 2016.0, 2016.0, 0, 'unique_6'), (4, 'default1', 'default1', 'default2', 'default1', 2015.0, NULL, 2015, 'unique_7'), (5, '2015-11-29', 'default2', NULL, 'default1', NULL, 2014.0, 2014, 'unique_8'), (6, 'default2', 'default1', 'default1', NULL, 1.0, 0.0, 2016, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2015, 2, 1, 'default2', '2023-01-01', 'default2', 'default2'), (0, 1, 2015, 0, 'default1', '2015-11-29', NULL, NULL), (2016, 2016, 1, 2014, '2015-11-29', '2015-11-30', 'default1', '2015-11-29'), (2015, 1, 2016, 1, '2015-11-29', '2015-11-28', NULL, 'default1'), (2014, 2014, 3, 0, 'default2', '2023-01-01', 'default2', 'unique_4'), (2, 1, 2015, 2014, '2015-11-29', '2023-01-02', '2015-11-29', 'unique_5'), (3, 1, 2016, 2015, 'default2', '2023-01-01', 'default2', 'unique_6'), (4, 2016, 5, 1, '2015-11-29', '2023-01-01', 'default1', 'unique_7'), (5, 2015, 6, 2014, 'default1', '2015-11-28', 'default2', 'unique_8'), (6, 2014, 6, 1, '2015-11-29', '2015-11-30', NULL, 'unique_9'), (7, 1, 1, 2014, 'default2', '2023-01-01', 'default1', 'unique_10');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2014, 2, 2, 5, 6, 2015, 2015, 2015, 'default1', 0, 1.0, 2014, NULL, NULL, 2015, NULL, '2015-11-29', 'default2'), (2015, 4, 2016, 2, 2, 2016, 1, 0, 'default1', 0, 2015.0, 1, NULL, 1, 2015, 1, 'default1', 'default2'), (2016, 0, 1, 1, 1, 2016, 2014, 2016, 'default1', 2014, 2014.0, 2014, '2015-11-29', NULL, 2016, NULL, '2015-11-29', NULL), (1, 0, 2, 3, 5, NULL, 1, 2015, 'default2', 2016, 0.0, 2016, 'default1', 2016, 2016, 2016, 'default1', '2015-11-29'), (0, 6, 2, 2, 3, 1, 2014, NULL, 'default1', 2016, 2015.0, 1, NULL, 1, 2016, 2015, '2015-11-29', NULL), (2, 4, 2015, 4, 2014, 1, 2015, NULL, 'default2', 1, 1.0, 1, NULL, 2015, 2014, 1, 'default2', '2015-11-29'), (3, 1, 2016, 2016, 2015, 2015, 1, 0, 'default1', 0, 1.0, 2015, NULL, 0, NULL, 2016, '2015-11-29', NULL), (4, 2016, 2015, 5, 6, NULL, 1, 1, 'default2', 2015, 2014.0, 2014, 'default2', 2015, NULL, 2015, 'default1', 'default2'), (5, 2014, 0, 2, 2, NULL, 2016, 2015, 'default2', 2015, 1.0, 0, 'default2', 2014, 2015, 2016, 'default1', '2015-11-29'), (6, 1, 1, 1, 0, 0, 2016, 2016, 'default2', 1, 2015.0, 1, 'default2', 0, 1, 0, 'default1', 'default2'), (7, 3, 1, 4, 0, 1, 2016, 1, 'default2', 1, 0.0, 2016, 'default1', 0, 1, 1, 'default1', 'default2'), (8, 0, 0, 1, 1, 2014, 2015, NULL, '2015-11-29', 2015, 2014.0, 2014, 'default2', 2014, 2014, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId WHERE T1.date = '2015-11-29' AND NOT T2.time IS NULL;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) AS not_finishing_drivers FROM races AS r INNER JOIN results AS res ON r.raceId = res.raceId WHERE r.year = 2015 AND r.date = '2015-11-29' AND res.time IS NULL;

/*
Prediction Result:
(0,)
*/