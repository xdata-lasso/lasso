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
INSERT INTO seasons (year, url) VALUES (2, 'default2'), (4, '%Y'), (0, '1990'), (3, '1980'), (1, 'default1'), (5, '1990-12-31'), (6, 'German'), (7, '1980-01-01');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (4, '1990', 4, '1980-01-01', '1980', 'default2', NULL, '1980', '1980'), (0, '%Y', NULL, 'German', '1990', '1980', '1980-01-02', 'German', '1990'), (3, 'default1', 2, NULL, '1980', '1990', '1991-01-01', NULL, '1980-01-01'), (1, 'default2', NULL, '1990', '1990-12-31', 'default2', '2023-01-01', '1980', '1990-12-31'), (2, '1980-01-01', 4, '1980', 'default1', '1990-12-31', '1979-12-31', '1990-12-31', 'German'), (5, '1990', 4, NULL, 'default1', '%Y', '2023-01-01', '%Y', '%Y'), (6, 'German', 4, '1980', '1980-01-01', 'default2', '1991-01-01', NULL, 'default1'), (7, 'default1', 3, 'German', '1990', '1990-12-31', '1991-01-01', '%Y', 'default2'), (8, '1980', 4, 'default2', '1990', '1990', '1980-10-27', 'default1', 'unique_8'), (9, '1990', 0, '1990', '1980-01-01', 'default2', '1980-01-01', NULL, 'unique_9');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (4, '1990', 'default2', 'default1', '1990-12-31', 1.0, 1.0, 3, '1980'), (1, '1990-12-31', '1980-01-01', '1980-01-01', NULL, 2.0, 3.0, 0, 'default2'), (0, '1980', 'German', '1980-01-01', 'German', 3.0, 1.0, 2, '1990-12-31'), (3, '1990', 'German', NULL, '%Y', NULL, 1.0, 3, '1980-01-01'), (2, '1990', 'default1', 'German', 'default1', 4.0, 4.0, 0, '1990'), (5, '1990-12-31', 'default2', '%Y', '%Y', NULL, 0.0, 4, 'default1'), (6, '%Y', 'German', 'default2', 'German', 1.0, 2.0, 1, 'German'), (7, '1980-01-01', 'default2', 'default2', '1980', 0.0, 4.0, 2, '%Y'), (8, '%Y', 'default1', NULL, NULL, 0.0, NULL, 2, 'unique_8'), (9, '%Y', '1980-01-01', 'default1', '1980', 1.0, 0.0, NULL, 'unique_9'), (10, '1980', '1990', 'default2', '1980-01-01', 1.0, NULL, 1, 'unique_10'), (11, '1990', 'German', '1980-01-01', '%Y', 1.0, 1.0, NULL, 'unique_11');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 7, 1, 4, 'default1', '1980-10-27', NULL, NULL), (3, 1, 7, 1, '%Y', '1980-01-01', 'default2', '1980'), (4, 3, 6, 3, '%Y', '1979-12-31', 'German', '1990'), (1, 1, 7, 0, '1990', '1979-12-31', '1990-12-31', '1990-12-31'), (2, 7, 4, 1, '1990-12-31', '1990-10-27', '1990-12-31', '1980-01-01'), (5, 0, 6, 0, 'default2', '1980-01-02', '1980-01-01', 'default1'), (6, 7, 3, 4, '1990', '1979-12-31', '1980', 'German'), (7, 7, 8, 1, 'default2', '1979-12-31', '1980', '%Y'), (8, 1, 1, 2, '1980', '1980-01-02', '1990-12-31', 'default2'), (9, 0, 8, 3, 'default2', '2023-01-01', 'default1', 'unique_9'), (10, 4, 6, 1, '1990-12-31', '2023-01-01', 'default1', 'unique_10');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (4, 9, 3, 3, '1980-01-01', 'default1', 2), (4, 9, 4, 0, 'German', '1990-12-31', 1), (0, 2, 0, 4, '1990-12-31', '1980', 3), (3, 5, 4, 3, '1980-01-01', 'default1', 2), (0, 0, 0, 4, '1980-01-01', '%Y', NULL), (5, 5, 2, 0, 'default2', NULL, 0), (4, 5, 4, 4, '1990', 'default1', 0), (1, 3, 2, 2, 'default1', '1990', 1), (0, 7, 4, 0, 'default2', '1990', 0), (7, 5, 2, 0, 'default2', 'default2', 2);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (0, 4, 1, NULL, '1990', NULL), (7, 1, 2, 4, 'default1', NULL), (5, 3, 3, 1, 'default1', 1), (3, 8, 3, 0, '1990', 0), (2, 0, 3, 4, '1990-12-31', 0), (3, 3, 3, NULL, '1990', 1), (10, 0, 1, 2, 'German', 1), (1, 6, 1, NULL, '1990', 1), (3, 8, 0, NULL, 'German', 2), (4, 3, 1, 0, 'German', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1990' ORDER BY T1.time, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT d.forename, d.surname FROM drivers AS d INNER JOIN lapTimes AS lt ON d.driverId = lt.driverId WHERE d.dob BETWEEN '1980-01-01' AND '1990-12-31' AND d.nationality = 'German' ORDER BY lt.time ASC, d.driverid NULLS LAST, lt.raceid NULLS LAST, lt.driverid NULLS LAST, lt.lap NULLS LAST LIMIT 3;

/*
Prediction Result:
('1990', '1980')
('1990', '1980')
*/