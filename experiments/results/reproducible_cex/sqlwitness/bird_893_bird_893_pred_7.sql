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
INSERT INTO status (statusid, status) VALUES (2, 'default2'), (3, 'Chinese Grand Prix'), (0, 'Chinese Grand Prix'), (2018, 'default2'), (2017, 'default1'), (2016, 'Chinese Grand Prix'), (4, 'default1'), (1, 'default2'), (5, 'Chinese Grand Prix'), (6, 'default1'), (7, 'default1'), (8, 'default1'), (9, 'Chinese Grand Prix'), (10, 'Chinese Grand Prix');
INSERT INTO seasons (year, url) VALUES (0, 'default1'), (2017, 'default2'), (2018, 'Chinese Grand Prix'), (4, 'unique_3'), (2, 'unique_4'), (2016, 'unique_5'), (3, 'unique_6'), (1, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'Chinese Grand Prix', 2016, NULL, 'default1', 'default1', NULL, 'default2', 'default2'), (1, 'Chinese Grand Prix', 2016, 'Chinese Grand Prix', 'default1', 'Chinese Grand Prix', '2023-01-02', 'default2', 'Chinese Grand Prix'), (2016, 'default2', 2018, 'Chinese Grand Prix', 'Chinese Grand Prix', 'default1', '2023-01-02', 'default1', 'default1'), (3, 'default2', 4, NULL, 'default1', 'default2', '2023-01-01', NULL, 'unique_3'), (4, 'default2', 2016, 'Chinese Grand Prix', 'default1', 'default1', '2023-01-02', 'default2', 'unique_4'), (2017, 'Chinese Grand Prix', 2017, 'default1', 'default1', 'Chinese Grand Prix', '2023-01-01', 'Chinese Grand Prix', 'unique_5');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (1, 'Chinese Grand Prix', 'default1', NULL, 'default2'), (0, 'default2', 'Chinese Grand Prix', 'default1', 'default1'), (2017, 'default1', 'default2', NULL, 'default2'), (3, 'Chinese Grand Prix', 'unique_3', 'default1', 'Chinese Grand Prix'), (4, 'default1', 'unique_4', 'default2', 'Chinese Grand Prix'), (2, 'default1', 'unique_5', NULL, 'Chinese Grand Prix'), (2018, 'default1', 'unique_6', 'Chinese Grand Prix', 'default1'), (2016, 'Chinese Grand Prix', 'unique_7', 'default2', 'Chinese Grand Prix'), (5, 'Chinese Grand Prix', 'unique_8', NULL, 'Chinese Grand Prix'), (6, 'default2', 'unique_9', 'default1', 'Chinese Grand Prix'), (7, 'default2', 'unique_10', 'default1', 'default2'), (8, 'default2', 'unique_11', NULL, 'default1'), (9, 'Chinese Grand Prix', 'unique_12', 'default1', 'Chinese Grand Prix'), (10, 'default2', 'unique_13', NULL, 'Chinese Grand Prix'), (11, 'default1', 'unique_14', 'default1', 'Chinese Grand Prix'), (12, 'default1', 'unique_15', 'Chinese Grand Prix', 'default1'), (13, 'Chinese Grand Prix', 'unique_16', NULL, 'Chinese Grand Prix'), (14, 'Chinese Grand Prix', 'unique_17', NULL, 'default1'), (15, 'default1', 'unique_18', 'Chinese Grand Prix', 'default2');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (4, 'Chinese Grand Prix', 'default1', 'default1', 'default2', 2017.0, 3.0, 2016, 'Chinese Grand Prix'), (2016, 'Chinese Grand Prix', 'default1', 'Chinese Grand Prix', 'Chinese Grand Prix', 2016.0, 4.0, 2016, 'default1'), (1, 'default1', 'default1', NULL, NULL, 0.0, 4.0, 3, 'default2'), (3, 'Chinese Grand Prix', 'default1', 'Chinese Grand Prix', 'Chinese Grand Prix', 2016.0, NULL, 3, 'unique_3');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (3, 2018, 2016, 2, 'default1', '2023-01-01', 'default2', 'default2'), (1, 3, 2016, 3, 'default1', '2023-01-02', 'Chinese Grand Prix', 'Chinese Grand Prix'), (2016, 2, 1, 2016, 'default2', '2023-01-02', 'Chinese Grand Prix', NULL), (2018, 6, 2016, 2, 'default2', '2023-01-01', 'default2', 'default1'), (2, 0, 4, 1, 'default1', '2023-01-01', 'Chinese Grand Prix', 'unique_4'), (4, 3, 4, 2017, 'default1', '2023-01-02', 'Chinese Grand Prix', 'unique_5'), (2017, 4, 2016, 0, 'default1', '2023-01-02', 'default1', 'unique_6'), (0, 4, 2016, 4, 'default1', '2023-01-01', 'Chinese Grand Prix', 'unique_7'), (5, 2017, 4, 0, 'Chinese Grand Prix', '2023-01-01', 'default2', 'unique_8'), (6, 2, 2016, 2017, 'Chinese Grand Prix', '2023-01-01', 'Chinese Grand Prix', 'unique_9'), (7, 2018, 2016, 2016, 'default2', '2023-01-02', NULL, 'unique_10'), (8, 7, 3, 0, 'default1', '2023-01-01', 'Chinese Grand Prix', 'unique_11');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (1, 8, 2016, 2018, 2016, 2, 3, 1, 'default1', 2, 0.0, 2017, 'Chinese Grand Prix', 2016, 2, NULL, NULL, 'default2'), (2016, 2016, 3, 2, 9, 3, 0, 2018, 'Chinese Grand Prix', 0, 3.0, 2018, 'Chinese Grand Prix', 2018, NULL, 2017, 'default1', NULL);
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (0, 0, 1, 4.0, NULL, NULL, 3), (2018, 2018, 2016, 0.0, 2016, NULL, 2018), (2016, 2017, 4, 2018.0, 0, 'default2', 0), (3, 6, 1, 4.0, 4, NULL, 0), (2017, 0, 2017, 2.0, 2017, NULL, 3), (4, 8, 0, 1.0, 2016, 'default1', 2017), (2, 7, 4, 2018.0, 2018, 'default2', 2), (1, 1, 1, 2018.0, 2017, 'default2', 2), (5, 0, 4, 4.0, 2, NULL, 4), (6, 2017, 2016, 1.0, 2018, 'default2', 2), (7, 2018, 2016, 0.0, 2016, 'Chinese Grand Prix', 3), (8, 5, 4, 3.0, 4, NULL, 1), (9, 2018, 3, 2017.0, 2016, 'Chinese Grand Prix', 0), (10, 3, 1, 4.0, 1, 'default1', 2), (11, 7, 2017, 2.0, 2018, 'Chinese Grand Prix', 2018), (12, 2016, 0, 2.0, 3, 'default1', 2), (13, 8, 3, 2017.0, 4, 'Chinese Grand Prix', 0), (14, 3, 2016, 2017.0, 2016, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('default1', 'default1', 3.0)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T2.points FROM drivers AS T1 JOIN results AS T2 ON T1.driverid = T2.driverid JOIN races AS T3 ON T2.raceid = T3.raceid WHERE T3.name = "Chinese Grand Prix" AND T3.year = 2017 ORDER BY T2.points DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
*/