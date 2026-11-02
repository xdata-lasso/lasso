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
INSERT INTO seasons (year, url) VALUES (7, 'default1'), (3, 'French'), (60, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (120, 'default1', 1000, 'default2', 'default1', 'French', '2023-01-02', 'default1', 'French'), (999, 'default1', 6, 'default2', 'default1', 'French', NULL, 'default2', 'default2'), (1, 'French', 59, NULL, 'default2', 'French', NULL, NULL, 'default1'), (3, 'default2', 1001, 'default1', 'default1', 'default2', NULL, NULL, 'unique_3'), (59, 'default1', 60, 'default1', 'default1', 'default2', '2023-01-01', NULL, 'unique_4'), (1000, 'French', 2, 'default1', 'French', 'French', NULL, NULL, 'unique_5'), (7, 'default2', 1001, 'default2', 'French', 'default1', NULL, 'French', 'unique_6'), (60, 'default2', 4, NULL, 'default1', 'French', '2023-01-01', 'default2', 'unique_7'), (1001, 'default1', NULL, 'default2', 'French', 'French', NULL, 'default1', 'unique_8'), (8, 'French', NULL, 'default1', 'default2', 'French', '2023-01-02', NULL, 'unique_9'), (121, 'French', 999, NULL, 'default2', 'default1', '2023-01-01', NULL, 'unique_10'), (61, 'default1', 0, 'default1', 'French', 'default2', '2023-01-01', 'default2', 'unique_11'), (0, 'default2', 119, 'default1', 'default1', 'default2', '2023-01-01', 'default2', 'unique_12'), (2, 'default2', 121, 'French', 'default2', 'French', '2023-01-02', 'French', 'unique_13'), (4, 'default2', 1000, NULL, 'default2', 'French', '2023-01-02', 'default2', 'unique_14'), (5, 'French', NULL, NULL, 'French', 'default2', NULL, 'default2', 'unique_15'), (6, 'default2', 1001, 'default1', 'French', 'default2', NULL, NULL, 'unique_16'), (119, 'French', 61, 'French', 'default1', 'default2', '2023-01-02', NULL, 'unique_17');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (4, 'default1', 'default1', 'default2', 'French', 59.0, 7.0, NULL, 'default1'), (2, 'French', 'default2', NULL, NULL, NULL, 119.0, 121, 'default2'), (0, 'default1', 'French', 'default1', 'French', 999.0, 119.0, 5, 'French'), (7, 'French', 'default2', 'default2', 'French', 6.0, 3.0, 5, 'unique_3'), (8, 'default2', 'default1', 'French', NULL, NULL, 120.0, 7, 'unique_4'), (120, 'default2', 'default1', 'default1', 'default1', 59.0, 8.0, 5, 'unique_5'), (1, 'default1', 'default2', 'default1', 'French', 999.0, 59.0, 8, 'unique_6'), (3, 'default1', 'default1', 'French', 'default2', 121.0, 5.0, 61, 'unique_7'), (5, 'French', 'default2', 'default2', 'default1', 0.0, 61.0, 120, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (119, 7, 2, 7, 'default2', '2023-01-02', 'French', 'default1'), (4, 60, 0, 1000, 'French', '2023-01-02', 'default1', NULL), (59, 3, 7, 1, 'default2', '2023-01-02', 'default1', 'French'), (8, 3, 0, 61, 'default1', '2023-01-01', 'French', 'default2'), (61, 7, 2, 8, 'default2', '2023-01-02', 'default2', 'unique_4'), (1000, 3, 3, 119, 'default2', '2023-01-01', 'default2', 'unique_5'), (5, 7, 5, 1001, 'default1', '2023-01-01', 'default2', 'unique_6'), (3, 7, 8, 0, 'French', '2023-01-02', 'default2', 'unique_7'), (1, 3, 2, 1000, 'default1', '2023-01-02', 'default1', 'unique_8'), (0, 60, 0, 1001, 'default2', '2023-01-02', 'default1', 'unique_9'), (2, 60, 1, 4, 'default2', '2023-01-01', NULL, 'unique_10'), (7, 60, 4, 5, 'default2', '2023-01-01', 'default2', 'unique_11'), (6, 60, 8, 1000, 'French', '2023-01-01', 'French', 'unique_12');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (7, 1, 120, 4, 'French', 0), (5, 7, 119, 2, NULL, 121), (5, 8, 8, 120, 'French', 121), (6, 120, 59, 1000, 'French', 8), (7, 2, 6, 8, 'French', 0), (1000, 1001, 60, NULL, NULL, 7), (8, 7, 61, 121, 'default2', 4), (3, 1001, 0, 60, 'French', 120), (7, 7, 120, 4, 'French', 119);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM drivers AS D INNER JOIN lapTimes AS LT ON D.driverId = LT.driverId WHERE D.nationality = 'French' AND CAST(LT.milliseconds AS REAL) / 1000 < 120;

/*
Prediction Result:
(4,)
*/