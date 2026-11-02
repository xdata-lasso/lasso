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
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (2, 'default2', 2, NULL, 'Hamilton', 'Hamilton', '2023-01-01', 'default2', 'Hamilton'), (0, 'default1', 1, 'Hamilton', 'Hamilton', 'Hamilton', '2023-01-02', 'Lewis', 'default2'), (1, 'Lewis', 0, 'default1', 'default2', 'default2', NULL, 'Lewis', 'Lewis'), (3, 'Lewis', NULL, 'Lewis', 'default1', 'Lewis', '2023-01-01', 'Hamilton', 'default1'), (4, 'default1', 1, NULL, 'Lewis', 'Hamilton', '2023-01-02', 'Hamilton', 'unique_4'), (5, 'default2', 1, 'default1', 'Hamilton', 'default1', '2023-01-01', 'Hamilton', 'unique_5'), (6, 'default2', 0, 'default2', 'Lewis', 'Hamilton', '2023-01-01', NULL, 'unique_6'), (7, 'default1', NULL, 'Hamilton', 'Hamilton', 'Hamilton', '2023-01-02', 'default1', 'unique_7'), (8, 'default1', 0, NULL, 'default2', 'default2', '2023-01-01', NULL, 'unique_8'), (9, 'default2', 1, NULL, 'default1', 'Hamilton', '2023-01-02', NULL, 'unique_9'), (10, 'Hamilton', 2, 'Hamilton', 'Lewis', 'default1', '2023-01-02', 'default1', 'unique_10'), (11, 'default1', 0, NULL, 'default1', 'Lewis', '2023-01-01', 'default1', 'unique_11'), (12, 'default1', 1, 'default1', 'Lewis', 'Lewis', '2023-01-01', 'Lewis', 'unique_12'), (13, 'Lewis', 0, 'Lewis', 'Hamilton', 'default2', '2023-01-02', NULL, 'unique_13'), (14, 'Hamilton', 0, 'default1', 'Lewis', 'Lewis', '2023-01-01', 'default1', 'unique_14'), (15, 'Hamilton', 2, 'Hamilton', 'default1', 'Lewis', '2023-01-02', 'default2', 'unique_15'), (16, 'default2', 0, 'default1', 'Hamilton', 'Hamilton', '2023-01-01', 'default1', 'unique_16'), (17, 'Hamilton', NULL, NULL, 'Hamilton', 'Hamilton', NULL, 'Hamilton', 'unique_17'), (18, 'default2', 2, 'Lewis', 'default1', 'default2', '2023-01-01', NULL, 'unique_18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT driverRef FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton';

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT driverRef FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton' LIMIT 1;

/*
Prediction Result:
('default1',)
*/