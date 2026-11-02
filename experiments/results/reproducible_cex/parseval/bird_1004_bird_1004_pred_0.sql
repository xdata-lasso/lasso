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
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't2__35a30a', 't2__fce214', '2025-06-04', 'hria2ypuzhs', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, '4nrq', 418417917, 'fqyp', 't2__35a30a', 't2__fce214', '1969-12-31', 's5bbp02e', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'liqa1', 2074205376, 'yytoo', 'o9hl72kl', 'x1', '2025-05-30', 'i7z', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '9rljsl0b4', 1649269347, 'p5qi2rkf9v', 'x58pz', 'f8jegd2', '2024-11-12', 'y9uxj4', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't2__8ce9f1', 't2__5f0c05', '2025-06-04', 'hria2ypuzhs', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'rwbbp6luhvd', -1377057208, 'ilbnp', 't2__8ce9f1', 't2__5f0c05', '2023-01-01', 'dpos', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, 'ie5', -1209887326, 'klfa9000t', 'dri_c86c1b', 'dri_b06d48', '2025-07-01', '4', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '2025-08-22', 'uhv', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, 'l', -845863578, 'lbn', 'A', 'A', '2022-09-14', 'mdpos', 'url_9');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: driverstandings --
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483648, -2147483648, 1, 467.07027, -1585009206, '52zb', 757448742);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483647, -2147483648, 4, 353.163664, -2081315180, '2dwyrq13pyu7', -1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483646, -2147483648, 3, 124.573829, -2050247126, 'lph2gn', 0);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483645, -2147483648, 4, 893.16532, -1052964641, 'qcx5', 0);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483644, -2147483648, 3, 210.05299, 1575412235, 'jtu0d', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483643, -2147483648, 4, 521.610309, -1748371085, 'q8', 0);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483642, -2147483648, 3, 450.823993, -1056308489, 'gcb98oz', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483641, -2147483648, 4, 463.845085, 1686459626, 'lyr', 0);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (-2147483640, -2147483648, 3, 615.222139, 32204797, 'k', 1);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2, -2147483648, 1, 591.134092, 834709651, 'f8jswwl', 1255343543);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3, -2147483648, 1, 598.428216, 602161869, 'xa', 1294666887);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (4, -2147483648, 6, 950.466571, 1274489983, 'gce', 2);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (5, -2147483648, 6, 875.837169, -1585009206, '52zb', 3);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (6, -2147483648, 7, 126.856521, -45536098, 'w6kl', 1620389964);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.wins) FROM driverStandings AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId GROUP BY T2.forename, T2.surname ORDER BY T2.dob ASC, SUM(T1.wins) NULLS LAST LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT T1.forename, T1.surname, SUM(T2.wins) FROM drivers AS T1 INNER JOIN driverStandings AS T2 ON T1.driverId = T2.driverId GROUP BY T1.driverId, T1.forename, T1.surname ORDER BY T1.dob, T1.forename NULLS LAST, T1.surname NULLS LAST, SUM(T2.wins) NULLS LAST LIMIT 1;

/*
Prediction Result:
('x58pz', 'f8jegd2', 3)
*/