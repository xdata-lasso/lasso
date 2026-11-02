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
INSERT INTO status (statusid, status) VALUES (60, '.'), (1, 'red_bull_ring');
INSERT INTO seasons (year, url) VALUES (1000, 'red_bull_ring'), (59, '.'), (999, 'Austrian Grand Prix'), (1, 'default1'), (61, ':'), (60, 'default2'), (0, 'unique_6'), (2, 'unique_7'), (1001, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12'), (7, 'unique_13'), (8, 'unique_14'), (9, 'unique_15');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (59, 'default2', 60, 'Austrian Grand Prix', ':', 'default1', '2023-01-01', 'default2', ':'), (0, 'default1', 999, ':', ':', '.', '2023-01-01', 'default1', '.'), (61, 'red_bull_ring', 60, NULL, 'default2', ':', '2023-01-02', 'red_bull_ring', 'default1'), (1000, 'default2', 1, 'Austrian Grand Prix', 'red_bull_ring', '.', '2023-01-02', 'default2', 'red_bull_ring');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (999, 'default2', ':', 'default1', '.'), (61, 'Austrian Grand Prix', 'default1', 'red_bull_ring', ':'), (1, '.', 'red_bull_ring', 'red_bull_ring', '.'), (1000, 'red_bull_ring', 'Austrian Grand Prix', '.', '.'), (59, 'red_bull_ring', '.', 'default1', 'default2'), (2, 'default1', 'default2', NULL, 'red_bull_ring'), (60, ':', 'unique_6', 'red_bull_ring', 'default2'), (1001, ':', 'unique_7', NULL, '.'), (0, 'red_bull_ring', 'unique_8', NULL, 'red_bull_ring'), (3, '.', 'unique_9', ':', 'default2'), (4, '.', 'unique_10', 'red_bull_ring', '.'), (5, 'red_bull_ring', 'unique_11', ':', '.'), (6, ':', 'unique_12', NULL, 'default2'), (7, 'red_bull_ring', 'unique_13', NULL, 'Austrian Grand Prix');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (60, 'default2', 'default2', 'default2', 'default1', 61.0, 1001.0, 999, 'default2'), (999, 'red_bull_ring', 'Austrian Grand Prix', NULL, NULL, 999.0, 2.0, 2, 'default1'), (1, 'red_bull_ring', 'Austrian Grand Prix', '.', '.', 0.0, 61.0, 61, '.'), (1001, 'Austrian Grand Prix', 'Austrian Grand Prix', 'red_bull_ring', '.', 59.0, 2.0, NULL, 'Austrian Grand Prix'), (1000, 'default1', 'default1', 'default2', 'default2', NULL, 59.0, 1, ':'), (0, ':', 'default2', NULL, 'default1', 59.0, 999.0, 2, 'red_bull_ring'), (2, '.', 'red_bull_ring', 'default1', 'default2', 999.0, 1001.0, 1001, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (59, 61, 2, 1001, 'Austrian Grand Prix', '2023-01-01', 'Austrian Grand Prix', ':'), (1, 4, 60, 60, ':', '2023-01-01', '.', 'default1'), (60, 0, 1000, 1000, 'default1', '2023-01-02', NULL, 'default2'), (999, 5, 999, 61, ':', '2023-01-02', NULL, NULL), (0, 61, 1001, 59, 'Austrian Grand Prix', '2023-01-02', 'default2', '.'), (1000, 7, 0, 1, 'default2', '2023-01-01', ':', 'red_bull_ring'), (1001, 4, 0, 0, 'default2', '2023-01-02', 'red_bull_ring', 'Austrian Grand Prix');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1000, 1, 59, 2, 1, 1000, 2, 1000, 'red_bull_ring', 2, 60.0, 1001, 'Austrian Grand Prix', 0, 59, 1000, 'default2', 'default2'), (1, 0, 1000, 7, 60, 60, 999, 60, 'Austrian Grand Prix', 60, 1.0, 61, ':', 1, 61, 1000, 'red_bull_ring', 'Austrian Grand Prix'), (999, 1, 59, 61, 1, 61, 1001, 1, 'red_bull_ring', 999, 1000.0, 999, 'red_bull_ring', 1001, 61, 1, 'red_bull_ring', 'Austrian Grand Prix'), (0, 59, 1000, 4, 60, 60, 60, 1000, 'red_bull_ring', 61, 1001.0, 60, ':', 61, 1001, 1, ':', 'default2'), (59, 60, 59, 61, 60, 61, 59, 0, ':', 61, 999.0, 999, 'default1', 999, 61, 61, 'default2', '.'), (1001, 59, 61, 0, 1, 2, 59, 59, 'red_bull_ring', 0, 1000.0, 59, 'red_bull_ring', 1, 60, 1, 'default1', 'default1');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (0, 61, 0, 61, 'default2', 61), (999, 59, 59, 0, 'Austrian Grand Prix', NULL), (1000, 61, 61, 59, 'Austrian Grand Prix', 61);
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
SELECT "races"."name" FROM "laptimes" INNER JOIN "races" ON "laptimes"."raceid" = "races"."raceid" INNER JOIN "circuits" ON "races"."circuitid" = "circuits"."circuitid" WHERE "circuits"."circuitref" = 'red_bull_ring' ORDER BY "laptimes"."milliseconds" ASC, laptimes.raceid NULLS LAST, laptimes.driverid NULLS LAST, laptimes.lap NULLS LAST, races.raceid NULLS LAST, circuits.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
(':',)
*/