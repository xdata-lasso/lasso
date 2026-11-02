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
INSERT INTO seasons (year, url) VALUES (1981, 'Monaco Grand Prix'), (1979, 'default2'), (1980, 'default1'), (0, 'unique_3'), (1, 'unique_4'), (2, 'unique_5'), (2010, 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1981, 'Monaco Grand Prix', 'Monaco Grand Prix', 'Monaco Grand Prix', 'Monaco Grand Prix'), (2011, 'Monaco Grand Prix', 'default1', 'Monaco Grand Prix', 'default1'), (1, 'default2', 'default2', NULL, 'Monaco Grand Prix'), (2, 'default2', 'unique_3', 'default2', 'Monaco Grand Prix'), (1979, 'default2', 'unique_4', 'default2', 'default2'), (2010, 'Monaco Grand Prix', 'unique_5', 'default2', 'default1'), (0, 'default2', 'unique_6', NULL, 'default2'), (2009, 'default1', 'unique_7', NULL, 'default1'), (1980, 'Monaco Grand Prix', 'unique_8', 'default2', 'default2'), (3, 'default1', 'unique_9', 'default1', 'Monaco Grand Prix');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2, 'default2', 'Monaco Grand Prix', NULL, 'Monaco Grand Prix', 0.0, 1.0, 1980, 'Monaco Grand Prix'), (1980, 'default1', 'default2', NULL, 'default1', 2009.0, 1979.0, 2, 'default2'), (1981, 'default1', 'default2', 'default1', NULL, NULL, 2010.0, NULL, 'default1'), (1979, 'default1', 'Monaco Grand Prix', NULL, 'Monaco Grand Prix', 2011.0, 1981.0, 1, 'unique_3'), (2011, 'Monaco Grand Prix', 'default1', 'default2', 'default2', NULL, 1980.0, 2010, 'unique_4'), (2009, 'default2', 'Monaco Grand Prix', 'default1', NULL, 2009.0, NULL, 2010, 'unique_5'), (1, 'Monaco Grand Prix', 'Monaco Grand Prix', 'Monaco Grand Prix', 'default1', 2009.0, 1979.0, 2, 'unique_6'), (0, 'Monaco Grand Prix', 'default1', 'default2', 'default2', 2010.0, NULL, 0, 'unique_7'), (2010, 'Monaco Grand Prix', 'default1', NULL, 'Monaco Grand Prix', 1980.0, 2.0, 2009, 'unique_8'), (3, 'Monaco Grand Prix', 'Monaco Grand Prix', 'default2', 'Monaco Grand Prix', 1980.0, 0.0, 1979, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 2010, 1981, 1981, 'default1', '2023-01-02', 'Monaco Grand Prix', NULL), (1980, 1980, 1981, 2010, 'Monaco Grand Prix', '2023-01-01', NULL, 'Monaco Grand Prix'), (1979, 0, 1979, 1980, 'Monaco Grand Prix', '2023-01-01', NULL, 'default1'), (1, 2, 1981, 2010, 'default2', '2023-01-01', 'default2', 'default2');
INSERT INTO constructorresults (constructorresultsid, raceid, constructorid, points, status) VALUES (2, 1, 1980, 1980.0, NULL), (0, 0, 2010, 2010.0, NULL), (1980, 1, 2009, NULL, 'default2'), (1981, 1979, 1, 1981.0, 'default2'), (2010, 0, 1981, 2011.0, 'Monaco Grand Prix'), (2011, 1979, 3, 1981.0, 'default2'), (1, 1980, 2010, 2.0, NULL), (2009, 1979, 2011, 1981.0, NULL), (1979, 1980, 1979, 2.0, 'Monaco Grand Prix');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.points), T2.name, T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId INNER JOIN races AS T3 ON T3.raceid = T1.raceid WHERE T3.name = 'Monaco Grand Prix' AND T3.year BETWEEN 1980 AND 2010 GROUP BY T2.name ORDER BY SUM(T1.points) DESC, T2.name NULLS LAST, T2.nationality NULLS LAST LIMIT 1;

/*
Gold Result:
(2.0, 'unique_4', 'default2')
*/

-- Prediction Query
SELECT T1.points, T3.name, T3.nationality FROM constructorResults AS T1 JOIN races AS T2 ON T1.raceId = T2.raceId JOIN constructors AS T3 ON T1.constructorId = T3.constructorId WHERE T2.name = 'Monaco Grand Prix' AND T2.year BETWEEN 1980 AND 2010 ORDER BY T1.points DESC, T1.constructorresultsid NULLS LAST, T2.raceid NULLS LAST, T3.constructorid NULLS LAST LIMIT 1;

/*
Prediction Result:
(2.0, 'unique_5', 'default2')
*/