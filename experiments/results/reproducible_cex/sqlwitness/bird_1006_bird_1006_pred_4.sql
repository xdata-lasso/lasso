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
INSERT INTO seasons (year, url) VALUES (2, 'default1'), (1, ':'), (1001, 'default2'), (61, '.'), (1000, 'unique_4'), (3599, 'unique_5'), (-1, 'unique_6'), (59, 'unique_7'), (0, 'unique_8'), (3600, 'unique_9'), (60, 'unique_10'), (999, 'unique_11'), (3, 'unique_12'), (3601, 'unique_13'), (4, 'unique_14'), (5, 'unique_15'), (6, 'unique_16');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (59, ':', 61, ':', '.', '.', '2023-01-02', 'default1', ':'), (0, ':', 3601, '.', 'default2', 'default1', NULL, NULL, 'default2'), (2, '.', NULL, 'default2', '.', ':', NULL, 'default1', 'default1'), (61, ':', 1000, '.', 'default1', '.', '2023-01-02', '.', '.'), (999, '.', 3601, NULL, ':', ':', NULL, NULL, 'unique_4'), (-1, 'default1', 60, NULL, 'default2', '.', '2023-01-01', NULL, 'unique_5'), (60, 'default1', 3601, ':', 'default2', ':', '2023-01-01', ':', 'unique_6'), (1000, '.', 1001, 'default1', 'default1', ':', '2023-01-01', 'default1', 'unique_7'), (1, 'default2', -1, '.', 'default1', ':', '2023-01-01', NULL, 'unique_8');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (3, ':', 'default1', ':', 'default1', 60.0, 0.0, 0, 'default1'), (1001, '.', '.', 'default2', 'default2', 1.0, 999.0, 3601, '.'), (1, ':', 'default1', NULL, 'default2', 3599.0, 3600.0, 3, ':'), (3601, 'default2', '.', 'default2', 'default2', 3600.0, 3601.0, 61, 'default2'), (0, ':', 'default2', 'default1', NULL, NULL, 1001.0, 3601, 'unique_4'), (-1, ':', 'default2', 'default1', 'default2', 999.0, 0.0, 999, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 4, 3601, 1000, 'default1', '2023-01-01', ':', ':'), (3, 1, 3601, -1, 'default2', '2023-01-01', '.', 'default2'), (59, -1, 0, 999, ':', '2023-01-01', '.', 'default1'), (3601, 5, -1, 3, '.', '2023-01-02', 'default1', '.'), (999, 3, 3601, 1001, '.', '2023-01-02', 'default2', NULL), (3600, 3, 3, 3600, 'default2', '2023-01-01', NULL, 'unique_5'), (60, 1, 3601, 60, 'default2', '2023-01-01', ':', 'unique_6'), (1, 3600, 3, 3601, ':', '2023-01-01', NULL, 'unique_7'), (3599, 1001, 1001, 999, '.', '2023-01-02', '.', 'unique_8'), (1000, 61, 3, 61, 'default2', '2023-01-02', NULL, 'unique_9'), (1001, 61, -1, 61, '.', '2023-01-02', '.', 'unique_10'), (-1, 59, 1, 999, ':', '2023-01-02', '.', 'unique_11'), (61, 59, 1, 2, 'default1', '2023-01-01', 'default1', 'unique_12'), (0, 1000, 1, 999, 'default1', '2023-01-01', NULL, 'unique_13'), (4, 3, -1, 1000, 'default1', '2023-01-01', ':', 'unique_14'), (5, 2, 3, 59, 'default2', '2023-01-01', NULL, 'unique_15'), (6, 2, 3601, -1, '.', '2023-01-01', 'default1', 'unique_16'), (7, 60, 0, 3599, 'default1', '2023-01-01', NULL, 'unique_17'), (8, -1, 1001, 1, '.', '2023-01-01', 'default1', 'unique_18'), (9, 1, 1001, 59, 'default2', '2023-01-01', NULL, 'unique_19'), (10, 6, 3, 1001, 'default1', '2023-01-01', 'default1', 'unique_20'), (11, 1001, 0, 59, 'default2', '2023-01-02', 'default2', 'unique_21'), (12, 0, -1, 3599, 'default1', '2023-01-01', ':', 'unique_22'), (13, 61, 1001, 1000, 'default1', '2023-01-02', ':', 'unique_23'), (14, 60, 3, 3601, ':', '2023-01-02', NULL, 'unique_24'), (15, 3599, 1001, 3600, '.', '2023-01-02', ':', 'unique_25'), (16, 5, -1, 2, '.', '2023-01-01', NULL, 'unique_26');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (6, 1, 3600, 3599, 'default1', 1001), (4, 60, 0, 0, ':', 0), (9, 60, 1, 60, 'default1', 1001), (16, 999, 3599, 59, ':', 999), (61, 1000, 59, 59, 'default2', 1001), (59, 1, -1, 59, '.', NULL), (-1, 999, 3599, 61, 'default2', NULL), (59, -1, 1, 3600, '.', 3), (3599, 1000, 3599, 1000, 'default1', 3601);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT time FROM lapTimes ORDER BY (CASE WHEN INSTR(time, ':') <> INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':') THEN CAST(SUBSTRING(time, 1, INSTR(time, ':') - 1) AS REAL) * 3600 ELSE 0 END) + (CAST(SUBSTRING(time, INSTR(time, ':') - 2 * (INSTR(time, ':') = INSTR(SUBSTRING(time, INSTR(time, ':') + 1), ':') + INSTR(time, ':')), INSTR(time, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(time, INSTR(time, ':') + 1, INSTR(time, '.') - INSTR(time, ':') - 1) AS REAL)) + (CAST(SUBSTRING(time, INSTR(time, '.') + 1) AS REAL) / 1000) ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT time FROM lapTimes ORDER BY time ASC, lapTimes.raceid NULLS LAST, lapTimes.driverid NULLS LAST, lapTimes.lap NULLS LAST LIMIT 1;

/*
Prediction Result:
('.',)
*/