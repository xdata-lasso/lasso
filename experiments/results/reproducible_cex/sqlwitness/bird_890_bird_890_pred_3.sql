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
INSERT INTO seasons (year, url) VALUES (1, 'British Grand Prix'), (0, 'default2'), (2, 'default1'), (3, 'Silverstone Circuit'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Silverstone Circuit', 'Silverstone Circuit', NULL, 'default2', NULL, NULL, 1, 'default2');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 3, 1, 1, 'Silverstone Circuit', '2023-01-01', 'default2', NULL), (1, 2, 1, 0, 'default2', '2023-01-02', 'default2', 'default2'), (2, 6, 1, 1, 'default1', '2023-01-01', NULL, 'default1'), (3, 7, 1, 0, 'default1', '2023-01-02', 'Silverstone Circuit', 'Silverstone Circuit'), (4, 3, 1, 1, 'default1', '2023-01-02', 'British Grand Prix', 'British Grand Prix'), (5, 0, 1, 0, 'British Grand Prix', '2023-01-02', 'default2', 'unique_5'), (6, 0, 1, 0, 'default1', '2023-01-02', 'default1', 'unique_6'), (7, 0, 1, 1, 'Silverstone Circuit', '2023-01-02', 'British Grand Prix', 'unique_7'), (8, 7, 1, 0, 'Silverstone Circuit', '2023-01-02', 'default2', 'unique_8'), (9, 0, 1, 0, 'default2', '2023-01-01', 'Silverstone Circuit', 'unique_9'), (10, 7, 1, 0, 'default2', '2023-01-01', NULL, 'unique_10'), (11, 2, 1, 0, 'British Grand Prix', '2023-01-02', NULL, 'unique_11'), (12, 4, 1, 0, 'Silverstone Circuit', '2023-01-02', 'default1', 'unique_12'), (13, 1, 1, 0, 'default1', '2023-01-01', 'default2', 'unique_13'), (14, 7, 1, 1, 'Silverstone Circuit', '2023-01-01', 'default2', 'unique_14'), (15, 7, 1, 1, 'British Grand Prix', '2023-01-01', 'Silverstone Circuit', 'unique_15'), (16, 7, 1, 0, 'default1', '2023-01-01', 'default2', 'unique_16'), (17, 1, 1, 1, 'Silverstone Circuit', '2023-01-01', 'default2', 'unique_17'), (18, 7, 1, 0, 'Silverstone Circuit', '2023-01-02', 'default2', 'unique_18'), (19, 3, 1, 1, 'default1', '2023-01-01', 'default1', 'unique_19'), (20, 2, 1, 1, 'British Grand Prix', '2023-01-02', 'Silverstone Circuit', 'unique_20'), (21, 7, 1, 1, 'Silverstone Circuit', '2023-01-02', 'Silverstone Circuit', 'unique_21'), (22, 6, 1, 0, 'default2', '2023-01-02', 'British Grand Prix', 'unique_22'), (23, 2, 1, 1, 'default2', '2023-01-01', NULL, 'unique_23'), (24, 5, 1, 1, 'default2', '2023-01-02', 'default2', 'unique_24'), (25, 5, 1, 0, 'British Grand Prix', '2023-01-02', 'Silverstone Circuit', 'unique_25'), (26, 6, 1, 0, 'default2', '2023-01-02', 'default1', 'unique_26'), (27, 7, 1, 1, 'Silverstone Circuit', '2023-01-02', 'default1', 'unique_27'), (28, 0, 1, 0, 'British Grand Prix', '2023-01-01', 'default1', 'unique_28'), (29, 3, 1, 1, 'Silverstone Circuit', '2023-01-01', 'Silverstone Circuit', 'unique_29'), (30, 7, 1, 0, 'default2', '2023-01-02', NULL, 'unique_30'), (31, 1, 1, 1, 'British Grand Prix', '2023-01-01', 'default1', 'unique_31'), (32, 7, 1, 0, 'default2', '2023-01-02', 'default1', 'unique_32'), (33, 5, 1, 0, 'default2', '2023-01-02', 'default2', 'unique_33'), (34, 5, 1, 0, 'default2', '2023-01-02', 'default1', 'unique_34'), (35, 4, 1, 1, 'default1', '2023-01-01', 'default1', 'unique_35'), (36, 0, 1, 1, 'default2', '2023-01-01', NULL, 'unique_36'), (37, 7, 1, 0, 'default1', '2023-01-02', 'British Grand Prix', 'unique_37'), (38, 1, 1, 0, 'default1', '2023-01-01', 'default2', 'unique_38'), (39, 1, 1, 1, 'British Grand Prix', '2023-01-02', 'default1', 'unique_39'), (40, 7, 1, 0, 'Silverstone Circuit', '2023-01-01', NULL, 'unique_40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.circuitid) FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.name = 'Silverstone Circuit' AND T2.name = 'British Grand Prix';

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.year) FROM circuits AS T1 INNER JOIN races AS T2 ON T1.circuitId = T2.circuitId WHERE T1.name = 'Silverstone Circuit' AND T2.name = 'British Grand Prix';

/*
Prediction Result:
(5,)
*/