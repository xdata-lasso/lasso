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
INSERT INTO seasons (year, url) VALUES (2010, 'default1'), (0, 'default2'), (2012, 'Australian Grand Prix'), (1, 'unique_3'), (2011, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (1, 'Australian Grand Prix', 2011, 'Australian Grand Prix', 'default2', 'default2', '2023-01-01', 'Australian Grand Prix', 'default1'), (2012, 'default1', 0, NULL, 'Australian Grand Prix', 'default2', '2023-01-02', 'default1', 'default2'), (0, 'default2', NULL, 'default1', 'Australian Grand Prix', 'default2', '2023-01-02', 'Australian Grand Prix', 'Australian Grand Prix'), (2010, 'Australian Grand Prix', NULL, 'default2', 'default2', 'Australian Grand Prix', '2023-01-02', 'default2', 'unique_3'), (2011, 'default2', NULL, NULL, 'default1', 'default1', '2023-01-02', 'Australian Grand Prix', 'unique_4'), (2, 'Australian Grand Prix', 2010, 'default1', 'default1', 'default1', NULL, 'default2', 'unique_5'), (3, 'default2', 0, 'default1', 'default2', 'default2', '2023-01-01', 'default1', 'unique_6');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'default2', 'default1', 'default2', 'default2', 2012.0, 0.0, 2010, 'Australian Grand Prix'), (2010, 'default2', 'Australian Grand Prix', 'default1', 'default1', NULL, 2010.0, 2012, 'default2'), (2011, 'default1', 'default1', 'default2', NULL, 2011.0, 2010.0, 2010, 'default1'), (1, 'Australian Grand Prix', 'Australian Grand Prix', 'default2', NULL, 0.0, NULL, 2012, 'unique_3'), (2012, 'default1', 'default2', 'default2', 'Australian Grand Prix', 2012.0, 2012.0, 2012, 'unique_4'), (2, 'default2', 'Australian Grand Prix', NULL, 'Australian Grand Prix', 0.0, NULL, 2011, 'unique_5'), (3, 'Australian Grand Prix', 'default2', 'default1', 'Australian Grand Prix', 1.0, 2011.0, 1, 'unique_6'), (4, 'default2', 'default1', 'Australian Grand Prix', 'Australian Grand Prix', 0.0, 2011.0, 0, 'unique_7'), (5, 'Australian Grand Prix', 'default1', NULL, 'default1', 1.0, 2010.0, 2011, 'unique_8'), (6, 'default1', 'Australian Grand Prix', 'default1', 'default2', 2011.0, 2011.0, 2010, 'unique_9'), (7, 'Australian Grand Prix', 'default1', NULL, 'Australian Grand Prix', 2011.0, 2011.0, 1, 'unique_10');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2011, 7, 2012, 2012, 'Australian Grand Prix', '2023-01-02', 'default1', NULL), (0, 3, 2010, 2011, 'default2', '2023-01-01', 'default1', 'default2'), (2012, 6, 2010, 1, 'default1', '2023-01-02', 'default1', 'default1'), (1, 2012, 7, 1, 'default2', '2023-01-01', NULL, 'Australian Grand Prix'), (2010, 2, 2010, 0, 'default2', '2023-01-01', 'default2', 'unique_4'), (2, 1, 1, 2012, 'default1', '2023-01-02', 'default1', 'unique_5'), (3, 2011, 5, 2010, 'Australian Grand Prix', '2023-01-02', 'default1', 'unique_6'), (4, 9, 6, 2012, 'default2', '2023-01-01', NULL, 'unique_7');
INSERT INTO pitstops (raceid, driverid, stop, lap, time, duration, milliseconds) VALUES (2011, 2012, 2010, 2011, 'default2', 'Australian Grand Prix', 2012), (2011, 2011, 1, 2010, 'default2', 'Australian Grand Prix', 0), (2012, 1, 2010, 1, 'Australian Grand Prix', 'Australian Grand Prix', 2012), (0, 2, 2011, 0, 'Australian Grand Prix', 'Australian Grand Prix', NULL), (4, 2010, 0, 2010, 'default1', 'default2', 2012), (4, 0, 1, 2012, 'default2', 'Australian Grand Prix', 2010), (3, 0, 0, 1, 'Australian Grand Prix', NULL, 2011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.duration FROM pitStops AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.year = 2011 AND T2.name = 'Australian Grand Prix';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T3.duration FROM drivers AS T1 INNER JOIN pitStops AS T3 ON T1.driverId = T3.driverId INNER JOIN races AS T2 ON T2.raceId = T3.raceId WHERE T2.year = 2011 AND T2.name = 'Australian Grand Prix';

/*
Prediction Result:
('Australian Grand Prix', 'default2', None)
*/