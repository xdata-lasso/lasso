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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, -2147483648, -1399556171, -2147483648, 'a9000t5c4eci', '2021-03-18', 'e', 'url_1');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'Lewis', 'Hamilton', '2025-06-04', 'hria2ypuzhs', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'zbuo4nrqrof', 373262291, 'p5s5bbp', 'Lewis', 'Hamilton', '2024-08-27', '2eutliqa11r', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '72klex14ji7z', -2081315180, '2dwyrq13pyu7', 'Lewis', 'Hamilton', '2020-07-21', '9rljsl0b4', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'p5qi2rkf9v', 556727997, '8pz0f8je', 'd2', 'vy9uxj4', '2021-05-25', 'bdvlph', 'url_4');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: laptimes --
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483648, -1585009206, 't1__815b1c', -53231346);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483647, -525979501, 't1__815b1c', 1898504886);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483646, 1644911394, 't1__815b1c', -1666765085);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 2, -2147483645, -261132974, 't1__815b1c', -1264842910);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 2, -2147483644, -664193365, 't1__815b1c', -1070063173);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 2, -2147483643, 722884590, 't1__815b1c', 580968159);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483642, -1106350634, 't1__815b1c', -1509264256);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483641, -361507387, 't1__8e6beb', 401805964);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483640, -1742081330, 't1__815b1c', 894242932);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483639, -1762857309, 't1__8e6beb', 806170397);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483638, -688216274, 't1__815b1c', 331812443);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483637, 1631231566, 't1__8e6beb', 172461907);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483636, 1443629118, 't1__815b1c', -155284187);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483635, -1554531873, 't1__815b1c', 982314585);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483634, 1038566008, 'n6vck6ah0f', 138842628);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-2147483648, 1, -2147483633, -658391922, NULL, -1388029300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.time FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton';

/*
Gold Result:
('t1__815b1c',)
('t1__815b1c',)
('t1__815b1c',)
('t1__815b1c',)
('t1__8e6beb',)
('t1__815b1c',)
('t1__8e6beb',)
('t1__815b1c',)
('t1__8e6beb',)
('t1__815b1c',)
('t1__815b1c',)
('n6vck6ah0f',)
(None,)
*/

-- Prediction Query
SELECT l.time FROM lapTimes AS l JOIN drivers AS d ON l.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY l.milliseconds ASC, l.raceid NULLS LAST, l.driverid NULLS LAST, l.lap NULLS LAST, d.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__815b1c',)
*/