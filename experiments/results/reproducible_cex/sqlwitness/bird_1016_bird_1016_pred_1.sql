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
INSERT INTO status (statusid, status) VALUES (59, 'Austrian Grand Prix Circuit'), (0, 'default1'), (61, 'default2'), (999, 'Austrian Grand Prix Circuit'), (1000, 'default2'), (1001, 'default2'), (2, '.'), (1, 'default1'), (60, 'Austrian Grand Prix'), (3, '.'), (4, ':'), (5, '.'), (6, 'default2'), (7, 'Austrian Grand Prix Circuit'), (8, 'default2'), (9, '.'), (10, 'Austrian Grand Prix Circuit');
INSERT INTO seasons (year, url) VALUES (1000, ':'), (61, 'Austrian Grand Prix Circuit'), (999, '.'), (0, 'default1'), (60, 'default2'), (59, 'Austrian Grand Prix'), (2, 'unique_6'), (1001, 'unique_7'), (1, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12'), (7, 'unique_13'), (8, 'unique_14'), (9, 'unique_15'), (10, 'unique_16'), (11, 'unique_17'), (12, 'unique_18'), (13, 'unique_19');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default1', 1001, ':', 'Austrian Grand Prix Circuit', 'default2', '2023-01-02', '.', 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (60, 'default2', ':', NULL, '.'), (1000, '.', '.', NULL, '.'), (2, 'Austrian Grand Prix', 'default1', 'default1', 'default1'), (0, '.', 'Austrian Grand Prix', 'default1', 'default2'), (61, 'default1', 'Austrian Grand Prix Circuit', '.', '.'), (1, 'default2', 'default2', 'default1', 'Austrian Grand Prix'), (999, 'default2', 'unique_6', 'default1', ':'), (59, 'default2', 'unique_7', 'default1', ':'), (1001, 'Austrian Grand Prix Circuit', 'unique_8', 'default2', '.'), (3, 'Austrian Grand Prix Circuit', 'unique_9', 'default1', '.'), (4, '.', 'unique_10', 'default1', 'default2'), (5, 'default2', 'unique_11', '.', 'Austrian Grand Prix'), (6, 'Austrian Grand Prix', 'unique_12', ':', 'Austrian Grand Prix Circuit'), (7, 'default1', 'unique_13', 'default1', '.'), (8, 'Austrian Grand Prix Circuit', 'unique_14', 'default1', 'default1'), (9, '.', 'unique_15', '.', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1000, 'default1', 'default1', 'default2', NULL, 2.0, NULL, 59, 'default2'), (60, 'Austrian Grand Prix Circuit', 'Austrian Grand Prix', '.', 'Austrian Grand Prix Circuit', 60.0, 1.0, 60, ':'), (2, 'default2', ':', 'default2', 'Austrian Grand Prix', NULL, 999.0, 999, 'Austrian Grand Prix'), (59, '.', ':', 'Austrian Grand Prix', 'Austrian Grand Prix', 999.0, 1000.0, 61, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (60, 1, 1000, 0, '.', '2023-01-02', 'Austrian Grand Prix Circuit', 'default2'), (1001, 12, 59, 999, 'Austrian Grand Prix', '2023-01-02', 'default2', NULL), (1000, 9, 60, 2, 'default2', '2023-01-02', 'Austrian Grand Prix', ':');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (59, 60, 0, 8, 2, 1, 999, 1000, 'default1', 999, 59.0, 59, NULL, NULL, 0, 61, NULL, 'Austrian Grand Prix Circuit'), (999, 1000, 0, 0, 60, 1, 2, 59, 'default1', 0, 1001.0, 61, NULL, 1000, 59, 59, 'Austrian Grand Prix Circuit', '.'), (1000, 1000, 0, 59, 2, 999, 0, NULL, '.', 59, 0.0, 1, 'Austrian Grand Prix', 1000, 61, 1, 'default2', ':'), (1, 1001, 0, 5, 8, 59, 1001, 1, 'default2', 60, 0.0, 61, 'default2', 2, 61, 61, 'Austrian Grand Prix', NULL), (1001, 1000, 0, 0, 5, NULL, 1, 2, 'default2', 59, 60.0, 1000, 'Austrian Grand Prix Circuit', 61, 1, 1001, ':', NULL), (0, 60, 0, 59, 10, 1, 0, 61, 'Austrian Grand Prix', 61, 1000.0, 1001, 'default2', 59, 60, 1, 'Austrian Grand Prix', 'default2');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (1001, 0, 1, 60, 'Austrian Grand Prix', 'Austrian Grand Prix', 2);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (60, 0, 61, 59, NULL, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.driverId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL), lap_record_race AS (SELECT T1.raceId, T1.driverId FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix') SELECT T4.duration FROM lap_record_race INNER JOIN pitStops AS T4 ON lap_record_race.raceId = T4.raceId AND lap_record_race.driverId = T4.driverId;

/*
Gold Result:
('Austrian Grand Prix',)
*/

-- Prediction Query
SELECT ps.duration FROM pitStops AS ps INNER JOIN races AS r ON ps.raceId = r.raceId INNER JOIN circuits AS c ON r.circuitId = c.circuitId INNER JOIN lapTimes AS lt ON ps.driverId = lt.driverId AND ps.raceId = lt.raceId WHERE r.name = 'Austrian Grand Prix' AND c.name = 'Austrian Grand Prix Circuit' AND lt.time = (SELECT MIN(lt2.time) FROM lapTimes AS lt2 INNER JOIN races AS r2 ON lt2.raceId = r2.raceId INNER JOIN circuits AS c2 ON r2.circuitId = c2.circuitId WHERE r2.name = 'Austrian Grand Prix' AND c2.name = 'Austrian Grand Prix Circuit');

/*
Prediction Result:
*/