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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (0, 'Renault'), (2, 'Renault');
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (0, 'default1'), (2, 'Renault'), (3, 'unique_3');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Renault', NULL, 'Renault', 'default2', 'Renault', '2023-01-01', 'default1', 'default2'), (0, 'Renault', 0, 'default2', 'default1', 'default1', '2023-01-02', 'default1', 'Renault'), (2, 'default1', NULL, 'default1', 'default1', 'default2', '2023-01-02', 'Renault', 'default1'), (3, 'Renault', NULL, 'default1', 'Renault', 'Renault', '2023-01-01', 'Renault', 'unique_3');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Renault', 'Renault', 'default2', 'default2'), (1, 'default2', 'default1', NULL, 'default2'), (2, 'default1', 'default2', 'default2', 'Renault');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Renault', 'default1', 'default1', 'Renault', 1.0, 1.0, 1, 'Renault'), (1, 'default2', 'Renault', 'default1', 'Renault', NULL, 0.0, 1, 'default2'), (2, 'default2', 'default2', 'default2', 'default1', 0.0, NULL, 1, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 3, 0, 1, 'default1', '2023-01-01', 'default1', 'default1'), (1, 3, 1, 1, 'default2', '2023-01-01', NULL, 'default2'), (2, 3, 2, 1, 'default2', '2023-01-02', NULL, 'Renault'), (3, 3, 2, 0, 'default1', '2023-01-02', 'default1', NULL), (4, 1, 2, 1, 'default1', '2023-01-02', 'default1', 'unique_4'), (5, 3, 0, 0, 'default2', '2023-01-01', 'default2', 'unique_5');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 0, 0, 1, 2, 0, 1, NULL, 'default2', 1, 1.0, 0, 'default2', NULL, 0, 0, 'Renault', 'Renault'), (0, 1, 3, 1, 1, 0, 0, 1, 'Renault', 1, 1.0, 1, 'default1', NULL, NULL, 0, NULL, 'default2'), (2, 3, 2, 1, 0, 0, 0, 0, 'default1', 0, 0.0, 1, 'default1', 0, 1, 1, 'default2', 'default1'), (3, 5, 2, 1, 1, 0, 1, 1, 'default2', 0, 0.0, 0, NULL, NULL, 1, NULL, 'default1', 'default2'), (4, 0, 2, 0, 1, 0, 1, 0, 'Renault', 0, 1.0, 0, 'Renault', 0, 1, 1, NULL, 'default1');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (0, 4, 2, 1.0, 1, 'default2', 0), (1, 0, 1, 1.0, NULL, 'default1', 0), (2, 0, 1, 1.0, 0, 'Renault', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.position FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T2.name = 'Renault';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT circuits.location FROM constructors INNER JOIN results ON constructors.constructorId = results.constructorId INNER JOIN races ON results.raceId = races.raceId INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE constructors.name = 'Renault';

/*
Prediction Result:
('default1',)
*/