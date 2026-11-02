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
INSERT INTO status (statusid, status) VALUES (60, 'Austrian Grand Prix'), (61, '.'), (2, ':'), (999, ':'), (59, 'default1'), (1001, ':'), (1000, 'default1'), (1, 'default2'), (0, 'default1'), (3, 'Austrian Grand Prix'), (4, 'default1'), (5, 'Austrian Grand Prix Circuit'), (6, 'Austrian Grand Prix Circuit'), (7, '.'), (8, 'Austrian Grand Prix');
INSERT INTO seasons (year, url) VALUES (2, 'Austrian Grand Prix Circuit'), (1, 'default1'), (59, 'default2'), (1001, ':'), (1000, '.'), (0, 'Austrian Grand Prix'), (999, 'unique_6'), (60, 'unique_7'), (61, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1001, 'default2', 61, 'Austrian Grand Prix Circuit', 'default2', '.', '2023-01-02', NULL, ':'), (0, 'default1', 1, 'default2', '.', '.', NULL, ':', 'Austrian Grand Prix'), (1000, 'Austrian Grand Prix', NULL, 'default1', 'Austrian Grand Prix Circuit', ':', '2023-01-02', '.', '.');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'Austrian Grand Prix', 'default2', 'Austrian Grand Prix', 'Austrian Grand Prix');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Austrian Grand Prix', 'default2', ':', 'default1', 0.0, 1.0, 999, 'Austrian Grand Prix Circuit');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 2, 1, 1, 'default1', '2023-01-02', 'default2', 'Austrian Grand Prix'), (60, 1, 1, 1001, 'Austrian Grand Prix Circuit', '2023-01-01', NULL, NULL), (999, 1000, 1, 60, '.', '2023-01-02', 'default1', 'default1'), (0, 1, 1, 0, 'Austrian Grand Prix', '2023-01-02', ':', '.'), (59, 6, 1, 60, 'default2', '2023-01-01', 'default1', 'Austrian Grand Prix Circuit'), (61, 1001, 1, 999, 'Austrian Grand Prix', '2023-01-02', '.', ':'), (1000, 60, 1, 0, 'Austrian Grand Prix', '2023-01-02', ':', 'default2'), (1001, 0, 1, 1, 'Austrian Grand Prix', '2023-01-01', 'default1', 'unique_7'), (1, 1000, 1, 60, 'Austrian Grand Prix', '2023-01-02', 'Austrian Grand Prix', 'unique_8'), (3, 3, 1, 1001, 'default2', '2023-01-01', 'Austrian Grand Prix Circuit', 'unique_9');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1000, 60, 1000, 1, 5, 2, 61, 1000, 'Austrian Grand Prix Circuit', 60, 1.0, 1, 'Austrian Grand Prix Circuit', 61, 61, 59, NULL, 'default1'), (59, 999, 1000, 1, 4, 1001, 1000, 2, ':', 1001, 1.0, 59, 'default2', 2, 2, 1001, '.', '.'), (0, 1001, 1001, 1, 59, 0, 59, 999, ':', 999, 1001.0, 61, ':', NULL, 999, 2, 'Austrian Grand Prix', ':'), (999, 1000, 1000, 1, 999, 1001, 59, 1000, 'default2', 999, 1001.0, 1001, NULL, NULL, 60, NULL, 'Austrian Grand Prix Circuit', '.');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (3, 0, 61, 61, ':', 1), (59, 0, 61, 999, 'default2', 0), (2, 0, 1, 0, 'default1', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T2.name FROM races AS T2 INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN results AS T1 ON T2.raceId = T1.raceId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('Austrian Grand Prix',)
('Austrian Grand Prix',)
*/

-- Prediction Query
SELECT T1.name, T1.date FROM races AS T1 INNER JOIN lapTimes AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T1.circuitId = T3.circuitId WHERE T3.name = 'Austrian Grand Prix Circuit' ORDER BY T2.time ASC, T1.raceid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/