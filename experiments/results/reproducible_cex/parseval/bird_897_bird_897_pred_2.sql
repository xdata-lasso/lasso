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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, -2147483648, 2026480202, -2147483648, 'ie5', '2023-09-04', 'w6kl', 'url_1');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't1__6ab2e2', 't1__86739d', '2025-06-04', 't1__41e82c', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'e376nium52', -443340271, 'uo4nrqrofqy', 't1__6ab2e2', 't1__86739d', '2022-09-19', 't1__41e82c', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 's5bbp02e', -751275471, 'iqa', 't1__6ab2e2', 't1__86739d', '2024-10-16', 't1__41e82c', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483645, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'dri_c86c1b', 'dri_b06d48', '2025-06-04', 'dri_51b0ed', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'hria2ypuzhs', 700293388, 'wbbp6luhvdlt', 't1__754c94', 't1__663886', '2023-05-30', 't1__008d7a', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'lbn', 462974032, 'posiie5unw6k', 't1__754c94', 't1__663886', '2021-12-14', 't1__008d7a', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'uo4nrqrofqy', -1106983592, '5bbp0', 't1__754c94', 't1__663886', '2024-12-15', 't1__008d7a', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'eutliqa11r', 2137741668, 'ytoo3o9hl7', 't1__754c94', 't1__663886', '2024-12-21', 't1__008d7a', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, '9', 244829661, 'jsl', 'b4yp5qi', 'rkf9vqx5', '2022-08-22', 'z0f8jegd21vy', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'A', 'A', '2025-06-04', 'A', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'hria2ypuzhs', 700293388, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', '2021-06-28', 'e5u', 'url_11');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 986.066566, 907682809, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: driverstandings --
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483648, -2147483648, 1, 1.0, 1620389964, '00t5c4ecigc', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483647, -2147483648, 1, 1.0, 274769912, 'oo3o9', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483646, -2147483648, 1, 1.0, 90119032, 'lex', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2, -2147483648, 1, 1.0, -74849714, '7zw', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3, -2147483648, 1, 1.0, 2123196517, 'dwyrq13pyu78', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483643, -2147483648, 1, 1.0, 1649269347, 'p5qi2rkf9v', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483642, -2147483648, 1, 1.0, 537874887, 'z0f8jegd21vy', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (4, -2147483648, 2, 2.0, 1620389964, '00t5c4ecigc', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (5, -2147483648, 2, 3.0, -1585009206, '52zb', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (6, -2147483648, -2147483647, 74.250383, -305670381, 'i7z', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (7, -2147483648, 5, 612.02959, 2123196517, 'dwyrq13pyu78', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (8, -2147483648, 7, 367.405851, 1442655647, 'hwbdvlph', 2);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (9, -2147483648, 8, 345.718563, 44952191, 'fa9', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname, T1.nationality, AVG(T2.points) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T2.driverId = T1.driverId WHERE T2.wins = 1 GROUP BY T1.forename, T1.surname, T1.nationality ORDER BY COUNT(T2.wins) DESC, T1.forename NULLS LAST, T1.surname NULLS LAST, T1.nationality NULLS LAST, AVG(T2.points) NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__6ab2e2', 't1__86739d', 't1__41e82c', 10.156297875)
*/

-- Prediction Query
SELECT T2.forename, T2.surname, T2.nationality, T1.points FROM driverStandings AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId ORDER BY T1.wins DESC, T1.points DESC, T1.driverstandingsid NULLS LAST, T2.driverid NULLS LAST LIMIT 1;

/*
Prediction Result:
('b4yp5qi', 'rkf9vqx5', 'z0f8jegd21vy', 367.405851)
*/