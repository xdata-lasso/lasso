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
INSERT INTO status (statusid, status) VALUES (0, 'Michael'), (2, 'Michael'), (1, 'default2'), (3, 'default2'), (4, 'default2'), (5, 'Michael'), (6, 'Schumacher'), (7, 'default2'), (8, 'Schumacher'), (9, 'Michael'), (10, 'default2'), (11, 'default2'), (12, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'Schumacher'), (0, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default1', 1, NULL, 'Michael', 'Michael', NULL, 'Michael', 'default1'), (0, 'Schumacher', 0, 'default1', 'Schumacher', 'Schumacher', '2023-01-02', 'Michael', 'default2'), (2, 'default1', 0, NULL, 'default1', 'Michael', NULL, 'default1', 'Schumacher'), (3, 'Schumacher', 1, 'default2', 'default1', 'Schumacher', NULL, NULL, 'Michael'), (4, 'default1', NULL, 'default1', 'Schumacher', 'Schumacher', '2023-01-01', NULL, 'unique_4'), (5, 'Schumacher', 0, 'Michael', 'Michael', 'default2', NULL, 'default2', 'unique_5'), (6, 'Schumacher', 1, 'default2', 'Michael', 'Schumacher', '2023-01-02', 'default1', 'unique_6'), (7, 'default1', 2, 'Michael', 'default2', 'Schumacher', NULL, NULL, 'unique_7');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'Schumacher', 'default1', 'Schumacher', 'Schumacher'), (1, 'default2', 'Michael', 'Schumacher', 'default2'), (2, 'Michael', 'Schumacher', 'default2', 'default1'), (3, 'Schumacher', 'default2', NULL, 'Michael'), (4, 'Michael', 'unique_4', 'default1', 'default2'), (5, 'default2', 'unique_5', 'Michael', 'default2'), (6, 'default2', 'unique_6', 'Schumacher', 'default2'), (7, 'default1', 'unique_7', 'default2', 'default2'), (8, 'default1', 'unique_8', NULL, 'default1'), (9, 'default1', 'unique_9', 'default1', 'default2'), (10, 'default1', 'unique_10', NULL, 'default2'), (11, 'default1', 'unique_11', 'Michael', 'Michael'), (12, 'Schumacher', 'unique_12', 'default2', 'default1'), (13, 'default2', 'unique_13', 'Michael', 'Schumacher'), (14, 'Schumacher', 'unique_14', 'default1', 'default1'), (15, 'default2', 'unique_15', 'Michael', 'Schumacher'), (16, 'default2', 'unique_16', 'default2', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'Schumacher', 'default2', 'Schumacher', 0.0, NULL, NULL, 'Michael'), (0, 'Schumacher', 'default2', 'default2', 'Schumacher', 1.0, 2.0, 0, 'default2'), (1, 'Michael', 'default1', 'Schumacher', 'default2', 1.0, NULL, 2, 'Schumacher'), (3, 'default1', 'Michael', 'default2', NULL, NULL, 0.0, 1, 'default1'), (4, 'default1', 'Schumacher', 'default2', 'default1', 0.0, NULL, 2, 'unique_4'), (5, 'default1', 'default2', 'Michael', 'Schumacher', 2.0, 1.0, 1, 'unique_5'), (6, 'Michael', 'default2', 'Schumacher', 'default1', 2.0, 2.0, 1, 'unique_6'), (7, 'Michael', 'default2', 'default1', 'Michael', NULL, NULL, 2, 'unique_7'), (8, 'Schumacher', 'default1', 'default2', 'default1', NULL, 1.0, 2, 'unique_8'), (9, 'default1', 'default2', 'Michael', 'Schumacher', 0.0, 1.0, 0, 'unique_9'), (10, 'default1', 'Schumacher', 'Schumacher', 'Schumacher', 2.0, 1.0, 2, 'unique_10'), (11, 'default1', 'Schumacher', 'Schumacher', 'default1', 1.0, 0.0, 1, 'unique_11'), (12, 'default2', 'default2', 'default2', NULL, 1.0, 2.0, 0, 'unique_12'), (13, 'Schumacher', 'default2', NULL, NULL, 2.0, 1.0, 2, 'unique_13');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 1, 13, 1, 'Schumacher', '2023-01-02', 'default1', NULL), (2, 0, 6, 2, 'Michael', '2023-01-01', 'default1', 'default2'), (0, 0, 11, 2, 'default1', '2023-01-02', 'Schumacher', 'Schumacher'), (3, 1, 8, 2, 'default1', '2023-01-01', NULL, 'Michael'), (4, 0, 8, 0, 'default1', '2023-01-01', NULL, 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 1, 1, 15, 10, 0, 1, 2, 'Schumacher', 1, 2.0, 0, 'Schumacher', 0, 1, 1, 'Schumacher', 'Michael'), (0, 3, 3, 7, 1, 0, 2, NULL, 'Michael', 1, 2.0, 1, NULL, 2, NULL, 0, 'Schumacher', 'Schumacher'), (2, 1, 6, 7, 4, 1, 2, 0, 'default1', 1, 1.0, 2, 'default2', 1, NULL, 1, 'default1', 'Michael'), (3, 3, 1, 5, 1, 0, 0, NULL, 'default1', 0, 2.0, 1, 'default1', 0, 0, 1, 'default2', 'default1'), (4, 3, 5, 9, 6, 2, 0, 2, 'Michael', 2, 2.0, 0, 'default2', 2, 2, 0, NULL, 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (1, 7, 1, 0, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN lapTimes AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Michael' AND T3.surname = 'Schumacher' ORDER BY T2.milliseconds ASC, T1.raceid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT r.name, r.year FROM races AS r INNER JOIN results AS res ON r.raceid = res.raceid INNER JOIN drivers AS d ON res.driverid = d.driverid WHERE d.forename = 'Michael' AND d.surname = 'Schumacher' AND res.milliseconds = (SELECT MIN(milliseconds) FROM results WHERE driverid = (SELECT driverid FROM drivers WHERE forename = 'Michael' AND surname = 'Schumacher'));

/*
Prediction Result:
('Schumacher', 1)
*/