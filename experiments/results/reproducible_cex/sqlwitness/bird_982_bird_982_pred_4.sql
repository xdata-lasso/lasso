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
INSERT INTO status (statusid, status) VALUES (2, 'default1'), (1, 'Puncture'), (3, 'default1'), (0, 'default2');
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'American'), (2, 'Puncture'), (3, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (3, 'American', 0, NULL, 'default2', 'Puncture', NULL, 'Puncture', 'American'), (2, 'American', NULL, 'Puncture', 'default2', 'American', '2023-01-02', 'default1', 'default1'), (1, 'American', NULL, NULL, 'American', 'default1', '2023-01-02', 'default2', 'Puncture'), (0, 'default1', 1, 'Puncture', 'Puncture', 'default1', '2023-01-01', 'American', 'default2'), (4, 'default2', 1, 'Puncture', 'default2', 'default2', NULL, 'default1', 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'American', 'Puncture', 'Puncture', 'default2'), (0, 'American', 'American', 'American', 'Puncture'), (3, 'default2', 'default2', 'default2', 'American'), (1, 'Puncture', 'default1', 'default1', 'default2'), (4, 'default1', 'unique_4', NULL, 'default1'), (5, 'American', 'unique_5', 'American', 'Puncture'), (6, 'default2', 'unique_6', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'Puncture', 'Puncture', 'default2', NULL, 1.0, 0, 'default1'), (2, 'default1', 'Puncture', NULL, 'American', 2.0, NULL, 3, 'default2'), (3, 'default1', 'Puncture', 'Puncture', 'default1', 0.0, 0.0, 0, 'American'), (1, 'American', 'default2', 'American', 'default1', 2.0, 1.0, 1, 'Puncture');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 1, 0, 'default1', '2023-01-02', 'default2', 'default2'), (2, 0, 3, 1, 'American', '2023-01-02', NULL, 'Puncture');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2, 1, 0, 3, 1, 2, 0, 2, 'Puncture', 0, 1.0, 0, 'American', 0, 1, 3, 'Puncture', 'default1'), (0, 2, 3, 6, 0, NULL, 1, NULL, 'Puncture', 1, 2.0, 0, 'default2', 2, 2, 2, 'default2', 'default2'), (1, 1, 3, 6, 2, NULL, 2, 0, 'Puncture', 3, 1.0, 2, 'default1', NULL, NULL, 2, 'American', 'default1'), (3, 1, 4, 3, 3, 0, 3, 1, 'American', 1, 3.0, 3, 'Puncture', 3, 3, 2, NULL, NULL), (4, 1, 2, 3, 0, NULL, 3, NULL, 'default2', 1, 0.0, 2, 'default2', 0, 2, 2, NULL, 'American');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN status AS T3 ON T2.statusId = T3.statusId WHERE T3.status = 2 AND T1.nationality = 'American';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.driverId) AS num_drivers_with_puncture FROM status AS T1 INNER JOIN results AS T2 ON T1.statusId = T2.statusId INNER JOIN drivers AS T3 ON T2.driverId = T3.driverId WHERE T3.nationality = 'American' AND T1.status = 'Puncture';

/*
Prediction Result:
(1,)
*/