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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, 1038707349, -2147483648, '9000t5c4ec', '2021-06-11', 'gce376nium52', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-1, -2147483648, -1390245819, -2147483648, 'x14ji7zwau2d', '2024-01-01', 'yrq13pyu78d9', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, -2147483648, 580968159, -2147483648, 'cprj', '2023-05-30', '0dz79f', 'url_3');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '1981-12-31', 'Spanish', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, '5bbp0', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', '1981-12-31', 'Spanish', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'rljsl0b4y', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', '2021-09-16', 'hwbdvlph', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'qv0gcb98ozk', -155284187, 'i', 'yrk', 'n6vck6ah0f', '1981-12-31', 'Spanish', 'url_4');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'luhvdltti', 'bnp', 'mdpos', 'ie5', 327.753528, 218.301157, -1399556171, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: pitstops --
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, 1, -443340271, 't1__c2b5fd', 'uo4nrqrofqy', -1106983592);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-1, 2, -1, -261132974, 't1__c2b5fd', 'dqwn', -1070063173);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (0, 2, 0, -1485777725, 't1__de5ea8', '8n2f3', 806170397);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (-1, 2, 0, 138842628, 't1__c2b5fd', 'wwlq7', 1255343543);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (0, 2, 1, -541746689, 't1__de5ea8', '7ryfdrz16n', -1496556994);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (0, 2, -1, -2115841792, 't1__c2b5fd', 'dh5ogrgj', -458359144);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 2, 0, 600440952, 't1__de5ea8', 'f', -1717646459);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.driverId FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId WHERE T2.nationality = 'Spanish' AND STRFTIME('%Y', T2.dob) < '1982' ORDER BY T1.time DESC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.stop NULLS LAST, T2.driverid NULLS LAST LIMIT 10;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT d.forename, d.surname, lt.time FROM drivers AS d INNER JOIN (SELECT driverid, MAX(time) AS time FROM laptimes GROUP BY driverid) AS lt ON d.driverid = lt.driverid WHERE d.nationality = 'Spanish' AND d.dob < '1982-01-01' ORDER BY lt.time DESC, d.driverid NULLS LAST LIMIT 10;

/*
Prediction Result:
*/