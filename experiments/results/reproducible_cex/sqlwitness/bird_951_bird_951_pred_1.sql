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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (2, 'Japanese'), (3, 'default1'), (-1, 'unique_3'), (1, 'unique_4'), (4, 'unique_5'), (5, 'unique_6'), (6, 'unique_7'), (7, 'unique_8'), (8, 'unique_9'), (9, 'unique_10');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (3, 'default1', 'Japanese', 'default2', 'default1'), (0, 'default2', 'default2', 'default1', 'default1'), (2, 'default1', 'default1', 'default1', 'default2'), (-1, 'Japanese', 'unique_3', 'default2', 'Japanese'), (1, 'default2', 'unique_4', NULL, 'default2'), (4, 'default1', 'unique_5', 'default1', 'Japanese'), (5, 'default1', 'unique_6', 'default1', 'default2'), (6, 'default1', 'unique_7', 'Japanese', 'Japanese'), (7, 'default2', 'unique_8', 'default2', 'default1'), (8, 'default1', 'unique_9', 'Japanese', 'Japanese'), (9, 'default2', 'unique_10', 'default1', 'default2'), (10, 'default1', 'unique_11', 'Japanese', 'default2'), (11, 'default2', 'unique_12', 'Japanese', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default1', 'Japanese', 'Japanese', 'default1', NULL, NULL, NULL, 'default1'), (1, 'default2', 'Japanese', 'Japanese', 'default1', -1.0, 2.0, 1, 'Japanese'), (3, 'Japanese', 'default2', 'Japanese', 'default1', NULL, NULL, NULL, 'default2');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (-1, -1, 1, 3, 'default1', '2023-01-02', 'default1', 'default1'), (0, 7, 2, 0, 'default2', '2023-01-02', 'default1', 'Japanese'), (1, 4, 3, -1, 'default2', '2023-01-01', 'default2', NULL), (2, 5, 3, 2, 'Japanese', '2023-01-02', 'Japanese', 'default2'), (3, 4, 2, 0, 'Japanese', '2023-01-01', 'default1', 'unique_4');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (-1, 2, 9, 3.0, 3, 'Japanese', 0), (0, 1, 11, -1.0, -1, NULL, 3), (2, 0, -1, 3.0, 1, NULL, 2), (3, 3, 11, 1.0, 3, 'Japanese', -1), (1, 2, 11, 3.0, NULL, 'default1', 0), (4, 0, 5, -1.0, 2, 'Japanese', -1), (5, -1, -1, 1.0, -1, 'default2', 3), (6, 1, 0, 0.0, 0, NULL, 1), (7, 2, 1, 3.0, 2, 'default1', 0), (8, 0, 4, 1.0, 3, NULL, 3), (9, 0, 5, 2.0, NULL, NULL, -1), (10, 3, 11, 0.0, 3, 'default1', -1), (11, -1, 10, 0.0, NULL, NULL, 2), (12, 2, 3, 1.0, 3, 'Japanese', 2), (13, 2, 8, 1.0, NULL, 'default2', 0), (14, -1, 1, 0.0, 1, NULL, 0), (15, 3, 5, 3.0, 1, NULL, 0), (16, -1, 10, 0.0, 0, 'default2', -1), (17, 2, -1, 3.0, 1, NULL, 0), (18, -1, 1, 2.0, NULL, 'Japanese', -1), (19, 2, 5, 1.0, 3, 'default2', 3), (20, 0, 0, 1.0, -1, 'Japanese', 0), (21, 3, 9, 0.0, 1, 'default2', -1), (22, 3, 7, 2.0, 0, 'default1', 0), (23, -1, 3, 2.0, 1, 'default2', -1), (24, 0, 0, 2.0, 3, 'default2', -1), (25, 1, 2, 1.0, 3, 'default2', -1), (26, 3, 3, -1.0, -1, 'default1', 2), (27, 1, 0, 0.0, NULL, NULL, -1), (28, 0, 5, 2.0, NULL, 'default1', 3), (29, 3, 9, 0.0, 3, NULL, 3), (30, 0, 5, 2.0, NULL, NULL, 2), (31, 2, 1, 3.0, 2, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.raceId) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T2.nationality = 'Japanese' GROUP BY T1.constructorId HAVING COUNT(raceId) = 2;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT constructors.constructorId) AS japanese_constructors_with_0_points_in_2_races FROM constructors INNER JOIN constructorStandings ON constructors.constructorId = constructorStandings.constructorId WHERE constructors.nationality = 'Japanese' GROUP BY constructors.constructorId HAVING COUNT(constructorStandings.raceId) = 2 AND SUM(constructorStandings.points) = 0;

/*
Prediction Result:
(1,)
*/