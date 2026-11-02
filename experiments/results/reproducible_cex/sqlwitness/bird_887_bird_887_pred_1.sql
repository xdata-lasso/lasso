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
INSERT INTO seasons (year, url) VALUES (1, 'default1'), (2016, 'default2'), (1999, 'unique_2'), (2000, 'unique_3'), (2001, 'unique_4'), (2017, 'unique_5'), (2018, 'unique_6');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2001, 'default2', 'default1', NULL, NULL, 1.0, NULL, NULL, 'default2'), (2018, 'default1', 'default2', 'default1', 'default2', 2017.0, 2016.0, 2017, 'default1'), (2000, 'default2', 'default2', 'default1', NULL, 2017.0, 2016.0, 0, 'unique_2'), (2017, 'default2', 'default2', 'default1', 'default1', 2001.0, 1.0, 2017, 'unique_3'), (0, 'default2', 'default2', 'default1', 'default2', 0.0, 2017.0, 2001, 'unique_4'), (2016, 'default2', 'default1', NULL, 'default1', 2017.0, 0.0, 2017, 'unique_5'), (1999, 'default2', 'default1', 'default2', NULL, 0.0, 0.0, 2001, 'unique_6'), (1, 'default2', 'default2', 'default1', NULL, 1999.0, 2016.0, 0, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2000, 2018, 2018, 2000, 'default2', '2023-01-02', 'default1', 'default2'), (0, 1999, 0, 2018, 'default2', '2023-01-02', 'default2', NULL), (2017, 1, 2016, 1999, 'default1', '2023-01-02', 'default2', 'default1'), (2001, 2018, 2018, 2016, 'default2', '2023-01-01', 'default2', 'unique_3'), (1, 1999, 2018, 2017, 'default1', '2023-01-02', 'default2', 'unique_4'), (2016, 2018, 1999, 1999, 'default1', '2023-01-02', 'default2', 'unique_5'), (1999, 2016, 2000, 2000, 'default2', '2023-01-01', NULL, 'unique_6'), (2018, 2017, 1, 0, 'default2', '2023-01-01', NULL, 'unique_7'), (2, 2016, 2001, 2000, 'default2', '2023-01-02', 'default2', 'unique_8'), (3, 1999, 2000, 0, 'default2', '2023-01-02', 'default2', 'unique_9'), (4, 2017, 2017, 1999, 'default1', '2023-01-01', 'default2', 'unique_10'), (5, 2000, 2016, 2017, 'default1', '2023-01-01', 'default2', 'unique_11'), (6, 2018, 2018, 2000, 'default1', '2023-01-01', 'default1', 'unique_12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM races WHERE year = 2017 AND NOT name IN (SELECT name FROM races WHERE year = 2000);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT r.name FROM races AS r WHERE r.year = 2017 AND NOT r.circuitId IN (SELECT r2.circuitId FROM races AS r2 WHERE r2.year = 2000);

/*
Prediction Result:
('default1',)
('default2',)
*/