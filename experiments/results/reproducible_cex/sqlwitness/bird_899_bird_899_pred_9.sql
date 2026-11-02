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
INSERT INTO seasons (year, url) VALUES (5, '1990'), (1989, 'default2'), (1, '%Y'), (2000, '2000');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2001, 'default2', '%Y', 'default1', '2000', 1.0, 1990.0, 2000, 'default1'), (2000, '%Y', '1990', 'default1', 'default1', 1.0, 4.0, 0, '%Y'), (1991, '2000', 'default2', '2000', '2000', 3.0, 2001.0, 3, '2000'), (5, '1990', '2000', 'default2', NULL, 0.0, 1990.0, 1991, '1990'), (1, 'default2', 'default1', '%Y', NULL, 1.0, 0.0, 1, 'default2'), (1990, '2000', '%Y', NULL, 'default2', 1991.0, 0.0, 1991, 'unique_5'), (4, 'default1', '%Y', '2000', '2000', 1.0, 4.0, 4, 'unique_6'), (1999, '2000', '2000', '2000', '%Y', 1991.0, NULL, 1, 'unique_7'), (3, '2000', '2000', '2000', NULL, 4.0, 0.0, 2001, 'unique_8'), (1989, 'default1', '1990', '1990', '%Y', 2000.0, 0.0, 1991, 'unique_9'), (0, '%Y', '1990', '1990', 'default2', 2000.0, 3.0, NULL, 'unique_10'), (2, '2000', '1990', '1990', '%Y', 5.0, 2001.0, 1991, 'unique_11'), (6, 'default1', '1990', NULL, NULL, 1989.0, 5.0, 1999, 'unique_12'), (7, 'default2', 'default1', 'default2', '1990', 1.0, 0.0, 4, 'unique_13'), (8, '%Y', '%Y', 'default2', 'default1', 3.0, 3.0, 1999, 'unique_14'), (9, 'default1', 'default1', 'default2', '2000', 3.0, 1.0, 1, 'unique_15'), (10, '1990', 'default1', '1990', '2000', 5.0, 0.0, 1999, 'unique_16');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (1989, 1, 1, 1990, '%Y', '2000-10-27', 'default1', 'default1'), (2001, 1, 4, 1991, '%Y', '1990-10-27', 'default2', 'default2'), (1991, 2000, 9, 0, '1990', '1990-10-27', NULL, NULL), (1, 1, 2001, 1, 'default1', '1990-10-27', 'default2', '2000'), (1999, 1989, 1999, 1999, '1990', '2023-01-01', '1990', '%Y'), (1990, 1989, 5, 4, 'default2', '2023-01-01', NULL, '1990'), (2000, 1, 2001, 1999, '1990', '2000-10-27', '2000', 'unique_6'), (4, 2000, 5, 2000, 'default1', '2000-10-27', '%Y', 'unique_7'), (3, 5, 10, 2001, 'default2', '2000-10-27', 'default1', 'unique_8'), (5, 1989, 9, 1989, 'default1', '1990-10-27', NULL, 'unique_9'), (0, 5, 2000, 1990, 'default1', '2023-01-02', '1990', 'unique_10'), (2, 5, 6, 0, 'default1', '2023-01-01', '2000', 'unique_11'), (6, 2000, 1991, 5, '1990', '2000-10-27', '2000', 'unique_12'), (7, 1, 1999, 2000, '2000', '2000-10-27', '2000', 'unique_13'), (8, 2000, 2, 2000, '%Y', '2023-01-01', '1990', 'unique_14'), (9, 1, 0, 0, '1990', '1990-10-27', '1990', 'unique_15'), (10, 1989, 1990, 1, 'default1', '2023-01-01', 'default1', 'unique_16'), (11, 1, 3, 1, '%Y', '2000-10-27', '2000', 'unique_17'), (12, 2000, 1989, 1999, 'default2', '2023-01-01', NULL, 'unique_18'), (13, 1, 4, 1, '1990', '2023-01-01', '1990', 'unique_19'), (14, 5, 3, 4, 'default2', '2000-10-27', '%Y', 'unique_20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('2000',)
('default1',)
*/

-- Prediction Query
SELECT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T2.year BETWEEN 1990 AND 2000 GROUP BY T1.circuitId HAVING COUNT(T2.circuitId) = 4;

/*
Prediction Result:
*/