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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 1, -1399556171, -2147483648, 't1__4b0251', '2020-01-23', '9000t5c4ec', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, 1, -188151580, -2147483648, 't1__4b0251', '2021-04-03', '72k', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 1, -305670381, -2147483648, 't1__4b0251', '2021-08-16', '7zw', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, 1, 2123196517, -2147483648, 't1__c01985', '2020-08-25', 'yrq13p', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1, 176380444, -2147483648, '9rljsl0b4', '2024-04-25', 'p5qi2rkf9v', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483643, 1, 195720193, -2147483648, 't1__c01985', '2023-10-28', 'c', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483642, 1, 1371234901, -2147483648, 't1__c01985', '2023-12-23', '1of77pzo72c', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1, 1908028688, -2147483648, 'p', '2025-08-22', 'uhv', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, 1908028688, -2147483648, 'p', '2025-08-22', 'uhv', 'url_9');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'Michael', 'Schumacher', '2025-06-04', 'hria2ypuzhs', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'uo4nrqrofqy', -1106983592, '5bbp0', 'Michael', 'Schumacher', '2024-12-15', 'eutliqa11r', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'd', -736979194, 'h2gn', 'Michael', 'Schumacher', '2020-08-28', 'wnqcx', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'cprj', -841004020, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', '2025-03-14', 'bilyrkn', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'f8jswwl', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', '2025-06-24', 'grgj', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 'dctmf', 7929158, '0v', 'q8qdjpe1', 'o22', '2025-10-23', '507cvtjpt', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'Michael', 't3__1f6701', '2025-06-04', 'hria2ypuzhs', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't3__4ebb2f', 'Schumacher', '2025-06-04', 'hria2ypuzhs', 'url_8');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_1');

-- Inserting into table: laptimes --
INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1, 1, 1, -1683203397, 'e376nium52', -443340271);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3, 1, -1, 556727997, '8pz0f8je', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3, 1, 0, 1196308825, 'd21vy9uxj4hw', 1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1, 0, -1, -688098735, '6ah', -1);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1, 3, 0, -458359144, '1afgogritsj', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (3, 1, 1, 2111987706, 'p1q430', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (1, -1, -1, 453836040, '6b', 0);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (4, 4, -2147483645, 1526238907, 'tti', -1364429300);

INSERT INTO "laptimes" ("raceid", "driverid", "lap", "position", "time", "milliseconds") VALUES (5, 5, -2147483644, 1526238907, 'tti', -1364429300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN lapTimes AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.forename = 'Michael' AND T3.surname = 'Schumacher' ORDER BY T2.milliseconds ASC, T1.raceid NULLS LAST, T2.raceid NULLS LAST, T2.driverid NULLS LAST, T2.lap NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__4b0251', 1)
*/

-- Prediction Query
SELECT T1.name, T1.year FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T2.driverId = T3.driverId WHERE T3.forename = 'Michael' AND T3.surname = 'Schumacher' ORDER BY T2.milliseconds ASC, T1.raceid NULLS LAST, T2.resultid NULLS LAST, T3.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/