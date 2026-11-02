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
INSERT INTO seasons (year, url) VALUES (0, '2000'), (1, '1990'), (3, 'default1'), (5, '%Y'), (4, 'default2'), (2, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13'), (14, 'unique_14'), (15, 'unique_15'), (16, 'unique_16'), (17, 'unique_17'), (18, 'unique_18'), (19, 'unique_19'), (20, 'unique_20'), (21, 'unique_21'), (22, 'unique_22'), (23, 'unique_23');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (5, '2000', '1990', '1990', 'default1', 4.0, 0.0, 0, 'default1'), (1, '%Y', 'default2', 'default2', '2000', 4.0, 4.0, NULL, '%Y'), (0, 'default1', '%Y', '2000', '%Y', 1.0, 1.0, NULL, 'default2'), (4, '2000', 'default2', 'default1', 'default2', 4.0, 1.0, NULL, '1990'), (3, '2000', 'default1', NULL, 'default1', 4.0, 3.0, 4, '2000'), (2, '2000', 'default2', 'default1', 'default2', 5.0, 5.0, 5, 'unique_5'), (6, '%Y', 'default2', 'default2', 'default1', NULL, 5.0, NULL, 'unique_6'), (7, 'default1', '2000', 'default1', '2000', 5.0, 0.0, 0, 'unique_7'), (8, 'default2', '%Y', '2000', NULL, NULL, 1.0, 0, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (5, 17, 2, 1, 'default1', '2000-10-27', '2000', '2000'), (1, 7, 3, 5, 'default1', '1990-10-27', NULL, '%Y'), (4, 6, 5, 5, '1990', '1990-10-27', '%Y', 'default2'), (0, 9, 5, 5, 'default2', '2000-10-27', 'default1', 'default1'), (3, 21, 0, 5, '1990', '2023-01-02', 'default1', NULL), (2, 3, 0, 5, '2000', '1990-10-27', 'default2', '1990'), (6, 13, 5, 4, 'default1', '2023-01-02', 'default1', 'unique_6'), (7, 11, 6, 0, '2000', '2000-10-27', 'default2', 'unique_7'), (8, 9, 8, 1, 'default2', '2023-01-01', NULL, 'unique_8'), (9, 9, 6, 5, '%Y', '2023-01-01', '1990', 'unique_9'), (10, 12, 6, 4, 'default2', '2023-01-01', NULL, 'unique_10'), (11, 21, 2, 5, '%Y', '2023-01-02', NULL, 'unique_11'), (12, 22, 6, 3, 'default1', '1990-10-27', 'default2', 'unique_12'), (13, 11, 4, 0, 'default2', '2023-01-01', 'default1', 'unique_13'), (14, 16, 2, 4, '%Y', '2023-01-01', '%Y', 'unique_14'), (15, 11, 5, 0, '2000', '1990-10-27', NULL, 'unique_15'), (16, 13, 8, 4, 'default2', '2023-01-02', 'default1', 'unique_16'), (17, 23, 8, 3, '1990', '1990-10-27', 'default1', 'unique_17'), (18, 1, 0, 3, 'default1', '2023-01-02', '1990', 'unique_18'), (19, 6, 5, 0, 'default2', '1990-10-27', 'default2', 'unique_19'), (20, 1, 4, 3, 'default1', '2000-10-27', 'default2', 'unique_20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('1990',)
('default2',)
*/

-- Prediction Query
SELECT circuits.name FROM circuits INNER JOIN races ON circuits.circuitid = races.circuitid WHERE STRFTIME('%Y', races.date) BETWEEN '1990' AND '2000' GROUP BY races.circuitid HAVING COUNT(races.raceid) = 4;

/*
Prediction Result:
('1990',)
*/