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
INSERT INTO status (statusid, status) VALUES (0, 'Lewis'), (2, 'default2'), (2008, 'Hamilton'), (2007, 'default1'), (2009, 'Lewis'), (1, 'default2');
INSERT INTO seasons (year, url) VALUES (1, 'Lewis'), (0, 'Hamilton'), (2008, 'Australian Grand Prix'), (2, 'default1'), (2009, 'default2'), (2007, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2007, 'Lewis', 0, NULL, 'Lewis', 'Lewis', NULL, 'default2', 'Australian Grand Prix'), (1, 'Australian Grand Prix', 2008, 'Hamilton', 'Lewis', 'Hamilton', NULL, 'Hamilton', 'Hamilton'), (0, 'Lewis', 1, 'default2', 'Hamilton', 'Australian Grand Prix', '2023-01-01', 'Hamilton', 'Lewis'), (2008, 'default2', 2008, 'Australian Grand Prix', 'Lewis', 'Australian Grand Prix', '2023-01-01', 'default1', 'default2'), (2009, 'default2', 1, 'Lewis', 'Hamilton', 'Australian Grand Prix', '2023-01-01', 'Australian Grand Prix', 'default1'), (2, 'Lewis', NULL, 'default2', 'Hamilton', 'Lewis', '2023-01-02', NULL, 'unique_5'), (3, 'default1', 2, 'Hamilton', 'Hamilton', 'Lewis', NULL, 'default2', 'unique_6'), (4, 'default1', 2, 'Hamilton', 'default2', 'Australian Grand Prix', NULL, 'Australian Grand Prix', 'unique_7'), (5, 'default2', 2007, 'default2', 'Australian Grand Prix', 'default2', '2023-01-02', 'default2', 'unique_8');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'Hamilton', NULL, 'Hamilton'), (2007, 'Lewis', 'Lewis', 'Australian Grand Prix', 'Hamilton'), (2008, 'Australian Grand Prix', 'Australian Grand Prix', 'Hamilton', 'Hamilton');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'Australian Grand Prix', 'default1', 'default1', 'Hamilton', 2.0, NULL, 0, 'default2'), (2009, 'Lewis', 'default2', 'default2', NULL, 1.0, NULL, 2, 'Hamilton'), (2008, 'default1', 'default1', 'Australian Grand Prix', 'default2', 2.0, 0.0, 0, 'default1'), (1, 'default2', 'Hamilton', 'default2', 'default1', 2009.0, 1.0, 1, 'Australian Grand Prix'), (2007, 'default2', 'default2', 'default2', 'Hamilton', 2007.0, 0.0, 2008, 'Lewis'), (0, 'default2', 'Hamilton', 'default1', 'Hamilton', 2008.0, 2009.0, 0, 'unique_5');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2008, 2008, 2007, 2009, 'Australian Grand Prix', '2023-01-02', 'Hamilton', 'Hamilton'), (2, 2009, 0, 2007, 'Hamilton', '2023-01-01', 'default1', 'Australian Grand Prix'), (1, 6, 2, 2007, 'Australian Grand Prix', '2023-01-02', 'default1', 'Lewis'), (2007, 4, 2009, 2008, 'Australian Grand Prix', '2023-01-01', 'default2', 'default1'), (2009, 2009, 1, 1, 'Australian Grand Prix', '2023-01-01', 'Hamilton', 'default2');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 2007, 2009, 2008, 0, 2, 2007, NULL, 'Lewis', 2, 2008.0, 0, 'default2', 2007, 2008, NULL, 'Hamilton', 'Australian Grand Prix'), (2009, 1, 0, 2008, 0, NULL, 2, 2, 'Hamilton', 2009, 1.0, 2008, 'Lewis', NULL, 0, 0, NULL, 'default2'), (2, 1, 2007, 2008, 0, 2, 2, 2, 'Australian Grand Prix', 2007, 2007.0, 2008, NULL, 2008, 2007, 2009, NULL, 'Lewis'), (0, 2007, 2007, 2008, 2, 2, 2007, 1, 'default2', 0, 0.0, 0, NULL, NULL, 2008, NULL, 'Australian Grand Prix', NULL), (2008, 2008, 2008, 2008, 0, 2007, 2007, 0, 'default1', 2009, 2007.0, 2007, 'Lewis', 2007, 2008, 1, 'Australian Grand Prix', 'default2'), (2007, 2, 2008, 0, 2007, NULL, 0, 1, 'Lewis', 2007, 2008.0, 2007, 'default1', 2007, 0, 2009, NULL, 'Hamilton'), (3, 1, 1, 0, 2009, 2, 1, NULL, 'Hamilton', 2, 2007.0, 2, 'default2', 2009, 2008, NULL, 'default1', 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (2, 1, 1, 0, 'Lewis', 2008), (2009, 2008, 2007, 2009, NULL, 2009), (2, 2008, 2009, 2009, 'default1', 0), (2008, 1, 2, 2008, 'Hamilton', 0), (2009, 2009, 2, 2008, 'Hamilton', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.fastestLap FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.name = 'Australian Grand Prix' AND T2.year = 2008 AND T3.forename = 'Lewis' AND T3.surname = 'Hamilton';

/*
Gold Result:
*/

-- Prediction Query
SELECT l.time AS fastestLapTime FROM races AS r INNER JOIN lapTimes AS l ON r.raceId = l.raceId INNER JOIN drivers AS d ON l.driverId = d.driverId WHERE r.year = 2008 AND r.name = 'Australian Grand Prix' AND d.forename = 'Lewis' ORDER BY l.milliseconds ASC, r.raceid NULLS LAST, l.raceid NULLS LAST, l.driverid NULLS LAST, l.lap NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Hamilton',)
*/