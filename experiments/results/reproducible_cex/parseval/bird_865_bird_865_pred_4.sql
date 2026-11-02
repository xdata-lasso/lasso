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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (592, -2147483648, -1399556171, -2147483648, 'a9000t5c4eci', '2021-03-18', 'e', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -794767771, -2147483648, 'c', '2025-02-08', 'tdu6bd0w96', 'url_2');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 't1__2d80dc', 't1__236db9', '2024-06-15', 'hria2ypu', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'p5qi2rkf9v', 556727997, '8pz0f8je', 't1__2d80dc', 't1__236db9', '2024-06-15', 'd2', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'vy9uxj4', -1612443122, 'd', 't1__2d80dc', 't1__236db9', '2024-06-15', 'lph2gn', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 'wlq7xb', 602161869, 'xa', 't1__2d80dc', 't1__236db9', '2024-06-15', '7ryfdrz16n', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'jja', -7597509, 'h5ogrgjd8yz', 't1__0df7e9', 't1__c9a6b5', '2024-06-15', '1afgo', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '9yfk7qk162n', -516345261, 'o', 'vu', '6dza35r', '2022-02-22', 'io1', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'sh5knzys7', 1487347213, 'yd1jmgj', 'c', '8q', NULL, 'ta8y3a17v4', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', NULL, 'luhvdltti', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'zbuo4nrqrof', 373262291, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', '2024-06-15', 'l7', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'pz0f8jegd', -283454505, '9uxj4hw', 'd', 'lph2gn', NULL, 'q', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'wlq7xb', 602161869, 'xa', '7ryfdrz16n', 'jja', NULL, '5dh', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'vacx7afu5', -290314193, 'f77pzo72ctd', 't', 'mfg62g0v5q8q', NULL, 'j', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (11, '0', 76987628, 'zezjo7wg', 'd5ysxc', 'r0oz', NULL, 'dgj5i', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (12, 'e578', 1908593332, 'vy', '7zzbe8y', 'kv42q7', NULL, 'x58b4', 'url_14');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '76nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'hsrwbbp', 'luhvdltti', 'bnp', 'mdpos', 133.007885, 75.403642, -1209887326, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '2eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1, 592, 1, -2147483648, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1775126557, 482.572691, 105869088, 't2__5caac6', -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 592, 2, -2147483648, -1070063173, 555413010, 722884590, 'hncprjtu0dz', -1748371085, 94.390081, 894242932, 't2__b58f46', -211209314, -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 592, 3, -2147483648, 678047687, -1478134144, -491938169, '1q43', 1235416111, 947.945777, 518609210, 't2__b58f46', 1948383687, 1476361420, 195720193, 'vacx7afu5', '1of77p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 592, 3, -2147483648, -820614248, 481546706, -1784554553, '2g0v5q8qd', 569007824, 234.606624, -288338724, 't2__b58f46', 1897687032, -241848752, 2004147439, 'tjpttg', 'bnou5zi36', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 592, 3, -2147483648, -1173368267, 382831862, -406331049, 'ezjo7wg', 1248858185, 50.798088, -57705450, 't2__b58f46', -915385605, -2005628382, 1721638020, '0oztdgj5i3lq', '5lnpim5k58qs', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 592, 3, -2147483648, -95808609, -244633520, 418247369, 'jla', 1919033056, 904.028668, -1428186898, 't2__b58f46', -761353513, 362376128, -1311735207, 'ne578lfv', 'yz7zzbe8yvk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 592, 1, -2147483648, 79330142, 1735561423, 756202403, '8b4pmaus3au', -699574669, 160.717227, 274891948, 't2__b58f46', 609771851, -1934017803, 1105964624, 'w5chn9m', 'o705a9n0jxfo', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 592, 1, -2147483648, -210159774, 270415200, -2071531094, 'q0k32od', -613916489, 979.99406, 895277769, 't2__b58f46', 364043263, -1177989415, -1352968577, 'ngc1dj9', 'rh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 592, 1, -2147483648, 1504707292, 955267863, -1156828895, 'o6l0hdt', -795975227, 801.297876, 778835680, 't2__b58f46', 1755752040, 1262491793, 450555855, '1gwnlas6', 'elboeowii1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 592, 1, -2147483648, -1552469358, 7342822, -1034034171, 'lyotow', 205676091, 735.218284, -2094843966, 't2__b58f46', -1048779857, -381485009, 868039568, 'ndz39tajz9', 'd8n5w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 4, -2147483648, 1677948887, 389700824, -1853955201, 'qxxnj', 917362079, 376.823393, -1312038093, NULL, 687330820, -224390110, -1810873111, 'h33p6sto1', 'j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 5, -2147483648, 1168225104, -499203870, 1509621238, 'dpuap', -845136979, 857.029414, -1042976410, 'm5', -648564084, -1573704891, -1260548409, 'p490', 'dmsqtg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 592, 6, -2147483648, -1257178728, 1236688122, 2087640001, 'dposiie5unw', -1399556171, 741.842896, 1419861592, NULL, 700088193, 374105386, 1274489983, 'gce', '76nium52', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 592, 7, -2147483648, -1390245819, 1055976837, 1775126557, 'ji7zwau2', 364869063, 278.010437, -1097120355, NULL, 244829661, -1362461264, -904834265, 'b4yp5qi', 'rkf9vqx5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 592, 8, -2147483648, -1070063173, 555413010, 722884590, 'hncprjtu0dz', -1748371085, 94.390081, 894242932, NULL, -211209314, -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 592, 9, -2147483648, 1449284300, -977470238, -1478247928, 'yzt1afgog', -946046410, 630.468925, -902895762, NULL, -197933860, 2111987706, -598313376, 'q4301jh', 'den8c68x', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 592, 10, -2147483648, -288338724, 1897687032, -241848752, '8507cvtjp', 1582582341, 605.666938, 1467355421, NULL, -1171104889, -29242208, 1691780814, '6c4bfkfo', 'c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 592, 11, -2147483648, -15162884, 1339733032, -1556979799, 'k58qs27p', 988954859, 99.674786, 1273687251, NULL, 333302050, 1162591638, -2136247961, 'la3', 'okv8uttmu2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 592, 12, -2147483648, 1849819405, -929383517, -2090240067, 'mkrpdj', 1105964624, 401.500141, -663234145, NULL, -2013213247, 101754718, 628082526, '9n0jxfofwsz', 'o', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN results AS T2 ON T2.driverId = T1.driverId WHERE T2.raceId = 592 AND NOT T2.time IS NULL AND NOT T1.dob IS NULL ORDER BY T1.dob ASC, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__2d80dc', 't1__236db9')
*/

-- Prediction Query
SELECT T1.forename, T1.surname, T1.dob FROM drivers AS T1 INNER JOIN results AS T2 ON T1.driverId = T2.driverId WHERE T2.raceId = 592 AND NOT T2.time IS NULL ORDER BY T1.dob, T1.driverid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__2d80dc', 't1__236db9', '2024-06-15')
*/