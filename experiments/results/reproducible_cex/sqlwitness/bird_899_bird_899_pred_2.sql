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
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (0, '1990'), (5, '2000'), (2000, 'default2'), (4, '%Y'), (1990, 'unique_5'), (1991, 'unique_6'), (3, 'unique_7'), (1999, 'unique_8'), (2001, 'unique_9'), (1989, 'unique_10'), (2, 'unique_11'), (6, 'unique_12'), (7, 'unique_13'), (8, 'unique_14'), (9, 'unique_15');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1990, '%Y', 'default1', '1990', 'default1', 2001.0, 2001.0, NULL, '%Y'), (5, '1990', '2000', 'default1', '%Y', 1991.0, 3.0, 1990, '1990'), (1, 'default2', '2000', NULL, '1990', 1990.0, 1999.0, 5, '2000'), (2000, '1990', '1990', NULL, '1990', 1991.0, 0.0, 1, 'default2'), (4, '%Y', '2000', 'default1', 'default1', 2001.0, 3.0, 5, 'default1'), (2001, '1990', 'default2', 'default1', '1990', 0.0, 1991.0, 1990, 'unique_5'), (3, 'default1', 'default2', 'default1', 'default2', 4.0, NULL, 1991, 'unique_6'), (0, '2000', 'default1', 'default1', NULL, 1990.0, 2001.0, 4, 'unique_7'), (1999, '%Y', '2000', '1990', 'default1', 1999.0, 1999.0, 1, 'unique_8'), (1989, '1990', '%Y', '2000', '%Y', NULL, 3.0, 2001, 'unique_9'), (1991, 'default1', '1990', '2000', NULL, 4.0, 1.0, 4, 'unique_10'), (2, '2000', '2000', '%Y', '1990', 1990.0, 5.0, 4, 'unique_11');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (5, 4, 1990, 1999, '2000', '1990-10-27', '2000', 'default1'), (4, 2000, 5, 1, 'default2', '2023-01-02', 'default1', NULL), (1991, 1, 1990, 5, '2000', '2023-01-02', '%Y', '1990'), (1, 2000, 3, 5, 'default2', '1990-10-27', 'default1', '%Y'), (0, 7, 4, 0, 'default2', '2023-01-01', 'default1', '2000'), (3, 3, 3, 2000, '1990', '2023-01-02', '1990', 'default2'), (1990, 6, 1, 1999, '1990', '1990-10-27', NULL, 'unique_6'), (1989, 0, 1990, 4, '2000', '1990-10-27', 'default2', 'unique_7'), (2000, 5, 5, 5, 'default1', '1990-10-27', '2000', 'unique_8'), (2001, 4, 1990, 1999, 'default2', '1990-10-27', '1990', 'unique_9'), (1999, 1, 2000, 1999, '2000', '2023-01-02', NULL, 'unique_10'), (2, 3, 0, 3, '%Y', '2000-10-27', 'default1', 'unique_11'), (6, 1991, 1999, 1999, '1990', '2023-01-02', '%Y', 'unique_12'), (7, 1, 3, 2001, '%Y', '1990-10-27', '%Y', 'unique_13'), (8, 8, 3, 1991, 'default1', '1990-10-27', 'default2', 'unique_14'), (9, 7, 5, 1989, 'default2', '2023-01-01', '1990', 'unique_15'), (10, 2000, 2001, 1990, '1990', '2000-10-27', '%Y', 'unique_16'), (11, 6, 1991, 1990, 'default1', '2000-10-27', NULL, 'unique_17'), (12, 2000, 3, 2001, '1990', '1990-10-27', '2000', 'unique_18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE STRFTIME('%Y', T2.date) BETWEEN '1990' AND '2000' GROUP BY T1.name HAVING COUNT(T2.raceId) = 4;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT "circuits"."name" FROM "circuits" INNER JOIN "races" ON "circuits"."circuitid" = "races"."circuitid" WHERE "races"."year" BETWEEN 1990 AND 2000 GROUP BY "circuits"."name" HAVING COUNT("races"."raceid") = 4;

/*
Prediction Result:
*/