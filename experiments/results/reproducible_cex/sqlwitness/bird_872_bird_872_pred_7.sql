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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (46, 'default1'), (44, '00:01:33'), (1, '1:33%'), (45, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (44, 'default1', 44, '00:01:33', 'default1', 'default2', '2023-01-02', 'default2', 'default2'), (1, '00:01:33', NULL, '00:01:33', 'default2', 'default1', '2023-01-01', 'default1', '00:01:33'), (46, 'default2', 46, 'default2', '00:01:33', '1:33%', NULL, '1:33%', 'default1'), (0, 'default1', 1, 'default1', 'default2', '00:01:33', '2026-10-27', NULL, '1:33%'), (45, '00:01:33', NULL, '00:01:33', '00:01:33', 'default1', '2023-01-02', '1:33%', 'unique_4'), (2, '1:33%', 1, 'default2', '00:01:33', '1:33%', '2026-10-27', '1:33%', 'unique_5'), (3, 'default1', 44, NULL, '00:01:33', 'default1', '2023-01-01', '00:01:33', 'unique_6'), (4, '1:33%', NULL, 'default2', '1:33%', '1:33%', '2023-01-01', 'default1', 'unique_7'), (5, 'default2', 44, '00:01:33', 'default2', 'default2', '2023-01-01', 'default1', 'unique_8'), (6, '1:33%', 0, '00:01:33', 'default1', '1:33%', NULL, '1:33%', 'unique_9'), (7, '00:01:33', 45, 'default2', 'default2', '1:33%', '2026-10-27', NULL, 'unique_10');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (44, 'default2', '1:33%', 'default1', 'default2'), (1, 'default1', '00:01:33', 'default1', 'default2'), (46, '00:01:33', 'default2', NULL, 'default2'), (0, 'default2', 'default1', '1:33%', 'default2'), (45, '1:33%', 'unique_4', 'default2', 'default1'), (2, '1:33%', 'unique_5', 'default1', '1:33%'), (3, 'default2', 'unique_6', '1:33%', '00:01:33'), (4, '1:33%', 'unique_7', '1:33%', '1:33%'), (5, 'default1', 'unique_8', '00:01:33', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (45, 'default2', '00:01:33', NULL, NULL, 1.0, 46.0, 45, 'default2'), (46, '00:01:33', 'default1', '1:33%', 'default2', NULL, 45.0, 0, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (44, 45, 45, 1, '00:01:33', '2023-01-01', '1:33%', NULL), (1, 3, 45, 44, 'default1', '2023-01-01', '1:33%', 'default2'), (45, 6, 46, 45, '00:01:33', '2026-10-27', '00:01:33', '1:33%'), (46, 8, 45, 1, 'default1', '2023-01-01', '00:01:33', '00:01:33'), (0, 2, 45, 0, '00:01:33', '2026-10-27', 'default2', 'default1'), (2, 45, 45, 45, 'default2', '2023-01-02', 'default2', 'unique_5'), (3, 0, 45, 0, 'default1', '2023-01-01', '1:33%', 'unique_6'), (4, 6, 46, 46, 'default1', '2026-10-27', 'default1', 'unique_7'), (5, 6, 46, 46, '1:33%', '2023-01-02', '1:33%', 'unique_8'), (6, 7, 45, 1, '1:33%', '2023-01-01', '00:01:33', 'unique_9');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (1, 1, 3, 44, 0, 45, NULL, 'default1', 'default2'), (46, 44, 46, 5, 1, 0, '1:33%', 'default2', 'default2'), (44, 4, 7, 3, 45, 1, '1:33%', 'default2', '1:33%'), (45, 45, 5, 44, 1, 44, NULL, NULL, '1:33%'), (0, 6, 4, 3, 0, NULL, NULL, 'default2', NULL), (2, 44, 4, 45, 45, 0, '1:33%', 'default2', 'default1'), (3, 4, 4, 1, 0, NULL, '1:33%', NULL, 'default2'), (4, 6, 6, 4, 1, 46, NULL, '1:33%', 'default2'), (5, 44, 0, 0, 46, 44, '00:01:33', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.code FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 45 AND T1.q3 LIKE '1:33%';

/*
Gold Result:
('00:01:33',)
*/

-- Prediction Query
SELECT T1.code FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 45 AND T2.q3 = '00:01:33';

/*
Prediction Result:
*/