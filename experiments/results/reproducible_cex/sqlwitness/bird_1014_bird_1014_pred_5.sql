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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (999, ':'), (1001, '.'), (1000, 'Italy'), (59, '.'), (0, 'default1'), (2, ':');
INSERT INTO seasons (year, url) VALUES (0, ':'), (1001, 'default2'), (60, '.'), (1000, 'Italy');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (59, 'Italy', 59, 'Italy', ':', 'default2', '2023-01-02', NULL, 'default1'), (2, ':', 59, 'Italy', 'default1', ':', '2023-01-02', NULL, 'default2'), (60, ':', 1000, 'default2', 'default1', 'default2', '2023-01-02', 'Italy', ':'), (61, 'default1', 60, 'Italy', 'default1', 'default1', '2023-01-01', 'Italy', 'Italy'), (0, 'default1', 1, 'default1', 'default2', '.', NULL, 'default2', '.'), (1, 'default1', 1, 'default2', '.', 'Italy', '2023-01-01', NULL, 'unique_5'), (1000, ':', 59, '.', ':', 'default1', NULL, NULL, 'unique_6'), (999, 'Italy', 1001, 'Italy', ':', 'Italy', '2023-01-01', ':', 'unique_7'), (1001, '.', 60, 'default1', 'default2', 'Italy', NULL, 'Italy', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1000, 'default1', 'default1', NULL, 'default2'), (999, '.', 'Italy', 'default1', 'default1'), (1001, 'Italy', '.', 'Italy', 'default1'), (1, ':', ':', 'default1', '.'), (0, '.', 'default2', 'Italy', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (61, 'default1', 'Italy', 'default2', ':', 1.0, 1.0, 1000, 'Italy'), (999, 'default2', ':', 'Italy', 'Italy', 61.0, 1001.0, 61, 'default1'), (2, 'default2', ':', 'default2', NULL, 61.0, 1000.0, NULL, '.'), (1, ':', ':', NULL, ':', 1001.0, 1.0, 1000, 'default2'), (60, '.', 'default1', NULL, 'default2', 999.0, 999.0, 60, ':'), (0, ':', 'Italy', 'default1', ':', 1000.0, 61.0, 60, 'unique_5'), (1000, 'default2', 'Italy', 'Italy', 'default2', 2.0, NULL, 2, 'unique_6'), (1001, 'default1', 'default2', 'default2', 'Italy', 59.0, 999.0, 1000, 'unique_7'), (59, ':', 'default1', 'default1', 'default2', 0.0, 0.0, 61, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1000, 1001, 2, 1001, '.', '2023-01-01', '.', 'Italy'), (0, 0, 999, 1, ':', '2023-01-01', ':', 'default2'), (59, 1000, 59, 1, '.', '2023-01-02', '.', '.'), (999, 1000, 59, 61, ':', '2023-01-02', '.', 'default1'), (1001, 1000, 1000, 1, 'default1', '2023-01-02', 'default1', ':'), (1, 60, 60, 59, 'default1', '2023-01-01', ':', NULL), (2, 0, 1001, 0, 'Italy', '2023-01-01', NULL, 'unique_6');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1000, 2, 60, 1000, 1000, 59, 59, 2, '.', 1001, 999.0, 0, NULL, 60, 60, 59, ':', 'default2'), (61, 59, 1, 0, 1000, 1001, 1, 1001, 'Italy', 999, 1000.0, 60, 'default2', 59, 0, 59, ':', '.'), (2, 0, 0, 1001, 59, 60, 1001, 1000, 'Italy', 1001, 61.0, 59, 'default1', 61, 999, 0, 'Italy', ':'), (59, 1001, 999, 1001, 0, 61, 60, 999, 'Italy', 60, 0.0, 59, '.', 61, 999, 60, 'default1', '.'), (999, 0, 1000, 1001, 999, 1, 999, NULL, 'Italy', 1001, 999.0, 1001, ':', NULL, 2, 1001, NULL, ':'), (1001, 1001, 1001, 1001, 1, 0, 999, 60, 'default1', 2, 0.0, 1001, 'default1', 2, 2, 60, 'Italy', ':'), (1, 0, 60, 999, 2, 0, 2, 2, ':', 1, 999.0, 60, '.', NULL, 59, 1000, 'Italy', 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (1000, 59, 1000, 1, 'default2', 60), (1000, 60, 60, 1000, '.', NULL), (0, 59, 999, 0, NULL, 1), (2, 1000, 61, 1000, 'Italy', 1001), (2, 2, 1, 60, '.', 59), (2, 999, 60, 999, 'default2', 0), (1001, 61, 1, 61, ':', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
('Italy',)
*/

-- Prediction Query
SELECT T1.time FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy' ORDER BY T1.milliseconds ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.raceid NULLS LAST, T3.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/