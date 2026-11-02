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
INSERT INTO seasons (year, url) VALUES (902, 'default1'), (1, '1:54%'), (0, 'default2'), (904, 'unique_3'), (903, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15'), (13, 'unique_16'), (14, 'unique_17'), (15, 'unique_18'), (16, 'unique_19'), (17, 'unique_20'), (18, 'unique_21'), (19, 'unique_22'), (20, 'unique_23');
INSERT INTO drivers (driverid, driverref, number, code, forename, surname, dob, nationality, url) VALUES (902, '1:54%', 904, 'default1', 'default2', '1:54%', '2023-01-02', 'default2', 'default2'), (0, 'default2', 0, NULL, 'default2', '1:54%', '2023-01-01', '1:54%', '1:54%'), (1, 'default2', 0, 'default2', '1:54%', 'default2', '2023-01-01', NULL, 'default1'), (903, '1:54%', NULL, NULL, 'default1', '1:54%', '2023-01-01', 'default2', 'unique_3'), (904, 'default2', 903, 'default1', 'default1', '1:54%', NULL, 'default1', 'unique_4'), (2, 'default2', 1, 'default1', '1:54%', 'default2', '2023-01-01', 'default1', 'unique_5'), (3, '1:54%', 904, 'default1', 'default1', 'default1', '2023-01-02', 'default1', 'unique_6'), (4, 'default1', 902, 'default1', 'default1', 'default1', NULL, NULL, 'unique_7'), (5, 'default1', 903, 'default2', 'default2', '1:54%', '2023-01-01', 'default1', 'unique_8'), (6, 'default2', 902, 'default1', 'default2', 'default1', '2023-01-02', NULL, 'unique_9'), (7, 'default1', NULL, 'default1', 'default1', 'default1', '2023-01-02', 'default2', 'unique_10'), (8, '1:54%', 0, 'default1', 'default1', '1:54%', '2023-01-01', NULL, 'unique_11'), (9, '1:54%', NULL, NULL, 'default2', 'default1', '2023-01-02', NULL, 'unique_12'), (10, '1:54%', 0, 'default1', '1:54%', '1:54%', NULL, 'default1', 'unique_13'), (11, 'default1', 903, '1:54%', '1:54%', '1:54%', '2023-01-01', NULL, 'unique_14'), (12, '1:54%', 903, 'default2', 'default1', '1:54%', '2023-01-02', '1:54%', 'unique_15'), (13, '1:54%', NULL, NULL, '1:54%', '1:54%', NULL, 'default1', 'unique_16'), (14, '1:54%', 902, 'default1', 'default2', 'default2', NULL, 'default2', 'unique_17'), (15, '1:54%', 902, 'default1', '1:54%', 'default2', NULL, 'default2', 'unique_18'), (16, 'default1', 902, NULL, 'default1', '1:54%', '2023-01-02', '1:54%', 'unique_19');
INSERT INTO constructors (constructorid, constructorref, name, nationality, url) VALUES (904, 'default1', 'default1', NULL, 'default1'), (903, '1:54%', 'default2', 'default1', '1:54%'), (1, '1:54%', '1:54%', 'default2', '1:54%'), (902, '1:54%', 'unique_3', 'default2', 'default1'), (0, 'default1', 'unique_4', 'default1', 'default1'), (2, '1:54%', 'unique_5', NULL, '1:54%'), (3, 'default1', 'unique_6', '1:54%', 'default2'), (4, 'default2', 'unique_7', '1:54%', 'default2'), (5, '1:54%', 'unique_8', 'default1', 'default2'), (6, 'default2', 'unique_9', 'default2', 'default2'), (7, 'default1', 'unique_10', NULL, '1:54%'), (8, 'default2', 'unique_11', '1:54%', 'default2'), (9, 'default2', 'unique_12', 'default1', '1:54%'), (10, 'default2', 'unique_13', 'default2', 'default2'), (11, '1:54%', 'unique_14', '1:54%', '1:54%'), (12, 'default2', 'unique_15', 'default1', '1:54%'), (13, '1:54%', 'unique_16', '1:54%', 'default1'), (14, 'default2', 'unique_17', 'default1', '1:54%'), (15, '1:54%', 'unique_18', '1:54%', 'default1'), (16, '1:54%', 'unique_19', NULL, 'default1'), (17, '1:54%', 'unique_20', 'default2', 'default1');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, '1:54%', '1:54%', NULL, NULL, 903.0, 902.0, 902, 'default1');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (903, 4, 1, 1, '1:54%', '2023-01-02', 'default2', 'default2'), (904, 19, 1, 902, '1:54%', '2023-01-01', NULL, 'default1'), (0, 16, 1, 1, '1:54%', '2023-01-01', 'default1', NULL), (902, 17, 1, 903, '1:54%', '2023-01-02', 'default1', '1:54%'), (1, 17, 1, 0, 'default1', '2023-01-02', 'default2', 'unique_4'), (2, 902, 1, 904, 'default2', '2023-01-02', NULL, 'unique_5'), (3, 8, 1, 904, 'default2', '2023-01-02', 'default1', 'unique_6'), (4, 1, 1, 0, 'default2', '2023-01-01', 'default1', 'unique_7'), (5, 17, 1, 1, 'default2', '2023-01-02', 'default1', 'unique_8'), (6, 9, 1, 1, '1:54%', '2023-01-02', 'default1', 'unique_9'), (7, 18, 1, 903, '1:54%', '2023-01-01', NULL, 'unique_10'), (8, 0, 1, 1, 'default2', '2023-01-02', NULL, 'unique_11');
INSERT INTO qualifying (qualifyid, raceid, driverid, constructorid, number, position, q1, q2, q3) VALUES (902, 904, 11, 0, 0, 902, 'default1', 'default1', 'default1'), (903, 904, 2, 13, 904, 904, 'default1', 'default1', NULL), (0, 7, 4, 12, 903, 904, 'default1', NULL, NULL), (1, 1, 12, 6, 904, 903, NULL, '1:54%', NULL), (904, 8, 903, 10, 902, NULL, NULL, '1:54%', '1:54%'), (2, 7, 904, 903, 1, 1, NULL, 'default1', 'default2'), (3, 0, 3, 6, 1, 1, '1:54%', NULL, 'default2'), (4, 4, 9, 15, 903, NULL, 'default2', NULL, 'default1'), (5, 8, 4, 3, 904, NULL, '1:54%', NULL, '1:54%'), (6, 7, 12, 903, 904, 0, 'default2', NULL, NULL), (7, 8, 4, 14, 903, 904, '1:54%', NULL, '1:54%'), (8, 7, 3, 2, 0, 904, '1:54%', '1:54%', 'default2'), (9, 8, 5, 5, 0, 903, 'default2', 'default1', 'default2'), (10, 1, 15, 8, 903, 902, 'default1', 'default1', NULL), (11, 904, 12, 2, 902, 0, 'default1', 'default1', '1:54%'), (12, 903, 8, 4, 1, 1, NULL, NULL, '1:54%'), (13, 1, 9, 14, 902, 0, '1:54%', NULL, 'default2'), (14, 904, 2, 1, 902, 1, 'default1', 'default2', NULL), (15, 904, 8, 4, 903, 904, NULL, '1:54%', NULL), (16, 902, 6, 5, 1, NULL, 'default2', 'default1', NULL), (17, 3, 13, 904, 0, 902, 'default1', 'default1', NULL), (18, 7, 8, 10, 902, 902, 'default1', 'default1', 'default2'), (19, 0, 12, 8, 1, 903, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.number FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T2.driverId = T1.driverId WHERE T1.raceId = 903 AND T1.q3 LIKE '1:54%';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT number FROM qualifying WHERE raceId = 903 AND q3 LIKE '1:54%';

/*
Prediction Result:
(1,)
*/