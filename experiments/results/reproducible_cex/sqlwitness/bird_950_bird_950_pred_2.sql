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
INSERT INTO seasons (year, url) VALUES (291, 'default2'), (292, 'default1'), (-1, 'unique_2'), (0, 'unique_3'), (1, 'unique_4'), (290, 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (290, 'default1', 'default1', 'default1', 'default1'), (-1, 'default1', 'default2', 'default1', 'default1'), (1, 'default1', 'unique_2', NULL, 'default2'), (0, 'default2', 'unique_3', NULL, 'default2'), (291, 'default1', 'unique_4', NULL, 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (-1, 'default2', 'default1', NULL, 'default1', 291.0, NULL, 290, 'default2'), (292, 'default2', 'default1', NULL, 'default1', 292.0, 292.0, -1, 'default1'), (290, 'default1', 'default1', 'default2', NULL, 1.0, 291.0, 0, 'unique_2'), (0, 'default2', 'default1', 'default1', NULL, 291.0, -1.0, NULL, 'unique_3'), (1, 'default2', 'default2', NULL, 'default1', 292.0, 291.0, 291, 'unique_4'), (291, 'default2', 'default2', 'default2', 'default1', 290.0, 291.0, 1, 'unique_5'), (2, 'default2', 'default2', NULL, NULL, NULL, 291.0, 1, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 0, 292, 292, 'default2', '2023-01-01', NULL, 'default1'), (-1, 291, 2, -1, 'default2', '2023-01-02', 'default1', 'default2'), (1, 0, 292, 0, 'default2', '2023-01-01', NULL, NULL), (292, 291, 290, 290, 'default1', '2023-01-01', 'default2', 'unique_3'), (291, 292, 290, 1, 'default1', '2023-01-01', 'default2', 'unique_4'), (290, 291, 2, 292, 'default1', '2023-01-01', NULL, 'unique_5'), (2, -1, -1, 1, 'default1', '2023-01-02', NULL, 'unique_6'), (3, -1, -1, 290, 'default1', '2023-01-01', 'default1', 'unique_7'), (4, 292, 1, 0, 'default1', '2023-01-02', 'default1', 'unique_8'), (5, 290, 2, -1, 'default1', '2023-01-02', 'default2', 'unique_9');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (0, 3, 0, 0.0, 1, 'default1', 292);
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (292, -1, 291, 291.0, 'default1'), (290, 291, 290, 0.0, 'default1'), (0, 292, 0, 290.0, 'default1'), (-1, 5, 290, 1.0, 'default2'), (1, 292, 290, NULL, 'default1'), (291, 3, 291, 0.0, 'default1'), (2, -1, 291, 291.0, NULL), (3, 4, 291, 0.0, 'default2'), (4, 0, -1, 290.0, 'default1'), (5, 4, 0, 290.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.points = 0 AND T1.raceId = 291;

/*
Gold Result:
*/

-- Prediction Query
SELECT "constructors"."name" FROM "constructors" INNER JOIN "constructorresults" ON "constructors"."constructorid" = "constructorresults"."constructorid" WHERE "constructorresults"."points" = 0 AND "constructorresults"."raceid" = 291;

/*
Prediction Result:
('default1',)
*/