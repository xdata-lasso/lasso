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
INSERT INTO seasons (year, url) VALUES (353, 'senna'), (355, 'Senna'), (0, 'default1'), (1, 'default2'), (354, 'Bruno'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (354, 'Bruno', 355, 'Senna', 'default2', 'default1', NULL, NULL, 'default1'), (0, 'Bruno', 354, NULL, 'Senna', 'Bruno', NULL, 'senna', 'default2'), (355, 'default1', 0, 'default1', 'Bruno', 'Bruno', NULL, 'Bruno', 'Senna'), (353, 'default2', 354, NULL, 'default2', 'Senna', '2023-01-01', 'Senna', 'Bruno'), (1, 'senna', NULL, 'Bruno', 'Bruno', 'Bruno', '2023-01-02', 'Bruno', 'senna'), (2, 'Senna', 1, NULL, 'Senna', 'default1', '2023-01-01', 'default2', 'unique_5'), (3, 'Bruno', 354, 'Senna', 'default2', 'senna', '2023-01-01', 'Bruno', 'unique_6'), (4, 'default1', 353, 'Senna', 'default1', 'Senna', '2023-01-01', 'default1', 'unique_7'), (5, 'default1', 354, 'Senna', 'default2', 'Senna', '2023-01-01', 'Senna', 'unique_8'), (6, 'default2', 355, NULL, 'default1', 'default2', '2023-01-02', 'default2', 'unique_9');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (355, 'senna', 'default2', 'senna', 'Bruno'), (354, 'default2', 'Bruno', NULL, 'default1'), (353, 'Bruno', 'senna', 'Bruno', 'Bruno'), (1, 'Bruno', 'default1', NULL, 'default2'), (0, 'Bruno', 'Senna', 'Bruno', 'default1'), (2, 'senna', 'unique_5', 'senna', 'Senna');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (353, 'Senna', 'senna', 'default2', 'default2', NULL, 1.0, 353, 'senna'), (354, 'default2', 'default2', 'Bruno', 'Bruno', 354.0, 0.0, 355, 'Bruno'), (355, 'default2', 'senna', 'default2', 'senna', NULL, 354.0, 353, 'Senna'), (0, 'Senna', 'default1', 'senna', 'default2', 1.0, 354.0, 1, 'default1'), (1, 'default2', 'senna', NULL, 'Senna', 353.0, 354.0, 355, 'default2');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2, 355, 355, 'default1', '2023-01-02', 'Bruno', 'Bruno'), (353, 354, 355, 1, 'Bruno', '2023-01-01', 'Bruno', 'senna'), (355, 353, 0, 353, 'default2', '2023-01-02', 'default2', NULL), (0, 354, 0, 354, 'Bruno', '2023-01-01', 'senna', 'Senna'), (354, 353, 0, 353, 'default1', '2023-01-01', NULL, 'default2'), (2, 2, 1, 355, 'senna', '2023-01-01', 'Senna', 'default1'), (3, 354, 354, 0, 'senna', '2023-01-01', 'Senna', 'unique_6'), (4, 1, 353, 355, 'senna', '2023-01-02', 'default1', 'unique_7'), (5, 2, 0, 355, 'default1', '2023-01-01', 'default1', 'unique_8'), (6, 3, 353, 355, 'senna', '2023-01-02', 'default2', 'unique_9'), (7, 3, 0, 1, 'default1', '2023-01-01', 'default1', 'unique_10'), (8, 355, 355, 1, 'senna', '2023-01-01', 'Senna', 'unique_11');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (354, 1, 2, 2, 1, 354, 'senna', 'default2', 'default1'), (353, 354, 3, 354, 0, 355, 'default2', 'senna', 'senna'), (1, 353, 0, 1, 353, 355, 'default1', NULL, 'default2'), (0, 7, 354, 353, 354, 354, 'default2', 'Bruno', 'senna'), (355, 1, 353, 2, 355, 1, 'default2', 'default1', 'Senna'), (2, 5, 2, 354, 355, 353, NULL, 'default2', 'default1'), (3, 8, 354, 354, 353, 355, 'Senna', 'default1', 'senna'), (4, 355, 5, 354, 353, 353, 'senna', 'Bruno', NULL), (5, 8, 1, 355, 355, 355, 'senna', 'senna', NULL), (6, 354, 1, 1, 1, 354, 'default1', 'Senna', 'Senna'), (7, 355, 355, 355, 0, 0, NULL, 'senna', 'senna'), (8, 2, 6, 355, 354, 1, 'Bruno', 'Senna', 'Bruno');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.q1 FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 354 AND T2.forename = 'Bruno' AND T2.surname = 'Senna';

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.q1 FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 354 AND T1.driverRef = 'senna';

/*
Prediction Result:
('default1',)
*/