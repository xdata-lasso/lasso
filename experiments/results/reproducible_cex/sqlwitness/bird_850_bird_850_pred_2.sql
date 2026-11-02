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
INSERT INTO seasons (year, url) VALUES (0, 'Germany'), (1, 'default1'), (2, 'default2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16'), (17, 'unique_17'), (18, 'unique_18'), (19, 'unique_19'), (20, 'unique_20'), (21, 'unique_21'), (22, 'unique_22'), (23, 'unique_23'), (24, 'unique_24');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Germany', 'Germany', 'Germany', 'Germany', 1.0, 0.0, NULL, 'default1'), (0, 'default1', 'default1', NULL, NULL, NULL, NULL, 1, 'default2'), (2, 'default2', 'default1', 'default1', 'Germany', 1.0, 0.0, NULL, 'Germany'), (3, 'default2', 'Germany', 'Germany', 'default2', 1.0, 0.0, NULL, 'unique_3'), (4, 'default2', 'default2', 'default2', 'default1', 1.0, NULL, 1, 'unique_4'), (5, 'default1', 'Germany', 'default1', 'default1', 0.0, 1.0, NULL, 'unique_5'), (6, 'default2', 'Germany', 'default2', 'default2', 1.0, 1.0, NULL, 'unique_6'), (7, 'Germany', 'default1', 'default1', NULL, 0.0, 0.0, NULL, 'unique_7'), (8, 'default2', 'Germany', NULL, 'default2', 0.0, 1.0, 0, 'unique_8'), (9, 'default2', 'default2', NULL, 'Germany', NULL, NULL, 1, 'unique_9'), (10, 'default1', 'default2', 'Germany', NULL, 1.0, 1.0, 1, 'unique_10'), (11, 'Germany', 'default2', NULL, 'default2', 0.0, NULL, 0, 'unique_11'), (12, 'Germany', 'default1', 'default1', NULL, 0.0, NULL, NULL, 'unique_12'), (13, 'default2', 'default2', 'Germany', NULL, 0.0, 1.0, 0, 'unique_13'), (14, 'default1', 'Germany', NULL, NULL, 0.0, NULL, 1, 'unique_14'), (15, 'default2', 'default1', 'Germany', 'default1', 1.0, 0.0, 0, 'unique_15'), (16, 'Germany', 'Germany', 'Germany', NULL, 1.0, NULL, 0, 'unique_16'), (17, 'Germany', 'Germany', NULL, 'default1', NULL, 1.0, 0, 'unique_17'), (18, 'Germany', 'default1', NULL, 'default1', 1.0, 1.0, NULL, 'unique_18'), (19, 'Germany', 'default1', 'default1', 'default2', 0.0, 1.0, 0, 'unique_19'), (20, 'Germany', 'default1', 'default1', 'default1', NULL, 0.0, 0, 'unique_20'), (21, 'default2', 'Germany', NULL, 'Germany', 1.0, NULL, NULL, 'unique_21'), (22, 'default2', 'default1', 'Germany', 'default1', 1.0, 1.0, 1, 'unique_22'), (23, 'default2', 'Germany', 'default2', 'default2', NULL, NULL, 1, 'unique_23'), (24, 'default1', 'default1', 'default1', 'Germany', NULL, 0.0, 0, 'unique_24');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 23, 11, 1, 'default2', '2023-01-02', NULL, 'default2'), (1, 19, 7, 1, 'default2', '2023-01-02', NULL, 'default1'), (2, 23, 8, 0, 'default1', '2023-01-02', 'default1', 'Germany'), (3, 1, 21, 0, 'default1', '2023-01-01', 'Germany', NULL), (4, 15, 15, 0, 'default1', '2023-01-01', NULL, 'unique_4'), (5, 1, 6, 0, 'Germany', '2023-01-01', 'Germany', 'unique_5'), (6, 12, 7, 1, 'Germany', '2023-01-01', 'Germany', 'unique_6'), (7, 11, 11, 1, 'Germany', '2023-01-01', 'default1', 'unique_7'), (8, 1, 7, 0, 'default1', '2023-01-02', 'Germany', 'unique_8'), (9, 1, 3, 1, 'default2', '2023-01-02', 'default1', 'unique_9'), (10, 13, 17, 0, 'default1', '2023-01-01', 'default1', 'unique_10'), (11, 13, 19, 1, 'default1', '2023-01-02', 'Germany', 'unique_11'), (12, 8, 3, 1, 'Germany', '2023-01-02', 'default2', 'unique_12'), (13, 0, 23, 1, 'default2', '2023-01-02', 'Germany', 'unique_13'), (14, 20, 0, 0, 'Germany', '2023-01-01', 'Germany', 'unique_14'), (15, 3, 4, 1, 'Germany', '2023-01-02', 'default1', 'unique_15'), (16, 4, 23, 0, 'default1', '2023-01-02', 'default2', 'unique_16'), (17, 4, 1, 1, 'default2', '2023-01-01', NULL, 'unique_17'), (18, 15, 24, 0, 'Germany', '2023-01-02', NULL, 'unique_18'), (19, 15, 19, 1, 'default2', '2023-01-01', 'default2', 'unique_19'), (20, 9, 12, 0, 'default2', '2023-01-01', 'Germany', 'unique_20'), (21, 7, 24, 1, 'default1', '2023-01-02', 'default2', 'unique_21'), (22, 4, 10, 0, 'default2', '2023-01-01', 'default2', 'unique_22'), (23, 18, 8, 1, 'Germany', '2023-01-02', 'Germany', 'unique_23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.country = 'Germany';

/*
Gold Result:
('default1',)
('default2',)
('Germany',)
*/

-- Prediction Query
SELECT T2.name FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T1.country = 'Germany';

/*
Prediction Result:
('default1',)
('default2',)
('Germany',)
('default1',)
*/