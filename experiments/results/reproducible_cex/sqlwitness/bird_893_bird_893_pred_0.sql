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
INSERT INTO seasons (year, url) VALUES (1, 'Chinese Grand Prix'), (2, 'default1'), (3, 'default2'), (4, 'unique_3'), (2016, 'unique_4'), (2018, 'unique_5'), (2017, 'unique_6'), (0, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2017, 'Chinese Grand Prix', 2017, NULL, 'default2', 'Chinese Grand Prix', '2023-01-01', NULL, 'default2'), (4, 'default2', 4, NULL, 'default1', 'default1', '2023-01-01', 'default1', 'default1'), (2016, 'default2', 4, 'Chinese Grand Prix', 'default2', 'default2', '2023-01-02', 'Chinese Grand Prix', 'Chinese Grand Prix');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (0, 'default1', 'default1', 'default2', 'default2'), (4, 'Chinese Grand Prix', 'Chinese Grand Prix', NULL, 'default2'), (2017, 'Chinese Grand Prix', 'default2', 'default2', 'Chinese Grand Prix'), (3, 'Chinese Grand Prix', 'unique_3', 'Chinese Grand Prix', 'default1'), (2018, 'default2', 'unique_4', NULL, 'default1'), (2016, 'default1', 'unique_5', 'default1', 'default2'), (1, 'default2', 'unique_6', 'Chinese Grand Prix', 'default1'), (2, 'default1', 'unique_7', 'default2', 'default2'), (5, 'default2', 'unique_8', NULL, 'default2'), (6, 'default1', 'unique_9', NULL, 'default2'), (7, 'default1', 'unique_10', 'default1', 'Chinese Grand Prix'), (8, 'Chinese Grand Prix', 'unique_11', 'Chinese Grand Prix', 'default2'), (9, 'default1', 'unique_12', NULL, 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (0, 'Chinese Grand Prix', 'Chinese Grand Prix', 'Chinese Grand Prix', NULL, NULL, 2016.0, 2018, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 2016, 0, 4, 'default2', '2023-01-01', 'default1', 'Chinese Grand Prix'), (4, 0, 0, 3, 'default1', '2023-01-01', 'default1', 'default2'), (2, 0, 0, 2017, 'Chinese Grand Prix', '2023-01-02', 'default1', 'default1'), (3, 6, 0, 2, 'Chinese Grand Prix', '2023-01-02', 'default1', NULL), (2018, 5, 0, 2018, 'Chinese Grand Prix', '2023-01-02', NULL, 'unique_4'), (2016, 2018, 0, 2, 'default2', '2023-01-01', NULL, 'unique_5'), (2017, 2, 0, 1, 'Chinese Grand Prix', '2023-01-01', 'default1', 'unique_6'), (1, 1, 0, 2018, 'default2', '2023-01-01', 'default1', 'unique_7'), (5, 11, 0, 2016, 'default2', '2023-01-01', 'default2', 'unique_8'), (6, 7, 0, 2017, 'default2', '2023-01-01', 'default1', 'unique_9'), (7, 3, 0, 2017, 'Chinese Grand Prix', '2023-01-02', 'default2', 'unique_10'), (8, 10, 0, 3, 'default2', '2023-01-01', 'Chinese Grand Prix', 'unique_11'), (9, 4, 0, 0, 'default1', '2023-01-01', 'default1', 'unique_12'), (10, 6, 0, 2017, 'Chinese Grand Prix', '2023-01-02', 'default2', 'unique_13'), (11, 7, 0, 2016, 'default2', '2023-01-01', 'default1', 'unique_14'), (12, 2017, 0, 0, 'Chinese Grand Prix', '2023-01-01', 'default1', 'unique_15'), (13, 12, 0, 2018, 'Chinese Grand Prix', '2023-01-01', 'Chinese Grand Prix', 'unique_16');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (2018, 11, 2017, 1.0, 4, 'Chinese Grand Prix', 2), (0, 12, 2017, 2018.0, 2016, 'default2', 4), (4, 13, 4, 4.0, NULL, 'default2', 0), (2, 3, 2017, 0.0, 2, 'default2', 0), (1, 8, 2017, 2017.0, 2016, 'default2', 2016), (2016, 3, 2016, 2.0, 2, 'default1', 0), (2017, 2016, 4, 2.0, 2017, 'default2', 2018), (3, 2, 4, 3.0, 2017, 'Chinese Grand Prix', 2), (5, 2, 2016, 3.0, 1, 'Chinese Grand Prix', 2016), (6, 9, 2017, 1.0, 2, 'default1', 4), (7, 2, 2017, 1.0, 2017, 'Chinese Grand Prix', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('default2', 'Chinese Grand Prix', 2018.0)
*/

-- Prediction Query
SELECT drivers.forename, drivers.surname, results.points FROM results INNER JOIN drivers ON results.driverId = drivers.driverId INNER JOIN races ON results.raceId = races.raceId WHERE races.name = 'Chinese Grand Prix' AND races.year = 2017 ORDER BY results.points DESC, results.resultid NULLS LAST, drivers.driverid NULLS LAST, races.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
*/