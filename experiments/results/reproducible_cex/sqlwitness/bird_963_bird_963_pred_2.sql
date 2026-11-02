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
INSERT INTO seasons (year, url) VALUES (60, 'default2'), (6, 'French'), (121, 'default1'), (59, 'unique_3'), (3, 'unique_4'), (120, 'unique_5'), (999, 'unique_6'), (119, 'unique_7'), (0, 'unique_8'), (1, 'unique_9'), (2, 'unique_10'), (5, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (120000, 'French', 59, 'French', 'default1', 'French', NULL, 'default2', 'French'), (120, 'French', 1001, 'default1', 'default2', 'French', '2023-01-01', 'French', 'default2'), (2, 'default2', 120, 'default1', 'French', 'default1', NULL, 'default1', 'default1'), (3, 'French', 120, 'default1', 'default2', 'default2', '2023-01-02', 'default1', 'unique_3'), (1, 'default1', 61, 'default1', 'French', 'French', NULL, 'French', 'unique_4'), (5, 'default1', 999, 'French', 'French', 'default2', '2023-01-02', NULL, 'unique_5'), (119, 'default2', 120001, 'default2', 'French', 'French', '2023-01-02', 'French', 'unique_6'), (1000, 'French', 4, 'default2', 'default2', 'default1', '2023-01-01', 'default1', 'unique_7'), (8, 'French', 1, 'French', 'default1', 'default1', '2023-01-01', 'default2', 'unique_8'), (119999, 'French', 1001, 'French', 'French', 'French', NULL, NULL, 'unique_9');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (120001, 'default2', 'default2', 'default1', NULL, 7.0, 4.0, 3, 'default2'), (60, 'default1', 'default2', 'default1', 'default1', 120001.0, 1.0, 2, 'French'), (121, 'default1', 'default2', 'default2', NULL, 121.0, 6.0, 121, 'default1'), (120, 'default1', 'French', NULL, 'French', 120000.0, 2.0, 7, 'unique_3'), (999, 'default1', 'default1', 'default2', 'French', 119.0, 2.0, 7, 'unique_4'), (3, 'French', 'default1', 'French', 'default2', 120.0, 119.0, 0, 'unique_5'), (4, 'default1', 'French', 'default2', 'default2', 1.0, 120.0, 5, 'unique_6'), (119, 'default2', 'default1', 'default2', 'default2', 8.0, 0.0, 120, 'unique_7'), (120000, 'French', 'French', 'default2', 'default1', 2.0, 8.0, 6, 'unique_8'), (119999, 'default1', 'default2', 'French', NULL, 119.0, 119.0, 7, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (120000, 1, 119999, 0, 'default2', '2023-01-02', 'default2', NULL), (0, 120, 60, 4, 'French', '2023-01-02', NULL, 'French'), (119999, 1, 120, 999, 'default1', '2023-01-02', 'French', 'default1'), (5, 119, 120001, 0, 'default2', '2023-01-02', NULL, 'default2'), (119, 119, 119999, 119, 'default1', '2023-01-02', 'default2', 'unique_4'), (120001, 120, 119999, 119, 'French', '2023-01-02', NULL, 'unique_5');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (0, 1, 120000, 119999, 'French', 1000), (119, 120000, 121, 60, NULL, 0), (119999, 3, 0, 120, 'French', 1001), (0, 1, 8, 121, 'French', NULL), (0, 8, 120001, 1, 'default1', 59), (120001, 3, 119, 999, 'French', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'French' AND (CAST(SUBSTRING(T2.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTRING(T2.time, 4, 2) AS INTEGER) + CAST(SUBSTRING(T2.time, 7, 2) AS REAL) / 1000) < 120;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "drivers"."driverId") FROM "drivers" INNER JOIN "lapTimes" ON "drivers"."driverId" = "lapTimes"."driverId" WHERE "drivers"."nationality" = 'French' AND "lapTimes"."milliseconds" < 120000;

/*
Prediction Result:
(1,)
*/