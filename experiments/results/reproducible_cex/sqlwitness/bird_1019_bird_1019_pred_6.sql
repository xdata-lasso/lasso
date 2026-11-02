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
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (0, 'Italy'), (2, 'default1'), (3, 'unique_3'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default1', NULL, 'Italy', 'Italy', 'default1', '2023-01-02', NULL, 'default1'), (1, 'default2', 0, 'default1', 'Italy', 'default2', '2023-01-02', 'default2', 'default2'), (2, 'default1', 1, 'Italy', 'default1', 'default2', NULL, 'Italy', 'Italy'), (3, 'Italy', NULL, 'default1', 'default1', 'Italy', NULL, 'Italy', 'unique_3'), (4, 'Italy', NULL, NULL, 'default1', 'Italy', '2023-01-02', 'Italy', 'unique_4'), (5, 'default2', 1, 'default2', 'default1', 'default2', '2023-01-01', NULL, 'unique_5'), (6, 'default1', 0, NULL, 'default1', 'Italy', NULL, NULL, 'unique_6'), (7, 'Italy', NULL, 'Italy', 'Italy', 'Italy', NULL, 'default2', 'unique_7'), (8, 'Italy', 0, 'default1', 'Italy', 'Italy', '2023-01-01', NULL, 'unique_8'), (9, 'Italy', NULL, 'Italy', 'default1', 'default1', '2023-01-02', 'default1', 'unique_9'), (10, 'Italy', 0, NULL, 'default2', 'Italy', '2023-01-01', 'default1', 'unique_10'), (11, 'Italy', NULL, 'Italy', 'default1', 'default1', '2023-01-02', 'Italy', 'unique_11');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Italy', 'default2', NULL, 'default2', 1.0, NULL, NULL, 'default1'), (0, 'default1', 'default1', 'default2', NULL, 0.0, 0.0, 1, 'Italy'), (2, 'Italy', 'default2', 'Italy', 'Italy', 1.0, NULL, 1, 'default2'), (3, 'default2', 'default2', NULL, NULL, NULL, 1.0, 0, 'unique_3'), (4, 'default1', 'default1', 'default2', 'Italy', 1.0, 0.0, 1, 'unique_4'), (5, 'Italy', 'default2', 'default1', 'default2', NULL, 1.0, 0, 'unique_5'), (6, 'default1', 'Italy', 'default1', 'default2', NULL, 0.0, 0, 'unique_6'), (7, 'default1', 'default2', NULL, 'Italy', 0.0, NULL, 0, 'unique_7'), (8, 'Italy', 'Italy', 'default1', 'Italy', 0.0, NULL, NULL, 'unique_8'), (9, 'Italy', 'default1', 'default1', NULL, 0.0, 1.0, NULL, 'unique_9'), (10, 'Italy', 'default1', 'default1', NULL, NULL, 1.0, NULL, 'unique_10'), (11, 'default2', 'default1', 'default2', 'default1', 1.0, 0.0, 1, 'unique_11'), (12, 'Italy', 'default2', NULL, 'Italy', 1.0, 0.0, NULL, 'unique_12'), (13, 'default1', 'default1', NULL, NULL, 0.0, 0.0, 0, 'unique_13'), (14, 'default1', 'Italy', 'Italy', 'default1', 1.0, NULL, NULL, 'unique_14'), (15, 'default2', 'Italy', 'default1', NULL, 0.0, 1.0, NULL, 'unique_15'), (16, 'Italy', 'default1', 'default2', NULL, NULL, 1.0, 1, 'unique_16'), (17, 'default2', 'default2', 'default2', NULL, 0.0, NULL, 0, 'unique_17'), (18, 'Italy', 'default2', 'default1', 'Italy', 0.0, 1.0, 0, 'unique_18'), (19, 'Italy', 'default2', 'default1', NULL, NULL, 0.0, 0, 'unique_19');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 19, 0, 'default1', '2023-01-01', 'Italy', NULL), (1, 1, 2, 0, 'default2', '2023-01-01', 'default2', 'Italy'), (2, 4, 0, 1, 'Italy', '2023-01-02', NULL, 'default2'), (3, 7, 11, 1, 'Italy', '2023-01-01', NULL, 'default1'), (4, 1, 14, 0, 'default2', '2023-01-02', NULL, 'unique_4'), (5, 2, 16, 1, 'default2', '2023-01-02', 'Italy', 'unique_5'), (6, 4, 8, 1, 'Italy', '2023-01-01', 'default2', 'unique_6'), (7, 0, 13, 1, 'Italy', '2023-01-01', NULL, 'unique_7'), (8, 0, 2, 0, 'default2', '2023-01-01', 'default1', 'unique_8'), (9, 2, 10, 0, 'default1', '2023-01-01', NULL, 'unique_9'), (10, 3, 0, 1, 'Italy', '2023-01-02', 'default1', 'unique_10'), (11, 8, 0, 0, 'Italy', '2023-01-02', NULL, 'unique_11'), (12, 1, 18, 1, 'default2', '2023-01-01', 'Italy', 'unique_12');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (0, 7, 1, NULL, 'default2', 1), (6, 4, 0, 0, 'default1', 1), (1, 1, 0, 0, 'default1', 0), (3, 4, 0, NULL, NULL, NULL), (8, 7, 1, NULL, 'Italy', NULL), (4, 5, 1, 1, 'default1', 1), (0, 10, 1, 1, 'Italy', 0), (0, 0, 0, 0, NULL, NULL), (7, 10, 0, NULL, 'default2', 1), (8, 9, 1, 0, 'Italy', 0), (3, 3, 0, 0, 'Italy', 1), (6, 7, 1, 0, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.milliseconds) AS REAL) / COUNT(T1.lap) FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy';

/*
Gold Result:
(0.4,)
*/

-- Prediction Query
SELECT AVG(l.milliseconds) AS average FROM laptimes AS l JOIN races AS r ON l.raceid = r.raceid JOIN circuits AS c ON r.circuitid = c.circuitid WHERE c.country = 'Italy';

/*
Prediction Result:
(0.5,)
*/