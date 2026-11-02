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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, -2147483648, -1257178728, -2147483648, 'mdpos', '2021-06-28', 'e5u', 'url_1');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'w6kl', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', '2022-11-29', 'p5s5bbp', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, '5k5swwqcgs', 't2__b95b5e', '9n8', '4');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, 'yp5qi2rk', 'name_2', '9v', 'x58pz');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, '5k5swwqcgs', 'name_3', '9n8', '4');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483645, '5k5swwqcgs', 'O', '9n8', '4');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483644, 'gu7v', 'A', 'e4', 'hria2ypuzhs');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483643, 'rwbbp6luhvd', 'Q', 'tti', 'bnp');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, 304.02808, -1364429300, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '02eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, -2147483648, -2147483648, 2, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1775126557, 482.572691, 105869088, 'au2dwy', -953437896, -1097120355, 1, '78d99r', 'jsl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, -2147483648, -2147483648, 1, 836513442, 176555546, -1937207087, 'vy9uxj4', -1612443122, 22.63964, -736979194, 'h2gn', 1968874827, -664193365, 1, 'cx5hn', 'p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, -2147483648, -2147483648, 2, -792947627, -1898531797, -1748371085, 'q8', -1255130038, 89.552801, 806170397, 'qv0gcb98ozk', -155284187, 1686459626, 1, 'lyr', 'kn6vck6ah0f8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, -2147483648, -2147483648, 2, -639539893, 1255343543, -541746689, '7ryfdrz16n', -1496556994, 7.367195, 1746373317, 'h', 1583472758, 1449284300, 1, 'gjd8y', 't1afgog', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, -2147483648, -2147483648, 2, 678047687, -1478134144, -491938169, '1q43', 1235416111, 947.945777, 518609210, '3d', -1826414375, 357330522, 1, '68x8vacx7a', 'u5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, -2147483648, -2147483648, 2, 76996700, -435350511, 1992637800, 'dctmf', 7929158, 93.813527, 1870300798, 'q8qdjpe1', -1180042408, 199672698, 1, '7cvtjpt', 'tg6bnou5zi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, -2147483648, -2147483648, 2, -2072838897, -1173368267, 382831862, '0', 76987628, 441.061634, 641521863, 'o7w', -542502665, 1999335832, 1, 'sxcmr0o', 'ztdgj5i3lq5l', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, -2147483648, -2147483648, 2, -1300180872, -1125548818, 1497321728, '4gth2mnaj', -1478011227, 11.892553, 1803796945, '8uttmu', -229022515, -1817527403, 1, '78lfvyz7zz', 'be8yvkv42q7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, -2147483648, -2147483648, 1, 782684333, 681598285, 319284352, '3auvm', 274891948, 641.973572, -1934017803, 'wzw5chn9mo70', 628082526, -1245584612, 1, 'xfo', 'ws', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, -2147483648, -2147483648, 1, 1010672881, -1197954156, -2019656607, '0k32o', -1898678660, 38.169466, 440115543, 'msorlwyngc', -323362455, 453340472, 1, '9erhizgk1yoe', 'o6l0hdt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, -2147483648, -2147483648, 2, -2140468103, 469838697, 1468640756, 'boeowii1z5nx', -1552469358, 515.131026, 7342822, '2xlyo', 727608179, 456034296, 2, 'g96aqb', 'tbindz3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, -2147483648, -2147483648, 1, -841516418, 152478847, -625404808, 'um', 989306270, 853.967947, 1147652228, 'u', -1943814113, 1514371324, 2, '603vzxw1r', 'e9yfk7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, -2147483648, -2147483648, 1, -246257698, -516345261, -1191116453, 'u06dza', -154207334, 576.663277, 729449685, 'io1', 769234989, 168442149, 1299171592, '6ewt', 'xxnja', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, -2147483648, -2147483648, 2, 1528227252, -1277305894, -1659775598, 'p6sto1cj', 1728926031, 485.281618, 1106724223, 'ys7dyyd1jmg', 729543907, -2108844113, 1, '8q', 'ta8y3a17v4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, -2147483648, -2147483648, 1, 1168225104, -499203870, 1509621238, 'dpuap', -845136979, 857.029414, -1042976410, 'm5', -648564084, -1573704891, 1, 'dn2np490x', 'm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, -2147483648, -2147483648, 3, 89267185, -1865039888, 1160656988, 'ia2yp', -1670923962, 663.049759, 906324270, 'b', 1072996612, 13244799, NULL, 'hvdltt', 'lbn', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.name FROM results AS T1 INNER JOIN constructors AS T2 ON T1.constructorId = T2.constructorId WHERE T1.rank = 1;

/*
Gold Result:
('t2__b95b5e',)
('name_2',)
*/

-- Prediction Query
SELECT T1.name FROM constructors AS T1 INNER JOIN constructorStandings AS T2 ON T1.constructorId = T2.constructorId WHERE T2.position = 1;

/*
Prediction Result:
*/