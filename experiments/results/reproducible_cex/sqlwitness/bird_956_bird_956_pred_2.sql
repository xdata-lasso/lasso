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
INSERT INTO status (statusid, status) VALUES (0, '%Y'), (1, 'default1'), (3, 'default2'), (2, '%Y'), (4, '%Y'), (5, '1975'), (6, 'default1');
INSERT INTO seasons (year, url) VALUES (2, '1975');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (3, 'default1', 0, 'default1', 'default2', 'default1', '1975-10-27', NULL, '%Y'), (1, 'default2', 3, 'default1', '%Y', '1975', '2023-01-01', NULL, 'default2'), (0, 'default1', 3, '%Y', 'default2', '1975', '2023-01-02', '%Y', 'default1'), (2, 'default1', 1, 'default2', '%Y', '%Y', '1975-10-27', '1975', '1975'), (4, 'default1', 1, 'default2', 'default1', 'default1', '2023-01-01', 'default1', 'unique_4'), (5, 'default2', 1, NULL, 'default2', '1975', '2023-01-02', '%Y', 'unique_5'), (6, 'default1', NULL, '1975', 'default2', 'default2', '2023-01-02', 'default2', 'unique_6'), (7, '1975', 1, 'default2', 'default1', 'default2', '2023-01-01', 'default2', 'unique_7'), (8, 'default1', 1, '%Y', '%Y', '1975', '1975-10-27', NULL, 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (3, 'default2', '%Y', '1975', 'default1'), (2, '1975', 'default1', 'default1', '1975'), (0, '1975', 'default2', NULL, '1975'), (1, '%Y', '1975', 'default1', 'default2'), (4, 'default1', 'unique_4', 'default2', 'default2'), (5, 'default2', 'unique_5', NULL, '1975'), (6, '%Y', 'unique_6', 'default2', '%Y'), (7, '1975', 'unique_7', NULL, '%Y');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, '1975', '%Y', 'default1', '1975', NULL, 0.0, 3, 'default2'), (2, '%Y', '1975', 'default1', '%Y', 3.0, 1.0, 1, '%Y'), (1, 'default2', 'default1', 'default2', 'default1', 3.0, 3.0, 2, 'default1'), (3, 'default1', 'default2', 'default2', 'default1', 0.0, 3.0, NULL, '1975'), (4, 'default2', 'default1', 'default1', 'default2', 1.0, 3.0, 2, 'unique_4'), (5, 'default1', '%Y', 'default1', 'default2', 0.0, 0.0, NULL, 'unique_5'), (6, '%Y', '%Y', 'default1', 'default2', 0.0, 3.0, 3, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 2, 2, 2, 'default2', '2023-01-02', NULL, '%Y'), (0, 2, 5, 3, 'default1', '1975-10-27', '%Y', '1975');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (3, 2, 5, 6, 6, 1, 2, 3, '1975', 2, 0.0, 1, '%Y', NULL, 3, 2, 'default2', 'default1'), (1, 2, 3, 2, 1, 0, 2, NULL, '1975', 3, 2.0, 1, '1975', 0, 0, 2, '%Y', '1975'), (0, 0, 0, 0, 5, 0, 0, 0, 'default2', 1, 0.0, 0, 'default2', 0, 1, 1, '1975', '%Y'), (2, 0, 6, 5, 2, 1, 3, 2, '%Y', 3, 1.0, 3, 'default1', 0, 0, 0, '1975', NULL), (4, 0, 6, 7, 4, 3, 1, 2, '%Y', 2, 2.0, 2, 'default2', NULL, 2, 0, '1975', 'default1');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (3, 2, 6, 3.0, NULL, NULL, 2), (1, 2, 2, 3.0, NULL, '1975', 3), (2, 0, 1, 2.0, NULL, 'default1', 3), (0, 2, 6, 0.0, NULL, '%Y', 3), (4, 0, 1, 2.0, NULL, 'default1', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM results AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE STRFTIME('%Y', T2.dob) > '1975' AND T1.rank = 2;

/*
Gold Result:
('default2', '1975')
*/

-- Prediction Query
SELECT "drivers"."forename", "drivers"."surname" FROM "drivers" INNER JOIN "driverstandings" ON "drivers"."driverid" = "driverstandings"."driverid" WHERE STRFTIME('%Y', "drivers"."dob") > '1975' AND "driverstandings"."position" = 2;

/*
Prediction Result:
*/