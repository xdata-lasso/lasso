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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2011, -1399556171, -2147483648, 'Australian Grand Prix', '2020-01-23', '9000t5c4ec', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, 2011, -188151580, -2147483648, 'Australian Grand Prix', '2021-04-03', '72k', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2011, -1672720816, -2147483648, 'Australian Grand Prix', '2021-01-15', 'jswwlq7xb', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2011, 2094425101, -2147483648, '7', '2023-02-05', 'fdrz16n', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1, -1437333179, -2147483648, 'Australian Grand Prix', '2023-03-15', 'wqcgsk', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, -45536098, -2147483648, 't3__030704', '2022-06-13', '6klfa9', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2011, -1437333179, -2147483648, 'Australian Grand Prix', '2023-03-15', 'wqcgsk', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2011, -45536098, -2147483648, 't3__030704', '2022-06-13', '6klfa9', 'url_8');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'Lewis', 'Hamilton', '2025-06-04', 'hria2ypuzhs', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'uo4nrqrofqy', -1106983592, '5bbp0', 'Lewis', 'Hamilton', '2024-12-15', 'eutliqa11r', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'l0b4y', -1116181514, 'i2rkf', 'Lewis', 'Hamilton', '2023-10-06', 'x58pz', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'f8jegd21vy9u', 1442655647, 'hwbdvlph', 'gndqwnqc', 'x5hncprjtu0', '2020-08-25', '79fjgq8', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '9n8c4pgu7v', -1865039888, 'hria2ypuzhs', 'Lewis', 'Hamilton', '2023-01-03', 'wbbp6luhvdlt', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, '00t5c4e', 1274489983, 'gce', 'Lewis', 'Hamilton', '2025-03-28', '6nium52zb', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '9n8c4pgu7v', -1865039888, 'hria2ypuzhs', 'Lewis', 't2__1134fa', '2023-01-03', 'wbbp6luhvdlt', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, '00t5c4e', 1274489983, 'gce', 'Lewis', 't2__1134fa', '2025-03-28', '6nium52zb', 'url_8');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2011, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: pitstops --
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483648, 1, 'gce', '76nium52', -443340271);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483647, 1, 'ex1', 'ji7zwau2', 364869063);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483646, 1, 'q13py', '78d99r', -1362461264);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 3, -2147483645, 1, 'n2f3dqv0gcb9', 'ozk3zbily', 638024588);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483644, 1, 'jja', '5dh', 1583472758);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 3, -2147483643, 1, 'gjd8y', 't1afgog', -946046410);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483642, 1, 'sj3ayxp1q430', 'jh3den8', 195720193);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 3, -2147483641, 1, 'c', 'x7afu5w1of77', -1099855564);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483640, 1, '72ctdctmfg62', '0v', 820970595);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483639, 1, 'j', 'e1io', -241848752);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483638, 1, '8507cvtjp', 'ttg6bnou5zi3', -68044929);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483637, 1, 'foa', 'cd07z2zezjo7', 304189298);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483636, 1, 'xd', 'ysxcmr0o', 853709925);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483635, 1, 'g', '5i3', -1405314653);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483634, 1, '5lnpim5k58qs', '7p2r94gt', 1273687251);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483633, 1, 'najj', 'a3o', -1428186898);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483632, 1, 'uttmu2ne5', '78lfvyz7zz', -2052653308);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483631, 1, 'kv42q7', 'x58b4', -1122409769);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483630, 1, 'u', '3auvm', 274891948);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483629, 1, 'j', 'wzw5chn9mo70', 628082526);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483628, 1, '9n0jxfofwsz', 'o', 1010672881);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483627, 1, 'obb0q0k32o', 'w', 440115543);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483626, 1, 'sorlwyngc1', 'j', 211603887);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483625, 1, 'iz', 'k1', 955267863);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483624, 1, 'yo', 'l0hdt6fuq', 1294064538);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483623, 1, 'kb521gw', 'las6', -2076274980);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (4, 4, -2147483622, -841692980, 'bnp', 'mdpos', -1576219117);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (5, 5, -2147483621, 757448742, '4nrq', 'rofqyp5s5b', 2107872094);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (6, 6, -2147483620, -841692980, 'bnp', 'mdpos', -1576219117);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (7, 7, -2147483619, 757448742, '4nrq', 'rofqyp5s5b', 2107872094);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.lap FROM pitStops AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T2.forename = 'Lewis' AND T2.surname = 'Hamilton' AND T3.year = 2011 AND T3.name = 'Australian Grand Prix';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT ps.lap FROM races AS r INNER JOIN pitStops AS ps ON r.raceId = ps.raceId INNER JOIN drivers AS d ON ps.driverId = d.driverId WHERE r.name = 'Australian Grand Prix' AND r.year = 2011 AND d.forename = 'Lewis';

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(-841692980,)
*/