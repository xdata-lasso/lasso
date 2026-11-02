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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (24, -2147483648, 2122220075, -2147483648, 'p6luhvdlttil', '2020-04-02', 'nprmdposii', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, 1692174491, -2147483648, 'qi2rkf9v', '2022-12-15', 'x58pz0f8je', 'url_2');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, '5k5swwqcgs', 'name_1', 't2__fb7550', '9n8');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483647, 'w6kl', 'A', 't2__fb7550', 'a9');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, 'cigce376nium', 'name_3', '52zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, '02eutliqa11r', 'name_4', 't2__fb7550', 'ytoo3o9');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4, '5k5swwqcgs', 'name_5', '9n8', '4');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (5, 'e4', 'name_6', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (6, 'bnp', 'name_7', 'mdpos', 'ie5');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (7, '5k5swwqcgs', 'name_8', '9n8', '4');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483640, 'gu7v', 'name_9', NULL, 'e4');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '4', 'gu7v', 'e4', 'hria2ypuzhs', 663.049759, 711.020062, 1908028688, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: constructorresults --
INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483648, 24, 1, 1.0, '5u');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483647, 24, 1, 1.0, '00t5c4e');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483646, 24, 3, 1.0, 'p');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483645, 24, 3, 1.0, 'l7');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483644, 24, 3, 1.0, 'klex14ji');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483643, 24, 3, 1.0, '7zwau2dwyr');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (2, 24, 1, 1.0, '13pyu');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (3, 24, 1, 1.0, '8d99rljsl');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483640, 1, 1, 1.0, 'd2');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483639, 24, 1, 101.0, 'vy9uxj4');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (-2147483638, 24, 1, 1.0, 'wb');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (4, 24, 4, NULL, 'gu7v');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (5, 1, 5, 101.0, 'tti');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (6, 1, 6, NULL, 'nw6klf');

INSERT INTO "constructorresults" ("constructorresultsid", "raceid", "constructorid", "points", "status") VALUES (7, 24, 7, 1.0, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.nationality FROM constructorResults AS T1 INNER JOIN constructors AS T2 ON T2.constructorId = T1.constructorId WHERE T1.raceId = 24 AND T1.points = 1;

/*
Gold Result:
('t2__fb7550',)
('t2__fb7550',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('52zbuo4nrq',)
('t2__fb7550',)
('t2__fb7550',)
('t2__fb7550',)
('9n8',)
*/

-- Prediction Query
SELECT DISTINCT constructors.constructorid FROM constructorresults INNER JOIN constructors ON constructorresults.constructorid = constructors.constructorid WHERE constructorresults.raceid = 24 AND constructorresults.points = 1;

/*
Prediction Result:
(1,)
(3,)
(7,)
*/