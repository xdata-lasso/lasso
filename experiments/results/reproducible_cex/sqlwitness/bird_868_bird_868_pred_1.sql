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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'Malaysian Grand Prix'), (2, 'default1'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default2', 'default1', 'Malaysian Grand Prix', 1.0, 1.0, NULL, 'default1'), (0, 'default2', 'Malaysian Grand Prix', NULL, NULL, NULL, NULL, 1, 'Malaysian Grand Prix'), (2, 'default2', 'Malaysian Grand Prix', 'default1', 'default1', 0.0, 0.0, 0, 'default2'), (3, 'default1', 'Malaysian Grand Prix', 'default1', 'Malaysian Grand Prix', 1.0, 1.0, NULL, 'unique_3'), (4, 'default1', 'default1', 'default1', 'default2', NULL, 0.0, 0, 'unique_4'), (5, 'default1', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 'default1', 1.0, NULL, 1, 'unique_5'), (6, 'default2', 'default2', 'Malaysian Grand Prix', 'default2', 1.0, 0.0, 1, 'unique_6'), (7, 'Malaysian Grand Prix', 'default1', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 1.0, 1.0, 1, 'unique_7'), (8, 'Malaysian Grand Prix', 'default2', 'default2', 'Malaysian Grand Prix', 0.0, 0.0, 0, 'unique_8'), (9, 'Malaysian Grand Prix', 'default1', 'default1', 'Malaysian Grand Prix', 0.0, 1.0, 0, 'unique_9'), (10, 'Malaysian Grand Prix', 'default2', 'Malaysian Grand Prix', 'Malaysian Grand Prix', NULL, 1.0, NULL, 'unique_10'), (11, 'default2', 'default1', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 0.0, 0.0, 1, 'unique_11'), (12, 'default1', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 0.0, NULL, NULL, 'unique_12'), (13, 'Malaysian Grand Prix', 'Malaysian Grand Prix', 'Malaysian Grand Prix', 'default2', 1.0, 0.0, NULL, 'unique_13'), (14, 'Malaysian Grand Prix', 'default2', 'Malaysian Grand Prix', 'default1', 1.0, 0.0, 0, 'unique_14');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 2, 14, 1, 'Malaysian Grand Prix', '2023-01-02', 'default1', 'default1'), (1, 8, 0, 0, 'Malaysian Grand Prix', '2023-01-01', 'default1', 'Malaysian Grand Prix'), (2, 7, 9, 1, 'default2', '2023-01-01', NULL, 'default2'), (3, 4, 0, 0, 'default1', '2023-01-01', NULL, NULL), (4, 0, 0, 0, 'Malaysian Grand Prix', '2023-01-01', 'default2', 'unique_4'), (5, 3, 11, 1, 'default1', '2023-01-02', 'default1', 'unique_5'), (6, 3, 6, 0, 'Malaysian Grand Prix', '2023-01-02', 'Malaysian Grand Prix', 'unique_6'), (7, 3, 0, 1, 'default2', '2023-01-01', 'Malaysian Grand Prix', 'unique_7'), (8, 3, 12, 0, 'default1', '2023-01-01', NULL, 'unique_8'), (9, 7, 7, 0, 'Malaysian Grand Prix', '2023-01-01', 'Malaysian Grand Prix', 'unique_9'), (10, 1, 7, 1, 'Malaysian Grand Prix', '2023-01-01', 'default1', 'unique_10'), (11, 6, 8, 0, 'default2', '2023-01-01', 'default2', 'unique_11'), (12, 4, 5, 0, 'default1', '2023-01-01', 'default1', 'unique_12'), (13, 4, 10, 1, 'default2', '2023-01-02', 'default2', 'unique_13'), (14, 2, 12, 1, 'default1', '2023-01-02', 'default1', 'unique_14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.lat, T1.lng FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T2.name = 'Malaysian Grand Prix';

/*
Gold Result:
(1.0, 0.0)
(None, None)
(1.0, 1.0)
*/

-- Prediction Query
SELECT circuits.lat, circuits.lng FROM races INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.name = 'Malaysian Grand Prix';

/*
Prediction Result:
(1.0, 0.0)
(None, None)
(None, None)
(1.0, 0.0)
(1.0, 1.0)
(1.0, 1.0)
*/