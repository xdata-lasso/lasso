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
INSERT INTO seasons (year, url) VALUES (60, 'French'), (119, ':'), (1001, 'default1'), (5, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (6, 'French', 1, NULL, 'default1', ':', '2023-01-01', 'default2', 'default1'), (61, 'default2', 999, 'default1', 'default2', ':', NULL, NULL, 'default2'), (1001, 'default1', 999, 'default1', 'default1', ':', NULL, 'default2', ':'), (3, ':', 59, NULL, 'default1', ':', '2023-01-02', ':', 'French'), (1000, 'French', 59, NULL, 'default2', 'default2', '2023-01-01', 'French', 'unique_4'), (121, 'default2', 3, 'default2', ':', 'default2', NULL, NULL, 'unique_5'), (59, ':', 0, NULL, ':', 'default2', '2023-01-02', 'French', 'unique_6'), (2, 'French', 1001, 'French', ':', ':', '2023-01-02', 'French', 'unique_7'), (4, 'French', 1001, 'French', 'French', 'default2', NULL, 'default2', 'unique_8'), (1, 'default1', 0, ':', 'default2', 'default2', NULL, NULL, 'unique_9'), (60, ':', 6, ':', 'French', 'default2', '2023-01-01', 'French', 'unique_10'), (8, 'default1', 60, NULL, 'French', 'default1', NULL, ':', 'unique_11'), (0, 'default1', 1, 'French', ':', 'default2', NULL, NULL, 'unique_12'), (5, 'French', 1000, 'default1', 'default2', 'default2', NULL, 'French', 'unique_13'), (7, 'default2', 1000, NULL, ':', ':', '2023-01-01', ':', 'unique_14'), (999, 'default1', 60, NULL, 'default2', 'French', '2023-01-02', 'default1', 'unique_15'), (120, ':', 1001, 'default1', 'default1', 'default1', '2023-01-01', 'French', 'unique_16');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (4, 'French', 'French', 'default2', 'default2', 60.0, 121.0, 7, 'default2'), (61, 'French', 'default2', NULL, 'default2', 8.0, 121.0, 119, 'default1'), (120, 'French', 'default1', 'default1', 'default2', 999.0, 61.0, 120, 'French'), (7, 'French', ':', NULL, 'default2', 119.0, 121.0, 7, ':'), (999, ':', 'French', NULL, ':', 120.0, 1000.0, 1000, 'unique_4'), (1, 'default2', ':', 'default2', 'French', 8.0, 0.0, 2, 'unique_5'), (0, 'default2', 'default1', NULL, 'French', 1000.0, 119.0, 1001, 'unique_6'), (2, 'French', 'French', 'default2', 'French', 0.0, 4.0, 5, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (60, 119, 120, 119, 'default2', '2023-01-02', NULL, 'default2'), (1000, 1001, 4, 6, 'default2', '2023-01-02', 'default2', 'French'), (121, 60, 4, 1001, 'default1', '2023-01-02', 'French', NULL), (3, 60, 120, 1, 'French', '2023-01-01', 'French', 'default1'), (2, 5, 1, 1001, 'default2', '2023-01-01', 'default2', ':'), (0, 60, 120, 2, ':', '2023-01-01', 'default2', 'unique_5'), (1001, 5, 61, 59, 'French', '2023-01-02', 'French', 'unique_6'), (8, 60, 4, 5, 'default2', '2023-01-01', ':', 'unique_7'), (61, 60, 0, 1000, ':', '2023-01-02', 'default2', 'unique_8'), (1, 60, 0, 60, 'default2', '2023-01-01', 'French', 'unique_9'), (120, 60, 120, 60, ':', '2023-01-02', 'default1', 'unique_10'), (119, 1001, 999, 1001, ':', '2023-01-02', 'default2', 'unique_11'), (5, 60, 7, 7, ':', '2023-01-01', NULL, 'unique_12'), (4, 60, 0, 1001, 'French', '2023-01-02', 'default2', 'unique_13'), (7, 1001, 2, 59, 'default1', '2023-01-02', ':', 'unique_14'), (6, 5, 1, 3, ':', '2023-01-01', ':', 'unique_15'), (999, 5, 1, 999, 'default2', '2023-01-02', ':', 'unique_16'), (59, 60, 0, 2, 'French', '2023-01-01', 'default1', 'unique_17'), (9, 5, 4, 119, 'default1', '2023-01-01', ':', 'unique_18');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (999, 7, 121, NULL, NULL, 5), (61, 3, 6, 3, 'default1', 1), (9, 120, 1000, 119, 'default1', 4), (999, 0, 61, 119, NULL, 999), (1000, 60, 0, 8, 'French', 8), (3, 1, 8, 3, ':', NULL), (4, 7, 61, 8, NULL, 5), (3, 1, 61, 1001, 'French', 61), (1001, 6, 6, 999, ':', 59), (59, 59, 1, 0, 'French', 60), (6, 1001, 120, 5, 'French', 8), (120, 1000, 6, 4, 'French', 7), (3, 2, 5, 1, ':', 1000), (3, 1001, 5, 121, 'default1', 3), (60, 121, 119, 1001, NULL, 1), (120, 1000, 1001, 5, 'default1', 59), (59, 999, 8, 999, NULL, 59);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT drivers.driverid) FROM drivers INNER JOIN laptimes ON drivers.driverid = laptimes.driverid WHERE drivers.nationality = 'French' AND (SUBSTRING(laptimes.time, INSTR(laptimes.time, ':') + 1) * 1 + SUBSTRING(laptimes.time, 1, INSTR(laptimes.time, ':') - 1) * 60) < 120;

/*
Prediction Result:
(5,)
*/