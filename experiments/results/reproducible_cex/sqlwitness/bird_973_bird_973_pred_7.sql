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
INSERT INTO seasons (year, url) VALUES (10, '%Y'), (1, 'default1'), (0, '1982');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (11, 'Spanish', 1, 'default1', '1982-01-01', 'Spanish', NULL, '%Y', 'default2'), (0, 'default2', 1, 'default2', 'default2', 'Spanish', '1981-12-31', 'default1', '%Y'), (1, 'default1', 9, 'default2', 'Spanish', '1982', '1981-12-31', 'Spanish', 'Spanish'), (9, '1982', 11, '%Y', 'Spanish', '1982', '2023-01-01', '1982-01-01', 'default1'), (10, 'default1', 10, 'default1', '1982-01-01', 'default2', '2023-01-02', '1982', '1982-01-01'), (2, '%Y', 0, 'Spanish', '%Y', 'default1', '2023-01-02', NULL, '1982'), (3, '1982', 1, '%Y', 'Spanish', '%Y', '1982-01-01', 'default1', 'unique_6'), (4, '1982-01-01', 1, '1982-01-01', '1982', '%Y', '1982-10-27', 'Spanish', 'unique_7'), (5, 'Spanish', 11, NULL, 'default1', 'Spanish', NULL, 'Spanish', 'unique_8'), (6, 'Spanish', 1, 'Spanish', '1982-01-01', 'default1', '2023-01-01', 'Spanish', 'unique_9'), (7, 'Spanish', 11, 'default1', '1982', '1982-01-01', '2023-01-01', '1982', 'unique_10'), (8, 'Spanish', 1, '1982', '%Y', '1982-01-01', '2023-01-02', '1982', 'unique_11'), (12, 'Spanish', 0, '1982', '1982-01-01', 'default2', '2023-01-02', NULL, 'unique_12'), (13, '%Y', 10, '1982', '%Y', '%Y', NULL, NULL, 'unique_13'), (14, '1982', 9, '%Y', 'Spanish', '1982', '1982-01-02', '1982-01-01', 'unique_14'), (15, 'Spanish', 1, '%Y', 'default2', 'Spanish', NULL, NULL, 'unique_15'), (16, '1982', 11, '1982-01-01', 'default2', 'default2', NULL, '1982-01-01', 'unique_16'), (17, 'Spanish', 0, '1982-01-01', 'Spanish', '%Y', '1982-10-27', 'default1', 'unique_17');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default1', 'default2', 'default2', NULL, 10.0, 11, 'default2'), (10, 'default1', 'default1', '%Y', '1982-01-01', NULL, 11.0, NULL, '1982'), (9, 'default1', '%Y', '1982-01-01', NULL, NULL, 10.0, NULL, '%Y');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (9, 0, 9, 0, '1982-01-01', '2023-01-02', '%Y', '%Y'), (1, 1, 1, 10, 'default2', '1982-10-27', '1982-01-01', NULL), (10, 10, 10, 0, 'default1', '1982-01-02', '%Y', 'default1'), (0, 1, 1, 0, '1982-01-01', '1982-10-27', '1982-01-01', 'default2'), (11, 0, 10, 1, 'default2', '1982-01-01', 'default2', '1982'), (2, 10, 10, 10, 'default2', '1982-10-27', 'default2', '1982-01-01'), (3, 10, 1, 0, '1982', '2023-01-01', NULL, 'Spanish'), (4, 10, 1, 10, 'Spanish', '2023-01-01', 'default2', 'unique_7'), (5, 0, 9, 1, '1982-01-01', '1982-01-02', NULL, 'unique_8');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (4, 11, 10, 10, 'default1', 'default1', 10), (1, 17, 9, 9, '1982-01-01', 'default2', 9), (4, 4, 10, 11, 'default1', 'Spanish', 1), (2, 12, 10, 0, 'default1', 'default1', 0), (1, 8, 9, 1, '%Y', '1982-01-01', 9), (0, 4, 0, 10, 'default2', '1982-01-01', 10), (2, 7, 11, 1, '1982', '1982-01-01', 11), (10, 5, 11, 11, '1982-01-01', '%Y', 1), (1, 3, 9, 10, '%Y', '%Y', NULL);
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (1, 14, 1, 11, 'default1', NULL), (3, 1, 9, NULL, 'Spanish', 11), (10, 5, 1, 10, 'default1', 9), (5, 12, 10, 1, NULL, 10), (4, 3, 10, 9, NULL, 10), (4, 3, 1, 11, 'default2', 11), (4, 17, 1, NULL, NULL, 0), (9, 13, 9, 1, 'default1', 0), (0, 11, 1, 0, '1982', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'Spanish' AND STRFTIME('%Y', T2.dob) < '1982' ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT d.forename, d.surname, lt.time FROM drivers AS d INNER JOIN (SELECT driverid, MAX(time) AS time FROM laptimes GROUP BY driverid) AS lt ON d.driverid = lt.driverid WHERE d.nationality = 'Spanish' AND d.dob < '1982-01-01' ORDER BY lt.time DESC, d.driverid NULLS LAST LIMIT 10;

/*
Prediction Result:
('Spanish', '1982', 'Spanish')
*/