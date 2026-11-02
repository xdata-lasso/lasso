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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'default1'), (2, 'unique_2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default1', 'default1', 'default2', 'default1'), (1, 'default1', 'default2', NULL, 'default1'), (0, 'default2', 'unique_2', 'default2', 'default2'), (3, 'default2', 'unique_3', 'default1', 'default2'), (4, 'default1', 'unique_4', NULL, 'default2'), (5, 'default2', 'unique_5', 'default1', 'default2'), (6, 'default2', 'unique_6', NULL, 'default1'), (7, 'default2', 'unique_7', 'default1', 'default1'), (8, 'default1', 'unique_8', NULL, 'default1'), (9, 'default2', 'unique_9', NULL, 'default1'), (10, 'default1', 'unique_10', 'default1', 'default1'), (11, 'default1', 'unique_11', 'default2', 'default2'), (12, 'default2', 'unique_12', 'default2', 'default2'), (13, 'default1', 'unique_13', 'default1', 'default2'), (14, 'default1', 'unique_14', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', 'default2', 'default2', NULL, NULL, NULL, 1, 'default1'), (2, 'default1', 'default1', 'default1', 'default1', 2.0, NULL, 2, 'default2'), (0, 'default2', 'default2', NULL, 'default1', NULL, 1.0, NULL, 'unique_2'), (3, 'default2', 'default2', 'default2', NULL, NULL, NULL, 1, 'unique_3'), (4, 'default2', 'default2', 'default1', 'default2', 0.0, NULL, 2, 'unique_4'), (5, 'default1', 'default2', 'default1', 'default1', 0.0, 2.0, NULL, 'unique_5'), (6, 'default2', 'default1', 'default1', 'default2', 1.0, 0.0, 1, 'unique_6'), (7, 'default2', 'default2', 'default1', 'default1', 0.0, 1.0, NULL, 'unique_7'), (8, 'default1', 'default2', NULL, NULL, 2.0, 1.0, 2, 'unique_8'), (9, 'default1', 'default1', 'default1', NULL, 1.0, 0.0, 1, 'unique_9'), (10, 'default2', 'default2', 'default1', NULL, 2.0, 1.0, 0, 'unique_10'), (11, 'default2', 'default2', 'default1', 'default2', 0.0, NULL, 2, 'unique_11'), (12, 'default2', 'default2', 'default1', NULL, NULL, 1.0, 1, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 11, 9, 1, 'default1', '2023-01-01', 'default2', 'default2'), (1, 6, 5, 0, 'default1', '2023-01-01', NULL, 'default1'), (2, 3, 10, 1, 'default2', '2023-01-01', NULL, NULL), (3, 5, 6, 1, 'default2', '2023-01-01', 'default1', 'unique_3'), (4, 0, 9, 2, 'default1', '2023-01-02', NULL, 'unique_4'), (5, 10, 8, 2, 'default2', '2023-01-01', 'default2', 'unique_5'), (6, 6, 8, 1, 'default2', '2023-01-02', 'default1', 'unique_6'), (7, 10, 8, 0, 'default1', '2023-01-02', NULL, 'unique_7'), (8, 3, 12, 0, 'default2', '2023-01-02', 'default1', 'unique_8'), (9, 0, 3, 2, 'default2', '2023-01-02', 'default2', 'unique_9'), (10, 2, 10, 2, 'default1', '2023-01-02', NULL, 'unique_10'), (11, 9, 4, 0, 'default1', '2023-01-01', 'default2', 'unique_11');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (0, 2, 14, 1.0, NULL, NULL, 0), (2, 6, 12, 1.0, 1, 'default2', 2), (1, 1, 0, 2.0, 2, 'default1', 0), (3, 11, 0, 1.0, 2, 'default2', 2), (4, 9, 11, 2.0, 1, 'default1', 2), (5, 10, 12, 0.0, 1, 'default2', 0), (6, 0, 7, 2.0, NULL, NULL, 2), (7, 10, 2, 1.0, NULL, 'default2', 2), (8, 3, 12, 2.0, NULL, NULL, 0), (9, 6, 2, 2.0, 0, 'default2', 1), (10, 7, 10, 1.0, 2, 'default1', 1), (11, 4, 10, 1.0, NULL, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.url FROM constructors AS T1 INNER JOIN constructorStandings AS T2 ON T1.constructorId = T2.constructorId ORDER BY T2.wins DESC, T1.constructorid NULLS LAST, T2.constructorstandingsid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT c.url FROM constructors AS c JOIN constructorStandings AS cs ON c.constructorId = cs.constructorId GROUP BY c.constructorId ORDER BY CAST(SUM(cs.wins) AS REAL) DESC, c.url NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/