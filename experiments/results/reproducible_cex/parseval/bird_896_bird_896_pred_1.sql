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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2010, 1038707349, -2147483648, '9000t5c4ec', '2021-06-11', 'gce376nium52', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2010, -2070843029, -2147483648, '02eu', '2023-05-04', 'iqa', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2010, 274769912, -2147483648, 'oo3o9', '2021-04-03', '72k', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2010, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2010, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2010, -106629402, -2147483648, 'u7', '2023-09-09', 'e4', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1, 882961052, -2147483648, '2eutliqa11r', '2024-03-30', 'ytoo3o9hl7', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2010, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 1, -1364429300, -2147483648, 'nprmdposii', '2020-11-04', 'unw6klfa', 'url_9');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'Hamilton', '2024-06-23', 'sr', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'ex1', -74849714, '7zw', 'au2dwyrq13', 'Hamilton', '2022-09-28', 'u78d99r', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'sl0', -2031361952, 'p5qi2rk', '9v', 'x58pz', '2024-08-06', 'f8jegd21vy9u', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '4', -734455130, '4h', 'ia2yp', 'Hamilton', '2023-08-23', 'hsrwbbp', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'hria2ypuzhs', 700293388, 'wbbp6luhvdlt', 'ilbnp', 'Hamilton', '2023-01-01', 'dpos', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'ie5', -1209887326, 'klfa9000t', 'c4ecigce', 'Hamilton', '2025-03-28', '6nium52zb', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'klex14ji', -453362185, 'au2dwyrq13', 'yu78', 'Hamilton', '2020-07-21', '9rljsl0b4', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '4', -734455130, '4h', 'ia2yp', 't3__587b70', '2023-08-23', 'hsrwbbp', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, '9000t5c4ec', -1683203397, 'e376nium52', 'zbuo4nrqrof', 't3__587b70', '2022-11-29', 'p5s5bbp', 'url_9');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', 327.753528, 218.301157, -1399556171, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2010, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: driverstandings --
INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (1, 1, 1, 816.814398, -443340271, 'uo4nrqrofqy', -1106983592);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (2, 1, 1, 328.40866, 2103044118, 'h2gndqwnqcx5', 580968159);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (3, 1, 1, 210.05299, 1575412235, 'jtu0d', 401805964);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (4, 4, 4, 503.083789, 2, 'hvdltt', -1610064545);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (9, 5, 1, 676.357279, 2, '4nrq', 418417917);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (6, 2, 10, 82.05602, 2, 'yp5s5', -2070843029);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (5, 6, 5, 884.000446, -1116181514, 'i2rkf', 222415430);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (7, 7, 6, 503.083789, -1659388584, 'l', -845863578);

INSERT INTO "driverstandings" ("driverstandingsid", "raceid", "driverid", "points", "position", "positiontext", "wins") VALUES (8, 9, 8, 705.580387, 743312762, 'eutliqa11r', 2137741668);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.position <> 1 THEN T2.position END) AS REAL) * 100 / COUNT(T2.driverStandingsId) FROM races AS T1 INNER JOIN driverStandings AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T3.surname = 'Hamilton' AND T1.year >= 2010;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT 100.0 * CAST(COUNT(CASE WHEN r.position > 1 THEN r.raceId END) AS REAL) / CAST(COUNT(r.raceId) AS REAL) AS percentage FROM results AS r JOIN drivers AS d ON r.driverId = d.driverId JOIN races AS ra ON r.raceId = ra.raceId WHERE d.surname = 'Hamilton' AND ra.year >= 2010;

/*
Prediction Result:
(None,)
*/