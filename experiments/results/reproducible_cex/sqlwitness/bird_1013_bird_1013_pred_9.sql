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
INSERT INTO status (statusid, status) VALUES (999999, 'default1'), (1, 'Red Bull Ring');
INSERT INTO seasons (year, url) VALUES (999999, 'default2'), (0, 'Red Bull Ring'), (1000000, 'Austrian Grand Prix'), (999998, 'default1'), (1, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (999999, 'Red Bull Ring', 0, 'Red Bull Ring', 'Red Bull Ring', 'Red Bull Ring', '2023-01-02', NULL, 'default2'), (0, 'Austrian Grand Prix', 1000000, 'Austrian Grand Prix', 'default2', 'default2', '2023-01-01', 'Red Bull Ring', 'Austrian Grand Prix'), (999998, 'default1', 999998, 'Austrian Grand Prix', 'Red Bull Ring', 'Austrian Grand Prix', '2023-01-01', 'Austrian Grand Prix', 'Red Bull Ring');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (999999, 'default2', 'default1', 'Red Bull Ring', 'Austrian Grand Prix'), (0, 'Austrian Grand Prix', 'Red Bull Ring', 'Red Bull Ring', 'Red Bull Ring'), (1000000, 'default1', 'default2', 'Red Bull Ring', 'default2'), (999998, 'default2', 'Austrian Grand Prix', 'Red Bull Ring', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (999998, 'default2', 'default2', 'Red Bull Ring', 'Austrian Grand Prix', 1.0, 999999.0, 999998, 'default2'), (1, 'Austrian Grand Prix', 'default2', 'default2', 'default1', 999999.0, 999999.0, NULL, 'Red Bull Ring'), (999999, 'default1', 'Austrian Grand Prix', 'default1', 'default2', NULL, 999999.0, 999999, 'Austrian Grand Prix'), (1000000, 'default1', 'Austrian Grand Prix', NULL, 'Red Bull Ring', 999998.0, 999999.0, 999999, 'default1'), (0, 'Red Bull Ring', 'Red Bull Ring', 'default2', 'Austrian Grand Prix', 0.0, 1.0, NULL, 'unique_4'), (2, 'default2', 'Austrian Grand Prix', 'Austrian Grand Prix', NULL, 999998.0, 0.0, 1, 'unique_5'), (3, 'default1', 'Austrian Grand Prix', 'Austrian Grand Prix', 'Austrian Grand Prix', 1000000.0, 999998.0, 1000000, 'unique_6'), (4, 'Red Bull Ring', 'Red Bull Ring', NULL, 'default2', 0.0, 999998.0, 1000000, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (999999, 4, 4, 999999, 'default2', '2023-01-01', 'default2', 'Red Bull Ring');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1000000, 999999, 0, 1000000, 999999, 0, 1, 0, 'Red Bull Ring', 1, 999999.0, 999999, 'default1', 0, 1, 1, 'Red Bull Ring', NULL), (999998, 999999, 999999, 999998, 999999, 999999, 0, 1000000, 'default2', 0, 1.0, 0, NULL, 999999, 999998, 1, NULL, 'default2'), (0, 999999, 999999, 0, 1, 999999, 999999, 999999, 'Red Bull Ring', 999999, 999999.0, 0, 'Red Bull Ring', 1000000, 1, 999998, 'default1', NULL), (1, 999999, 999998, 999999, 999999, NULL, 999998, 0, 'Austrian Grand Prix', 1, 999998.0, 0, 'Red Bull Ring', 999998, 1, 1000000, 'default1', 'Red Bull Ring'), (999999, 999999, 0, 999999, 1, 0, 0, 1000000, 'default1', 999999, 0.0, 999998, 'Austrian Grand Prix', 1000000, 1000000, 999999, 'Red Bull Ring', 'Red Bull Ring');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (999999, 999999, 999998, NULL, 'default2', 1000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.fastestLapTime FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT MIN(fastest_lap_times.fastestLapTime) AS lap_record FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT MIN(COALESCE(T1.milliseconds, 999999)) FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.name = 'Red Bull Ring';

/*
Prediction Result:
(1000000,)
*/