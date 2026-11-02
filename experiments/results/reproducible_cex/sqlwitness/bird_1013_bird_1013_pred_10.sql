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
INSERT INTO status (statusid, status) VALUES (1, 'default2'), (0, 'default2'), (2, 'Austrian Grand Prix'), (3, 'default2'), (4, 'Austrian Grand Prix'), (5, 'default1'), (6, 'default1'), (7, 'default1'), (8, 'default1');
INSERT INTO seasons (year, url) VALUES (1, 'Austrian Grand Prix'), (0, 'default1'), (2, 'default2'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default1', 1, 'Austrian Grand Prix', 'default1', 'Austrian Grand Prix', NULL, NULL, 'default2'), (1, 'default2', NULL, 'Austrian Grand Prix', 'default2', 'default2', '2023-01-02', 'default1', 'Austrian Grand Prix'), (2, 'default2', 1, 'default1', 'default2', 'default2', '2023-01-02', 'default1', 'default1'), (3, 'default1', 1, 'Austrian Grand Prix', 'Austrian Grand Prix', 'Austrian Grand Prix', '2023-01-01', 'default2', 'unique_3'), (4, 'Austrian Grand Prix', NULL, 'default2', 'default2', 'default1', NULL, NULL, 'unique_4'), (5, 'default1', NULL, 'default2', 'Austrian Grand Prix', 'default2', '2023-01-02', 'Austrian Grand Prix', 'unique_5'), (6, 'default1', 1, NULL, 'default1', 'default1', NULL, 'Austrian Grand Prix', 'unique_6'), (7, 'Austrian Grand Prix', NULL, 'Austrian Grand Prix', 'default1', 'default2', '2023-01-01', 'default1', 'unique_7'), (8, 'Austrian Grand Prix', 1, 'Austrian Grand Prix', 'default1', 'default1', '2023-01-01', 'default2', 'unique_8'), (9, 'default1', NULL, NULL, 'default1', 'default1', '2023-01-02', 'default2', 'unique_9'), (10, 'default1', 0, 'Austrian Grand Prix', 'default1', 'Austrian Grand Prix', '2023-01-01', 'default1', 'unique_10');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Austrian Grand Prix', 'default2', 'Austrian Grand Prix', 'default2'), (1, 'Austrian Grand Prix', 'Austrian Grand Prix', NULL, 'default2'), (2, 'default2', 'default1', 'default2', 'default1'), (3, 'Austrian Grand Prix', 'unique_3', 'default2', 'default2'), (4, 'default1', 'unique_4', 'Austrian Grand Prix', 'default1'), (5, 'default1', 'unique_5', 'Austrian Grand Prix', 'default2'), (6, 'default2', 'unique_6', 'default1', 'default1'), (7, 'default1', 'unique_7', 'default1', 'Austrian Grand Prix');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Austrian Grand Prix', 'default1', NULL, 'default1', 1.0, 1.0, NULL, 'default1'), (1, 'Austrian Grand Prix', 'default2', NULL, 'default2', 0.0, NULL, 1, 'default2'), (2, 'default2', 'Austrian Grand Prix', NULL, 'default2', 1.0, NULL, NULL, 'Austrian Grand Prix');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 5, 0, 0, 'Austrian Grand Prix', '2023-01-01', 'default2', 'Austrian Grand Prix'), (0, 2, 1, 1, 'Austrian Grand Prix', '2023-01-01', NULL, 'default2'), (2, 7, 2, 0, 'default2', '2023-01-01', NULL, 'default1'), (3, 9, 0, 1, 'default1', '2023-01-01', NULL, NULL), (4, 2, 0, 0, 'default2', '2023-01-02', 'default2', 'unique_4'), (5, 2, 1, 0, 'Austrian Grand Prix', '2023-01-01', 'default1', 'unique_5'), (6, 3, 2, 0, 'default1', '2023-01-01', 'default2', 'unique_6'), (7, 2, 0, 1, 'default1', '2023-01-02', NULL, 'unique_7'), (8, 4, 2, 1, 'default1', '2023-01-01', 'Austrian Grand Prix', 'unique_8'), (9, 8, 2, 0, 'default1', '2023-01-02', NULL, 'unique_9'), (10, 4, 1, 0, 'default2', '2023-01-02', 'default2', 'unique_10'), (11, 0, 0, 1, 'default1', '2023-01-01', NULL, 'unique_11'), (12, 4, 0, 0, 'default1', '2023-01-02', 'default2', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1, 0, 6, 1, 0, 1, NULL, 'default1', 1, 0.0, 0, NULL, NULL, NULL, NULL, 'default1', 'default1'), (0, 11, 6, 2, 4, 0, 0, NULL, 'default2', 1, 0.0, 0, 'default2', 0, NULL, NULL, NULL, 'default2'), (2, 6, 6, 0, 0, NULL, 0, 0, 'default1', 0, 0.0, 0, 'default2', 0, 0, 1, 'Austrian Grand Prix', 'default1'), (3, 11, 4, 3, 4, 0, 1, NULL, 'Austrian Grand Prix', 1, 1.0, 1, 'default1', 1, 1, NULL, NULL, 'Austrian Grand Prix'), (4, 7, 9, 3, 1, NULL, 1, 0, 'Austrian Grand Prix', 0, 0.0, 1, 'default1', 1, NULL, 1, 'default1', 'Austrian Grand Prix'), (5, 9, 2, 2, 3, 1, 1, NULL, 'default2', 1, 1.0, 0, 'default1', 1, 0, 0, NULL, 'default1'), (6, 6, 0, 1, 0, 1, 1, 1, 'default1', 0, 1.0, 1, 'default1', 0, NULL, NULL, 'Austrian Grand Prix', 'Austrian Grand Prix'), (7, 2, 2, 3, 6, NULL, 1, 1, 'Austrian Grand Prix', 1, 0.0, 1, 'Austrian Grand Prix', 1, NULL, 1, 'Austrian Grand Prix', 'default2'), (8, 10, 5, 2, 7, 0, 1, 0, 'Austrian Grand Prix', 1, 0.0, 1, NULL, NULL, 1, 1, 'default1', 'Austrian Grand Prix'), (9, 7, 3, 3, 6, 0, 0, NULL, 'default2', 0, 0.0, 0, 'default2', 1, 0, NULL, 'default1', 'Austrian Grand Prix'), (10, 7, 0, 7, 3, NULL, 1, 0, 'Austrian Grand Prix', 0, 1.0, 0, 'default1', 0, NULL, 1, NULL, 'default1'), (11, 10, 0, 1, 6, 1, 0, 1, 'Austrian Grand Prix', 0, 1.0, 1, 'default1', 0, NULL, 1, 'default1', 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (8, 2, 0, 0, 'Austrian Grand Prix', 0), (6, 2, 0, 1, 'Austrian Grand Prix', NULL), (12, 0, 1, 0, 'Austrian Grand Prix', NULL), (7, 2, 0, NULL, NULL, 1), (7, 10, 0, 1, 'default2', 1), (7, 7, 1, 0, 'default2', 0), (5, 10, 0, 1, 'default1', NULL), (6, 4, 0, 1, 'default2', 0), (5, 8, 0, NULL, 'Austrian Grand Prix', 1), (4, 10, 0, 0, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.fastestLapTime FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT MIN(fastest_lap_times.fastestLapTime) AS lap_record FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT MIN(lt.time) FROM laptimes AS lt JOIN races AS r ON lt.raceId = r.raceId WHERE r.name = 'Austrian Grand Prix';

/*
Prediction Result:
('Austrian Grand Prix',)
*/