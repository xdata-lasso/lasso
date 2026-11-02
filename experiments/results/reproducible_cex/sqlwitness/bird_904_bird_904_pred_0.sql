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
INSERT INTO status (statusid, status) VALUES (2, 'default2'), (1, 'default1'), (0, 'default1'), (3, 'Schumacher'), (4, 'default1'), (5, 'default1'), (6, 'Michael'), (7, 'default2'), (8, 'Schumacher'), (9, 'Michael'), (10, 'default1');
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (1, 'default2'), (2, 'Michael'), (3, 'Schumacher'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 0, 'default1', 'default2', 'default2', NULL, 'Schumacher', 'Michael'), (1, 'default1', NULL, 'Schumacher', 'Schumacher', 'Schumacher', '2023-01-01', 'Michael', 'Schumacher'), (2, 'Michael', 0, NULL, 'Michael', 'Schumacher', '2023-01-01', 'Schumacher', 'default1'), (3, 'default1', 0, 'default1', 'default1', 'Schumacher', '2023-01-01', 'default1', 'default2'), (4, 'Michael', 1, 'default2', 'default2', 'Schumacher', NULL, 'default1', 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Michael', 'Michael', 'default2', 'Michael'), (2, 'default2', 'default2', 'Michael', 'default2'), (1, 'default1', 'default1', 'default1', 'default2'), (3, 'Schumacher', 'Schumacher', 'default2', 'Michael');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'default2', 'Michael', 'Schumacher', 0.0, 2.0, 1, 'default1'), (0, 'default2', 'default1', 'default1', 'Michael', NULL, NULL, 1, 'Michael');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 0, 0, 0, 'Schumacher', '2023-01-01', NULL, 'default1'), (0, 2, 2, 2, 'default2', '2023-01-01', NULL, 'Michael'), (2, 5, 0, 2, 'default2', '2023-01-01', 'default1', 'default2'), (3, 0, 2, 0, 'Schumacher', '2023-01-02', 'Michael', 'Schumacher'), (4, 1, 2, 1, 'default1', '2023-01-01', 'default1', NULL), (5, 5, 2, 2, 'Michael', '2023-01-02', 'Michael', 'unique_5'), (6, 1, 2, 0, 'default2', '2023-01-01', 'Michael', 'unique_6'), (7, 3, 2, 0, 'Michael', '2023-01-02', 'default1', 'unique_7'), (8, 5, 0, 0, 'Schumacher', '2023-01-02', NULL, 'unique_8'), (9, 1, 0, 2, 'Schumacher', '2023-01-02', 'Schumacher', 'unique_9'), (10, 4, 0, 0, 'Michael', '2023-01-01', 'Michael', 'unique_10'), (11, 1, 2, 1, 'default2', '2023-01-02', 'Michael', 'unique_11'), (12, 0, 0, 1, 'default1', '2023-01-01', 'Schumacher', 'unique_12'), (13, 2, 0, 2, 'default2', '2023-01-02', 'Schumacher', 'unique_13'), (14, 2, 0, 0, 'Schumacher', '2023-01-01', NULL, 'unique_14');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 1, 2, 1, 4, 2, 0, NULL, 'default1', 2, 1.0, 1, 'Michael', NULL, 2, NULL, 'Michael', 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (9, 1, 0, NULL, 'Schumacher', 1), (5, 4, 0, 0, 'Michael', 2), (14, 2, 0, NULL, 'default2', NULL), (14, 1, 1, 2, 'default1', 2), (11, 0, 1, 1, 'default1', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN lapTimes AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Michael' AND T3.surname = 'Schumacher' ORDER BY T2.milliseconds ASC, T1.raceid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('Schumacher', 2)
*/

-- Prediction Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T2.driverId = T3.driverId WHERE T3.surname = 'Schumacher' AND T3.forename = 'Michael' ORDER BY T2.fastestLapTime, T1.raceid NULLS LAST, T2.resultid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Schumacher', 0)
*/