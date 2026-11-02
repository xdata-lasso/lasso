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
INSERT INTO seasons (year, url) VALUES (2001, 'default2'), (2018, 'default1'), (2000, 'unique_2'), (2017, 'unique_3'), (2016, 'unique_4'), (1, 'unique_5'), (1999, 'unique_6'), (0, 'unique_7'), (2, 'unique_8'), (3, 'unique_9'), (4, 'unique_10'), (5, 'unique_11'), (6, 'unique_12'), (7, 'unique_13'), (8, 'unique_14');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2018, 'default1', 'default1', NULL, NULL, 2001.0, 2016.0, 2018, 'default2'), (0, 'default1', 'default1', 'default2', 'default1', 2018.0, 2000.0, 2017, 'default1'), (1999, 'default1', 'default2', 'default1', 'default2', 2000.0, 1999.0, 1999, 'unique_2'), (2017, 'default1', 'default2', NULL, NULL, 2017.0, 2018.0, 1999, 'unique_3'), (2000, 'default2', 'default2', 'default1', 'default1', 1999.0, 1.0, 1999, 'unique_4'), (2001, 'default2', 'default2', 'default2', 'default2', 0.0, 2016.0, 2016, 'unique_5'), (2016, 'default2', 'default1', NULL, NULL, 2001.0, 1.0, 2017, 'unique_6'), (1, 'default1', 'default1', 'default2', 'default2', 1.0, 2017.0, 2018, 'unique_7'), (2, 'default2', 'default2', 'default2', NULL, 2017.0, 2016.0, 2016, 'unique_8'), (3, 'default2', 'default1', NULL, NULL, 2016.0, 1.0, 1999, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2000, 4, 0, 2001, 'default2', '2023-01-01', NULL, 'default2'), (1, 5, 2, 1999, 'default2', '2023-01-01', 'default2', NULL), (2017, 2017, 2001, 2001, 'default1', '2023-01-02', 'default2', 'default1'), (0, 2018, 1999, 2016, 'default2', '2023-01-02', 'default2', 'unique_3'), (2018, 4, 2017, 2018, 'default2', '2023-01-01', 'default2', 'unique_4'), (2001, 2001, 2017, 2000, 'default2', '2023-01-02', 'default1', 'unique_5'), (1999, 2000, 1999, 2016, 'default1', '2023-01-01', 'default1', 'unique_6'), (2016, 2017, 1999, 0, 'default2', '2023-01-02', NULL, 'unique_7'), (2, 2001, 2001, 1999, 'default1', '2023-01-01', 'default1', 'unique_8'), (3, 1, 2017, 2018, 'default2', '2023-01-01', 'default2', 'unique_9'), (4, 2018, 1999, 2018, 'default1', '2023-01-02', NULL, 'unique_10'), (5, 7, 2, 0, 'default1', '2023-01-02', 'default1', 'unique_11'), (6, 2018, 2000, 1, 'default2', '2023-01-02', NULL, 'unique_12'), (7, 5, 2, 2016, 'default2', '2023-01-01', 'default2', 'unique_13'), (8, 2016, 2000, 1999, 'default2', '2023-01-01', NULL, 'unique_14'), (9, 2016, 2018, 1999, 'default1', '2023-01-02', 'default2', 'unique_15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT name FROM races WHERE year = 2017 AND NOT "year" IN (SELECT "year" FROM seasons WHERE year = 2000);

/*
Prediction Result:
('default2',)
('default1',)
*/