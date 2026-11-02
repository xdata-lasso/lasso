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
INSERT INTO status (statusid, status) VALUES (0, 'default2');
INSERT INTO seasons (year, url) VALUES (1000, 'default2'), (59, 'default1'), (1, '.'), (61, ':'), (999, 'Italy'), (0, 'unique_5'), (2, 'unique_6'), (1001, 'unique_7'), (60, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (61, '.', 1000, NULL, 'default1', 'default2', NULL, ':', 'Italy'), (0, 'default1', 0, 'default2', '.', 'default1', '2023-01-01', ':', '.'), (1000, 'default2', 2, 'Italy', 'Italy', ':', '2023-01-01', NULL, 'default1'), (2, 'default1', 1001, ':', 'default2', 'default1', NULL, '.', ':'), (1001, '.', 60, NULL, 'default2', 'default1', '2023-01-01', '.', 'default2'), (1, ':', 60, 'default2', 'default1', 'default1', '2023-01-02', '.', 'unique_5'), (60, 'default2', 61, 'default1', '.', 'default1', NULL, 'default1', 'unique_6'), (999, 'default1', 0, 'default1', '.', 'default2', '2023-01-02', NULL, 'unique_7'), (59, ':', 60, ':', ':', ':', '2023-01-01', 'Italy', 'unique_8'), (3, 'default2', 2, ':', '.', '.', '2023-01-02', NULL, 'unique_9'), (4, ':', 0, ':', 'default1', '.', '2023-01-01', ':', 'unique_10');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1001, '.', 'default2', ':', '.'), (1000, '.', 'Italy', 'Italy', '.'), (60, 'default1', '.', NULL, 'default2'), (999, '.', 'default1', NULL, '.'), (1, 'default2', ':', 'default1', 'Italy'), (0, 'Italy', 'unique_5', 'default2', '.');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'Italy', 'default2', 'default2', '.', NULL, 999.0, 60, 'Italy'), (60, 'default2', 'default2', ':', 'Italy', 61.0, 59.0, 2, 'default1'), (61, ':', ':', 'default2', NULL, 1000.0, 60.0, NULL, '.'), (1, 'default1', ':', 'Italy', 'default1', 1001.0, 1001.0, 61, ':'), (0, ':', ':', NULL, 'default1', 999.0, 1000.0, 59, 'default2'), (1000, 'Italy', ':', 'Italy', ':', 60.0, 0.0, 0, 'unique_5'), (999, ':', 'Italy', '.', ':', 61.0, 60.0, 61, 'unique_6'), (1001, 'default2', 'Italy', 'default2', 'Italy', 0.0, 999.0, 2, 'unique_7'), (59, 'default2', 'default2', '.', 'default2', 1001.0, 999.0, 0, 'unique_8'), (3, 'default2', 'Italy', NULL, '.', 2.0, 59.0, 0, 'unique_9'), (4, 'Italy', 'Italy', '.', ':', 1001.0, 61.0, 59, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (999, 3, 0, 2, 'Italy', '2023-01-02', ':', NULL), (0, 999, 3, 2, ':', '2023-01-02', NULL, 'default2'), (1001, 999, 1000, 2, ':', '2023-01-01', 'Italy', ':'), (1, 60, 60, 2, 'Italy', '2023-01-02', NULL, '.'), (61, 61, 59, 60, 'Italy', '2023-01-02', 'default2', 'Italy'), (59, 6, 999, 0, '.', '2023-01-02', 'default2', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1001, 1, 0, 0, 999, 59, 1001, 'default1', 0, 1001.0, 1001, 'default1', 60, 1001, 2, 'default1', NULL), (60, 59, 0, 999, 0, 1000, 61, 61, 'default1', 60, 61.0, 1001, ':', NULL, 999, 1000, 'Italy', NULL), (1001, 1, 1001, 1001, 0, NULL, 999, 61, '.', 59, 59.0, 1001, 'Italy', 2, NULL, 2, NULL, ':');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (59, 61, 0, 1000, ':', 1000), (59, 2, 59, 1001, 'default2', NULL), (59, 999, 59, 60, ':', 61), (1001, 1001, 999, 61, 'default1', 61), (1, 1001, 1000, 0, NULL, 1), (0, 4, 60, 61, 'Italy', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT circuits.circuitId, MIN(lapTimes.time) AS fastest_lap_time FROM lapTimes INNER JOIN races ON lapTimes.raceId = races.raceId INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Italy' GROUP BY circuits.circuitId;

/*
Prediction Result:
(60, None)
*/