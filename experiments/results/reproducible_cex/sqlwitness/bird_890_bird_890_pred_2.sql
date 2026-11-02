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
INSERT INTO seasons (year, url) VALUES (1, 'Silverstone Circuit'), (0, 'default2'), (2, 'British Grand Prix'), (3, 'default1'), (4, 'unique_4'), (5, 'unique_5'), (6, 'unique_6'), (7, 'unique_7'), (8, 'unique_8'), (9, 'unique_9'), (10, 'unique_10'), (11, 'unique_11'), (12, 'unique_12'), (13, 'unique_13');
INSERT INTO circuits (circuitid, circuitref, name, location, country, lat, lng, alt, url) VALUES (1, 'Silverstone Circuit', 'British Grand Prix', 'British Grand Prix', 'default1', NULL, NULL, 0, 'default1'), (0, 'default1', 'Silverstone Circuit', NULL, 'default2', 0.0, NULL, 0, 'default2'), (2, 'British Grand Prix', 'default2', 'default1', NULL, 0.0, 0.0, NULL, 'Silverstone Circuit'), (3, 'British Grand Prix', 'default2', 'Silverstone Circuit', 'default2', 1.0, 0.0, 1, 'British Grand Prix'), (4, 'British Grand Prix', 'default2', NULL, 'British Grand Prix', 1.0, 1.0, 1, 'unique_4'), (5, 'Silverstone Circuit', 'British Grand Prix', 'default1', 'default1', 0.0, 0.0, NULL, 'unique_5'), (6, 'default2', 'British Grand Prix', 'default1', 'default1', NULL, NULL, NULL, 'unique_6'), (7, 'British Grand Prix', 'British Grand Prix', 'default1', 'default1', 0.0, 1.0, NULL, 'unique_7'), (8, 'British Grand Prix', 'default2', 'default1', 'Silverstone Circuit', 0.0, 1.0, NULL, 'unique_8'), (9, 'default2', 'Silverstone Circuit', 'Silverstone Circuit', 'Silverstone Circuit', NULL, 0.0, 0, 'unique_9'), (10, 'Silverstone Circuit', 'British Grand Prix', NULL, 'default1', 0.0, 1.0, NULL, 'unique_10'), (11, 'default2', 'default1', NULL, 'Silverstone Circuit', NULL, 0.0, 1, 'unique_11'), (12, 'Silverstone Circuit', 'default2', 'Silverstone Circuit', 'Silverstone Circuit', 0.0, 1.0, NULL, 'unique_12'), (13, 'default1', 'Silverstone Circuit', 'default2', 'Silverstone Circuit', NULL, 0.0, 1, 'unique_13'), (14, 'Silverstone Circuit', 'default1', 'default1', 'British Grand Prix', 0.0, 0.0, 0, 'unique_14'), (15, 'default2', 'default1', 'default1', 'default2', NULL, 0.0, NULL, 'unique_15'), (16, 'British Grand Prix', 'default1', 'default2', 'default1', 0.0, 1.0, NULL, 'unique_16'), (17, 'British Grand Prix', 'British Grand Prix', 'default2', 'default1', NULL, NULL, 0, 'unique_17'), (18, 'default2', 'default2', 'Silverstone Circuit', 'British Grand Prix', 0.0, 0.0, 1, 'unique_18'), (19, 'Silverstone Circuit', 'default2', NULL, 'default2', 0.0, 1.0, 1, 'unique_19'), (20, 'default2', 'British Grand Prix', 'Silverstone Circuit', 'British Grand Prix', NULL, 0.0, 1, 'unique_20'), (21, 'British Grand Prix', 'default1', 'default2', 'Silverstone Circuit', NULL, 0.0, 1, 'unique_21'), (22, 'Silverstone Circuit', 'default2', 'Silverstone Circuit', 'default2', NULL, 0.0, 0, 'unique_22');
INSERT INTO races (raceid, year, circuitid, round, name, date, time, url) VALUES (0, 13, 15, 1, 'default2', '2023-01-02', 'default2', 'default2'), (1, 6, 9, 0, 'default2', '2023-01-01', 'British Grand Prix', 'Silverstone Circuit'), (2, 13, 13, 0, 'British Grand Prix', '2023-01-01', 'default1', 'default1'), (3, 12, 13, 0, 'British Grand Prix', '2023-01-02', 'British Grand Prix', 'British Grand Prix'), (4, 6, 17, 0, 'Silverstone Circuit', '2023-01-02', 'default1', NULL), (5, 12, 13, 0, 'British Grand Prix', '2023-01-02', 'British Grand Prix', 'unique_5'), (6, 11, 21, 0, 'default1', '2023-01-02', 'default2', 'unique_6'), (7, 4, 8, 1, 'default2', '2023-01-02', 'Silverstone Circuit', 'unique_7'), (8, 7, 0, 1, 'British Grand Prix', '2023-01-01', 'Silverstone Circuit', 'unique_8'), (9, 3, 0, 1, 'default1', '2023-01-02', NULL, 'unique_9'), (10, 8, 13, 0, 'default1', '2023-01-01', 'Silverstone Circuit', 'unique_10'), (11, 9, 4, 1, 'Silverstone Circuit', '2023-01-01', 'British Grand Prix', 'unique_11'), (12, 10, 11, 1, 'Silverstone Circuit', '2023-01-02', 'British Grand Prix', 'unique_12'), (13, 11, 22, 0, 'default2', '2023-01-01', 'default2', 'unique_13'), (14, 5, 20, 0, 'default2', '2023-01-02', 'Silverstone Circuit', 'unique_14'), (15, 0, 5, 1, 'default1', '2023-01-01', 'default1', 'unique_15'), (16, 0, 12, 1, 'default2', '2023-01-02', NULL, 'unique_16'), (17, 12, 6, 1, 'default1', '2023-01-01', 'British Grand Prix', 'unique_17'), (18, 3, 6, 0, 'Silverstone Circuit', '2023-01-01', NULL, 'unique_18'), (19, 6, 4, 0, 'default1', '2023-01-01', NULL, 'unique_19'), (20, 12, 12, 1, 'default2', '2023-01-01', 'British Grand Prix', 'unique_20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.circuitid) FROM circuits AS T1 INNER JOIN races AS T2 ON T2.circuitID = T1.circuitId WHERE T1.name = 'Silverstone Circuit' AND T2.name = 'British Grand Prix';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "races"."year") FROM "races" INNER JOIN "circuits" ON "races"."circuitid" = "circuits"."circuitid" WHERE "circuits"."name" = 'Silverstone Circuit' AND "races"."name" = 'British Grand Prix';

/*
Prediction Result:
(3,)
*/