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
INSERT INTO status (statusid, status) VALUES (1000, ':'), (61, 'Italy'), (1, '.'), (1001, '.'), (60, ':'), (59, 'Italy'), (2, 'default1'), (999, ':'), (0, ':'), (3, 'default1'), (4, ':');
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (2, ':'), (999, 'default1'), (59, '.'), (1000, 'Italy'), (1001, 'unique_5'), (0, 'unique_6'), (60, 'unique_7'), (61, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default1', 1001, 'default1', 'Italy', '.', '2023-01-02', NULL, 'Italy'), (59, 'Italy', 1, '.', ':', ':', '2023-01-02', 'Italy', 'default1'), (1, 'default1', 1001, 'Italy', ':', 'Italy', '2023-01-02', 'default2', 'default2'), (1001, 'default1', 999, '.', '.', 'default2', NULL, 'default2', '.'), (2, 'Italy', 1000, NULL, ':', '.', '2023-01-01', 'default1', ':'), (61, 'default1', 1001, 'Italy', ':', 'default2', '2023-01-02', 'default1', 'unique_5'), (1000, 'Italy', 60, '.', '.', 'Italy', '2023-01-02', 'Italy', 'unique_6'), (999, ':', 0, 'default2', 'Italy', ':', '2023-01-01', 'Italy', 'unique_7'), (60, ':', 2, '.', '.', '.', '2023-01-02', 'default1', 'unique_8'), (3, 'Italy', 1001, 'Italy', 'default1', ':', '2023-01-01', 'default1', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1001, '.', ':', '.', 'default1'), (0, 'default2', 'default1', NULL, ':'), (61, ':', '.', 'default1', ':'), (2, 'default1', 'default2', 'Italy', ':'), (59, 'Italy', 'Italy', ':', '.'), (999, 'default1', 'unique_5', ':', 'Italy'), (1000, 'default1', 'unique_6', ':', ':');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (61, 'default1', ':', NULL, 'Italy', 1000.0, 60.0, 61, 'default1'), (999, 'Italy', 'Italy', ':', '.', 1001.0, 1000.0, 1001, 'default2'), (1000, ':', 'default2', '.', 'default2', 61.0, 2.0, 2, '.'), (1, 'Italy', 'default1', 'default1', NULL, 1000.0, 2.0, 60, ':'), (0, 'default2', 'default2', '.', NULL, 60.0, 2.0, 999, 'Italy'), (1001, 'Italy', 'Italy', NULL, '.', 999.0, 61.0, 0, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (60, 0, 0, 1, '.', '2023-01-01', 'Italy', '.'), (1, 60, 1000, 999, '.', '2023-01-02', NULL, NULL), (61, 59, 1001, 0, 'default2', '2023-01-02', 'Italy', ':'), (1000, 61, 61, 1, '.', '2023-01-02', '.', 'Italy');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1000, 1000, 0, 60, 0, 0, 60, 'default2', 1001, 1.0, 1001, ':', 1, NULL, 1, 'default2', ':');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (60, 3, 0, 1001, 'Italy', 1001), (1, 60, 999, 1, 'default2', 1), (1, 2, 0, 2, NULL, NULL), (60, 1, 1001, 999, 'default2', 59);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT MIN("laptimes"."time") AS "lap_record", "circuits"."name" FROM "laptimes" INNER JOIN "races" ON "laptimes"."raceid" = "races"."raceid" INNER JOIN "circuits" ON "races"."circuitid" = "circuits"."circuitid" WHERE "circuits"."country" = 'Italy' GROUP BY "circuits"."name";

/*
Prediction Result:
*/