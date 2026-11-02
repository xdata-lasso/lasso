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
INSERT INTO seasons (year, url) VALUES (1, 'Hamilton'), (0, 'default1'), (2, 'default2'), (3, 'Lewis'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'default2', 0, 'Lewis', 'default1', 'default1', '2023-01-01', 'default2', 'default2'), (2, 'default1', NULL, NULL, 'Lewis', 'Hamilton', NULL, 'default2', 'Lewis'), (0, 'Lewis', 0, 'Lewis', 'Hamilton', 'Lewis', '2023-01-02', 'default1', 'Hamilton'), (3, 'Hamilton', 0, 'Lewis', 'Lewis', 'default2', NULL, NULL, 'default1'), (4, 'default2', 0, NULL, 'default1', 'Lewis', NULL, NULL, 'unique_4'), (5, 'Lewis', 1, 'default2', 'default1', 'default1', NULL, 'Hamilton', 'unique_5'), (6, 'Lewis', NULL, 'default2', 'default2', 'Hamilton', '2023-01-02', 'Lewis', 'unique_6');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'Lewis', 'Hamilton', NULL, 0.0, 0.0, 1, 'Hamilton'), (1, 'default2', 'default2', 'Hamilton', 'Lewis', 1.0, 0.0, 1, 'default1'), (2, 'default2', 'Hamilton', 'default2', NULL, 2.0, 2.0, 2, 'default2'), (3, 'Lewis', 'default1', 'default1', NULL, 2.0, 1.0, NULL, 'Lewis'), (4, 'default1', 'Lewis', NULL, 'Lewis', 1.0, 1.0, 2, 'unique_4'), (5, 'default1', 'Hamilton', 'Hamilton', 'Hamilton', 1.0, 0.0, NULL, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1, 2, 4, 2, 'Hamilton', '2023-01-02', NULL, 'default1'), (0, 7, 5, 1, 'default2', '2023-01-01', 'Hamilton', 'Hamilton'), (2, 2, 0, 2, 'default1', '2023-01-01', 'default1', NULL), (3, 1, 0, 1, 'default1', '2023-01-02', NULL, 'default2'), (4, 4, 3, 0, 'Hamilton', '2023-01-01', NULL, 'Lewis'), (5, 4, 2, 2, 'default1', '2023-01-02', 'Hamilton', 'unique_5'), (6, 11, 5, 1, 'default2', '2023-01-01', NULL, 'unique_6'), (7, 3, 0, 0, 'default2', '2023-01-01', 'default2', 'unique_7'), (8, 0, 1, 1, 'default1', '2023-01-01', 'Lewis', 'unique_8'), (9, 13, 0, 1, 'default1', '2023-01-02', 'default2', 'unique_9'), (10, 11, 1, 2, 'Lewis', '2023-01-01', 'default2', 'unique_10'), (11, 9, 4, 0, 'default2', '2023-01-01', 'default2', 'unique_11'), (12, 7, 3, 2, 'default1', '2023-01-02', NULL, 'unique_12'), (13, 13, 0, 1, 'default2', '2023-01-01', NULL, 'unique_13'), (14, 4, 1, 1, 'Hamilton', '2023-01-02', 'default1', 'unique_14'), (15, 2, 2, 2, 'default2', '2023-01-01', 'default1', 'unique_15'), (16, 2, 0, 1, 'Lewis', '2023-01-01', 'default1', 'unique_16'), (17, 3, 2, 1, 'default1', '2023-01-02', NULL, 'unique_17'), (18, 2, 3, 1, 'default1', '2023-01-01', 'default2', 'unique_18'), (19, 6, 5, 0, 'default1', '2023-01-02', 'default1', 'unique_19'), (20, 7, 3, 0, 'default2', '2023-01-01', 'Lewis', 'unique_20'), (21, 10, 3, 2, 'default1', '2023-01-01', 'Hamilton', 'unique_21'), (22, 4, 2, 0, 'Lewis', '2023-01-02', NULL, 'unique_22'), (23, 0, 2, 0, 'Lewis', '2023-01-02', 'default1', 'unique_23');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (6, 2, 1, 1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT lt.position FROM drivers AS d INNER JOIN laptimes AS lt ON d.driverid = lt.driverid WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' AND lt.time = (SELECT MIN(lt.time) FROM drivers AS d INNER JOIN laptimes AS lt ON d.driverid = lt.driverid WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton');

/*
Prediction Result:
*/