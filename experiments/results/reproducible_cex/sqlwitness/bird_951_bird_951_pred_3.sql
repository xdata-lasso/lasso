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
INSERT INTO seasons (year, url) VALUES (-1, 'Japanese'), (2, 'default2'), (3, 'default1'), (1, 'unique_3'), (0, 'unique_4'), (4, 'unique_5'), (5, 'unique_6'), (6, 'unique_7'), (7, 'unique_8'), (8, 'unique_9'), (9, 'unique_10'), (10, 'unique_11'), (11, 'unique_12'), (12, 'unique_13'), (13, 'unique_14');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Japanese', 'default1', 'Japanese', 'default1'), (-1, 'Japanese', 'default2', 'Japanese', 'default2'), (1, 'Japanese', 'Japanese', 'Japanese', 'default1'), (2, 'Japanese', 'unique_3', 'default2', 'Japanese'), (3, 'default2', 'unique_4', NULL, 'default2'), (4, 'Japanese', 'unique_5', 'default2', 'Japanese'), (5, 'default2', 'unique_6', 'default1', 'default1'), (6, 'Japanese', 'unique_7', 'default1', 'default1'), (7, 'default1', 'unique_8', 'Japanese', 'Japanese'), (8, 'Japanese', 'unique_9', 'default1', 'Japanese');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (-1, 'Japanese', 'default2', 'default2', NULL, 0.0, NULL, -1, 'Japanese'), (2, 'default1', 'default1', 'default2', 'default1', 2.0, 1.0, 2, 'default1'), (1, 'default2', 'default2', NULL, 'default1', 0.0, -1.0, -1, 'default2'), (0, 'Japanese', 'default2', NULL, 'Japanese', 3.0, 2.0, 1, 'unique_3'), (3, 'default1', 'default2', 'Japanese', 'default1', 2.0, -1.0, 3, 'unique_4'), (4, 'Japanese', 'default1', NULL, 'default2', NULL, 1.0, 0, 'unique_5'), (5, 'Japanese', 'default2', 'Japanese', 'default2', NULL, 3.0, 3, 'unique_6'), (6, 'default1', 'default2', NULL, 'default2', -1.0, 3.0, NULL, 'unique_7'), (7, 'default2', 'Japanese', NULL, NULL, 0.0, NULL, -1, 'unique_8'), (8, 'default2', 'default2', NULL, NULL, 3.0, 2.0, NULL, 'unique_9'), (9, 'Japanese', 'default1', 'default2', NULL, 0.0, NULL, 1, 'unique_10'), (10, 'default2', 'default2', 'default2', 'default2', NULL, 3.0, 1, 'unique_11'), (11, 'default1', 'Japanese', 'default2', 'Japanese', 0.0, 1.0, 3, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (3, 2, 9, -1, 'default1', '2023-01-02', 'Japanese', 'Japanese'), (1, 2, 11, 1, 'Japanese', '2023-01-02', 'Japanese', NULL), (0, 1, 6, 0, 'Japanese', '2023-01-02', 'Japanese', 'default1');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (0, 1, 0, 0.0, 1, 'default1', 0), (-1, 3, 8, -1.0, 2, 'default2', 3), (2, 1, 0, 0.0, 1, 'Japanese', 0), (3, 0, 2, 2.0, 3, NULL, -1), (1, 3, -1, 1.0, 1, 'Japanese', 0), (4, 3, 7, 0.0, 1, 'default1', 2), (5, 1, 6, 1.0, 3, NULL, -1), (6, 0, 2, 0.0, 1, NULL, 1), (7, 3, 4, 2.0, 3, NULL, 3), (8, 1, 7, -1.0, 0, 'default1', 1);
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (1, 0, 8, -1.0, NULL), (0, 1, 1, -1.0, 'default1'), (3, 3, 1, 0.0, 'default2'), (2, 1, 4, -1.0, 'Japanese'), (-1, 3, 6, 0.0, 'default1'), (4, 0, 2, -1.0, 'default2'), (5, 3, 1, 3.0, 'Japanese'), (6, 0, 5, -1.0, 'default1'), (7, 0, 2, -1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.raceId) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T2.nationality = 'Japanese' GROUP BY T1.constructorId HAVING COUNT(raceId) = 2;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.constructorId) FROM constructors AS T1 INNER JOIN constructorResults AS T2 ON T1.constructorId = T2.constructorId WHERE T1.nationality = 'Japanese' AND T2.points = 0 GROUP BY T1.constructorId HAVING COUNT(T2.raceId) = 2;

/*
Prediction Result:
*/