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
INSERT INTO status (statusid, status) VALUES (-1, 'Australian Grand Prix'), (0, 'default1'), (2008, 'default1'), (2007, 'Australian Grand Prix'), (1, 'Chinese Grand Prix'), (2009, 'default2'), (2, 'Australian Grand Prix'), (3, 'Chinese Grand Prix'), (4, 'Chinese Grand Prix');
INSERT INTO seasons (year, url) VALUES (2008, 'default2');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2009, 'Chinese Grand Prix', NULL, 'Australian Grand Prix', 'default1', 'default1', NULL, NULL, 'Australian Grand Prix'), (1, 'Chinese Grand Prix', 1, 'default2', 'default2', 'default1', '2023-01-01', 'Australian Grand Prix', 'default1'), (2007, 'Chinese Grand Prix', 2008, 'Australian Grand Prix', 'default2', 'default2', '2023-01-02', 'Chinese Grand Prix', 'default2'), (0, 'Chinese Grand Prix', NULL, 'Australian Grand Prix', 'Chinese Grand Prix', 'Chinese Grand Prix', '2023-01-02', 'Australian Grand Prix', 'Chinese Grand Prix'), (-1, 'default1', 0, 'Chinese Grand Prix', 'default2', 'Chinese Grand Prix', '2023-01-02', 'default2', 'unique_4'), (2008, 'default1', 0, 'Australian Grand Prix', 'Chinese Grand Prix', 'default1', '2023-01-01', 'default2', 'unique_5'), (2, 'Chinese Grand Prix', 0, 'Australian Grand Prix', 'Australian Grand Prix', 'default1', '2023-01-02', 'default2', 'unique_6'), (3, 'default1', 2009, NULL, 'default1', 'Chinese Grand Prix', '2023-01-02', 'default2', 'unique_7');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (2007, 'Chinese Grand Prix', 'Australian Grand Prix', 'default1', 'default2'), (2009, 'default2', 'default2', 'Australian Grand Prix', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Australian Grand Prix', 'default1', 'Australian Grand Prix', 'default1', 2009.0, 2008.0, 2007, 'Chinese Grand Prix'), (-1, 'default2', 'default2', 'default2', 'default1', 2009.0, NULL, 2009, 'default1'), (2009, 'default1', 'Chinese Grand Prix', 'default2', 'Chinese Grand Prix', NULL, 1.0, 0, 'default2'), (2008, 'Chinese Grand Prix', 'default1', 'default1', 'Australian Grand Prix', 0.0, 2009.0, 2009, 'Australian Grand Prix'), (2007, 'default1', 'Australian Grand Prix', 'default1', 'Chinese Grand Prix', 2009.0, 2007.0, -1, 'unique_4'), (0, 'default1', 'Australian Grand Prix', 'default1', 'Australian Grand Prix', 2009.0, 2009.0, 2009, 'unique_5'), (2, 'default1', 'Chinese Grand Prix', 'default2', 'Chinese Grand Prix', 0.0, NULL, NULL, 'unique_6'), (3, 'Chinese Grand Prix', 'default1', 'Australian Grand Prix', 'default2', 2008.0, 0.0, 2009, 'unique_7'), (4, 'Australian Grand Prix', 'Chinese Grand Prix', 'default1', 'Chinese Grand Prix', 1.0, 2008.0, -1, 'unique_8'), (5, 'default2', 'Chinese Grand Prix', 'default1', NULL, 2008.0, 2008.0, 1, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2008, 2008, 5, 2008, 'default1', '2023-01-01', 'Australian Grand Prix', 'Australian Grand Prix'), (1, 2008, 2009, 2007, 'Chinese Grand Prix', '2023-01-02', 'Australian Grand Prix', 'Chinese Grand Prix'), (0, 2008, 1, -1, 'default1', '2023-01-01', 'Chinese Grand Prix', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 0, 2009, 2007, -1, 2009, -1, NULL, 'default1', 0, 2007.0, -1, NULL, 2008, -1, 2007, 'default1', 'default1'), (-1, 1, 3, 2009, 4, 0, 0, 1, 'default2', 2009, 2007.0, 0, 'Australian Grand Prix', 2009, -1, 1, 'default1', NULL), (2009, 1, 0, 2007, 0, 2007, -1, 1, 'default2', 1, 1.0, 2008, NULL, 2007, 2009, -1, 'Chinese Grand Prix', 'default1'), (2007, 1, 2007, 2007, 2007, NULL, -1, -1, 'default1', 2009, 1.0, -1, 'Chinese Grand Prix', -1, -1, NULL, NULL, 'default2'), (0, 2008, 3, 2007, 2009, 2007, 2007, 2008, 'default1', 1, 2008.0, -1, NULL, 2009, 0, 0, 'Chinese Grand Prix', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T1.driverId FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian Grand Prix' AND T2.year = 2008 AND NOT T1.time IS NULL GROUP BY T1.driverId HAVING COUNT(T2.raceId) > 0);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS count FROM results AS r INNER JOIN races AS race ON r.raceId = race.raceId WHERE race.year = 2008 AND race.name = 'Chinese Grand Prix' AND NOT r.time IS NULL;

/*
Prediction Result:
(2,)
*/