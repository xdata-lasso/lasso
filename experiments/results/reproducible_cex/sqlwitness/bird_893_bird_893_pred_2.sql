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
INSERT INTO status (statusid, status) VALUES (2017, 'default2'), (2018, 'default1'), (4, 'default1'), (0, 'default2'), (2016, 'default2');
INSERT INTO seasons (year, url) VALUES (2018, 'Chinese Grand Prix'), (0, 'default2'), (3, 'default1'), (2017, 'unique_3');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (0, 'default2', 2018, 'Chinese Grand Prix', 'default2', 'default2', '2023-01-02', 'default1', 'Chinese Grand Prix'), (2017, 'default2', 3, 'default1', 'Chinese Grand Prix', 'Chinese Grand Prix', '2023-01-01', NULL, 'default2'), (4, 'default2', 2017, 'default2', 'default1', 'default1', NULL, 'default1', 'default1'), (2016, 'Chinese Grand Prix', 1, 'default2', 'Chinese Grand Prix', 'default1', NULL, 'default2', 'unique_3'), (2, 'Chinese Grand Prix', 2017, 'Chinese Grand Prix', 'default2', 'default2', NULL, NULL, 'unique_4'), (3, 'Chinese Grand Prix', NULL, NULL, 'default1', 'default2', '2023-01-01', 'Chinese Grand Prix', 'unique_5'), (2018, 'default2', 2018, NULL, 'default2', 'default2', '2023-01-02', 'default1', 'unique_6'), (1, 'default2', 2, NULL, 'Chinese Grand Prix', 'Chinese Grand Prix', NULL, 'Chinese Grand Prix', 'unique_7'), (5, 'Chinese Grand Prix', 1, NULL, 'Chinese Grand Prix', 'default2', '2023-01-01', 'default2', 'unique_8'), (6, 'default2', 2016, 'Chinese Grand Prix', 'Chinese Grand Prix', 'default1', '2023-01-02', 'Chinese Grand Prix', 'unique_9'), (7, 'default2', 3, 'default1', 'Chinese Grand Prix', 'default1', '2023-01-02', 'default1', 'unique_10');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (2016, 'Chinese Grand Prix', 'default2', 'Chinese Grand Prix', 'Chinese Grand Prix', 2017.0, 1.0, 2, 'default1'), (3, 'Chinese Grand Prix', 'default1', 'Chinese Grand Prix', 'default1', 2017.0, 2018.0, 2016, 'Chinese Grand Prix'), (2018, 'default2', 'Chinese Grand Prix', 'default2', NULL, NULL, 4.0, 2016, 'default2'), (0, 'default1', 'default2', 'Chinese Grand Prix', 'Chinese Grand Prix', 2018.0, 1.0, 2016, 'unique_3'), (1, 'Chinese Grand Prix', 'default2', 'default2', 'default1', 1.0, 1.0, 2018, 'unique_4'), (2, 'default2', 'default1', 'default1', 'Chinese Grand Prix', 1.0, 2016.0, NULL, 'unique_5'), (2017, 'Chinese Grand Prix', 'default2', 'default1', 'Chinese Grand Prix', 2018.0, 2016.0, 0, 'unique_6'), (4, 'Chinese Grand Prix', 'default2', 'Chinese Grand Prix', NULL, 2.0, 3.0, 2018, 'unique_7'), (5, 'default2', 'default2', 'default1', 'default2', 2016.0, 1.0, 3, 'unique_8'), (6, 'Chinese Grand Prix', 'default2', NULL, NULL, 4.0, 2017.0, 2016, 'unique_9'), (7, 'default1', 'default2', 'default2', NULL, 2017.0, 4.0, 2, 'unique_10'), (8, 'Chinese Grand Prix', 'default2', 'default1', 'Chinese Grand Prix', 1.0, 4.0, 2016, 'unique_11'), (9, 'Chinese Grand Prix', 'default1', NULL, NULL, 3.0, 2016.0, 1, 'unique_12');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (2018, 2017, 4, 3, 'Chinese Grand Prix', '2023-01-02', 'default2', NULL), (4, 2018, 5, 2018, 'default2', '2023-01-02', 'default1', 'Chinese Grand Prix'), (2, 3, 1, 3, 'default1', '2023-01-01', NULL, 'default1'), (1, 2017, 0, 4, 'Chinese Grand Prix', '2023-01-02', 'Chinese Grand Prix', 'default2'), (0, 3, 3, 2, 'default1', '2023-01-02', 'default2', 'unique_4'), (2017, 2017, 4, 0, 'default2', '2023-01-01', 'default2', 'unique_5'), (2016, 3, 5, 2016, 'default2', '2023-01-02', 'default2', 'unique_6');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (2016, 1, 2, 3.0, 2018, 'default1', 2016), (2018, 4, 2018, 4.0, 4, 'default2', 2), (0, 0, 0, 2018.0, 2016, NULL, 0), (1, 4, 1, 1.0, 2016, 'default2', 2016), (2017, 4, 7, 2016.0, 2017, 'Chinese Grand Prix', 2016), (3, 2016, 4, 0.0, 3, 'default1', 1), (2, 2016, 2, 2.0, 1, 'default1', 2017);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.forename, T3.surname, T2.points FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.name = 'Chinese Grand Prix' AND T1.year = 2017 ORDER BY T2.points DESC, T1.raceid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.driverid NULLS LAST LIMIT 3;

/*
Gold Result:
('default2', 'default2', 3.0)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T3.points FROM drivers AS T1 INNER JOIN results AS T3 ON T1.driverId = T3.driverId INNER JOIN races AS T4 ON T3.raceId = T4.raceId WHERE T4.year = 2017 AND T4.name = 'Chinese Grand Prix' ORDER BY T3.points DESC, T1.driverid NULLS LAST, T3.resultid NULLS LAST, T4.raceid NULLS LAST LIMIT 3;

/*
Prediction Result:
*/