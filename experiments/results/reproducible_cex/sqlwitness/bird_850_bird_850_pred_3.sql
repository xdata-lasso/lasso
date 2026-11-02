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
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (0, 'Germany'), (2, 'default1'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'Germany', NULL, 'default1', NULL, 0.0, NULL, 'Germany'), (1, 'default1', 'default2', 'Germany', 'default1', NULL, 0.0, NULL, 'default2'), (2, 'default2', 'default2', 'Germany', 'default2', 0.0, 0.0, 0, 'default1'), (3, 'default2', 'default1', 'default2', NULL, NULL, NULL, NULL, 'unique_3'), (4, 'default1', 'default1', NULL, 'default1', NULL, 0.0, 1, 'unique_4'), (5, 'default2', 'default2', 'default2', 'default2', 0.0, 1.0, 1, 'unique_5'), (6, 'default1', 'default2', 'default1', NULL, 1.0, 0.0, 0, 'unique_6'), (7, 'default2', 'default2', 'default1', 'Germany', 0.0, 1.0, 1, 'unique_7'), (8, 'Germany', 'Germany', 'default1', 'default2', NULL, 1.0, 0, 'unique_8'), (9, 'Germany', 'default1', 'default2', 'default1', NULL, NULL, 1, 'unique_9'), (10, 'default2', 'default2', NULL, NULL, 0.0, NULL, 0, 'unique_10'), (11, 'default2', 'Germany', 'Germany', 'default2', 0.0, 0.0, 1, 'unique_11'), (12, 'default2', 'default1', 'default1', 'default2', NULL, 0.0, 0, 'unique_12'), (13, 'default2', 'Germany', NULL, 'Germany', NULL, 0.0, NULL, 'unique_13'), (14, 'Germany', 'Germany', NULL, 'Germany', 1.0, 0.0, NULL, 'unique_14'), (15, 'default2', 'default1', 'Germany', 'Germany', 1.0, 0.0, NULL, 'unique_15'), (16, 'default1', 'default1', 'default2', 'Germany', NULL, 0.0, NULL, 'unique_16');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 6, 14, 1, 'default1', '2023-01-01', 'default2', 'default1'), (0, 4, 12, 1, 'default2', '2023-01-01', 'Germany', NULL), (2, 3, 7, 0, 'Germany', '2023-01-01', 'default1', 'default2'), (3, 5, 16, 0, 'Germany', '2023-01-01', 'Germany', 'Germany'), (4, 2, 14, 0, 'default1', '2023-01-01', 'Germany', 'unique_4'), (5, 5, 1, 1, 'Germany', '2023-01-01', NULL, 'unique_5'), (6, 1, 7, 0, 'Germany', '2023-01-02', 'default2', 'unique_6'), (7, 5, 7, 0, 'Germany', '2023-01-01', 'default1', 'unique_7'), (8, 5, 7, 1, 'default1', '2023-01-01', 'Germany', 'unique_8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.country = 'Germany';

/*
Gold Result:
('default1',)
('Germany',)
*/

-- Prediction Query
SELECT T1.name FROM races AS T1 INNER JOIN circuits AS T2 ON T1.circuitId = T2.circuitId WHERE T2.country = 'Germany';

/*
Prediction Result:
('default1',)
('Germany',)
('Germany',)
('default1',)
('Germany',)
('Germany',)
('default1',)
*/