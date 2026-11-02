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
INSERT INTO seasons (year, url) VALUES (1, 'default2'), (3, 'German'), (4, '%Y'), (2, '1980'), (0, 'default1'), (5, '1990'), (6, 'unique_6'), (7, 'unique_7');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, '%Y', 3, 'German', 'German', '1980', '1980-10-27', 'default2', '1990'), (1, 'default2', 3, NULL, '1980', 'German', '2023-01-01', 'German', 'default1'), (4, 'German', 4, 'German', '1980', 'German', '2023-01-01', '%Y', 'default2'), (3, '%Y', 2, 'default1', '%Y', 'German', '1990-10-27', 'German', '%Y'), (0, '%Y', 4, '1980', '1980', 'German', '2023-01-01', 'German', 'German');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, '1990', '1980', '1990', '%Y', 4.0, 1.0, 4, '1980'), (3, '%Y', 'German', '%Y', NULL, NULL, 1.0, NULL, 'default2'), (1, '1990', '%Y', NULL, NULL, 0.0, 1.0, NULL, '%Y'), (0, '1980', '1980', NULL, '1990', 4.0, NULL, 4, 'German'), (4, 'default1', 'German', NULL, '1980', 3.0, NULL, 0, '1990'), (5, '1980', 'default2', '%Y', '1980', 0.0, NULL, 4, 'default1'), (6, 'default2', 'German', '%Y', 'default2', 0.0, 1.0, 4, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 1, 1, 0, '1980', '2023-01-01', 'default1', '1990'), (1, 7, 3, 0, 'default1', '1990-10-27', NULL, '1980'), (3, 2, 1, 2, '1990', '2023-01-01', '1980', 'German'), (4, 0, 3, 3, 'default1', '2023-01-02', 'default2', 'default1'), (2, 4, 3, 0, 'default2', '1980-10-27', '1990', 'default2'), (5, 1, 1, 4, 'German', '2023-01-02', 'default2', '%Y'), (6, 1, 1, 4, '%Y', '1990-10-27', 'default2', NULL);
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (3, 1, 4, 4, 'default2', '1980', 2), (6, 3, 2, 2, '1980', NULL, 4), (1, 3, 2, 2, '%Y', 'default1', NULL), (6, 0, 1, 3, '1980', 'default1', 3), (5, 2, 2, 3, '%Y', '1990', 1);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (3, 2, 0, 0, '1980', 2), (2, 3, 0, 4, 'default2', 0), (1, 2, 0, NULL, '1990', 4), (5, 4, 2, 1, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'German' AND STRFTIME('%Y', T2.dob) BETWEEN '1980' AND '1990' ORDER BY T1.time, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
(3,)
(3,)
*/

-- Prediction Query
SELECT d.driverid, d.forename, d.surname, MIN(l.time) AS earliest_lap_time FROM drivers AS d INNER JOIN laptimes AS l ON d.driverid = l.driverid WHERE d.nationality = 'German' AND STRFTIME('%Y', d.dob) BETWEEN '1980' AND '1990' GROUP BY d.driverid ORDER BY earliest_lap_time ASC, d.driverid NULLS LAST, d.forename NULLS LAST, d.surname NULLS LAST LIMIT 3;

/*
Prediction Result:
(3, '%Y', 'German', 'default2')
*/