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
INSERT INTO seasons (year, url) VALUES (0, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (904, 'default2', 902, '0:01:54', '0:01:54', 'default1', '2023-01-02', 'default2', 'default1'), (902, 'default2', 903, 'default2', 'default1', 'default2', '2026-10-27', 'default2', '1:54%'), (903, '0:01:54', 902, '0:01:54', 'default1', 'default2', '2026-10-27', 'default1', '0:01:54'), (0, 'default2', 904, '1:54%', '1:54%', 'default1', '2023-01-02', '1:54%', 'default2'), (1, '0:01:54', 903, '1:54%', '1:54%', 'default2', '2023-01-01', 'default2', 'unique_4'), (2, '1:54%', NULL, 'default2', '1:54%', '0:01:54', '2023-01-02', NULL, 'unique_5'), (3, '1:54%', 0, 'default2', 'default1', 'default2', NULL, '1:54%', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (902, 'default1', '0:01:54', 'default2', 'default2'), (1, 'default1', 'default1', NULL, '1:54%'), (904, '0:01:54', '1:54%', '0:01:54', 'default2'), (903, 'default1', 'default2', NULL, 'default1'), (0, '0:01:54', 'unique_4', '0:01:54', 'default1'), (2, 'default1', 'unique_5', 'default2', '1:54%'), (3, 'default1', 'unique_6', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (902, '0:01:54', '1:54%', NULL, '0:01:54', 1.0, 902.0, 1, 'default2'), (903, '0:01:54', 'default1', 'default1', 'default2', 903.0, 904.0, 0, '0:01:54');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (902, 0, 902, 0, '1:54%', '2026-10-27', 'default1', NULL), (0, 0, 902, 1, 'default2', '2023-01-02', 'default1', '1:54%'), (1, 0, 903, 902, 'default1', '2026-10-27', NULL, '0:01:54'), (903, 0, 903, 0, 'default2', '2026-10-27', 'default2', 'default1');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (0, 902, 904, 2, 904, 902, NULL, '0:01:54', '0:01:54'), (904, 902, 1, 903, 1, NULL, NULL, 'default2', '1:54%'), (903, 1, 2, 903, 1, 902, 'default2', 'default2', NULL), (902, 902, 2, 2, 903, 904, '1:54%', 'default2', '0:01:54'), (1, 903, 903, 0, 1, 903, '0:01:54', 'default1', NULL), (2, 903, 902, 904, 1, NULL, '0:01:54', 'default2', '1:54%'), (3, 1, 902, 2, 904, NULL, 'default2', NULL, '0:01:54'), (4, 903, 2, 3, 903, 903, NULL, '0:01:54', '1:54%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.number FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 903 AND T1.q3 LIKE '1:54%';

/*
Gold Result:
(903,)
(None,)
*/

-- Prediction Query
SELECT T2.number FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T1.raceId = 903 AND T1.q3 = '0:01:54';

/*
Prediction Result:
*/