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
INSERT INTO seasons (year, url) VALUES (6, '%Y'), (1, '1980'), (0, 'default1'), (5, '1985');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (4, 'default1', NULL, '%Y', '%Y', '1980', NULL, NULL, '%Y'), (6, 'default2', 5, '1980', 'default2', 'German', '2023-01-02', NULL, 'default2'), (1, 'default2', 5, '1980', '1985', 'German', '1980-10-27', NULL, '1985'), (5, '%Y', 5, '1980', 'default2', '1980', '1980-10-27', 'German', '1980'), (0, 'default2', 0, 'default2', '%Y', '1985', '2023-01-02', 'default1', 'German'), (2, 'default1', NULL, 'German', 'default1', '1980', '2023-01-01', '1985', 'default1'), (3, '1980', 4, '%Y', 'German', '%Y', '2023-01-02', NULL, 'unique_6'), (7, '1985', 4, 'default1', '1985', 'default2', '2023-01-01', NULL, 'unique_7'), (8, 'default1', 1, 'German', '%Y', 'default2', '1985-10-27', '%Y', 'unique_8'), (9, '%Y', 0, '1985', 'German', 'default1', NULL, NULL, 'unique_9'), (10, '1980', 6, 'default1', 'default2', 'default2', '2023-01-02', 'default2', 'unique_10');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '%Y', '1985', '%Y', 'German', 1.0, 1.0, 1, '1985'), (4, '1985', 'German', 'default2', 'default2', NULL, 0.0, 1, 'default2'), (5, '1985', '1980', 'default2', 'default1', NULL, NULL, NULL, '%Y'), (6, '1980', 'default2', '%Y', '%Y', 0.0, 0.0, 5, 'German');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (6, 1, 1, 6, '%Y', '2023-01-02', 'default1', '%Y'), (5, 6, 1, 5, '%Y', '2023-01-02', NULL, '1980'), (4, 6, 1, 5, '1980', '1980-10-27', '1980', 'default2'), (1, 6, 6, 0, '1985', '1985-10-27', 'default2', '1985'), (0, 1, 4, 1, 'German', '1980-10-27', 'default2', NULL), (2, 0, 6, 1, 'default1', '1980-10-27', 'German', 'German'), (3, 5, 4, 6, 'default1', '1985-10-27', '%Y', 'default1'), (7, 0, 6, 6, 'default2', '2023-01-01', 'default1', 'unique_7'), (8, 0, 1, 5, 'German', '1985-10-27', '%Y', 'unique_8'), (9, 1, 6, 5, 'default2', '2023-01-01', 'default2', 'unique_9'), (10, 5, 4, 6, 'default1', '1985-10-27', 'German', 'unique_10'), (11, 5, 6, 6, 'German', '2023-01-01', NULL, 'unique_11'), (12, 6, 1, 6, 'default2', '1985-10-27', 'default1', 'unique_12'), (13, 0, 6, 6, '1980', '1980-10-27', '1985', 'unique_13');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (10, 9, 5, 4, '%Y', NULL, 1), (12, 0, 5, 0, '1985', '1985', 0), (4, 0, 1, 0, '1980', '1980', 4), (4, 10, 0, 5, '%Y', '1985', 0), (13, 3, 5, 1, 'default1', '%Y', 1), (7, 0, 1, 6, '%Y', 'default1', 0), (6, 0, 4, 5, '%Y', 'German', 4), (9, 2, 1, 4, 'default1', '1985', 0), (12, 5, 0, 1, '1985', 'default1', 4), (4, 7, 0, 6, '%Y', '%Y', 0), (9, 0, 5, 0, 'German', 'default1', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1985' GROUP BY T2.forename, T2.surname ORDER BY AVG(T1.duration), T2.forename NULLS LAST, T2.surname NULLS LAST LIMIT 5;

/*
Gold Result:
('default2', '1980')
*/

-- Prediction Query
SELECT T1.driverId, T1.forename, T1.surname, AVG(T2.duration) AS avg_duration FROM drivers AS T1 INNER JOIN pitStops AS T2 ON T1.driverId = T2.driverId WHERE T1.nationality = 'German' AND STRFTIME('%Y', T1.dob) BETWEEN '1980' AND '1985' GROUP BY T1.driverId ORDER BY avg_duration ASC, T1.driverId NULLS LAST, T1.forename NULLS LAST, T1.surname NULLS LAST LIMIT 5;

/*
Prediction Result:
(5, 'default2', '1980', 0.0)
*/