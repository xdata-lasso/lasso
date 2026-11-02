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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2009, -992890117, -2147483648, 'Singapore Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, 2009, -1822992503, -2147483648, 'Singapore Grand Prix', '2023-05-04', 'iqa', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2009, 836513442, -2147483648, 'Singapore Grand Prix', '2021-08-12', 'gd', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2009, -688509700, -2147483648, '9uxj4hwbdvl', '2022-09-24', 'h2gndqwnqcx5', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1, -1437333179, -2147483648, 'Singapore Grand Prix', '2023-03-15', 'wqcgsk', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, 546571701, -2147483648, 'Singapore Grand Prix', '2024-09-18', '5c4ec', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1, -1438850342, -2147483648, 'Singapore Grand Prix', '2020-10-31', 'x14ji7zwau2d', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 1, 1581736075, -2147483648, 'Singapore Grand Prix', '2024-12-03', 'nd', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 1, 1255343543, -2147483648, 'Singapore Grand Prix', '2020-03-27', '72fxa7ryfd', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 1, 2078438287, -2147483648, 'Singapore Grand Prix', '2023-07-08', 'w1of77pz', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 1, 1798111945, -2147483648, 'Singapore Grand Prix', '2023-08-15', '5zi36c4bfkfo', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 1, 1817366143, -2147483648, 'Singapore Grand Prix', '2025-01-21', '7p2r94gth2m', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 1, 238533676, -2147483648, 'Singapore Grand Prix', '2024-09-14', 'xfo', 'url_13');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'b', 1072996612, 'luhvdltti', 'bnp', 'mdpos', '2021-06-28', 'e5u', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, 't3__10f35c', 'name_1', '5k5swwqcgs', 't3__08b67b');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483647, 't3__10f35c', 'A', 'p', 't3__08b67b');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, 't3__10f35c', 'name_3', 'wlq7xb', 't3__08b67b');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, 'a7ryfd', 'name_4', 'z16ni', 'jai');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (4, '9n8c4pgu7v', 'name_5', 'e4', 'hria2ypuzhs');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (5, 'gce', 'name_6', '76nium52', 'zbuo4nrqrof');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (6, 'yrq13p', 'name_7', 'u78d99r', 'jsl');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (7, 'wnqcx', 'name_8', '5hncprjtu0d', '79fjgq8');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (8, 'z16ni', 'name_9', 'jai', 'dh5ogrgj');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (9, '72ct', 'name_10', 'c', 'mfg62');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (10, 'c', 'name_11', '0', '7z2zezjo7wg');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (11, 'ajjl', 'name_12', '3', 'okv8uttmu2');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (12, 'ws', 'name_13', 'do2zobb', 'q0k32od');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '9n8', '4', 'gu7v', 'e4', 779.409124, 640.719621, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2009, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'w6kl');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, 1, 1620389964, 546571701, 947159877, '5c4ec', -1683203397, 623.093099, -1585009206, 'a::aa.aaa', -53231346, -443340271, 757448742, '4nrq', 'rofqyp5s5b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, 1, 274769912, -188151580, 226938182, '72k', -1390245819, 763.856372, 1055976837, 'a::aa.aaa', 1775126557, -74849714, 105869088, 'au2dwy', 'q13py', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, 1, -977635379, 1661181156, -1372125820, '4', 1649269347, 598.741024, -1116181514, 'a::aa.aaa', 1255852738, -1555456236, -975213201, '9v', 'x58pz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, -2147483648, 1, -1106350634, -1509264256, -792947627, 'z', -1748371085, 94.390081, 894242932, 'a::aa.aaa', -211209314, -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, -2147483648, 2, 1360271423, 1583472758, 1449284300, 'gjd8y', 1129658414, 308.482994, 1250290042, 'a::aa.aaa', -1717646459, -1696173285, 710458518, 'sj3ayxp1q430', 'jh3den8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 2, -2147483648, 1, 1732258051, -1762140823, 1371234901, '1of77p', -435350511, 689.065203, 1992637800, 'a::aa.aaa', -820614248, 481546706, -1784554553, '2g0v5q8qd', 'jpe1io22785', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, 2, -866772222, -847293924, -2033879835, 'u5zi', 1944978593, 900.959264, -2072838897, 'a::aa.aaa', -1173368267, 382831862, -406331049, 'ezjo7wg', 'd5ysxc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 2, -2147483648, 1, 1269522000, 853709925, -870767087, 'j5', -1609653472, 172.799686, 1816660482, 'a::aa.aaa', -1212676731, 1692046802, -1300180872, '58q', 's27p2r94gth2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, 2, -1524425594, -1351793914, 1919033056, 'v8u', 618058035, 318.763195, 1553368934, 'a::aa.aaa', -1252009958, 1908593332, 697257217, '7zzbe8y', 'kv42q7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, 1, 782684333, 681598285, 319284352, '3auvm', 274891948, 641.973572, -1934017803, 'a::aa.aaa', 1105964624, -663234145, -2013213247, '9mo7', '5a9n0jx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, 1, -1793230843, -441521858, 2015094998, '2zobb0q0k32o', -1898678660, 38.169466, 440115543, 'a::aa.aaa', 292557306, 709097796, -984562992, 'yngc1d', 'j9erhizgk1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, -2147483648, 1, 469838697, 1468640756, 1048147204, 'eowi', -1610380698, 393.510383, 1557188093, 'a::aa.aaa', 548968280, -1552469358, 7342822, '2xlyo', 'tow9oaawg96a', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, -2147483648, 1, -850941333, -1216952047, -457901285, 'tajz9td8n', -625404808, 105.460765, -1275298282, 'a::aa.aaa', 1933158443, 1295379066, 1071401016, 'w9603vz', 'xw1rxe9yfk7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, -2147483648, 1, -246257698, -516345261, -1191116453, 'u06dza', -154207334, 576.663277, 729449685, NULL, -1580984044, 150596046, 431832073, 'hy08ftp6', 'wt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, -2147483648, 1, 2013745856, 917362079, -1312038093, 'n2mfx7h33p', 63063873, 303.704524, -285085577, '8sh', -63214972, 1106724223, 1966809332, '7dyyd', 'jmgjach', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, -2147483648, 1, -161108900, -735270562, 614314115, 'ma', -499203870, 851.486083, 1432875972, 'a::aa.aaa', 1032339628, 608093726, 1595033206, '96rn', 'dqrhm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, -2147483648, 4, 1908028688, 2122220075, 1072996612, 'luhvdltti', -1364429300, 998.421621, -1257178728, 'a::aa.aaa', 1236688122, 2087640001, 907682809, 'siie', 'unw6klfa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 5, -2147483648, 5, -1106983592, 1884179925, 902551284, 'p', 882961052, 673.065986, -1822992503, NULL, -868774469, -1068298341, -314162272, 'ytoo3o9', 'l7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 6, -2147483648, 6, 1692174491, -1025564911, -227162283, 'f9v', 556727997, 860.770887, 1178000634, NULL, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', 'd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 7, -2147483648, 7, -1762857309, 806170397, 513454646, '0gcb98', -1454058168, 395.957566, -2078052421, NULL, -512640349, 1038566008, 32204797, 'k', 'ah0f8jsww', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 8, -2147483648, 8, 1129658414, 1250290042, -1717646459, 'ri', -902895762, 453.914926, 2111987706, NULL, -598313376, 1972233925, 1792827279, '4301jh3den8', 'c68x8vacx7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 9, -2147483648, 9, 1870300798, 820970595, 1421303999, 'j', -1139855872, 432.865904, 1897687032, NULL, -241848752, 2004147439, -691774480, 'ptt', '6b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 10, -2147483648, 10, 1999335832, -526612570, -546516406, 'r0oz', -870767087, 104.37745, 875300074, NULL, -1609653472, -1405314653, 1816660482, 'npi', '5k58', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (11, 11, -2147483648, 11, 1908593332, 697257217, -451030047, 'be8yvkv42q7', -2060082151, 710.005534, -1122409769, NULL, 1849819405, -929383517, -2090240067, 'mkrpdj', 'wzw5chn9mo70', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (12, 12, -2147483648, 12, 2061558815, 895277769, 364043263, 'sorlwyngc1', 681061317, 950.711683, 595714424, NULL, 1056589776, -499913447, -360096930, 't', 'fuqyxuzkb', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.constructorRef, T3.url FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN constructors AS T3 ON T1.constructorId = T3.constructorId WHERE T2.name = 'Singapore Grand Prix' AND T2.year = 2009 AND T1.time LIKE '_:%:__.___';

/*
Gold Result:
('t3__10f35c', 't3__08b67b')
('t3__10f35c', 't3__08b67b')
('t3__10f35c', 't3__08b67b')
('a7ryfd', 'jai')
('a7ryfd', 'jai')
('a7ryfd', 'jai')
('t3__10f35c', 't3__08b67b')
('t3__10f35c', 't3__08b67b')
('t3__10f35c', 't3__08b67b')
('t3__10f35c', 't3__08b67b')
('t3__10f35c', 't3__08b67b')
*/

-- Prediction Query
SELECT T3.constructorRef, T3.url FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN constructors AS T3 ON T1.constructorId = T3.constructorId WHERE T2.year = 2009 AND T2.name = 'Singapore Grand Prix' ORDER BY T1.positionOrder, T1.resultid NULLS LAST, T2.raceid NULLS LAST, T3.constructorid NULLS LAST LIMIT 1;

/*
Prediction Result:
('t3__10f35c', 't3__08b67b')
*/