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
INSERT INTO seasons (year, url) VALUES (355, '1:40.000'), (0, 'default2'), (1, 'default1'), (354, '1:40%'), (356, 'unique_4'), (2, 'unique_5');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, '1:40%', 0, '1:40.000', 'default1', 'default1', '2026-10-27', '1:40%', 'default1'), (356, '1:40.000', 1, '1:40%', '1:40.000', 'default2', '2026-10-27', 'default1', '1:40%'), (354, '1:40%', 0, 'default1', 'default1', 'default2', '2023-01-01', '1:40%', 'default2'), (355, '1:40.000', 354, NULL, 'default1', '1:40.000', '2023-01-02', 'default2', '1:40.000'), (0, 'default2', 1, 'default1', '1:40%', 'default2', '2026-10-27', '1:40.000', 'unique_4'), (2, 'default2', NULL, '1:40%', '1:40.000', '1:40%', NULL, '1:40%', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default1', 'default2', '1:40%', '1:40%'), (354, '1:40.000', '1:40%', '1:40.000', '1:40%'), (0, 'default2', '1:40.000', '1:40%', 'default1'), (356, '1:40.000', 'default1', 'default2', 'default2'), (355, 'default1', 'unique_4', NULL, 'default1'), (2, '1:40%', 'unique_5', 'default2', 'default1'), (3, '1:40%', 'unique_6', '1:40.000', '1:40%');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (354, 'default1', 'default1', 'default1', NULL, 0.0, 354.0, 0, '1:40.000'), (356, '1:40.000', 'default2', '1:40.000', '1:40.000', 1.0, 355.0, 354, 'default2'), (1, 'default1', 'default1', '1:40%', NULL, 0.0, 0.0, NULL, 'default1'), (0, 'default2', 'default2', 'default2', 'default1', NULL, NULL, 355, '1:40%'), (355, 'default2', 'default2', NULL, 'default2', NULL, 356.0, NULL, 'unique_4'), (2, 'default1', '1:40%', '1:40%', NULL, 1.0, 355.0, 0, 'unique_5'), (3, 'default1', '1:40%', 'default2', NULL, 0.0, NULL, 354, 'unique_6'), (4, '1:40%', 'default2', 'default1', '1:40%', 356.0, NULL, 355, 'unique_7'), (5, '1:40.000', 'default2', '1:40%', '1:40%', 355.0, 354.0, 0, 'unique_8'), (6, '1:40.000', '1:40.000', '1:40%', 'default1', 354.0, 1.0, 354, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (355, 0, 6, 1, 'default2', '2026-10-27', 'default1', '1:40%'), (0, 354, 354, 355, 'default2', '2026-10-27', '1:40.000', NULL), (354, 354, 1, 356, '1:40.000', '2023-01-01', NULL, '1:40.000');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (354, 355, 0, 355, 0, 1, 'default1', '1:40%', 'default2'), (355, 0, 0, 3, 355, 354, 'default1', 'default1', 'default1'), (356, 0, 354, 356, 0, 355, '1:40.000', 'default1', '1:40.000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.nationality FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 355 AND T1.q2 LIKE '1:40%';

/*
Gold Result:
('1:40.000',)
*/

-- Prediction Query
SELECT d.nationality FROM drivers AS d JOIN qualifying AS q ON d.driverId = q.driverId WHERE q.q2 = '1:40.000' AND q.raceId = 355;

/*
Prediction Result:
*/