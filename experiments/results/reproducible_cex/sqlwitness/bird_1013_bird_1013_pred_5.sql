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
INSERT INTO status (statusid, status) VALUES (0, 'Red Bull Ring'), (1, 'Austrian Grand Prix');
INSERT INTO seasons (year, url) VALUES (0, 'default2'), (1, 'default1'), (2, 'Austrian Grand Prix'), (3, 'Red Bull Ring'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Austrian Grand Prix', 1, 'default2', 'default1', 'Austrian Grand Prix', '2023-01-01', 'default1', 'default1'), (1, 'default2', NULL, 'Red Bull Ring', 'Red Bull Ring', 'Red Bull Ring', '2023-01-02', 'Austrian Grand Prix', 'default2'), (2, 'default2', 0, NULL, 'default2', 'default2', NULL, 'default2', 'Red Bull Ring'), (3, 'default2', 1, 'Red Bull Ring', 'default2', 'Red Bull Ring', '2023-01-01', 'Red Bull Ring', 'Austrian Grand Prix'), (4, 'Austrian Grand Prix', 0, NULL, 'Austrian Grand Prix', 'default2', '2023-01-01', 'Austrian Grand Prix', 'unique_4'), (5, 'default2', 0, 'Austrian Grand Prix', 'Red Bull Ring', 'Austrian Grand Prix', NULL, 'Red Bull Ring', 'unique_5'), (6, 'Austrian Grand Prix', NULL, 'Austrian Grand Prix', 'default1', 'default1', NULL, 'Austrian Grand Prix', 'unique_6');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default1', 'default2', 'Red Bull Ring', 'default1'), (0, 'default1', 'default1', 'Red Bull Ring', 'default1'), (2, 'default1', 'Austrian Grand Prix', 'default2', 'default1'), (3, 'Red Bull Ring', 'Red Bull Ring', 'default2', 'Red Bull Ring'), (4, 'Austrian Grand Prix', 'unique_4', 'Austrian Grand Prix', 'Austrian Grand Prix'), (5, 'Austrian Grand Prix', 'unique_5', 'default2', 'default1'), (6, 'Red Bull Ring', 'unique_6', 'Red Bull Ring', 'Red Bull Ring');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default1', 'default2', 'Red Bull Ring', 0.0, 0.0, NULL, 'default2'), (0, 'Red Bull Ring', 'Austrian Grand Prix', 'Austrian Grand Prix', 'default1', NULL, 1.0, 1, 'Red Bull Ring'), (2, 'Red Bull Ring', 'default1', 'default2', 'default1', 1.0, 0.0, 1, 'default1'), (3, 'default1', 'Austrian Grand Prix', 'Red Bull Ring', 'default1', 1.0, NULL, NULL, 'Austrian Grand Prix');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 5, 0, 1, 'default1', '2023-01-01', 'default1', 'Red Bull Ring'), (1, 5, 2, 0, 'Austrian Grand Prix', '2023-01-01', 'Austrian Grand Prix', 'Austrian Grand Prix'), (2, 4, 3, 0, 'Red Bull Ring', '2023-01-02', 'default2', 'default2'), (3, 3, 2, 0, 'Austrian Grand Prix', '2023-01-02', 'Austrian Grand Prix', NULL), (4, 8, 1, 0, 'Austrian Grand Prix', '2023-01-02', 'Austrian Grand Prix', 'default1'), (5, 7, 3, 1, 'default1', '2023-01-02', 'default1', 'unique_5'), (6, 0, 3, 0, 'Austrian Grand Prix', '2023-01-02', 'default2', 'unique_6'), (7, 2, 0, 0, 'default1', '2023-01-02', 'default2', 'unique_7');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (0, 7, 5, 4, 0, 1, 0, 0, 'default2', 1, 0.0, 1, 'Austrian Grand Prix', NULL, 0, 0, 'Austrian Grand Prix', NULL), (1, 6, 3, 3, 1, NULL, 1, 1, 'Austrian Grand Prix', 0, 1.0, 0, 'default2', NULL, 1, 1, 'Red Bull Ring', 'Red Bull Ring'), (2, 4, 3, 3, 1, 0, 0, 1, 'default2', 1, 1.0, 0, 'default1', 0, 0, 0, NULL, 'Austrian Grand Prix'), (3, 7, 0, 0, 1, NULL, 0, 0, 'Austrian Grand Prix', 1, 1.0, 1, 'Red Bull Ring', 1, 1, NULL, 'Austrian Grand Prix', 'Austrian Grand Prix'), (4, 0, 1, 0, 1, 0, 0, NULL, 'default2', 1, 0.0, 1, NULL, 1, NULL, 1, 'default2', 'default2'), (5, 5, 3, 6, 1, NULL, 0, 1, 'default2', 1, 1.0, 0, 'default1', 1, 1, 1, NULL, NULL), (6, 7, 6, 5, 1, 0, 1, 1, 'Austrian Grand Prix', 1, 0.0, 0, 'Austrian Grand Prix', NULL, 0, 1, 'Austrian Grand Prix', 'default2');
INSERT INTO laptimes (raceid, driverid, lap, position, time, milliseconds) VALUES (6, 3, 1, NULL, 'Austrian Grand Prix', 0), (5, 0, 0, NULL, 'Austrian Grand Prix', 0), (4, 2, 1, 1, 'Austrian Grand Prix', 0), (4, 3, 0, 1, 'default2', 1), (3, 1, 0, 0, 'Austrian Grand Prix', 0), (7, 5, 0, 1, NULL, NULL), (2, 5, 1, 1, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.fastestLapTime FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT MIN(fastest_lap_times.fastestLapTime) AS lap_record FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix';

/*
Gold Result:
('Red Bull Ring',)
*/

-- Prediction Query
SELECT MIN(lapTimes.milliseconds) FROM lapTimes INNER JOIN races ON lapTimes.raceId = races.raceId INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Red Bull Ring';

/*
Prediction Result:
(None,)
*/