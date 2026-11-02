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
INSERT INTO status (statusid, status) VALUES (20, 'Alex'), (21, 'Yoong'), (19, 'default2'), (11, 'Alex'), (0, 'default1'), (9, 'default2'), (10, 'default1'), (1, 'default1'), (2, 'Alex'), (3, 'default2'), (4, 'Alex');
INSERT INTO seasons (year, url) VALUES (20, 'Yoong'), (9, 'default1'), (10, 'Alex'), (11, 'default2'), (19, 'unique_4'), (21, 'unique_5');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (21, 'default2', 20, 'Alex', 'default1', 'Yoong', '2023-01-01', 'Yoong', 'Alex'), (19, 'Alex', NULL, NULL, 'Yoong', 'Alex', '2023-01-01', 'Alex', 'default2'), (20, 'Alex', 19, 'Yoong', 'default1', 'Yoong', '2023-01-02', 'default1', 'Yoong'), (11, 'default2', 0, 'Alex', 'Yoong', 'default1', NULL, 'default1', 'default1'), (10, 'Yoong', 0, 'default1', 'default1', 'Alex', '2023-01-01', NULL, 'unique_4'), (0, 'Yoong', 1, 'default1', 'default1', 'default2', NULL, 'default2', 'unique_5'), (9, 'default1', 21, 'Alex', 'default2', 'Alex', '2023-01-02', 'default2', 'unique_6'), (1, 'Alex', 19, NULL, 'Alex', 'Yoong', '2023-01-02', 'Yoong', 'unique_7'), (2, 'default2', NULL, 'Yoong', 'default2', 'Yoong', '2023-01-02', 'default1', 'unique_8'), (3, 'default1', 21, 'Yoong', 'Alex', 'Alex', NULL, 'Yoong', 'unique_9'), (4, 'default1', 19, 'default1', 'Alex', 'Yoong', NULL, NULL, 'unique_10'), (5, 'Yoong', NULL, 'Alex', 'default2', 'default2', NULL, 'Alex', 'unique_11');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (19, 'default1', 'default2', 'Yoong', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Yoong', 'default2', 'default1', 'Yoong', 9.0, 1.0, 11, 'Yoong'), (19, 'default1', 'Alex', 'Alex', 'Yoong', 21.0, 19.0, NULL, 'default1'), (20, 'Alex', 'default2', 'Alex', NULL, 10.0, 9.0, 1, 'Alex'), (21, 'default1', 'Alex', 'Alex', NULL, 10.0, 19.0, 19, 'default2'), (0, 'Alex', 'Yoong', NULL, 'Alex', NULL, 9.0, 20, 'unique_4');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (21, 21, 19, 19, 'Alex', '2023-01-02', 'Yoong', 'Yoong'), (10, 11, 21, 20, 'Alex', '2023-01-01', NULL, NULL), (9, 21, 19, 19, 'Yoong', '2023-01-02', 'Yoong', 'default1'), (19, 10, 0, 11, 'default1', '2023-01-02', 'Alex', 'Alex'), (1, 21, 1, 0, 'default1', '2023-01-02', 'default1', 'default2'), (11, 19, 19, 1, 'Yoong', '2023-01-01', 'Yoong', 'unique_5'), (20, 20, 1, 1, 'Alex', '2023-01-02', 'default1', 'unique_6'), (0, 10, 0, 20, 'default2', '2023-01-02', NULL, 'unique_7'), (2, 21, 21, 1, 'Alex', '2023-01-02', 'default1', 'unique_8'), (3, 20, 21, 9, 'Yoong', '2023-01-01', 'Alex', 'unique_9'), (4, 11, 19, 1, 'default2', '2023-01-01', NULL, 'unique_10'), (5, 20, 0, 1, 'Alex', '2023-01-02', 'default1', 'unique_11'), (6, 21, 1, 10, 'default1', '2023-01-02', 'Yoong', 'unique_12');
INSERT INTO results (resultid, raceid, driverid, constructorid, statusid, number, grid, position, positiontext, positionorder, points, laps, time, milliseconds, fastestlap, rank, fastestlaptime, fastestlapspeed) VALUES (9, 1, 1, 19, 19, 19, 11, 11, 'Alex', 20, 21.0, 0, NULL, 1, 20, 9, 'default1', NULL), (10, 2, 2, 19, 2, 19, 10, 9, 'Alex', 10, 21.0, 20, NULL, 9, 9, 0, 'Alex', NULL), (1, 2, 10, 19, 19, 20, 9, 20, 'default2', 9, 9.0, 1, 'default2', 1, 1, 0, 'default1', 'Yoong'), (21, 3, 3, 19, 1, 1, 20, 19, 'Yoong', 10, 9.0, 21, NULL, 19, 1, 0, NULL, NULL), (11, 4, 19, 19, 9, 20, 9, NULL, 'Yoong', 10, 10.0, 11, 'default2', 21, 19, 1, 'Alex', NULL), (0, 21, 4, 19, 19, NULL, 0, 10, 'Yoong', 1, 21.0, 11, 'default2', 11, NULL, 20, 'Alex', 'Alex'), (20, 1, 9, 19, 11, 11, 11, 20, 'Yoong', 20, 11.0, 11, 'Yoong', 1, 1, 1, 'default1', 'Alex'), (19, 21, 11, 19, 19, 10, 9, NULL, 'Alex', 9, 21.0, 1, 'default1', 1, 20, 11, 'Yoong', 'Alex'), (2, 21, 10, 19, 20, 21, 0, 1, 'Alex', 20, 20.0, 21, 'Yoong', 21, 11, NULL, 'default1', 'default1'), (3, 4, 1, 19, 19, 10, 0, 1, 'Yoong', 11, 0.0, 19, 'Yoong', 11, 11, 10, NULL, 'default2'), (4, 21, 20, 19, 11, 11, 9, 19, 'default1', 20, 0.0, 10, 'default2', 20, 10, 10, NULL, 'default1'), (5, 10, 19, 19, 21, 9, 10, 0, 'default1', 11, 0.0, 21, 'Alex', 21, 9, 1, 'Yoong', 'Yoong');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (20, 3, 20, 9.0, 11, NULL, 20), (21, 6, 21, 0.0, 20, NULL, 10), (19, 3, 1, 21.0, NULL, 'Yoong', 11), (9, 3, 1, 21.0, 1, 'Alex', 19), (11, 10, 3, 9.0, 11, NULL, 0), (10, 5, 1, 9.0, 11, 'Yoong', 9), (1, 4, 3, 9.0, 9, 'default1', 11), (0, 0, 9, 0.0, 20, 'Alex', 21), (2, 1, 11, 9.0, 20, 'Yoong', 11), (3, 11, 19, 19.0, 1, 'default2', 19), (4, 1, 4, 11.0, NULL, 'default2', 11), (5, 6, 1, 1.0, 11, 'Yoong', 20), (6, 21, 19, 20.0, 0, 'Yoong', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
('Yoong',)
*/

-- Prediction Query
SELECT DISTINCT races.name FROM drivers INNER JOIN results ON drivers.driverid = results.driverid INNER JOIN races ON results.raceid = races.raceid WHERE drivers.forename = 'Alex' AND drivers.surname = 'Yoong' AND results.position < 20;

/*
Prediction Result:
('Alex',)
('default2',)
('default1',)
*/