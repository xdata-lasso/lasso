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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, 1, 'Austrian Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -1070063173, 1, 'Austrian Grand Prix', '2024-02-11', '5hncprjtu0d', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, 1448731351, 1, 'Austrian Grand Prix', '2025-11-13', 'wgxd5ysxcm', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, 853709925, 1, 'dgj5i', '2025-02-22', 'q5l', 'url_4');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'p', 13244799, 'hvdltt', 'lbn', 'rmdp', '2022-07-21', 'siie5unw6k', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'xeilp', -1839279753, '19cy7od033d', 'hds', 'nhed29', '2021-12-24', 'qv26u331spx', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'nlj', 1673977398, 'dmp61l2o3ak1', '62ocagjeevx', 'xlu49ku', '2020-04-01', 'e8cd', 'url_3');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '00t5c4ecigc', 'name_1', 'e376nium52', 'zbuo4nrqrof');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483647, 'vy9uxj4', 'wb', 'v', 'ph2', 109.083092, 802.414724, 1968874827, 'url_2');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2, 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 357.061424, 979.99406, 895277769, 'url_3');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3, 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 506.13059, 78.702002, -795975227, 'url_4');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'qyp5s5bbp0');

-- Inserting into table: pitstops --
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483648, 1151980946, 'a9', 't4__454cda', 1620389964);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483647, -1485777725, '8n2f3', 't4__454cda', 806170397);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483646, 513454646, '0gcb98', 't4__454cda', -1454058168);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483645, 1339733032, 'im5k', 't4__454cda', 1379859112);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483644, 778835680, 'kb521gw', 't4__454cda', -1250380401);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483643, 920097188, '1rxe9y', 't4__454cda', -1046720861);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483642, -2008781089, 'qta8y3a17', 't4__454cda', -735270562);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483641, -1043357093, 'd8ftb8', 't4__454cda', 1183069552);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483640, -1096060187, 'mwfw', 't4__454cda', -544173163);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483639, -711121679, 'wpp', 't4__454cda', 1913338832);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 2, -2147483638, 764047845, '30bgwk', 't4__454cda', 1659285381);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483637, 2095228319, 'gm8gxb5q', 't4__454cda', -1497515537);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483636, 771073365, 'fc', 't4__454cda', -1550947002);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483635, 1550706713, 'tlzh42', 't4__454cda', -1241530177);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483634, 1487440939, 'y', 't4__454cda', 2017526622);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 2, -2147483633, 1293700593, 'gwakmwg', 't4__454cda', -151666814);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483632, -390950704, 'l1zmjrssbh', 't4__454cda', 133794777);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483631, -2099978946, 'kr2t', 't4__454cda', -1903548007);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483630, -1588383617, '8o', 't4__454cda', 1796323549);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483629, 638054085, 'if0', 't4__454cda', 500709040);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483628, 266841961, 'cq2iae6aj6ql', 't4__454cda', 29713329);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483627, -270252656, 'qt5uw42', 't4__454cda', 1580796530);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483626, 764338493, '5', 't4__454cda', 1154691182);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483625, -109711729, '6rurl72q8ip', 't4__454cda', 2068794689);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483624, -726015117, 'h59i', 't4__454cda', 1427769239);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483623, -717909980, 'cwraqxeddn', 't4__454cda', -1188144607);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483622, 2024891547, 'w84jm3', 't4__454cda', -922143835);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483621, -130970718, 'wggg30zch', 't4__454cda', 1922961793);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483620, 1396531582, 'qofzr1qv7z6', 't4__454cda', 2140117306);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483619, 2111065897, 'tcpo1ke8euy', 't4__454cda', 629009789);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483618, -1721586795, '0kr5bk0d0gkg', 't4__454cda', 586154782);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483617, -713353583, '5sdd', 't4__454cda', 1291840872);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483616, -2122365401, 'h8mp', 't4__454cda', -416331440);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483615, -197507241, 'll8k', 't4__454cda', -1034567822);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483614, -1012234498, 'wbdo290a5nxz', 't4__454cda', -1765640104);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483613, 1095868744, 'ufkhq6sd1hg', '8jcakwtu', 981266326);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483612, 907636171, '9dvetwe', '1', 1806410862);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483611, 277269433, 'z', NULL, 1055301009);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483610, -1427409983, 'aop6', 't4__454cda', 1440926181);

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274.580687, 274769912, 'oo3o9', -1666765085, 1178636309, -1390245819, 't1__795336', 'x14ji7zwau2d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, 1, -2147483648, -953437896, -1097120355, 244829661, 'jsl', -346339240, 470.165282, 1692174491, 'qi2rkf9v', 556727997, 1178000634, 1836127587, '1', 'f8jegd2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 1, -2147483648, -1554531873, 982314585, 638024588, '6vck6ah0f8js', -658391922, 176.824244, -566887085, '72fxa7ryfd', 564390026, -1259474148, 2011234363, 't1__795336', 'ai5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, 1, -2147483648, 1583472758, 1449284300, -977470238, 'd8y', 1129658414, 308.482994, 1250290042, 'og', -946046410, -902895762, -197933860, 't1__8ee8aa', 'xp1q430', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, 1, -2147483648, 1948383687, 1476361420, 195720193, 'vacx7afu5', -290314193, 850.85096, 76996700, 'o72ctdc', 1303877941, -1284905200, 7929158, '1', '0v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 1, 1, -2147483648, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, 338.933701, -1523347137, 'ttg6bnou5zi3', -68044929, -1776877925, 1201273976, '1', 'oacd07z2zez', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, 1, -2147483648, 1615073310, 1055237066, 988954859, 'th', 333302050, 193.695314, 1162591638, 'ajjla3okv8u', 618058035, 1553368934, -1252009958, 't1__795336', '78lfvyz7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 2, 1, -2147483648, -2052653308, -489120589, -72442907, '7sx58', 782684333, 476.006677, 681598285, 'aus3', -2090240067, -699574669, 274891948, '1', 'pdjwzw5chn9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 1, -2147483648, 469838697, 1468640756, 1048147204, 'eowi', -1610380698, 393.510383, 1557188093, 'xih662q2xly', 412199481, 727608179, 456034296, 't1__795336', 'g96aqb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, 1, -2147483648, 868039568, 503053726, -1897615568, '9tajz9td', 152478847, 655.746331, -625404808, 'um', 989306270, 1147652228, 1378873397, '1', 'u6bd0w9603', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, 1, -2147483648, -1231488097, 956819642, 774922170, '3dohvu0', 30861410, 397.847489, -154207334, 'rmkio18ri2', 1677948887, 389700824, -1853955201, 't1__795336', 'qxxnj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, 1, -2147483648, -1312038093, 687330820, -224390110, 'x7', -1659775598, 453.840746, -891525031, '1cj8', 1728926031, -63214972, 1106724223, '1', 'ys7dyyd1jmg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, 1, -2147483648, -2081662466, -1941472821, -2082238979, '6rntdqrhm', 555368535, 181.220234, 899787662, 'n2np490xdms', -1027584872, -1685482179, -1391541536, 't1__795336', 'qb9i9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 2, 1, -2147483648, 908468929, 1149620614, -1414362698, '1quik', 1570917601, 680.51123, -2052350430, 'hlst1pqom', 2141720493, 1793241362, -1304516770, '1', 'z78', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, 1, -2147483648, 1639204149, -2063751689, 36589303, 'jeuuwsj8kj', -55270062, 243.463869, 1939337883, 'isurz', -388527046, -1040951738, -1218774640, 't1__795336', 'gc8s3b7v88k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, 1, -2147483648, 1789767331, 1633584225, 1671062261, 'h', 313797011, 953.185987, -1215810104, 'r', -343920305, 460471995, -1515201134, '1', 'n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, 1, -2147483648, 2015039199, -641927001, 558684943, 'r5dqtsmg', -2098439423, 392.952848, -1148194959, 'pj6ddly', 1813965704, 719861381, 1193656937, 't1__795336', 'phdku2gir31v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 1, 1, -2147483648, 1188674483, -299585625, -2014514218, 'oi1pav', 1206923461, 340.48601, 1645850786, 'yqro', 917675957, -1582954378, -1143329124, '1', 't63', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 3, 1, -2147483648, -364462246, 982289268, 493701528, '33ir1axyyh', 370054768, 444.670601, -1837449583, 'p', -1452518801, -662859586, 1339281953, '4o6qjektb1', '2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, 1, -2147483648, -1517965246, 1807244612, 1125564712, 'ja8dccy3', 1560573473, 610.035242, 826141460, '49yrn', -583955995, -1935855834, 294818731, 't1__795336', 'do2v7t', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, 1, -2147483648, -699779308, -1368221491, 231250827, 'vuu', -1415215611, 411.706646, -251621840, 'y1ogyv1rgeza', 423028705, -316078323, -754769711, '1', 'ly', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, 3, -2147483648, -775706063, -1417040770, 858308694, 'lbwvdpu5v0e', -1920675616, 594.359145, -699425950, '129835x', 1084895939, 765955451, 1372042958, 'b', 'f0c296xi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, 1, -2147483648, 1177967285, -2001463367, -2003500453, 'perxa61sjv', -1265768652, 984.65145, -1879135081, 'okuez', 1795932554, -831032281, 2006256976, 't1__795336', 'a3c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, 1, -2147483648, 848275284, 736542812, -1977676789, 'ffwor1', 1202197697, 294.17485, -1424758178, '9q', -213453775, -1721445347, -314024594, '1', 'ij7f8k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, 1, -2147483648, -924570154, -99415515, -635922435, 'hl7j43y7', 209963559, 388.072029, 191797158, 'r3w', 1347243533, 1099005231, -1213283783, 't1__795336', '19xgjja', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 2, 1, -2147483648, -1333309256, 1671168213, 1139923255, '5', -1603206153, 481.051754, -813616969, 'bfokv', -1844939963, 59326585, -1371170489, '1', 't6lu2c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, 1, -2147483648, -1846239934, -1591272038, 1985372765, 'mb', 1859885644, 494.754011, -1023455371, '27xh8', 1875923360, -286884572, 2132634715, 't1__795336', '53sb59ls1e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, 1, -2147483648, 888725581, 1896957144, 470513738, 'zsnp64h', -1324600306, 208.856257, -1301565530, 'rwbjk', -356851435, -1093026980, -1940885010, '1', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, 1, -2147483648, 411661379, -1506240204, 1357426337, 'qkna', -1725694639, 701.559148, 1037880389, '2', -339252929, 1388989730, -600498375, 't1__795336', 'b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, 1, -2147483648, 619382464, 792905581, -1013704446, 'k4c6gwn', 542602362, 55.932348, -1984500518, 'iikaxzr90nhs', -1205570400, -976193147, -15423424, '1', 'phy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 3, 3, -2147483648, 195093192, -1957842577, -366834342, '3qn0b', -1500616, 443.377693, -1001218462, 'crwfx0', 1950697910, -964661721, 1269188010, '84lqme2', 'wb1b3vun66e0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, 1, -2147483648, -862433074, 80244587, -379984089, '0q833g86', 608918735, 403.166892, 1636393410, 'ewew', 508276629, 796830191, -115832402, 't1__795336', '2vil21', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, 1, -2147483648, -2091367850, 1367239582, 579664554, 'iqoauy0', -215230989, 176.854966, -669329028, '994fqc1m9gr', 1191255697, 1903061181, 943944514, '1', 'loxd4sj5il', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 2, 3, -2147483648, -1436037867, -1567310198, 1484560348, 'bl', -296531894, 256.996575, -1906909599, 'fc75m4s2ajdu', -567584339, -395383776, -1876636977, '3u5u77', '9qf9lx8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, 1, -2147483648, -2143583288, 1732744963, -686517061, 'mwu7al', 618880480, 949.55987, -1674574732, 'oe79350f', 1125313981, 1124849943, 1147847511, 't1__795336', 'll930xv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 1, 1, -2147483648, 513178845, -974198226, 1814543627, 'saxeeinmbc', -1598084888, 986.237451, -46379547, 'sme', -1038583670, -195750727, -794493872, '1', 'o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 1, 1, -2147483648, -73867879, 1086562671, -1092779922, '03a1ngqu', 359389091, 62.398913, 1961977235, 'l', 2142421496, -1408342453, 1689665778, 't1__795336', 'yxk0a0cql1c8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 2, 1, -2147483648, -721450631, -1908930700, 1259583135, '760ugk2', -1507399154, 368.492978, -1698199106, 'cg9', 2076581069, 1917868705, 188256891, '1', 'w16f5tqhjd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, 1, -2147483648, 1411268911, -221912911, -641282671, '2', -1934015200, 307.615462, 445436732, 'v', 681805258, 1254343862, -1963616196, 't1__795336', 'pw8672f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, 1, -2147483648, -390816038, -1748913439, -1608712068, '99kvn', 1211169035, 341.225439, 13488751, '3tfn', 990436826, 2071439307, 2077933154, '1', '9qy6sru4e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, 1, -2147483648, -1517836823, -2124619836, -1746125330, '8zr', 1579423631, 541.207148, -1860416222, 'lf0y', -327742602, -1457401052, 903854855, 't1__795336', '50', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, 1, -2147483648, 1617485225, -1232470711, 615649657, 'ex41fa', 1358642481, 436.289282, 680304659, '48u5lvdb', 1337608681, 709713623, -1664812348, '1', '3o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 1, 1, -2147483648, -804801271, -1830688350, 788036815, 'm3q0pq97', -30073701, 764.224206, -70372742, 'xbk11ysp', 1408494635, 1686931087, -111324604, 't1__795336', 'pjjv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, -266037807, 895167757, 831075499, '6j72vkwegrf', 1686819558, 207.451144, 1220359260, '5pbgwo', -1611243101, 16782608, -164454935, '1', 'dx5hn75b73', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, -445327932, -1714719754, 1946934142, '0twou', 1942685474, 473.652569, -470913545, '4h5c4f1q9w43', -1597057552, 1940380266, 196097271, '1', 'p4j9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 1, 1, -2147483648, 304203858, -1430783766, -895238090, 'e98b85', 946867225, 703.641664, -152632026, '8ikp3q', 127564856, -1716375595, -313408686, 't1__795336', 'vu6v8hkl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 3, 1, -2147483648, -163756060, -1036457856, -1154116262, 'smdhctnj', 177710966, 508.963144, 1530956156, 'hlh5i1', -1931468427, 1718452961, 2109623518, '1', 'lhw6lv7j4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, 3, 1, -2147483648, -1740675234, -856771235, -1625071271, 'l3bjksu', 1928368836, 219.34841, -1889113209, '60sijuf', 813052479, -737687664, -1708077219, 't1__795336', 'xbu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 1, 1, -2147483648, -1548627424, -1057155638, -1590734269, 'q', 1344117622, 750.810664, -249764330, 'zbw', 1422871709, -1023537273, -2051635326, '1', '7qobvbj2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 1, 1, -2147483648, 1729319706, 1094417174, -1269361504, 'lcorqtl1uodb', 563583599, 461.009986, -534387926, 'l431gfeg6', -1736300823, 769236877, -848571674, 't1__795336', 'xt41zjf1qj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 1, 1, -2147483648, 404661718, -1009771351, 1013019380, 'f5j', -1814058838, 773.493764, -29054318, '1gz7p', 1767626260, -1624769339, -1733083999, 't1__795336', 'ytzip2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 3, 1, -2147483648, 1290341173, 1232852817, 1379090934, 'zc192282', 1354931772, 206.126026, 1345356721, 'krmfoq', 673108767, -755719771, 1410336613, '1', '3i98owqw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 3, 1, -2147483648, -1080470671, 52953901, 1193772684, 'okt16hqb9jae', -1139271161, 480.809554, 1894848627, 'ne0b', -1090577818, -1448153489, 1850954065, 't1__795336', '623', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483595, 1, 1, -2147483648, 331287536, 921580808, -1836655128, '2zl4ptf8', 1590087415, 564.842829, -393305044, '90t2kl', -2127892574, 1955390593, 1819790775, '1', 'zdayv5uh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483594, 1, 1, -2147483648, 1718388939, -373111401, 1164059352, 'z3rs9', -89990023, 804.42525, -525409560, 'g3ufge', 2003439664, -970617683, -659241529, 't1__795336', 'qgiqh4ao3k79', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483593, 1, 1, -2147483648, -71910989, -875587691, -158691005, '49kf5l6rnd3r', 1238033614, 21.365513, 376343297, 'bp96', 1061006043, 970841205, -216136015, '1', 'v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483592, 1, 1, -2147483648, -992513509, -289518843, -1505803580, 'bssy', 110647977, 354.397815, 910724149, 'agrj6o317kaj', 98755104, 1422066671, -1563126058, 't1__795336', '9f9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483591, 1, 1, -2147483648, -1983237870, -46116361, 857489503, 'jmeuvjv', 644887463, 268.636909, -392675823, 'f515y8am0q', 1092973308, -797802265, -208707815, '1', '16fr11lu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483590, 1, 1, -2147483648, 735250406, -461669512, -261162125, 'enn4il', -1964917384, 760.104819, 1441332845, 'w6gv', 1246780528, 538410706, -1406204087, 't1__795336', 'mrsv641', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483589, 1, 1, -2147483648, 284729405, 1096271431, -1639582801, 'dlzbbk2', 92746551, 393.193511, 1833037259, 'uwyewbihg801', -1860262488, -192376676, 996081640, 't1__795336', '2n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483588, 3, 1, -2147483648, 1327838637, 1460090168, 2134974396, 'v4lraxg0gt', -593591690, 297.566717, 1106541902, '1lrh', -524520263, 880857056, 756343111, '1', 'yhmlrnycz8d5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483587, 3, 1, -2147483648, 1039011719, 2115509653, 438588017, 'bkfphyyxnm', -377880939, 200.326802, -788022648, 'y4c1vk27ki', -128719216, 1164825902, -1787219074, 't1__795336', 'ndgi80zqe9rs', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483586, 1, 1, -2147483648, -205525091, 1705616658, 1116930784, 'sqirlhj', -283126913, 372.691644, 683709377, 'o9km29vphx5v', 461626933, -1152460844, -493605337, '1', 'skvh4qm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483585, 1, 1, -2147483648, -1890973087, -1801965762, 317664148, '4lj', -567298605, 248.171376, 1780490976, 'bn', -506886523, 965039732, 430146619, 't1__795336', 'pyee2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483584, 1, 1, -2147483648, 1980395190, 295543538, 1197358774, '7qnkj2dsjla9', 996091596, 204.300627, 2040233149, '7dxug9rta6w', -2117214475, -1550302174, 101396312, '1', 'q6gahjc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483583, 1, 1, -2147483648, -1035489492, 1772524500, 1059686731, '19', 132846311, 824.551566, -1873030622, 'rrulwblhtkbt', 633090631, 499326529, -1252329401, 't1__795336', 'wnzpkc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483582, 1, 1, -2147483648, 714955236, 724210726, -448128829, 'yul6g25j', -1385817383, 164.579549, -1726587435, 'kx1wfn', -2067877584, 2123259094, -98939200, '1', '9g9nw16bb6t', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483581, 1, 1, -2147483648, -1356099725, 1401780703, -720003270, 'c3', 945485304, 409.537499, -688389515, '3muo9o5cw', 1587263314, 1007592936, -1807415577, 't1__795336', 'y2vtctr95snh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483580, 1, 1, -2147483648, 2112315535, 372754157, 1074058348, 'hv1', -575776570, 593.88391, -1657244403, 'w', -607510855, -1416665277, -585011180, 't1__795336', 'ftaq65', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483579, 3, 1, -2147483648, 987389130, 71627414, 1781568993, '86mok', 131124756, 309.333522, -347271276, 'w', -1641998003, 1223106837, 185128084, '1', 'izd0cunhg8mg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483578, 3, 1, -2147483648, -462815484, -1859171141, 457373592, '41i6vn9a6', -1621905952, 260.842371, 555347058, 'etff9znz5', -1950732390, -510584054, 1757672521, 't1__795336', 'e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483577, 1, 1, -2147483648, -1457809462, -907624439, 992976427, 'uxpevos', -2015196480, 704.269643, 725889807, 'bvoyhadym3ja', 435918223, -438688587, 1299411857, '1', 'zxpmaspu0abl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483576, 1, 1, -2147483648, 593312927, -892860277, 2003681474, 'd57xpoym', -1435728387, 820.662266, -503102544, 'effs4e', 2052041014, 417875257, -2008346397, 't1__795336', 'ssva836iviiz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483575, 1, 1, -2147483648, 694956975, -1366856113, 1653776824, 'l71l0q4nksw', -18383241, 718.478505, 512155743, '0da', 959578742, -136826782, -167254422, '1', 'szsmb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483574, 1, 1, -2147483648, 709082202, -1832063257, -606548084, 'm8', -1106675376, 827.162233, 1396600276, 'ps38', -690539497, -63563920, 1604307119, NULL, '4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483573, 1, 1, -2147483648, -1668844682, 811217886, -1788107498, 'x0', 1207670065, 654.587736, -689724455, '3r', 1544681993, -1859314879, -1768488861, NULL, 'wrasmde2kh', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.driverId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL), lap_record_race AS (SELECT T1.raceId, T1.driverId FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix') SELECT T4.duration FROM lap_record_race INNER JOIN pitStops AS T4 ON lap_record_race.raceId = T4.raceId AND lap_record_race.driverId = T4.driverId;

/*
Gold Result:
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('t4__454cda',)
('8jcakwtu',)
('1',)
(None,)
('t4__454cda',)
*/

-- Prediction Query
SELECT "p"."duration" FROM "pitstops" AS "p" INNER JOIN "laptimes" AS "l" ON "p"."raceid" = "l"."raceid" AND "p"."driverid" = "l"."driverid" INNER JOIN "races" AS "r" ON "l"."raceid" = "r"."raceid" INNER JOIN "circuits" AS "c" ON "r"."circuitid" = "c"."circuitid" WHERE "c"."name" = 'Austrian Grand Prix Circuit' AND "l"."time" = (SELECT MIN("time") FROM "laptimes" WHERE "raceid" = "l"."raceid" AND "driverid" = "l"."driverid" AND "raceid" IN (SELECT "raceid" FROM "races" WHERE "circuitid" = "c"."circuitid"));

/*
Prediction Result:
*/