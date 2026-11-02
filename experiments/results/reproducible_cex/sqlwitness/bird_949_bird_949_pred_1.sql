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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (2, 'default1');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2, 'default2', 'default2', 'default1', 'default2'), (0, 'default1', 'default1', 'default1', 'default1'), (1, 'default2', 'unique_2', 'default2', 'default2'), (3, 'default2', 'unique_3', 'default1', 'default1'), (4, 'default2', 'unique_4', 'default1', 'default1'), (5, 'default2', 'unique_5', 'default1', 'default2'), (6, 'default1', 'unique_6', NULL, 'default1'), (7, 'default2', 'unique_7', 'default1', 'default2'), (8, 'default2', 'unique_8', 'default1', 'default1'), (9, 'default1', 'unique_9', 'default1', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default1', 'default2', 'default2', 'default2', 0.0, 1.0, NULL, 'default2'), (1, 'default2', 'default1', NULL, NULL, 2.0, 1.0, NULL, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2, 2, 2, 'default2', '2023-01-01', NULL, 'default2'), (0, 0, 1, 0, 'default2', '2023-01-02', 'default1', 'default1'), (2, 0, 1, 1, 'default1', '2023-01-01', 'default1', NULL), (3, 0, 2, 2, 'default2', '2023-01-01', 'default2', 'unique_3'), (4, 2, 2, 0, 'default1', '2023-01-01', 'default1', 'unique_4'), (5, 2, 1, 2, 'default1', '2023-01-02', 'default2', 'unique_5'), (6, 2, 1, 0, 'default2', '2023-01-01', 'default2', 'unique_6');
INSERT INTO constructorstandings (constructorstandingsid, raceid, constructorid, points, position, positiontext, wins) VALUES (2, 2, 3, 2.0, 2, 'default1', 2), (0, 5, 5, 2.0, NULL, 'default2', 0), (1, 0, 8, 0.0, 0, NULL, 2), (3, 4, 6, 1.0, 2, 'default1', 2), (4, 6, 2, 2.0, 2, NULL, 0), (5, 4, 1, 1.0, 0, 'default2', 1), (6, 3, 6, 1.0, 2, 'default1', 1), (7, 6, 2, 1.0, NULL, NULL, 2), (8, 6, 9, 2.0, NULL, 'default1', 1), (9, 3, 2, 2.0, 1, 'default2', 0), (10, 1, 6, 1.0, NULL, NULL, 1), (11, 6, 3, 0.0, 1, NULL, 0), (12, 1, 0, 2.0, 1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM constructorStandings AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId ORDER BY T1.points DESC, T1.constructorstandingsid NULLS LAST, T2.constructorid NULLS LAST LIMIT 1;

/*
Gold Result:
('unique_5',)
*/

-- Prediction Query
SELECT c.name FROM constructors AS c INNER JOIN constructorStandings AS cs ON c.constructorId = cs.constructorId GROUP BY c.name ORDER BY SUM(cs.points) DESC, c.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/