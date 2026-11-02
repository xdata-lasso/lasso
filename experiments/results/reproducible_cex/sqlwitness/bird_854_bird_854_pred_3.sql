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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'Australian Grand Prix'), (2, 'default1'), (3, 'unique_3'), (4, 'unique_4');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'default1', 'default1', NULL, 0.0, NULL, 0, 'default2'), (1, 'default1', 'Australian Grand Prix', 'default2', 'Australian Grand Prix', 0.0, 0.0, 1, 'default1'), (2, 'default1', 'Australian Grand Prix', NULL, 'default2', 0.0, 1.0, NULL, 'Australian Grand Prix'), (3, 'default1', 'default2', 'Australian Grand Prix', 'default2', 1.0, 0.0, 1, 'unique_3'), (4, 'default1', 'Australian Grand Prix', NULL, NULL, 0.0, 1.0, 1, 'unique_4'), (5, 'default1', 'default2', 'default1', 'default1', 1.0, 0.0, NULL, 'unique_5'), (6, 'Australian Grand Prix', 'Australian Grand Prix', 'default2', 'default1', NULL, 1.0, 1, 'unique_6'), (7, 'default1', 'Australian Grand Prix', NULL, 'Australian Grand Prix', 0.0, NULL, 0, 'unique_7'), (8, 'default2', 'default2', NULL, 'default2', 0.0, NULL, 1, 'unique_8'), (9, 'default1', 'Australian Grand Prix', 'default2', 'default2', 0.0, NULL, 0, 'unique_9'), (10, 'default2', 'default2', 'default1', 'Australian Grand Prix', 1.0, 0.0, 0, 'unique_10'), (11, 'default2', 'Australian Grand Prix', NULL, NULL, NULL, 1.0, NULL, 'unique_11'), (12, 'default1', 'default2', NULL, 'Australian Grand Prix', 0.0, NULL, NULL, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 0, 6, 0, 'default1', '2023-01-02', 'Australian Grand Prix', 'default2'), (1, 2, 6, 1, 'Australian Grand Prix', '2023-01-01', 'Australian Grand Prix', NULL), (2, 0, 8, 1, 'Australian Grand Prix', '2023-01-02', 'default1', 'default1'), (3, 0, 8, 0, 'default2', '2023-01-02', 'default1', 'Australian Grand Prix'), (4, 0, 5, 0, 'Australian Grand Prix', '2023-01-02', 'default1', 'unique_4'), (5, 3, 6, 1, 'default2', '2023-01-02', 'default1', 'unique_5'), (6, 1, 6, 1, 'Australian Grand Prix', '2023-01-02', 'default1', 'unique_6'), (7, 3, 1, 1, 'default1', '2023-01-02', 'Australian Grand Prix', 'unique_7'), (8, 3, 5, 0, 'default1', '2023-01-01', 'default2', 'unique_8'), (9, 3, 3, 0, 'Australian Grand Prix', '2023-01-01', 'default2', 'unique_9'), (10, 3, 9, 1, 'default1', '2023-01-02', 'default1', 'unique_10'), (11, 3, 3, 1, 'default2', '2023-01-02', 'Australian Grand Prix', 'unique_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.lat, T1.lng FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T2.name = 'Australian Grand Prix';

/*
Gold Result:
(None, 1.0)
(0.0, None)
(1.0, 0.0)
*/

-- Prediction Query
SELECT T2.lat, T2.lng FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T1.name = 'Australian Grand Prix';

/*
Prediction Result:
(None, 1.0)
(0.0, None)
(1.0, 0.0)
(None, 1.0)
(1.0, 0.0)
*/