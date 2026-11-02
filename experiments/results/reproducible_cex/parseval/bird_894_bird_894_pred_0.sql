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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -1399556171, -2147483648, 't3__ecde77', '2020-01-23', '9000t5c4ec', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, -188151580, -2147483648, 't3__ecde77', '2021-04-03', '72k', 'C');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, 1055976837, -2147483648, 't3__ecde77', '2024-10-22', 'ji7zwau2', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -977635379, -2147483648, 'sl0', '2020-04-20', 'yp5qi2rk', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-1, -2147483648, -1264842910, -2147483648, 't3__ecde77', '2022-11-09', 'nqcx5h', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, -2147483648, -1485777725, -2147483648, '8n2f3', '2020-08-04', 'qv0gcb98ozk', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2436, -2147483648, 138842628, -2147483648, 't3__ecde77', '2023-03-04', 'wlq7xb', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2437, -2147483648, 1294666887, -2147483648, 'fdrz16n', '2021-06-18', 'jai', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, -845863578, -2147483648, 'lbn', '2022-09-14', 'mdpos', 'url_9');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't1__0f4b12', 't1__eb57c2', '2025-06-04', 'hria2ypuzhs', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'zbuo4nrqrof', 373262291, 'p5s5bbp', 't1__0f4b12', 't1__eb57c2', '2024-08-27', '2eutliqa11r', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2437, 'd2', 1675430660, 'y9uxj4', 't1__d09171', 't1__15cc08', '2021-05-25', 'bdvlph', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483645, 'yrk', 32204797, 'k', 't1__d09171', 't1__15cc08', '2025-09-14', 'h', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483644, '1afgo', -1696173285, 'tsj', 't1__d09171', 't1__15cc08', '2025-02-02', 'y', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2438, '4301jh3den8', 195720193, 'vacx7afu5', 't1__d09171', 't1__15cc08', '2023-12-23', '1of77pzo72c', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, 'e1io', -241848752, '8507cvtjp', 't1__d09171', 't1__15cc08', '2023-06-01', 'tg6bnou5zi', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483641, 'r0oz', -870767087, 'j5', 't1__d09171', 't1__15cc08', '2021-05-27', 'lq5lnpim', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, '3', 1803796945, '8uttmu', 't1__d09171', 't1__15cc08', '2025-01-03', 'e578', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, 'pdjwzw5chn9', 101754718, 'a9n0jxfo', 't1__d09171', 't1__15cc08', '2020-12-03', 'szdo2z', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483638, '0k32o', -1898678660, 'l', 't1__d09171', 't1__15cc08', '2025-07-25', 'amsorlwyng', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '2025-08-22', 'uhv', 'url_12');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: laptimes --
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1, 1, 1, -1683203397, 'e376nium52', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2, 1, 1, 364869063, 'q13py', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3, 1, 1, -705985602, 'x58pz0f8je', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-1, 2437, -1, 1575412235, 'jtu0d', -1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 2437, 0, -155284187, 'i', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2437, 1, 0, 1746373317, 'h', -1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (2436, 1, 1, 1583472758, 'rg', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-1, 2438, 0, -1284905200, '62', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 2438, 1, -1744557630, '5q8qdj', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 2438, 0, -1950324754, '7z2zezj', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1, 2438, 1, 1448731351, 'wgxd5ysxc', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-1, 1, -1, -451030047, 'be8yvkv42q7', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 1, 0, -2060082151, 'pmaus3auvmkr', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (-1, 1, 0, 211603887, 'rhizgk1yoey', -1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, 1, 1, 513375398, 'l0hdt6fuq', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (4, 2, -2147483645, -1576219117, '5u', 1861536320);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (0, -2147483640, -2147483644, -1399556171, 'a9000t5c4eci', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.milliseconds, T1.forename, T1.surname, T3.name FROM drivers AS T1 INNER JOIN lapTimes AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId ORDER BY T2.milliseconds ASC, T1.driverid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
(None, 't1__d09171', 't1__15cc08', '8n2f3')
*/

-- Prediction Query
SELECT T1.time, T2.forename, T2.surname, T3.name FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T1.time = (SELECT MIN(time) FROM lapTimes);

/*
Prediction Result:
('5q8qdj', 't1__d09171', 't1__15cc08', '8n2f3')
*/