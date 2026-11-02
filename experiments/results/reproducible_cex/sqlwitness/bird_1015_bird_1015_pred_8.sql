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
INSERT INTO status (statusid, status) VALUES (1001, 'default1'), (60, 'default2'), (0, 'default2'), (1000, 'Austrian Grand Prix');
INSERT INTO seasons (year, url) VALUES (1, 'Austrian Grand Prix'), (0, ':'), (1000, 'default1'), (999, 'Austria'), (60, '.'), (61, 'default2'), (1001, 'unique_6'), (2, 'unique_7'), (59, 'unique_8'), (3, 'unique_9'), (4, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, '.', 2, 'Austria', '.', 'default1', NULL, 'Austrian Grand Prix', '.'), (59, '.', 999, 'Austrian Grand Prix', ':', 'default2', NULL, ':', 'Austria'), (0, 'Austria', 0, ':', '.', 'Austria', '2023-01-02', ':', 'Austrian Grand Prix'), (1000, 'default2', 1001, NULL, ':', 'Austria', '2023-01-01', NULL, 'default1'), (999, 'default2', 1001, 'default2', '.', ':', NULL, NULL, ':'), (1001, 'default2', 0, 'default1', 'default2', 'default2', '2023-01-02', ':', 'default2'), (2, 'default2', 1000, 'Austria', ':', 'default1', '2023-01-02', 'Austrian Grand Prix', 'unique_6'), (60, 'Austria', 999, 'Austrian Grand Prix', '.', '.', NULL, NULL, 'unique_7'), (61, 'default2', NULL, NULL, ':', 'Austria', '2023-01-01', ':', 'unique_8'), (3, 'default2', 1000, NULL, 'default2', 'Austria', NULL, ':', 'unique_9'), (4, 'Austrian Grand Prix', 1, ':', '.', 'default1', NULL, 'Austrian Grand Prix', 'unique_10');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (59, '.', 'default2', 'Austria', 'Austrian Grand Prix'), (1000, 'Austrian Grand Prix', 'Austrian Grand Prix', 'Austrian Grand Prix', 'Austria'), (61, 'default2', 'default1', ':', 'default1'), (1001, 'default1', '.', NULL, 'Austria'), (0, ':', ':', 'Austria', 'default1'), (999, 'Austria', 'Austria', 'default1', 'default1'), (1, ':', 'unique_6', 'default2', ':'), (2, 'default1', 'unique_7', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (61, 'Austria', 'default1', ':', ':', 60.0, NULL, 1000, ':'), (1001, 'default2', '.', 'Austria', NULL, 999.0, 1000.0, 0, 'default2'), (999, ':', 'default1', ':', 'default2', 60.0, NULL, 1, 'default1'), (1000, '.', 'Austria', NULL, '.', 1001.0, 999.0, 1001, 'Austrian Grand Prix'), (59, ':', ':', '.', 'default2', 60.0, 59.0, 1001, '.'), (0, ':', 'default2', 'default2', 'Austrian Grand Prix', 1.0, 1000.0, 1000, 'Austria'), (1, 'Austria', ':', 'default1', NULL, 0.0, 61.0, 1000, 'unique_6'), (2, 'Austrian Grand Prix', 'default1', 'default1', 'Austrian Grand Prix', 0.0, 1000.0, 61, 'unique_7'), (60, 'default1', 'Austria', 'default1', 'default2', 1001.0, 1000.0, 1, 'unique_8'), (3, 'default1', 'Austrian Grand Prix', ':', ':', 61.0, 1.0, 1000, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 4, 60, 61, 'Austrian Grand Prix', '2023-01-01', NULL, 'default1'), (0, 1000, 999, 999, 'default2', '2023-01-01', 'default2', 'default2'), (59, 59, 2, 59, 'default2', '2023-01-01', '.', '.');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1001, 1, 0, 1, 1001, 59, 0, 1, '.', 2, 61.0, 999, ':', 61, 1000, 2, 'Austrian Grand Prix', NULL), (0, 59, 59, 1, 1001, 0, 1000, 999, 'Austria', 1001, 999.0, 999, 'default1', 1000, 59, 59, 'default1', 'default2'), (60, 0, 999, 61, 1000, NULL, 60, 60, 'Austria', 999, 59.0, 1000, 'default2', 999, 2, NULL, 'default1', 'default2'), (59, 0, 1, 1000, 0, 1, 2, 60, 'default1', 999, 59.0, 61, ':', 2, 999, 59, 'default1', 'default2'), (1, 1, 3, 2, 1001, 0, 1001, 60, 'default2', 59, 999.0, 59, ':', 999, 2, NULL, 'Austrian Grand Prix', NULL), (1000, 1, 1001, 999, 1001, 1001, 1, 61, 'Austria', 1000, 1000.0, 1001, 'Austrian Grand Prix', NULL, NULL, 59, ':', 'Austrian Grand Prix'), (999, 0, 2, 0, 1001, 1, 1000, 999, ':', 2, 1.0, 59, 'default2', 60, 1001, 1000, '.', 'Austrian Grand Prix'), (2, 1, 1, 0, 60, 2, 61, 60, ':', 0, 59.0, 2, '.', NULL, 999, 61, NULL, 'default1');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (59, 59, 1, NULL, 'default2', 2), (0, 1001, 999, 61, 'Austria', 1001), (59, 3, 1001, 1001, 'Austrian Grand Prix', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T2.name FROM races AS T2 INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN results AS T1 ON T2.raceId = T1.raceId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('Austrian Grand Prix',)
('Austrian Grand Prix',)
('Austrian Grand Prix',)
*/

-- Prediction Query
SELECT T2.name FROM circuits AS T1 JOIN races AS T2 ON T1.circuitid = T2.circuitid JOIN results AS T3 ON T2.raceid = T3.raceid JOIN lapTimes AS T4 ON T3.raceid = T4.raceid WHERE T1.country = 'Austria' ORDER BY T4.milliseconds DESC, T1.circuitid NULLS LAST, T2.raceid NULLS LAST, T3.resultid NULLS LAST, T4.raceid NULLS LAST, T4.driverid NULLS LAST, T4.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
*/