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
INSERT INTO seasons (year, url) VALUES (9, 'default2'), (21, 'default1'), (0, 'Yoong'), (10, 'Alex'), (1, 'unique_4'), (19, 'unique_5'), (11, 'unique_6'), (20, 'unique_7'), (2, 'unique_8');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (20, 'default2', NULL, 'default2', 'Yoong', 'default2', '2023-01-02', 'Yoong', 'Yoong'), (11, 'Yoong', 1, 'default1', 'Alex', 'Yoong', NULL, NULL, 'default2'), (10, 'Alex', NULL, 'default1', 'Yoong', 'default1', '2023-01-02', 'default2', 'Alex'), (19, 'default2', 1, 'Alex', 'Yoong', 'Yoong', '2023-01-01', 'default1', 'default1'), (21, 'Yoong', 21, 'Yoong', 'default1', 'Alex', '2023-01-02', 'Alex', 'unique_4'), (9, 'Yoong', 0, NULL, 'default2', 'default1', '2023-01-02', 'Alex', 'unique_5'), (0, 'Yoong', 11, 'default1', 'Yoong', 'Yoong', '2023-01-01', 'default1', 'unique_6'), (1, 'Yoong', 21, 'Alex', 'default2', 'Yoong', '2023-01-02', NULL, 'unique_7'), (2, 'default2', 9, NULL, 'default1', 'default2', '2023-01-02', 'default2', 'unique_8');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (9, 'default2', 'default1', 'Alex', 'default1', 20.0, 9.0, 19, 'Yoong'), (19, 'Alex', 'Yoong', 'Yoong', 'default1', 21.0, 20.0, 20, 'default2'), (20, 'Yoong', 'default1', NULL, 'default2', 1.0, 19.0, 0, 'default1'), (1, 'default2', 'default1', 'default1', 'default1', 19.0, 0.0, 20, 'Alex'), (11, 'default1', 'Alex', 'Alex', 'Alex', 9.0, 10.0, 11, 'unique_4'), (21, 'Alex', 'Alex', 'Alex', 'default1', 19.0, 1.0, 11, 'unique_5'), (10, 'Alex', 'default2', 'default1', 'Yoong', 10.0, 11.0, NULL, 'unique_6'), (0, 'Yoong', 'Alex', 'Yoong', NULL, 9.0, 9.0, 0, 'unique_7'), (2, 'default2', 'Alex', 'default1', 'Yoong', 20.0, 11.0, 10, 'unique_8'), (3, 'Alex', 'Yoong', 'Yoong', NULL, 20.0, 1.0, NULL, 'unique_9');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (19, 1, 10, 11, 'default1', '2023-01-02', 'default1', 'Yoong'), (11, 20, 2, 1, 'default1', '2023-01-02', 'Yoong', 'Alex');
INSERT INTO driverstandings (driverstandingsid, raceid, driverid, points, position, positiontext, wins) VALUES (19, 11, 2, 9.0, 10, 'Yoong', 11), (9, 19, 2, 20.0, 1, 'Alex', 20), (10, 19, 11, 19.0, 10, NULL, 10), (20, 19, 1, 9.0, 10, 'Alex', 10), (11, 19, 1, 1.0, 1, 'default1', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Alex' AND T3.surname = 'Yoong' AND T2.position < 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT r.name FROM races AS r JOIN driverStandings AS ds ON r.raceId = ds.raceId JOIN drivers AS d ON ds.driverId = d.driverId WHERE d.forename = 'Alex' AND d.surname = 'Yoong' AND ds.position < 20;

/*
Prediction Result:
('default1',)
*/