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
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (-1, 'default2'), (290, 'unique_2'), (1, 'unique_3'), (291, 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (291, 'default2', 'default2', 'default2', 'default2'), (-1, 'default1', 'default1', 'default2', 'default2'), (1, 'default2', 'unique_2', 'default2', 'default1'), (0, 'default2', 'unique_3', 'default2', 'default1'), (290, 'default2', 'unique_4', NULL, 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (291, 'default2', 'default2', NULL, 'default2', -1.0, 290.0, NULL, 'default1'), (-1, 'default2', 'default2', NULL, 'default2', 1.0, 0.0, 292, 'default2'), (1, 'default2', 'default1', NULL, 'default2', -1.0, 292.0, 0, 'unique_2'), (290, 'default1', 'default1', 'default2', 'default2', NULL, 290.0, 291, 'unique_3'), (292, 'default1', 'default2', NULL, 'default1', 290.0, 290.0, 1, 'unique_4'), (0, 'default1', 'default2', NULL, NULL, 0.0, 291.0, 0, 'unique_5'), (2, 'default1', 'default1', NULL, NULL, 292.0, 0.0, 291, 'unique_6'), (3, 'default1', 'default1', 'default2', NULL, 292.0, -1.0, 1, 'unique_7'), (4, 'default2', 'default2', NULL, 'default1', NULL, 1.0, -1, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (291, 0, 0, -1, 'default1', '2023-01-02', 'default2', 'default2'), (292, 0, 2, 0, 'default2', '2023-01-02', NULL, NULL), (0, 1, 0, 1, 'default1', '2023-01-02', 'default1', 'default1'), (290, -1, 4, 291, 'default1', '2023-01-02', 'default2', 'unique_3'), (1, 291, 1, -1, 'default1', '2023-01-01', NULL, 'unique_4'), (-1, -1, 290, 0, 'default2', '2023-01-01', 'default2', 'unique_5'), (2, 0, 4, -1, 'default1', '2023-01-01', 'default1', 'unique_6'), (3, -1, 3, 292, 'default1', '2023-01-02', 'default2', 'unique_7'), (4, -1, 1, 0, 'default2', '2023-01-02', NULL, 'unique_8'), (5, 0, 291, -1, 'default1', '2023-01-02', 'default1', 'unique_9'), (6, 0, 292, 0, 'default1', '2023-01-02', 'default1', 'unique_10');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (291, 4, 291, 0.0, 0, NULL, 291), (290, 2, 290, 291.0, NULL, 'default2', 291), (0, 6, 291, -1.0, 1, 'default2', 291), (292, 1, 0, 0.0, 1, 'default2', 290), (-1, 292, 1, -1.0, 0, 'default1', 292), (1, -1, 1, 290.0, NULL, NULL, 292), (2, 291, 1, 0.0, 291, NULL, 292), (3, 291, 0, 290.0, 290, NULL, 291), (4, 292, -1, 290.0, 0, 'default2', 292), (5, 1, 291, 290.0, -1, 'default1', -1), (6, 5, 291, 290.0, 292, 'default2', 0);
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (290, 6, -1, 1.0, NULL), (1, 4, 291, 1.0, NULL), (292, 1, 290, NULL, 'default2'), (0, 3, 0, NULL, NULL), (-1, 2, 290, 1.0, 'default2'), (291, 2, 0, -1.0, 'default2'), (2, 5, 1, 290.0, 'default1'), (3, 4, 290, NULL, 'default1'), (4, 0, 1, 291.0, 'default2'), (5, 292, 1, 291.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T1.raceId = 291;

/*
Gold Result:
('unique_2',)
*/

-- Prediction Query
SELECT T2.name FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.raceId = 291 AND T1.points = 0;

/*
Prediction Result:
*/