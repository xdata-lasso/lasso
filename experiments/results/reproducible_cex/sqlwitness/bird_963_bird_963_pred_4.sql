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
INSERT INTO seasons (year, url) VALUES (60, 'French'), (1001, 'default1'), (119999, 'default2'), (120001, 'unique_3'), (61, 'unique_4'), (120000, 'unique_5'), (1, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (3, 'French', 999, 'default1', 'default2', 'default2', '2023-01-01', 'default2', 'default2'), (120, 'French', 60, 'default1', 'French', 'default1', '2023-01-02', 'default2', 'French'), (2, 'French', 2, 'default2', 'default2', 'default2', '2023-01-01', NULL, 'default1'), (1, 'default2', 119999, NULL, 'French', 'default2', NULL, 'French', 'unique_3'), (60, 'default2', 2, NULL, 'default1', 'default1', '2023-01-01', 'default2', 'unique_4'), (120000, 'French', 3, 'default2', 'French', 'default1', NULL, 'default2', 'unique_5');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3, 'default1', 'default2', 'default2', 'default1', 5.0, 121.0, 2, 'default1'), (120001, 'default1', 'French', 'default1', 'default1', NULL, 3.0, NULL, 'French'), (7, 'default1', 'French', NULL, NULL, NULL, 4.0, 61, 'default2'), (4, 'default1', 'default2', NULL, 'French', 120000.0, 3.0, 4, 'unique_3'), (119999, 'French', 'default1', NULL, 'default1', 3.0, 2.0, 61, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 120001, 120001, 5, 'default1', '2023-01-01', 'default1', NULL), (4, 120000, 4, 120, 'default2', '2023-01-02', 'default2', 'default2'), (8, 61, 4, 121, 'French', '2023-01-02', 'French', 'default1'), (7, 60, 120001, 61, 'French', '2023-01-02', 'default2', 'French'), (120000, 120001, 120001, 1001, 'default1', '2023-01-01', NULL, 'unique_4'), (0, 1, 120001, 120001, 'default1', '2023-01-01', NULL, 'unique_5'), (120, 1, 120001, 4, 'default2', '2023-01-02', 'default1', 'unique_6'), (1001, 60, 3, 61, 'French', '2023-01-01', NULL, 'unique_7'), (5, 1001, 119999, 8, 'default1', '2023-01-01', NULL, 'unique_8'), (119999, 60, 4, 0, 'default1', '2023-01-01', 'French', 'unique_9');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (2, 120, 120000, 120000, 'default1', 0), (7, 120000, 7, 60, 'default1', 119999), (2, 120000, 3, 3, 'default1', 120), (4, 1, 121, 61, 'French', 1001), (120000, 1, 60, 8, 'default1', 999), (0, 120, 119, 120000, NULL, 120000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT drivers.driverId) FROM drivers JOIN lapTimes ON drivers.driverId = lapTimes.driverId WHERE drivers.nationality = 'French' AND lapTimes.milliseconds < 120000;

/*
Prediction Result:
(1,)
*/