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
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'Hamilton'), (2, 'Lewis'), (3, 'default1');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'Hamilton', 1, 'Lewis', 'Hamilton', 'default1', '2023-01-01', NULL, 'default1'), (0, 'Hamilton', 2, 'Lewis', 'default1', 'default1', NULL, NULL, 'Hamilton'), (1, 'Lewis', 1, NULL, 'Hamilton', 'Lewis', '2023-01-01', NULL, 'default2'), (3, 'Lewis', 1, NULL, 'default1', 'Lewis', '2023-01-01', NULL, 'Lewis'), (4, 'default1', 0, 'Lewis', 'Lewis', 'Hamilton', NULL, 'default1', 'unique_4'), (5, 'default1', 2, 'Hamilton', 'default1', 'default2', NULL, 'Hamilton', 'unique_5'), (6, 'default2', 1, 'default2', 'default1', 'default1', NULL, 'Hamilton', 'unique_6'), (7, 'Lewis', 2, 'Hamilton', 'Hamilton', 'default2', NULL, 'default2', 'unique_7'), (8, 'Hamilton', 1, 'default2', 'default1', 'Hamilton', NULL, 'default1', 'unique_8'), (9, 'Hamilton', 1, 'Hamilton', 'default2', 'Hamilton', NULL, 'Hamilton', 'unique_9'), (10, 'Hamilton', 0, 'Lewis', 'default1', 'default1', '2023-01-02', 'default2', 'unique_10'), (11, 'Lewis', 0, 'Lewis', 'default2', 'Hamilton', NULL, 'default1', 'unique_11');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default1', 'Lewis', 'Lewis', NULL, 0.0, NULL, 2, 'default1'), (1, 'default2', 'Hamilton', 'Hamilton', 'Hamilton', 1.0, 2.0, 2, 'Hamilton'), (2, 'default1', 'Lewis', 'Hamilton', 'Hamilton', 1.0, NULL, 2, 'default2'), (3, 'Hamilton', 'Lewis', 'Lewis', 'default1', 0.0, 0.0, 1, 'Lewis'), (4, 'default1', 'default1', 'default1', 'default2', 1.0, 0.0, 1, 'unique_4'), (5, 'Lewis', 'Lewis', 'default1', 'default2', 2.0, 0.0, 0, 'unique_5'), (6, 'Lewis', 'default2', 'default1', 'default1', 0.0, 1.0, 0, 'unique_6'), (7, 'default1', 'Lewis', 'Hamilton', NULL, 2.0, NULL, 1, 'unique_7'), (8, 'Hamilton', 'default2', 'default2', 'Lewis', 1.0, 0.0, 1, 'unique_8'), (9, 'default1', 'Hamilton', 'default1', 'default1', NULL, 0.0, NULL, 'unique_9'), (10, 'Lewis', 'Lewis', 'default2', NULL, 0.0, NULL, 1, 'unique_10'), (11, 'Hamilton', 'default2', 'Hamilton', NULL, NULL, 0.0, 2, 'unique_11'), (12, 'default2', 'Lewis', 'default1', NULL, 0.0, NULL, 1, 'unique_12'), (13, 'Hamilton', 'default1', 'Lewis', NULL, 1.0, 2.0, 1, 'unique_13'), (14, 'Hamilton', 'default2', 'default1', 'default1', 0.0, 0.0, 1, 'unique_14'), (15, 'default2', 'Hamilton', 'Hamilton', 'Lewis', 0.0, 0.0, 0, 'unique_15'), (16, 'default2', 'Hamilton', 'Hamilton', 'Lewis', 2.0, NULL, 2, 'unique_16');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2, 3, 13, 0, 'Hamilton', '2023-01-01', 'Hamilton', 'default1'), (0, 2, 5, 0, 'Hamilton', '2023-01-01', 'default1', 'Hamilton'), (1, 1, 12, 0, 'Hamilton', '2023-01-02', NULL, 'default2'), (3, 0, 13, 2, 'default2', '2023-01-02', 'Lewis', 'Lewis'), (4, 3, 9, 2, 'Hamilton', '2023-01-02', 'default1', NULL), (5, 1, 5, 0, 'default2', '2023-01-01', 'default1', 'unique_5'), (6, 3, 12, 0, 'default2', '2023-01-01', 'Hamilton', 'unique_6'), (7, 0, 2, 1, 'Lewis', '2023-01-01', NULL, 'unique_7'), (8, 1, 13, 2, 'default2', '2023-01-01', NULL, 'unique_8');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (0, 5, 1, 2, 'Lewis', 2), (0, 0, 2, 0, 'default1', 2), (8, 7, 2, 0, 'Lewis', 1), (4, 3, 0, 2, 'default2', 2), (0, 4, 1, 2, NULL, NULL), (0, 10, 1, 2, 'Lewis', 0), (6, 11, 0, 2, 'default1', NULL), (0, 10, 0, 0, 'default2', NULL), (1, 1, 0, NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.position FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' ORDER BY T1.time ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT lt.position FROM lapTimes AS lt JOIN drivers AS d ON lt.driverId = d.driverId JOIN races AS r ON lt.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' AND lt.time = (SELECT MIN(time) FROM lapTimes WHERE driverId = d.driverId);

/*
Prediction Result:
*/