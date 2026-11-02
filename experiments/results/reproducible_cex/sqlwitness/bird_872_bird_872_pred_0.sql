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
INSERT INTO seasons (year, url) VALUES (45, '0:01:33'), (46, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (44, 'default2', 46, NULL, '0:01:33', '0:01:33', NULL, NULL, 'default1'), (0, 'default1', 44, '0:01:33', '1:33%', '1:33%', '2023-01-01', 'default2', 'default2'), (46, '0:01:33', 1, '0:01:33', '0:01:33', '0:01:33', '2023-01-01', NULL, '0:01:33'), (1, '0:01:33', 0, '0:01:33', '1:33%', 'default1', '2023-01-02', NULL, '1:33%'), (45, '0:01:33', 46, '1:33%', 'default1', 'default1', '2023-01-01', '1:33%', 'unique_4'), (2, '1:33%', 46, 'default1', 'default2', 'default2', '2026-10-27', 'default2', 'unique_5'), (3, '0:01:33', 0, NULL, 'default1', '0:01:33', NULL, '1:33%', 'unique_6'), (4, 'default2', 0, '1:33%', 'default1', '1:33%', '2023-01-02', NULL, 'unique_7'), (5, '1:33%', 45, 'default1', 'default1', '1:33%', '2023-01-01', 'default1', 'unique_8'), (6, 'default2', 45, '1:33%', 'default2', 'default2', '2026-10-27', 'default1', 'unique_9'), (7, 'default2', 46, '0:01:33', 'default1', 'default1', '2026-10-27', '0:01:33', 'unique_10'), (8, '0:01:33', NULL, 'default2', '1:33%', '1:33%', '2026-10-27', 'default1', 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (46, 'default2', 'default2', NULL, 'default1'), (45, '0:01:33', '1:33%', '1:33%', '0:01:33'), (44, '0:01:33', '0:01:33', '1:33%', '1:33%'), (0, 'default1', 'default1', 'default1', '0:01:33'), (1, '1:33%', 'unique_4', '0:01:33', 'default1'), (2, 'default1', 'unique_5', 'default2', 'default2'), (3, '0:01:33', 'unique_6', NULL, '0:01:33'), (4, 'default1', 'unique_7', '0:01:33', '0:01:33');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (46, 'default1', 'default2', 'default2', 'default1', 44.0, 46.0, 46, 'default1'), (1, '1:33%', '0:01:33', '1:33%', 'default2', 1.0, 44.0, 46, '1:33%'), (45, 'default1', 'default2', '0:01:33', 'default1', 46.0, 0.0, 45, '0:01:33'), (0, 'default1', '0:01:33', 'default1', '1:33%', 0.0, 46.0, 0, 'default2'), (44, '1:33%', 'default1', '0:01:33', '0:01:33', 0.0, 44.0, 44, 'unique_4'), (2, 'default1', 'default2', '1:33%', 'default1', 44.0, 46.0, 1, 'unique_5'), (3, '1:33%', '1:33%', '0:01:33', '1:33%', 0.0, 46.0, 46, 'unique_6'), (4, 'default1', 'default2', '0:01:33', 'default1', 45.0, 44.0, NULL, 'unique_7'), (5, 'default2', 'default1', 'default2', 'default2', NULL, 44.0, NULL, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 46, 45, 46, 'default2', '2023-01-02', '0:01:33', '0:01:33'), (45, 45, 2, 1, '1:33%', '2026-10-27', '1:33%', 'default1'), (44, 45, 5, 44, '1:33%', '2026-10-27', '1:33%', '1:33%'), (46, 45, 44, 45, '1:33%', '2026-10-27', '0:01:33', 'default2'), (1, 45, 0, 45, '1:33%', '2023-01-02', '1:33%', NULL), (2, 45, 45, 0, '1:33%', '2026-10-27', '0:01:33', 'unique_5');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (46, 45, 46, 4, 0, 45, '1:33%', NULL, '0:01:33'), (0, 44, 2, 46, 0, 45, NULL, '1:33%', 'default1'), (1, 1, 6, 3, 46, 46, '0:01:33', 'default2', 'default1'), (45, 2, 5, 0, 1, 0, 'default1', 'default2', 'default1'), (44, 44, 6, 3, 1, 1, NULL, '0:01:33', 'default1'), (2, 0, 44, 2, 45, 0, '1:33%', NULL, '0:01:33'), (3, 45, 44, 4, 45, NULL, 'default1', 'default1', NULL), (4, 1, 0, 0, 45, 0, 'default2', 'default1', '0:01:33'), (5, 0, 45, 2, 1, 45, 'default1', 'default1', '1:33%'), (6, 1, 6, 4, 1, 45, 'default1', 'default1', 'default1'), (7, 45, 4, 3, 46, NULL, 'default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.code FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 45 AND T1.q3 LIKE '1:33%';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.code FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 45 AND T2.q3 = '0:01:33';

/*
Prediction Result:
('0:01:33',)
*/