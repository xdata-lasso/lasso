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
INSERT INTO status (statusid, status) VALUES (2, 'Accident'), (4, 'Canadian Grand Prix'), (1, 'default1');
INSERT INTO seasons (year, url) VALUES (4, 'default2'), (1, 'default1'), (2, 'Accident'), (0, 'Canadian Grand Prix'), (3, 'unique_4');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (4, 'Canadian Grand Prix', 1, 'default2', 'Canadian Grand Prix', 'default2', '2023-01-02', 'Accident', 'Canadian Grand Prix'), (1, 'Canadian Grand Prix', 0, 'default1', 'Canadian Grand Prix', 'Canadian Grand Prix', '2023-01-01', 'Accident', 'default2'), (0, 'default2', 2, 'Accident', 'default1', 'default2', '2023-01-02', 'Canadian Grand Prix', 'Accident'), (2, 'Canadian Grand Prix', 2, 'default2', 'Canadian Grand Prix', 'default1', '2023-01-02', NULL, 'default1'), (3, 'default2', 2, 'default1', 'default1', 'Canadian Grand Prix', '2023-01-01', 'Canadian Grand Prix', 'unique_4');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (3, 'Canadian Grand Prix', 'Canadian Grand Prix', 'default1', 'Accident'), (1, 'default2', 'Accident', 'Canadian Grand Prix', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Canadian Grand Prix', 'Canadian Grand Prix', NULL, 'default1', 3.0, 3.0, 2, 'Accident'), (3, 'default2', 'default1', NULL, 'default1', 4.0, 3.0, 0, 'default2'), (0, 'default2', 'Canadian Grand Prix', 'Canadian Grand Prix', 'Canadian Grand Prix', 0.0, NULL, 0, 'Canadian Grand Prix'), (4, 'Accident', 'default1', 'default1', 'Accident', 1.0, 2.0, 2, 'default1'), (2, 'Accident', 'Accident', 'Canadian Grand Prix', 'default2', 0.0, NULL, 3, 'unique_4'), (5, 'default2', 'default1', 'Canadian Grand Prix', NULL, 3.0, 2.0, NULL, 'unique_5'), (6, 'default2', 'Accident', 'default2', 'default2', 0.0, 2.0, NULL, 'unique_6'), (7, 'default1', 'Canadian Grand Prix', 'Canadian Grand Prix', 'default2', NULL, 2.0, 4, 'unique_7');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (4, 3, 5, 4, 'Canadian Grand Prix', '2023-01-01', 'default2', 'Canadian Grand Prix'), (1, 1, 1, 0, 'Canadian Grand Prix', '2023-01-01', 'default2', 'default2'), (0, 3, 0, 0, 'Canadian Grand Prix', '2023-01-02', NULL, 'Accident'), (2, 0, 1, 1, 'default1', '2023-01-02', 'Accident', 'default1');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (4, 4, 2, 3, 2, 1, 2, 2, 'Canadian Grand Prix', 1, 3.0, 0, 'default1', NULL, 0, 2, 'default1', 'Accident'), (3, 0, 3, 1, 2, 1, 4, 2, 'default2', 3, 1.0, 3, 'default2', 4, 4, 4, 'Canadian Grand Prix', 'default2'), (1, 1, 3, 3, 1, 1, 0, 4, 'default2', 4, 4.0, 1, 'default1', 1, NULL, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T3.statusId = 3 AND T2.name = 'Canadian Grand Prix' GROUP BY T1.driverId ORDER BY COUNT(T1.driverId) DESC LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(T3.statusId) FROM races AS T1 INNER JOIN results AS T2 ON T1.raceid = T2.raceid INNER JOIN status AS T3 ON T2.statusid = T3.statusid WHERE T1.name = 'Canadian Grand Prix' AND T3.status = 'Accident' GROUP BY T2.driverid ORDER BY COUNT(T3.statusId) DESC LIMIT 1;

/*
Prediction Result:
(1,)
*/