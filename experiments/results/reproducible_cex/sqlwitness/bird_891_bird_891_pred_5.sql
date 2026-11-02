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
INSERT INTO status (statusid, status) VALUES (2010, 'Singapore Grand Prix'), (2011, 'default1'), (0, 'default1'), (2009, 'default2'), (1, 'default2'), (2, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'Singapore Grand Prix'), (2009, 'default2'), (2010, 'default1'), (2011, 'unique_3');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2009, 'Singapore Grand Prix', 2009, 'default2', 'Singapore Grand Prix', 'default2', '2023-01-01', 'default1', 'default2');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'default1', 'Singapore Grand Prix', 'Singapore Grand Prix'), (1, 'Singapore Grand Prix', 'default2', 'default1', 'default1'), (2010, 'Singapore Grand Prix', 'Singapore Grand Prix', 'default2', 'default2'), (2009, 'Singapore Grand Prix', 'unique_3', NULL, 'default2'), (2011, 'Singapore Grand Prix', 'unique_4', 'default1', 'default2'), (2, 'Singapore Grand Prix', 'unique_5', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default1', 'Singapore Grand Prix', 'Singapore Grand Prix', 'default2', 2009.0, 2011.0, 1, 'default2'), (2009, 'default2', 'default2', 'default1', NULL, 2010.0, 0.0, 2009, 'Singapore Grand Prix'), (2011, 'default1', 'default2', 'default2', NULL, NULL, 2010.0, 2010, 'default1'), (0, 'default2', 'default1', NULL, 'default1', 2011.0, NULL, 2011, 'unique_3'), (2010, 'default1', 'default2', 'Singapore Grand Prix', NULL, NULL, 2009.0, NULL, 'unique_4'), (2, 'default2', 'default2', NULL, NULL, 2011.0, 2010.0, NULL, 'unique_5'), (3, 'default2', 'Singapore Grand Prix', 'default2', 'Singapore Grand Prix', 0.0, 2010.0, 2009, 'unique_6'), (4, 'Singapore Grand Prix', 'Singapore Grand Prix', 'default2', NULL, 1.0, 2009.0, NULL, 'unique_7'), (5, 'default2', 'default1', NULL, 'default2', 2011.0, NULL, 2009, 'unique_8');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2009, 1, 2, 1, 'Singapore Grand Prix', '2023-01-02', 'default1', 'Singapore Grand Prix'), (2011, 2009, 2009, 1, 'Singapore Grand Prix', '2023-01-01', 'default2', NULL), (2010, 2011, 5, 2009, 'Singapore Grand Prix', '2023-01-01', 'default2', 'default2'), (1, 2010, 2010, 1, 'default1', '2023-01-02', 'Singapore Grand Prix', 'default1'), (0, 2010, 5, 2011, 'Singapore Grand Prix', '2023-01-01', 'default1', 'unique_4'), (2, 2009, 2011, 2010, 'default1', '2023-01-02', 'default2', 'unique_5'), (3, 2010, 0, 2011, 'default2', '2023-01-01', NULL, 'unique_6'), (4, 1, 2009, 2011, 'default1', '2023-01-01', 'default1', 'unique_7'), (5, 1, 2010, 2011, 'default2', '2023-01-01', 'Singapore Grand Prix', 'unique_8');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 2, 2009, 2011.0, 0, NULL, 2009), (2011, 3, 2009, 2011.0, 2011, 'Singapore Grand Prix', 2010), (2010, 3, 2009, 1.0, 2009, NULL, 2010), (2009, 0, 2009, 2011.0, NULL, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Singapore Grand Prix' AND T1.year = 2010 ORDER BY T2.position ASC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST;

/*
Gold Result:
('Singapore Grand Prix', 'default2')
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname FROM drivers INNER JOIN results ON drivers.driverid = results.driverid INNER JOIN races ON results.raceid = races.raceid WHERE races.year = 2010 AND races.name = 'Singapore Grand Prix' ORDER BY results.position ASC, drivers.driverid NULLS LAST, results.resultid NULLS LAST, races.raceid NULLS LAST;

/*
Prediction Result:
*/