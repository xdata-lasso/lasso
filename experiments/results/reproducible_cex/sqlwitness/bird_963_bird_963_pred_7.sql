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
INSERT INTO seasons (year, url) VALUES (6, 'French'), (8, 'default2'), (119, 'default1'), (59, 'unique_3'), (7, 'unique_4');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1000, 'default1', 1001, NULL, 'default2', 'default1', NULL, 'default2', 'default2'), (7, 'French', 59, 'default1', 'French', 'default2', '2023-01-01', 'default1', 'French'), (119, 'French', 59, NULL, 'default1', 'default1', '2023-01-02', 'French', 'default1'), (999, 'default2', 6, 'default1', 'default2', 'default1', NULL, 'French', 'unique_3'), (1001, 'French', 7, 'French', 'default1', 'default1', '2023-01-02', NULL, 'unique_4'), (60, 'default1', 1, 'French', 'default2', 'default1', '2023-01-01', 'default2', 'unique_5'), (8, 'default1', 999, 'default2', 'default2', 'default1', '2023-01-02', 'default2', 'unique_6'), (120000, 'default1', 4, 'French', 'default1', 'default2', '2023-01-01', 'French', 'unique_7'), (121, 'default2', 3, 'default2', 'default1', 'default2', NULL, 'default2', 'unique_8'), (3, 'French', 60, NULL, 'default1', 'French', '2023-01-02', 'French', 'unique_9'), (120001, 'French', 121, 'French', 'default2', 'default1', '2023-01-02', NULL, 'unique_10'), (4, 'default2', 5, 'French', 'French', 'default2', NULL, 'default2', 'unique_11'), (119999, 'French', 999, 'default2', 'default2', 'default2', NULL, 'default2', 'unique_12'), (1, 'default2', 8, 'French', 'default1', 'French', '2023-01-01', 'French', 'unique_13'), (0, 'default1', 120000, NULL, 'default2', 'default2', NULL, NULL, 'unique_14'), (2, 'default2', NULL, 'default2', 'default2', 'default2', '2023-01-01', 'default2', 'unique_15');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (59, 'French', 'default1', 'French', 'French', 60.0, 119.0, 1, 'French'), (61, 'default1', 'default2', 'French', 'default1', NULL, 6.0, 1, 'default1'), (5, 'default1', 'default2', 'French', 'default2', 60.0, 7.0, 119999, 'default2'), (120000, 'French', 'default2', NULL, 'default1', 119.0, 0.0, 120000, 'unique_3');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (6, 8, 120000, 8, 'French', '2023-01-01', 'French', 'French'), (60, 8, 59, 1, 'French', '2023-01-01', 'French', NULL), (1001, 6, 120000, 2, 'default1', '2023-01-02', 'default1', 'default1'), (61, 7, 59, 2, 'French', '2023-01-02', 'default1', 'default2'), (8, 59, 59, 0, 'default1', '2023-01-01', 'default2', 'unique_4'), (120000, 6, 5, 4, 'default2', '2023-01-01', NULL, 'unique_5'), (119999, 6, 120000, 6, 'French', '2023-01-02', 'default1', 'unique_6');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (120000, 1000, 1, 8, 'French', 61), (61, 7, 59, 61, 'French', 7), (120000, 60, 120001, 7, NULL, 1001), (60, 7, 3, 121, 'default2', 1), (119999, 8, 5, 2, 'French', 1000), (8, 4, 1000, 59, NULL, 1001), (119999, 119, 119, 6, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM drivers AS T1 JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND T2.milliseconds < 120000;

/*
Prediction Result:
(0,)
*/