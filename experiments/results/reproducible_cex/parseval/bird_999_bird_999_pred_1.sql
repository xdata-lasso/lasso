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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, -2147483648, 't1__b16a6c', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -188151580, -2147483648, 't1__b16a6c', '2021-04-03', '72k', 'A');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-1, -2147483648, 556727997, -2147483648, 't1__b16a6c', '2025-06-26', 'pz0f8jegd', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, -2147483648, -688509700, -2147483648, 't1__91b558', '2023-07-16', 'j4hwbd', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, 2103044118, -2147483648, 'h2gndqwnqcx5', '2021-04-09', 'cprj', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, 1557188093, -2147483648, 'xih662q2xly', '2022-08-13', 'tow9oaawg96a', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -59984348, -2147483648, 'wqcgsk', '2022-04-27', '8c4pgu7vfe', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, -2147483648, 1038707349, -2147483648, '9000t5c4ec', '2021-06-11', 'gce376nium52', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, -2147483648, -1525670226, -2147483648, '7zwau2dwyr', '2022-12-09', '3pyu78d', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, -2147483648, -1264842910, -2147483648, 'wnqcx', '2025-07-02', 'hncprjtu0dz', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, -2147483648, 1427161052, -2147483648, 'z16ni', '2021-09-12', 'ai5', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, -2147483648, 1371234901, -2147483648, '1of77p', '2024-06-20', '72ct', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, -2147483648, 1722106924, -2147483648, 'f', '2021-11-12', 'oa', 'url_13');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'b', 1072996612, 'luhvdltti', 'bnp', 'mdpos', '2021-06-28', 'e5u', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'w6kl', 'name_1', 'a9', '00t5c4e');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'cigce376nium');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (1, 1, -2147483648, -2147483648, 283598170, 742285925, -747753377, 'nrqrofqy', -1106983592, 938.694822, 902551284, 'p', 882961052, 743312762, -1822992503, 't2__12141a', 'liqa1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, 105869088, -2081315180, 1909986641, 'yrq13p', -533293970, 520.715697, 176380444, '9rljsl0b4', 1649269347, -1116181514, 1255852738, 't2__6da095', '2rk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (0, 4, -2147483648, -2147483648, -1898531797, -1748371085, -1742081330, 'n2f3dqv0g', 1382410067, 879.800692, 172461907, 'k3zbily', 638024588, -688098735, 1784916884, 't2__12141a', 'ah0f8jsww', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-1, 4, -2147483648, -2147483648, -1888505890, 777149609, 61479715, 'jja', -7597509, 651.586084, -1625552518, 'grgj', -458359144, 600440952, 1568069663, 't2__12141a', 'fgogritsj3ay', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, -2147483648, -2147483648, -1744557630, 1870300798, 820970595, 'qdjpe1io2', 199672698, 993.555996, -1962347906, 'jpttg', -2033879835, 1798111945, 944975670, 't2__6da095', 'i36c4bf', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 1, -2147483648, -2147483648, -253138337, 641521863, 304189298, 'xd', 1999335832, 377.388457, -546516406, 'r0oz', -870767087, -1699185893, 875300074, 't2__6da095', '3lq', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, -2147483648, 1379859112, 195202164, 1817366143, '7p2r94gt', 1273687251, 577.602934, 1162591638, 'ajjla3okv8u', 618058035, 1553368934, -1252009958, 't2__6da095', '78lfvyz7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, -2147483648, -2147483648, 318331233, -233617564, 79330142, '58b4pm', 1849819405, 693.650436, -929383517, 'u', -699574669, 274891948, 609771851, 't2__6da095', 'j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, 823835795, -354292049, 238533676, 'jxfofws', 1719800120, 55.294573, -210159774, 'obb0q0k32o', -1898678660, 440115543, 292557306, 't2__6da095', 'orlwyngc1dj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 2, -2147483648, -2147483648, -850941333, -1216952047, -457901285, 'tajz9td8n', -625404808, 105.460765, -1275298282, '3', 1147652228, 1378873397, 1964331395, NULL, 'bd0w9603v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 3, -2147483648, -2147483648, -252690330, 1115440883, 1644814318, 'sr', 906324270, 944.247544, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, NULL, 'siie5unw6k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 5, -2147483648, -2147483648, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 705.580387, 743312762, 'eutliqa11r', 2137741668, -525979501, 1898504886, NULL, 'o3o9hl72klex', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 6, -2147483648, -2147483648, -904834265, -346339240, 1692174491, 'qi2rkf9v', 556727997, 860.770887, 1178000634, 'pz0f8jegd', -283454505, 233994589, 1442655647, NULL, 'hwbdvlph', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 7, -2147483648, -2147483648, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk', -155284187, 892.659478, -1554531873, 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, NULL, 'xb72fxa7r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 8, -2147483648, -2147483648, -1738458256, -1714354341, -458359144, '1afgogritsj', -197933860, 991.735454, -598313376, 'q4301jh', -163600466, -1826414375, 357330522, NULL, '68x8vacx7a', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 9, -2147483648, -2147483648, -1284905200, 7929158, -1744557630, '5q8qdj', -1139855872, 432.865904, 1897687032, '278507cv', -866772222, -847293924, -2033879835, NULL, 'u5zi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 10, -2147483648, -2147483648, 76987628, -253138337, 641521863, 'o7w', -542502665, 965.506647, -526612570, 'cmr0oz', -870767087, -1699185893, 875300074, NULL, '3lq', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name FROM races AS T1 INNER JOIN results AS T2 ON T1.raceId = T2.raceId WHERE NOT T2.fastestLapTime IS NULL ORDER BY T2.fastestLapTime ASC, T1.raceid NULLS LAST, T2.resultid NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__b16a6c',)
*/

-- Prediction Query
SELECT races.name FROM results JOIN races ON results.raceId = races.raceId WHERE results.fastestLapTime = (SELECT MIN(fastestLapTime) FROM results);

/*
Prediction Result:
('h2gndqwnqcx5',)
('h2gndqwnqcx5',)
('t1__b16a6c',)
*/