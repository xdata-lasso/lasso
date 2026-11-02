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
INSERT INTO seasons (year, url) VALUES (60, 'French'), (6, 'default2'), (3, 'default1'), (1, 'unique_3'), (7, 'unique_4'), (120000, 'unique_5'), (120001, 'unique_6'), (119999, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (120001, 'default1', 121, NULL, 'default1', 'default1', NULL, 'default1', 'French'), (0, 'default1', 120000, 'default1', 'default1', 'default1', '2023-01-02', 'French', 'default1'), (2, 'French', 120, 'default2', 'default2', 'French', NULL, 'default2', 'default2'), (59, 'French', 61, NULL, 'default1', 'default1', '2023-01-02', 'French', 'unique_3'), (61, 'French', 4, 'default2', 'French', 'default2', '2023-01-02', 'default2', 'unique_4'), (7, 'default1', 0, 'default1', 'default2', 'default2', NULL, 'French', 'unique_5'), (120000, 'default1', 1001, NULL, 'default1', 'default2', NULL, 'French', 'unique_6'), (60, 'French', 1, 'default1', 'French', 'default1', NULL, 'default2', 'unique_7'), (119999, 'French', 1000, 'default1', 'default2', 'default2', '2023-01-02', 'default2', 'unique_8'), (1, 'French', 60, 'default2', 'French', 'French', '2023-01-01', NULL, 'unique_9'), (3, 'French', 3, 'French', 'default1', 'French', '2023-01-02', 'default1', 'unique_10'), (4, 'French', 2, NULL, 'default2', 'default1', '2023-01-01', 'French', 'unique_11');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'French', 'default2', 'default2', 'French', 0.0, 120001.0, 1, 'French'), (6, 'French', 'French', 'French', NULL, 3.0, 120.0, 120, 'default1'), (7, 'default2', 'French', 'French', 'default1', 1.0, 120000.0, 8, 'default2'), (0, 'French', 'default1', 'French', 'default2', 4.0, 120.0, 8, 'unique_3'), (61, 'French', 'default2', NULL, 'default2', 8.0, 6.0, 61, 'unique_4'), (120, 'default1', 'default2', 'default1', 'default2', 5.0, 1001.0, 0, 'unique_5'), (999, 'default2', 'default1', NULL, NULL, 120001.0, 119.0, 60, 'unique_6'), (119999, 'default1', 'French', NULL, 'default2', 6.0, 6.0, 59, 'unique_7'), (3, 'French', 'French', NULL, 'default1', 7.0, NULL, 1001, 'unique_8'), (1001, 'default1', 'French', 'default1', NULL, 120001.0, 4.0, 61, 'unique_9'), (60, 'French', 'default1', NULL, 'French', 2.0, 59.0, 4, 'unique_10'), (59, 'French', 'default1', 'default1', NULL, 119999.0, 999.0, 120000, 'unique_11'), (120000, 'default1', 'French', 'French', 'default2', 3.0, 2.0, 0, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (7, 7, 2, 59, 'default2', '2023-01-02', 'default2', 'French'), (1001, 7, 119999, 61, 'French', '2023-01-02', 'default1', NULL), (119999, 120001, 120000, 120, 'default2', '2023-01-01', 'default2', 'default1'), (120, 119999, 2, 7, 'French', '2023-01-01', 'French', 'default2'), (5, 3, 120000, 0, 'French', '2023-01-01', 'default2', 'unique_4'), (8, 119999, 61, 0, 'default2', '2023-01-02', 'default2', 'unique_5'), (3, 120001, 61, 121, 'default1', '2023-01-01', 'default2', 'unique_6'), (0, 119999, 0, 999, 'default2', '2023-01-02', 'French', 'unique_7'), (120000, 120001, 0, 1, 'French', '2023-01-01', 'French', 'unique_8'), (120001, 1, 120000, 5, 'default1', '2023-01-01', 'default1', 'unique_9'), (1, 120000, 61, 59, 'default1', '2023-01-01', 'default1', 'unique_10'), (2, 120000, 0, 6, 'French', '2023-01-01', NULL, 'unique_11');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (120, 1, 60, 1, 'default2', 60), (119999, 1, 60, 1, NULL, 119), (3, 120001, 120, 1000, NULL, 0), (5, 7, 3, 119, 'French', 5), (2, 60, 119999, 0, NULL, 60), (119999, 120000, 6, 59, 'default1', 999), (3, 4, 60, 1, NULL, 8), (120001, 120001, 59, 1, 'French', 999), (8, 119999, 120000, 119999, 'default2', 59), (1001, 0, 1, 8, 'default2', 119), (0, 2, 120, 59, NULL, 1001), (119999, 60, 120, 121, 'French', 119999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND T2.milliseconds < 120000;

/*
Prediction Result:
(4,)
*/