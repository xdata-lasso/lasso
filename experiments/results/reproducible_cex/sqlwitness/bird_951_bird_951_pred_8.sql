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
INSERT INTO seasons (year, url) VALUES (-1, 'default1'), (1, 'Japanese'), (3, 'default2'), (2, 'unique_3'), (0, 'unique_4'), (4, 'unique_5'), (5, 'unique_6'), (6, 'unique_7'), (7, 'unique_8'), (8, 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (-1, 'Japanese', 'default1', 'Japanese', 'default2'), (2, 'default2', 'default2', NULL, 'default1'), (1, 'default2', 'Japanese', 'default2', 'default1'), (0, 'default1', 'unique_3', NULL, 'default1'), (3, 'default2', 'unique_4', 'default1', 'default2'), (4, 'default1', 'unique_5', NULL, 'Japanese'), (5, 'default1', 'unique_6', 'Japanese', 'default1'), (6, 'Japanese', 'unique_7', 'Japanese', 'default2'), (7, 'default2', 'unique_8', 'Japanese', 'Japanese'), (8, 'default1', 'unique_9', NULL, 'default2'), (9, 'default1', 'unique_10', 'default2', 'Japanese');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Japanese', 'default2', 'default2', 'default2', -1.0, 3.0, 3, 'default1'), (-1, 'default1', 'default2', NULL, 'Japanese', 3.0, 3.0, -1, 'Japanese'), (2, 'default2', 'Japanese', 'default1', 'default1', 0.0, 0.0, NULL, 'default2'), (1, 'default1', 'Japanese', NULL, 'default1', NULL, -1.0, 0, 'unique_3'), (3, 'default1', 'Japanese', 'default2', 'Japanese', 0.0, -1.0, 0, 'unique_4'), (4, 'Japanese', 'Japanese', 'default2', 'default1', 1.0, NULL, -1, 'unique_5'), (5, 'default1', 'default2', 'default1', 'Japanese', -1.0, -1.0, 0, 'unique_6'), (6, 'Japanese', 'Japanese', 'default2', 'default2', 3.0, 0.0, NULL, 'unique_7'), (7, 'Japanese', 'default2', NULL, NULL, -1.0, 0.0, 3, 'unique_8'), (8, 'default1', 'Japanese', 'Japanese', 'default1', NULL, NULL, 3, 'unique_9'), (9, 'default1', 'Japanese', NULL, 'default1', 0.0, 2.0, 1, 'unique_10'), (10, 'Japanese', 'default2', 'Japanese', 'Japanese', 1.0, 1.0, 2, 'unique_11'), (11, 'default2', 'default2', NULL, NULL, 3.0, 1.0, NULL, 'unique_12'), (12, 'default2', 'default2', 'Japanese', 'Japanese', 2.0, 2.0, 1, 'unique_13'), (13, 'default1', 'Japanese', 'Japanese', NULL, 0.0, 0.0, 0, 'unique_14'), (14, 'Japanese', 'default1', 'default2', 'default2', NULL, 3.0, 1, 'unique_15'), (15, 'Japanese', 'Japanese', 'default1', 'default2', 3.0, 1.0, 1, 'unique_16'), (16, 'default1', 'default1', 'Japanese', NULL, 2.0, NULL, 1, 'unique_17'), (17, 'Japanese', 'Japanese', 'default2', 'default2', 2.0, NULL, 3, 'unique_18'), (18, 'default1', 'Japanese', 'default2', NULL, -1.0, 3.0, 3, 'unique_19'), (19, 'default2', 'default2', 'default2', 'default2', -1.0, -1.0, 1, 'unique_20'), (20, 'default2', 'default1', 'default2', 'Japanese', -1.0, 3.0, 0, 'unique_21'), (21, 'default2', 'Japanese', 'Japanese', 'default2', -1.0, 2.0, 1, 'unique_22');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 4, 17, 0, 'default2', '2023-01-02', 'default2', 'default2'), (-1, 4, 16, 0, 'default2', '2023-01-02', 'default2', 'Japanese'), (2, 1, 2, -1, 'Japanese', '2023-01-02', 'default2', 'default1');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (0, 1, 3, -1.0, 3, NULL, -1), (3, -1, 2, 0.0, NULL, 'default1', 3), (1, 1, 6, 3.0, 3, 'default1', -1), (-1, -1, 8, 2.0, 1, NULL, 1), (2, 1, 3, 1.0, -1, 'default1', 1), (4, -1, 8, -1.0, 0, 'default1', 2), (5, 1, 4, 0.0, 2, 'default2', 1), (6, -1, 2, 3.0, 2, 'default2', 3), (7, 2, 6, -1.0, 1, 'Japanese', -1), (8, 1, 7, 3.0, 2, NULL, 3), (9, 1, 6, 1.0, -1, 'Japanese', 2), (10, 2, 3, 0.0, 2, 'default2', 2), (11, 1, -1, 0.0, 2, 'default2', -1), (12, 1, 5, 0.0, 1, 'default1', 3), (13, 1, 7, 3.0, 2, 'default1', -1), (14, -1, 0, 0.0, 2, 'default2', -1), (15, 2, 9, 2.0, NULL, 'default1', 1), (16, 1, 9, 0.0, 2, 'Japanese', -1), (17, 1, -1, 0.0, 0, 'default1', -1), (18, 2, 1, -1.0, -1, 'default2', 2), (19, -1, 4, 3.0, 3, NULL, 0), (20, 1, 0, -1.0, 0, NULL, 0), (21, -1, -1, 1.0, 0, 'default1', 0), (22, -1, 7, 1.0, 0, 'default1', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.raceId) FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T2.nationality = 'Japanese' GROUP BY T1.constructorId HAVING COUNT(raceId) = 2;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT cs.constructorId) AS JapaneseConstructorsWith0PointsIn2Races FROM constructors AS c JOIN constructorStandings AS cs ON c.constructorId = cs.constructorId WHERE c.nationality = 'Japanese' GROUP BY cs.constructorId HAVING COUNT(cs.raceId) = 2 AND SUM(cs.points) = 0;

/*
Prediction Result:
*/