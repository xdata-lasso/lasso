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
INSERT INTO status (statusid, status) VALUES (4, '%%:%%:%%.%%'), (1974, ':'), (59, '.'), (2, '.'), (1, '%%:%%:%%.%%'), (0, 'default1'), (60, '.');
INSERT INTO seasons (year, url) VALUES (3601, 'default2'), (3599, '.'), (1976, ':'), (5, '%%:%%:%%.%%'), (6, 'default1'), (1, 'unique_5'), (0, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (5, ':', 0, 'default1', 'default2', 'default2', '2023-01-02', 'default1', 'default2'), (1974, 'default2', 7, 'default2', ':', 'default1', NULL, 'default1', 'default1'), (3601, 'default2', 1974, NULL, 'default2', 'default1', NULL, '%%:%%:%%.%%', ':'), (1976, '%%:%%:%%.%%', 60, '.', 'default2', '%%:%%:%%.%%', '2023-01-02', NULL, '.'), (0, 'default2', 1974, 'default1', ':', '%%:%%:%%.%%', '2023-01-02', ':', '%%:%%:%%.%%'), (7, '.', 1975, '%%:%%:%%.%%', 'default2', 'default1', '2023-01-01', 'default2', 'unique_5'), (1, 'default2', 61, '.', '.', ':', '2023-01-01', NULL, 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (59, '%%:%%:%%.%%', 'default2', NULL, 'default2'), (0, 'default2', '.', ':', ':'), (4, 'default1', ':', 'default1', 'default2'), (3599, 'default2', 'default1', 'default1', 'default2'), (61, 'default1', '%%:%%:%%.%%', NULL, 'default2'), (1974, '.', 'unique_5', 'default1', 'default2'), (1976, '%%:%%:%%.%%', 'unique_6', 'default2', 'default1'), (1, 'default2', 'unique_7', 'default1', '.'), (2, '.', 'unique_8', 'default2', 'default2'), (3, ':', 'unique_9', '.', '.'), (6, 'default1', 'unique_10', ':', 'default1'), (5, 'default2', 'unique_11', '.', 'default1'), (7, 'default2', 'unique_12', 'default1', '.');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3599, '.', ':', ':', ':', 1974.0, 1.0, 61, 'default2'), (3601, 'default2', '%%:%%:%%.%%', '%%:%%:%%.%%', '.', 4.0, 1976.0, 59, 'default1'), (1975, 'default2', 'default2', '%%:%%:%%.%%', '%%:%%:%%.%%', 61.0, 61.0, 1976, '.'), (1976, 'default2', '.', '.', '%%:%%:%%.%%', 7.0, 5.0, 5, ':'), (1, 'default1', 'default1', 'default1', ':', 1976.0, 6.0, 61, '%%:%%:%%.%%'), (6, '%%:%%:%%.%%', '.', 'default1', 'default2', 1975.0, 7.0, 60, 'unique_5'), (0, 'default2', '%%:%%:%%.%%', ':', '%%:%%:%%.%%', 1.0, 5.0, 4, 'unique_6'), (2, 'default2', 'default2', 'default1', ':', 3600.0, 3.0, 61, 'unique_7'), (3, 'default2', 'default1', NULL, NULL, 1975.0, 4.0, 3, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (3601, 5, 2, 1975, '.', '2023-01-02', ':', '.'), (60, 5, 2, 0, 'default2', '2023-01-02', 'default2', NULL), (3599, 1976, 6, 1974, ':', '2023-01-02', NULL, '%%:%%:%%.%%'), (61, 6, 3, 2, ':', '2023-01-01', ':', ':'), (1976, 6, 3601, 61, '%%:%%:%%.%%', '2023-01-02', 'default1', 'default1'), (1, 1976, 3599, 6, 'default2', '2023-01-02', '%%:%%:%%.%%', 'default2'), (2, 1976, 3, 3600, '.', '2023-01-02', 'default2', 'unique_6'), (3, 0, 1, 1976, '.', '2023-01-02', ':', 'unique_7'), (0, 3601, 3, 7, '.', '2023-01-02', 'default1', 'unique_8'), (7, 0, 1975, 6, '.', '2023-01-02', ':', 'unique_9'), (4, 3599, 2, 59, ':', '2023-01-02', '.', 'unique_10'), (6, 1976, 6, 4, 'default2', '2023-01-02', ':', 'unique_11'), (5, 6, 3601, 1, 'default1', '2023-01-02', 'default1', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (60, 5, 1974, 3, 1, 1, 0, 5, '%%:%%:%%.%%', 3599, 5.0, 2, 'default2', 1976, 6, 3599, 'default1', ':'), (0, 4, 5, 61, 60, 1, 61, 60, '%%:%%:%%.%%', 0, 1975.0, 60, '.', 1, 4, 60, 'default2', 'default1'), (6, 6, 0, 1976, 59, 1975, 60, 1, '.', 1976, 1975.0, 5, '%%:%%:%%.%%', 2, 3601, 1, '%%:%%:%%.%%', 'default1'), (3600, 1, 1976, 7, 60, 2, 6, 2, 'default1', 1975, 2.0, 3599, '%%:%%:%%.%%', 3599, 1976, 61, '.', 'default2'), (59, 60, 1974, 7, 1974, 3, 5, 2, '.', 3601, 0.0, 3599, '.', 1976, 1976, 5, '.', 'default1'), (4, 3599, 1, 4, 1974, 4, 1975, 1976, ':', 1, 1974.0, 2, 'default2', 3600, 1974, 60, '.', ':'), (3601, 1976, 0, 1, 4, 1976, 0, 6, '%%:%%:%%.%%', 4, 1.0, 6, 'default2', 3601, 1975, 5, NULL, 'default1'), (1975, 5, 1, 3599, 4, 61, 1974, 60, 'default2', 1974, 1975.0, 2, ':', 59, 1975, 2, '.', '.'), (1, 60, 5, 61, 4, 3600, 3599, 4, 'default1', 7, 4.0, 3, NULL, 6, 0, 0, '.', NULL), (2, 5, 0, 5, 1974, 3, 3599, 3601, '%%:%%:%%.%%', 61, 1976.0, 61, ':', 59, 1976, 5, '%%:%%:%%.%%', NULL), (3, 1976, 7, 5, 2, 1976, 5, 3600, 'default2', 60, 1975.0, 3599, '%%:%%:%%.%%', 60, 1976, 7, 'default1', NULL), (5, 4, 3601, 4, 1, 1975, 59, 3599, 'default1', 7, 3601.0, 3599, ':', 2, 61, NULL, 'default1', '.'), (7, 4, 5, 59, 4, 7, 3599, 60, '.', 3601, 1976.0, 0, 'default1', 7, 1, 6, '.', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T2.year, T2.raceId, T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.time IS NULL), champion_time AS (SELECT year, raceId, time_seconds FROM time_in_seconds WHERE positionOrder = 1) SELECT year, AVG(time_seconds) FROM champion_time GROUP BY year HAVING NOT AVG(time_seconds) IS NULL;

/*
Gold Result:
(1976, 0.0)
*/

-- Prediction Query
SELECT races.year, AVG(CAST(SUBSTRING(results.time, 1, INSTR(results.time, ':') - 1) AS INTEGER) * 3600 + CAST(SUBSTRING(results.time, INSTR(results.time, ':') + 1, INSTR(results.time, ':') - INSTR(results.time, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(results.time, INSTR(results.time, ':') + 1, INSTR(results.time, '.') - INSTR(results.time, ':') - 1) AS INTEGER)) AS avg_time_seconds FROM results INNER JOIN races ON results.raceid = races.raceid WHERE NOT results.time IS NULL AND results.time LIKE '%%:%%:%%.%%' AND races.year < 1975 GROUP BY races.year;

/*
Prediction Result:
(6, 0.0)
*/