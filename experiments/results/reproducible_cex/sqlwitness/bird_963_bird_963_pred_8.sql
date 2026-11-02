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
INSERT INTO seasons (year, url) VALUES (8, 'default1'), (0, ':'), (5, 'French'), (2, 'default2'), (119, 'unique_4'), (999, 'unique_5'), (1, 'unique_6'), (60, 'unique_7'), (1001, 'unique_8'), (4, 'unique_9'), (6, 'unique_10'), (1000, 'unique_11'), (61, 'unique_12'), (3, 'unique_13'), (7, 'unique_14'), (120, 'unique_15'), (121, 'unique_16'), (59, 'unique_17'), (9, 'unique_18'), (10, 'unique_19'), (11, 'unique_20'), (12, 'unique_21'), (13, 'unique_22');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1000, 'French', 60, ':', 'default2', ':', '2023-01-01', 'default2', ':'), (2, ':', 1001, 'French', ':', 'default1', NULL, 'default1', 'default1'), (6, 'French', 60, ':', 'French', 'default2', '2023-01-02', 'French', 'French'), (999, ':', 0, NULL, 'default2', 'default2', NULL, ':', 'default2'), (1, 'default1', 120, ':', 'default2', 'French', NULL, 'French', 'unique_4'), (59, 'default2', 1, 'default1', 'default2', 'default1', NULL, ':', 'unique_5'), (8, ':', 60, ':', ':', ':', '2023-01-01', 'default2', 'unique_6'), (1001, ':', 120, ':', 'default1', ':', '2023-01-02', 'default1', 'unique_7'), (60, 'default2', 121, 'default2', 'default1', 'default1', NULL, 'default1', 'unique_8'), (120, 'default1', 1000, ':', 'default2', ':', '2023-01-02', ':', 'unique_9'), (61, 'French', 5, NULL, ':', ':', '2023-01-01', 'default1', 'unique_10'), (0, 'French', 0, 'French', 'French', 'French', '2023-01-02', ':', 'unique_11'), (3, 'default1', 60, NULL, ':', 'default1', '2023-01-01', ':', 'unique_12'), (4, ':', 1000, 'default2', 'default2', 'French', '2023-01-01', ':', 'unique_13'), (5, 'default2', NULL, ':', 'default2', ':', '2023-01-01', ':', 'unique_14'), (7, 'French', 7, ':', 'French', 'default2', '2023-01-02', 'default1', 'unique_15');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (999, 'default1', ':', ':', ':', 61.0, 999.0, 60, 'default2'), (8, 'default2', 'default1', 'French', 'French', NULL, 3.0, 7, 'default1'), (61, 'default1', 'default2', 'default1', 'default1', 1001.0, 8.0, 999, 'French'), (7, 'French', 'default2', 'default2', NULL, NULL, 5.0, 5, ':'), (1001, ':', 'default1', 'French', ':', 5.0, 2.0, 7, 'unique_4'), (6, ':', 'French', NULL, 'French', 59.0, 4.0, 5, 'unique_5'), (3, 'French', ':', 'French', ':', 60.0, 0.0, 6, 'unique_6'), (0, 'French', 'default1', ':', 'French', 5.0, 1001.0, 8, 'unique_7'), (120, 'default2', ':', ':', 'default1', 60.0, 2.0, 59, 'unique_8'), (4, 'default2', ':', NULL, 'French', 3.0, 5.0, 1, 'unique_9'), (5, ':', ':', ':', 'default2', 1000.0, 8.0, 61, 'unique_10'), (1, 'default1', 'default1', 'default1', 'default1', 61.0, 60.0, 6, 'unique_11'), (2, ':', 'default1', 'default1', 'French', 4.0, 1001.0, 999, 'unique_12'), (1000, 'default2', 'default1', 'French', 'French', 5.0, NULL, 8, 'unique_13'), (119, 'French', 'French', NULL, NULL, 1.0, 120.0, 1001, 'unique_14'), (121, ':', 'default1', NULL, 'French', 1.0, 3.0, 6, 'unique_15'), (60, 'default1', 'default2', 'French', 'default1', 2.0, 2.0, 0, 'unique_16');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (121, 5, 0, 1001, 'default2', '2023-01-01', NULL, 'default1'), (2, 120, 999, 999, ':', '2023-01-01', 'default1', 'French'), (8, 61, 1001, 2, 'default2', '2023-01-02', 'French', ':'), (0, 999, 120, 6, 'default1', '2023-01-02', 'default1', 'default2'), (60, 1001, 3, 60, 'French', '2023-01-01', 'default1', NULL), (61, 0, 2, 1000, ':', '2023-01-02', NULL, 'unique_5'), (1, 119, 6, 6, 'French', '2023-01-02', NULL, 'unique_6'), (119, 1000, 4, 8, 'French', '2023-01-02', 'default1', 'unique_7'), (3, 8, 1000, 8, ':', '2023-01-01', 'French', 'unique_8'), (4, 59, 121, 3, 'default1', '2023-01-02', ':', 'unique_9'), (5, 999, 121, 8, ':', '2023-01-02', 'default2', 'unique_10'), (7, 0, 121, 59, 'default1', '2023-01-02', 'French', 'unique_11'), (6, 3, 1001, 120, ':', '2023-01-01', NULL, 'unique_12');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (4, 120, 60, 5, ':', 59), (7, 1, 1001, 0, ':', 59), (7, 1001, 0, 999, NULL, 6), (2, 7, 59, 120, NULL, 8), (61, 1, 999, 120, 'French', 4), (6, 8, 59, NULL, 'default1', 999), (60, 2, 59, 60, ':', 5), (2, 2, 120, 2, 'default1', 8), (3, 1001, 999, 4, ':', 1000), (3, 1001, 1, 3, ':', 4), (7, 8, 2, 121, 'French', 999), (61, 2, 0, 61, 'default2', 120), (4, 2, 999, 7, 'French', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT d.driverId) AS french_drivers_with_fast_laptime FROM drivers AS d JOIN laptimes AS l ON d.driverId = l.driverId WHERE d.nationality = 'French' AND CAST(SUBSTRING(l.time, INSTR(l.time, ':') + 1) AS REAL) + 60 * CAST(SUBSTRING(l.time, 1, INSTR(l.time, ':') - 1) AS REAL) < 120;

/*
Prediction Result:
(1,)
*/