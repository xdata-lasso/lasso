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
-- Inserting into table: races --
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, 2026480202, -2147483648, 't3__0e9b02', '2021-06-28', 'e5u', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, 1884179925, -2147483648, 't3__0e9b02', '2025-08-08', 'bbp02eutliqa', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, 274769912, -2147483648, 'oo3o9', '2021-04-03', '72k', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, -2147483648, 1836127587, -2147483648, 't3__0e9b02', '2024-08-06', 'f8jegd21vy9u', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, -1245682094, -2147483648, 'x', '2025-07-02', 'hncprjtu0dz', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-1, -2147483648, 331812443, -2147483648, 't3__0e9b02', '2020-06-01', '9', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, -59984348, -2147483648, 'wqcgsk', '2022-04-27', '8c4pgu7vfe', 'url_7');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't1__6cbdea', 't1__76d84c', '2025-06-04', 't1__cb2668', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, '00t5c4ecigc', 528680845, '76nium52', 't1__6cbdea', 't1__76d84c', '2024-06-13', 't1__cb2668', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'u', -1179823637, 'rqro', 't1__6cbdea', 't1__76d84c', '2020-12-02', 't1__cb2668', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 'dwyrq13pyu78', 244829661, 'jsl', 't1__6cbdea', 't1__76d84c', '2024-09-13', 't1__cb2668', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, '4', 1649269347, 'p5qi2rkf9v', 't1__40d8b8', 't1__c4bb8e', '2022-12-15', 't1__60a571', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'hria2ypu', 1644814318, 'sr', 'wbbp6luhvdlt', 'ilbnp', '2023-01-01', NULL, 'url_6');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 986.066566, 907682809, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: driverstandings --
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1, 1, 1, 933.422701, 44952191, 'fa9', 1620389964);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483647, 3, 2, 176.308171, 1055976837, '4ji7zwa', 2123196517);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (0, 0, 3, 479.592965, -629784617, 'v', 1581736075);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-1, 2, -1, 521.610309, -1748371085, 'q8', -1255130038);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2, 1, 1, 692.775559, -688098735, '6ah', -348113485);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3, 1, 1, 532.326819, -932772113, 'lq7xb7', 602161869);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (4, 4, 4, 986.066566, 907682809, 'siie', -45536098);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname, T1.nationality, T3.name FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId ORDER BY JULIANDAY(T1.dob) DESC, T1.driverid NULLS LAST, T2.driverstandingsid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__6cbdea', 't1__76d84c', 't1__cb2668', 't3__0e9b02')
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T1.nationality, T3.name FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId ORDER BY T1.dob DESC, T1.driverid NULLS LAST, T2.resultid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/