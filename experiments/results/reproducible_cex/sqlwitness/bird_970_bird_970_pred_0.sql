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
INSERT INTO seasons (year, url) VALUES (4, 'default2'), (0, 'German'), (3, 'default1'), (2, '1980'), (1, '1990'), (5, '%Y'), (6, 'unique_6'), (7, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, '1980', NULL, '%Y', '1990', '1980', '2023-01-01', '1990', 'default2'), (3, 'German', 2, NULL, '1990', 'default2', '1980-10-27', 'German', '1980'), (4, 'default1', 1, 'default2', '%Y', 'default2', '2023-01-02', '1990', 'default1'), (1, '1990', 1, 'German', '1990', '1990', '2023-01-01', 'default2', '1990'), (0, '1990', 3, NULL, 'default2', 'default1', '1990-10-27', '1990', '%Y'), (5, '1980', 3, NULL, '1980', '1990', '1990-10-27', '%Y', 'German'), (6, '%Y', NULL, '%Y', '1980', 'default1', '2023-01-02', '1980', 'unique_6'), (7, 'default2', 0, 'default1', '1990', '%Y', '1980-10-27', '1980', 'unique_7'), (8, 'German', 3, 'default1', '%Y', 'default1', NULL, '%Y', 'unique_8'), (9, '%Y', 4, 'default1', '%Y', '%Y', '2023-01-01', '%Y', 'unique_9'), (10, '1980', 3, '1990', 'default1', '%Y', NULL, 'default2', 'unique_10'), (11, 'default2', NULL, 'default1', 'German', '%Y', '2023-01-02', '1990', 'unique_11'), (12, 'German', 0, '%Y', '1980', '1990', '1980-10-27', '%Y', 'unique_12'), (13, 'German', 4, 'default1', '1980', '1980', '2023-01-02', 'German', 'unique_13'), (14, 'German', 1, '1990', 'default2', '1990', '1980-10-27', '1990', 'unique_14'), (15, '1980', NULL, 'German', 'German', '%Y', '2023-01-02', 'default2', 'unique_15'), (16, '%Y', 0, '%Y', '1990', '1980', '2023-01-01', '1980', 'unique_16');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (4, '1990', 'default1', 'German', '1990', 2.0, 2.0, 1, 'German'), (2, '1980', '1980', '%Y', 'default2', 4.0, 1.0, 0, '1990'), (1, '1980', 'default2', '%Y', NULL, 1.0, 0.0, NULL, '1980'), (0, '%Y', '1990', '%Y', 'default2', 0.0, 2.0, NULL, '%Y'), (3, 'default2', '1980', '%Y', 'default1', 4.0, NULL, 2, 'default2'), (5, 'default1', '1990', NULL, '%Y', 1.0, 3.0, 3, 'default1'), (6, 'default1', 'German', 'default2', '1980', 3.0, 3.0, 1, 'unique_6'), (7, '1990', '1980', '%Y', 'default1', 0.0, 3.0, 2, 'unique_7'), (8, 'default1', 'default2', NULL, '1980', 0.0, NULL, 2, 'unique_8'), (9, 'German', 'default2', '%Y', '1980', 0.0, 4.0, 0, 'unique_9'), (10, 'default1', 'German', '1980', 'default1', 3.0, 3.0, 4, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (4, 3, 3, 0, 'default1', '1980-10-27', 'German', '1980'), (0, 0, 4, 0, '1980', '2023-01-02', '%Y', 'default1'), (1, 4, 0, 0, '1990', '2023-01-01', 'default2', NULL), (2, 4, 0, 2, 'German', '2023-01-02', '1980', '%Y'), (3, 5, 0, 1, '1980', '2023-01-02', 'default2', '1990'), (5, 6, 0, 1, '%Y', '2023-01-02', 'default2', 'default2'), (6, 7, 5, 4, '%Y', '2023-01-01', 'default2', 'German'), (7, 7, 0, 3, 'German', '1980-10-27', '%Y', 'unique_7'), (8, 0, 0, 0, 'German', '2023-01-02', 'default2', 'unique_8'), (9, 5, 10, 2, 'default1', '2023-01-01', 'default2', 'unique_9'), (10, 3, 4, 2, '%Y', '2023-01-01', 'German', 'unique_10'), (11, 7, 9, 0, '1990', '2023-01-01', 'default1', 'unique_11'), (12, 4, 1, 0, '1990', '1980-10-27', '1990', 'unique_12'), (13, 6, 4, 0, 'default2', '2023-01-01', '%Y', 'unique_13'), (14, 7, 2, 4, '1990', '2023-01-01', 'default2', 'unique_14'), (15, 6, 5, 3, 'default2', '1980-10-27', NULL, 'unique_15'), (16, 6, 5, 4, '%Y', '1980-10-27', NULL, 'unique_16'), (17, 5, 4, 4, '%Y', '1990-10-27', '%Y', 'unique_17');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (14, 16, 3, 3, 'default1', '1990', NULL), (5, 11, 3, 0, '1980', NULL, 2), (8, 7, 1, 0, '1980', NULL, 2), (3, 5, 2, 0, 'German', '%Y', 1), (0, 1, 2, 2, 'default2', '%Y', 2), (6, 1, 2, 3, 'default1', 'default2', 1), (13, 1, 2, 4, '1990', 'default1', 0), (16, 3, 3, 0, '%Y', 'default1', 2), (3, 2, 0, 2, '1980', 'default2', 2), (4, 15, 4, 3, 'default1', '%Y', 3), (6, 13, 3, 3, '1980', 'German', 0), (13, 7, 0, 2, 'default1', NULL, 0), (5, 3, 4, 1, 'German', NULL, 1), (1, 3, 0, 0, '%Y', NULL, 4), (13, 2, 3, 3, '1990', '1980', 4), (4, 16, 4, 1, 'default2', '1990', 0), (4, 0, 0, 1, '1990', 'default1', 2);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (5, 1, 1, 2, 'German', NULL), (11, 2, 4, NULL, 'default2', 0), (16, 10, 3, 3, 'German', 3), (14, 4, 4, NULL, 'German', 3), (2, 12, 1, NULL, '1990', NULL), (12, 16, 2, 3, 'default1', NULL), (3, 15, 4, 0, NULL, 4), (5, 4, 3, 3, 'default2', NULL), (1, 2, 3, 4, 'default1', 2), (16, 10, 0, 4, 'default1', 3), (7, 15, 4, 0, '1990', 3), (14, 16, 4, 4, 'default2', 0), (4, 8, 2, 4, '1980', 2), (6, 11, 1, 0, '1990', 4), (13, 11, 4, NULL, '%Y', 4), (3, 4, 3, 4, '%Y', 2), (14, 6, 1, 0, 'default2', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1990' ORDER BY T1.time, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
(3,)
(3,)
(3,)
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'German' AND STRFTIME('%Y', T1.dob) BETWEEN '1980' AND '1990' ORDER BY T2.time ASC, T1.driverid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST LIMIT 3;

/*
Prediction Result:
*/