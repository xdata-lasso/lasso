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
INSERT INTO seasons (year, url) VALUES (1001, 'default1'), (0, 'default2'), (3599, ':'), (59, '.'), (-1, 'unique_4');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (60, ':', 1000, NULL, 'default1', ':', NULL, '.', 'default2'), (999, 'default1', -1, ':', ':', '.', '2023-01-02', ':', '.'), (0, 'default2', 3599, NULL, 'default1', '.', '2023-01-01', 'default2', ':'), (20, 'default2', 1, NULL, ':', 'default1', NULL, '.', 'default1'), (1, '.', 999, NULL, 'default1', '.', NULL, 'default2', 'unique_4'), (19, 'default1', 1000, 'default1', ':', 'default2', NULL, ':', 'unique_5'), (-1, 'default1', 59, ':', ':', ':', '2023-01-02', ':', 'unique_6'), (2, ':', 59, 'default2', 'default2', 'default1', '2023-01-02', NULL, 'unique_7');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (21, ':', ':', 'default2', 'default2', 2.0, 999.0, 999, 'default1'), (60, ':', 'default2', NULL, 'default2', 3599.0, 1.0, 1001, 'default2'), (999, '.', '.', 'default2', 'default2', 60.0, 0.0, 20, '.'), (1000, ':', 'default2', 'default1', 'default1', NULL, 3600.0, 1000, ':'), (3601, '.', 'default2', 'default2', 'default1', 999.0, 2.0, 1001, 'unique_4'), (-1, 'default2', 'default2', ':', NULL, 3599.0, 1000.0, 3600, 'unique_5'), (2, ':', ':', '.', 'default2', 59.0, 3599.0, 1, 'unique_6'), (19, 'default1', ':', NULL, NULL, 3.0, 3.0, 999, 'unique_7'), (0, 'default1', '.', 'default1', 'default2', 3601.0, 21.0, 1001, 'unique_8'), (1, '.', 'default2', 'default1', ':', 999.0, 59.0, 60, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 59, 1, 59, 'default2', '2023-01-01', 'default1', 'default2'), (21, 1001, 3601, 60, 'default2', '2023-01-02', 'default1', ':'), (20, 3599, 19, 999, 'default2', '2023-01-01', 'default2', '.'), (3, -1, 21, 3601, 'default2', '2023-01-01', NULL, 'default1'), (19, 3599, 21, 60, 'default2', '2023-01-01', ':', NULL), (61, 3599, 2, 3600, '.', '2023-01-02', ':', 'unique_5'), (1000, 0, 1000, 59, '.', '2023-01-01', '.', 'unique_6'), (59, 1001, 0, 3601, '.', '2023-01-01', '.', 'unique_7'), (0, 1001, 0, 3601, 'default1', '2023-01-02', 'default1', 'unique_8');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (59, 1, 1, 1, 'default2', 1), (20, 19, 3600, 3599, NULL, 3599), (3, 60, 60, 60, NULL, 21), (1, 999, 20, 60, '.', 20), (1000, 999, 3601, 1001, '.', 3601), (21, 0, 1, 1001, ':', 3599), (61, 2, 3, 20, 'default2', 3), (0, 1, 1, 1, ':', 59);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH lap_times_in_seconds AS (SELECT driverId, (CASE WHEN INSTR(time, ':') <> INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':') THEN CAST(SUBSTRING(time, 1, INSTR(time, ':') - 1) AS REAL) * 3600 ELSE 0 END) + (CAST(SUBSTRING(time, INSTR(time, ':') - 2 * (INSTR(time, ':') = INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':')), INSTR(time, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(time, INSTR(time, ':') + 1, INSTR(time, '.') - INSTR(time, ':') - 1) AS REAL)) + (CAST(SUBSTRING(time, INSTR(time, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM lapTimes) SELECT T2.forename, T2.surname FROM (SELECT driverId, MIN(time_in_seconds) AS min_time_in_seconds FROM lap_times_in_seconds GROUP BY driverId) AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId ORDER BY T1.min_time_in_seconds ASC, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(':', 'default2')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d INNER JOIN (SELECT driverid, MIN(CAST(SUBSTRING(time, 1, INSTR(time, ':') - 1) AS REAL) * 60 + CAST(SUBSTRING(time, INSTR(time, ':') + 1, INSTR(time, '.') - INSTR(time, ':') - 1) AS REAL) + CAST(SUBSTRING(time, INSTR(time, '.') + 1) AS REAL) / 1000) AS numeric_time FROM laptimes GROUP BY driverid) AS lt ON d.driverid = lt.driverid ORDER BY lt.numeric_time ASC, d.driverid NULLS LAST LIMIT 20;

/*
Prediction Result:
(':', 'default2')
('default1', ':')
('default1', '.')
('default1', '.')
('default2', 'default1')
(':', '.')
*/