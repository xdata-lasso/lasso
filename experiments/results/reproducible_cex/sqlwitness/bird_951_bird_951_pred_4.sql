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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (-1, 'Japanese'), (3, 'default1'), (1, 'unique_3'), (2, 'unique_4'), (4, 'unique_5'), (5, 'unique_6'), (6, 'unique_7'), (7, 'unique_8'), (8, 'unique_9'), (9, 'unique_10'), (10, 'unique_11'), (11, 'unique_12'), (12, 'unique_13'), (13, 'unique_14'), (14, 'unique_15'), (15, 'unique_16'), (16, 'unique_17'), (17, 'unique_18'), (18, 'unique_19');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'Japanese', 'Japanese', 'Japanese'), (2, 'default2', 'default1', NULL, 'default2'), (-1, 'default2', 'default2', NULL, 'default1'), (0, 'default1', 'unique_3', 'default2', 'default2'), (3, 'default1', 'unique_4', 'default2', 'default2'), (4, 'default1', 'unique_5', 'Japanese', 'default1'), (5, 'Japanese', 'unique_6', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'Japanese', 'default1', NULL, 'default2', NULL, -1.0, 1, 'Japanese'), (-1, 'default1', 'default1', 'Japanese', NULL, 1.0, 2.0, 3, 'default1'), (0, 'default1', 'Japanese', NULL, 'default1', 3.0, 1.0, -1, 'default2'), (1, 'default1', 'Japanese', 'Japanese', NULL, 3.0, NULL, 0, 'unique_3'), (3, 'default1', 'default2', 'default1', 'default2', NULL, 3.0, -1, 'unique_4'), (4, 'Japanese', 'default2', NULL, 'Japanese', 2.0, NULL, NULL, 'unique_5'), (5, 'Japanese', 'Japanese', NULL, 'default2', 1.0, 0.0, 0, 'unique_6'), (6, 'Japanese', 'default2', NULL, NULL, -1.0, NULL, -1, 'unique_7'), (7, 'default2', 'Japanese', 'default1', 'default1', 0.0, 2.0, 3, 'unique_8'), (8, 'Japanese', 'Japanese', 'default1', NULL, -1.0, 2.0, 0, 'unique_9'), (9, 'default1', 'default2', 'Japanese', 'default1', NULL, NULL, 2, 'unique_10'), (10, 'default2', 'Japanese', 'Japanese', 'Japanese', 2.0, NULL, -1, 'unique_11'), (11, 'Japanese', 'Japanese', NULL, 'default1', NULL, 1.0, 3, 'unique_12'), (12, 'default1', 'default2', NULL, 'default2', -1.0, NULL, NULL, 'unique_13'), (13, 'Japanese', 'default1', 'default1', NULL, -1.0, NULL, 0, 'unique_14'), (14, 'Japanese', 'default2', 'default2', 'Japanese', 2.0, 2.0, 0, 'unique_15'), (15, 'Japanese', 'default1', 'Japanese', 'Japanese', 3.0, 2.0, NULL, 'unique_16'), (16, 'default2', 'default1', NULL, 'Japanese', 1.0, 0.0, -1, 'unique_17'), (17, 'default2', 'default2', 'default2', 'default2', NULL, -1.0, 1, 'unique_18'), (18, 'default2', 'default2', 'Japanese', 'default2', 1.0, 2.0, 2, 'unique_19'), (19, 'default2', 'default1', 'Japanese', 'default1', 0.0, 2.0, 0, 'unique_20'), (20, 'default2', 'Japanese', NULL, NULL, -1.0, -1.0, -1, 'unique_21'), (21, 'default2', 'Japanese', NULL, NULL, NULL, 2.0, 0, 'unique_22'), (22, 'Japanese', 'default2', NULL, 'default1', -1.0, NULL, -1, 'unique_23'), (23, 'default2', 'Japanese', NULL, NULL, -1.0, NULL, 0, 'unique_24');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 11, 13, 3, 'default2', '2023-01-02', 'Japanese', NULL), (-1, 9, 14, 1, 'default1', '2023-01-01', 'Japanese', 'default2'), (2, 2, 9, 0, 'default1', '2023-01-01', 'Japanese', 'default1'), (3, 11, 13, 3, 'Japanese', '2023-01-01', 'default2', 'Japanese'), (0, 1, 7, -1, 'default1', '2023-01-02', NULL, 'unique_4'), (4, 16, 2, 2, 'Japanese', '2023-01-02', 'Japanese', 'unique_5'), (5, 2, 23, 2, 'default2', '2023-01-02', 'default2', 'unique_6'), (6, 6, 14, 0, 'default1', '2023-01-02', 'default1', 'unique_7'), (7, 12, 1, 2, 'Japanese', '2023-01-02', 'default2', 'unique_8'), (8, 7, 15, 3, 'default2', '2023-01-01', 'default2', 'unique_9'), (9, 2, 20, 1, 'default1', '2023-01-02', 'Japanese', 'unique_10'), (10, 18, 12, 0, 'default1', '2023-01-01', NULL, 'unique_11'), (11, 11, 4, 1, 'default2', '2023-01-01', NULL, 'unique_12'), (12, -1, 22, 2, 'default1', '2023-01-01', NULL, 'unique_13'), (13, 1, 12, 0, 'default2', '2023-01-02', 'Japanese', 'unique_14'), (14, 7, 8, 1, 'default2', '2023-01-01', 'default2', 'unique_15'), (15, 6, 23, 1, 'default1', '2023-01-02', 'default1', 'unique_16'), (16, 16, 18, 2, 'Japanese', '2023-01-01', 'Japanese', 'unique_17'), (17, 15, 12, 0, 'Japanese', '2023-01-02', 'Japanese', 'unique_18');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (3, 11, -1, 0.0, NULL, 'default2', 2), (-1, 1, 1, 0.0, -1, 'Japanese', 1), (1, 3, 3, 3.0, 0, 'default1', 0), (0, 12, 3, 0.0, 1, NULL, 3), (2, 15, 4, -1.0, NULL, 'default1', -1), (4, 11, 2, 1.0, 1, 'default1', 3), (5, 9, 2, -1.0, NULL, NULL, -1), (6, 11, 1, 0.0, 3, NULL, -1), (7, 2, -1, -1.0, 2, 'default2', 2), (8, 0, 3, 3.0, 2, 'Japanese', 0), (9, 15, 4, -1.0, 1, 'default2', 1), (10, 16, 2, -1.0, NULL, 'default1', 2), (11, 16, 0, 3.0, -1, 'default1', -1), (12, 16, 5, 3.0, 1, 'default1', 2), (13, 4, 0, 0.0, -1, NULL, 1), (14, 5, 1, 2.0, 2, 'default2', 3), (15, 8, -1, 3.0, 1, 'default2', -1), (16, 4, -1, 1.0, 0, NULL, 0), (17, 6, 5, -1.0, NULL, NULL, 3), (18, 10, 2, 1.0, 0, 'Japanese', 2), (19, 9, 5, 1.0, 0, 'default1', 1), (20, 9, 5, 2.0, 3, 'default2', 0), (21, 14, 4, 1.0, 2, 'default1', 3), (22, 1, -1, 1.0, 0, NULL, 0), (23, 12, -1, 2.0, -1, NULL, 3);
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (0, 6, 2, 2.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.raceId) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T2.nationality = 'Japanese' GROUP BY T1.constructorId HAVING COUNT(raceId) = 2;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT cr.constructorId) FROM constructorResults AS cr JOIN constructors AS c ON cr.constructorId = c.constructorId WHERE c.nationality = 'Japanese' AND cr.points = 0 GROUP BY cr.constructorId HAVING COUNT(DISTINCT cr.raceId) = 2;

/*
Prediction Result:
*/