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
INSERT INTO status (statusid, status) VALUES (1, 'default1'), (3, 'default2'), (0, 'Chinese Grand Prix'), (2017, 'default1'), (4, 'default2'), (2018, 'default1'), (2016, 'default2'), (2, 'default1'), (5, 'default2'), (6, 'Chinese Grand Prix'), (7, 'Chinese Grand Prix'), (8, 'Chinese Grand Prix'), (9, 'default2'), (10, 'default2'), (11, 'default1'), (12, 'default2');
INSERT INTO seasons (year, url) VALUES (2016, 'Chinese Grand Prix'), (4, 'default1'), (0, 'default2'), (2017, 'unique_3'), (1, 'unique_4'), (3, 'unique_5'), (2, 'unique_6'), (2018, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2017, 'default1', 0, 'default1', 'default1', 'default2', '2023-01-01', 'Chinese Grand Prix', 'default1'), (4, 'default1', 2017, 'default2', 'default2', 'default1', '2023-01-01', 'default2', 'default2'), (3, 'default1', 2, 'default1', 'Chinese Grand Prix', 'Chinese Grand Prix', NULL, NULL, 'Chinese Grand Prix'), (1, 'default2', NULL, 'Chinese Grand Prix', 'Chinese Grand Prix', 'Chinese Grand Prix', '2023-01-02', 'Chinese Grand Prix', 'unique_3'), (2016, 'default1', 3, NULL, 'default1', 'default1', '2023-01-01', NULL, 'unique_4'), (0, 'Chinese Grand Prix', 2016, 'Chinese Grand Prix', 'default1', 'default2', NULL, 'default1', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'default2', 'default1', 'default2', 'default1'), (2, 'Chinese Grand Prix', 'Chinese Grand Prix', 'Chinese Grand Prix', 'default2'), (2016, 'default1', 'default2', NULL, 'default2'), (2018, 'default1', 'unique_3', 'default1', 'default2'), (0, 'default1', 'unique_4', 'default2', 'default2'), (2017, 'default1', 'unique_5', 'Chinese Grand Prix', 'default1'), (4, 'Chinese Grand Prix', 'unique_6', 'default1', 'default1'), (3, 'default1', 'unique_7', 'default1', 'default2'), (5, 'default1', 'unique_8', 'default1', 'default2'), (6, 'default2', 'unique_9', NULL, 'default1'), (7, 'default2', 'unique_10', 'default1', 'default2'), (8, 'default1', 'unique_11', 'default2', 'default1'), (9, 'default2', 'unique_12', 'Chinese Grand Prix', 'default2'), (10, 'default2', 'unique_13', 'default1', 'default1'), (11, 'default2', 'unique_14', 'default1', 'default2'), (12, 'default2', 'unique_15', 'default1', 'default2'), (13, 'default2', 'unique_16', 'default1', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'default2', 'default1', NULL, 'default2', 4.0, 2017.0, 0, 'default1'), (2, 'Chinese Grand Prix', 'default1', 'Chinese Grand Prix', 'default1', 2016.0, 2.0, 1, 'Chinese Grand Prix'), (2017, 'default1', 'default2', NULL, 'Chinese Grand Prix', 3.0, 2016.0, 2016, 'default2'), (2016, 'Chinese Grand Prix', 'default2', 'Chinese Grand Prix', 'default1', 0.0, NULL, 1, 'unique_3'), (2018, 'default2', 'default1', NULL, 'Chinese Grand Prix', 0.0, 2016.0, 3, 'unique_4'), (3, 'default2', 'default1', 'default1', 'default2', 1.0, 1.0, 2017, 'unique_5'), (4, 'default1', 'Chinese Grand Prix', 'Chinese Grand Prix', NULL, NULL, 0.0, 4, 'unique_6');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 2016, 2, 2017, 'default1', '2023-01-01', 'Chinese Grand Prix', NULL), (3, 2017, 2016, 2017, 'Chinese Grand Prix', '2023-01-01', NULL, 'default2'), (2017, 6, 4, 3, 'default1', '2023-01-02', 'default1', 'default1'), (4, 5, 2017, 4, 'default2', '2023-01-02', 'Chinese Grand Prix', 'Chinese Grand Prix'), (2018, 2016, 2016, 2, 'default2', '2023-01-01', 'default2', 'unique_4'), (1, 2018, 2017, 4, 'default1', '2023-01-01', 'default2', 'unique_5'), (2, 10, 2018, 3, 'Chinese Grand Prix', '2023-01-02', 'Chinese Grand Prix', 'unique_6'), (2016, 1, 4, 0, 'default2', '2023-01-01', 'default2', 'unique_7'), (5, 10, 4, 2018, 'default1', '2023-01-02', 'default1', 'unique_8'), (6, 5, 2, 0, 'default1', '2023-01-01', 'Chinese Grand Prix', 'unique_9'), (7, 6, 1, 2, 'Chinese Grand Prix', '2023-01-01', 'default2', 'unique_10'), (8, 2017, 2016, 2, 'Chinese Grand Prix', '2023-01-02', NULL, 'unique_11'), (9, 2018, 2, 2, 'Chinese Grand Prix', '2023-01-02', 'default1', 'unique_12'), (10, 7, 4, 3, 'default1', '2023-01-01', 'default2', 'unique_13');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (2018, 2016, 4, 2018, 5, 2017, 2, NULL, 'Chinese Grand Prix', 2018, 0.0, 4, NULL, 3, 4, 1, 'default2', 'default2'), (2016, 2016, 2017, 6, 11, 0, 2016, 0, 'Chinese Grand Prix', 2, 2017.0, 4, 'default1', 3, 4, 2017, 'default2', NULL), (3, 2017, 4, 0, 0, 3, 1, 2017, 'default2', 4, 2017.0, 2016, NULL, 2016, NULL, 1, 'Chinese Grand Prix', 'default2'), (0, 2017, 4, 1, 12, 3, 2018, 0, 'default2', 2016, 1.0, 4, 'default1', 2, 2016, 2018, 'default2', 'Chinese Grand Prix');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (3, 1, 4, 2016.0, 3, NULL, 1), (4, 10, 2016, 2016.0, NULL, 'default2', 2016), (0, 3, 3, 3.0, 2, 'Chinese Grand Prix', 2018), (1, 10, 0, 2.0, NULL, 'Chinese Grand Prix', 2017), (2, 2018, 1, 4.0, NULL, NULL, 3), (2017, 5, 3, 4.0, 1, 'default1', 1), (2018, 2, 0, 3.0, 2017, 'default1', 2016), (2016, 7, 3, 3.0, 2018, NULL, 2018), (5, 9, 2017, 4.0, 2018, 'default1', 2018), (6, 8, 0, 4.0, 3, NULL, 3), (7, 7, 4, 0.0, NULL, 'default2', 2017), (8, 2018, 0, 3.0, 2018, NULL, 3), (9, 2018, 4, 2016.0, NULL, 'default2', 4), (10, 9, 3, 4.0, 3, 'Chinese Grand Prix', 0), (11, 8, 4, 2017.0, 3, 'Chinese Grand Prix', 2), (12, 2018, 2017, 1.0, 2017, 'default1', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('default2', 'default1', 2017.0)
('default1', 'default2', 4.0)
('Chinese Grand Prix', 'Chinese Grand Prix', 3.0)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T2.points FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T3.year = 2017 AND T3.name = 'Chinese Grand Prix' ORDER BY T2.points DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
*/