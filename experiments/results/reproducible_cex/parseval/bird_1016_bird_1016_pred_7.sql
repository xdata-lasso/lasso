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

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, 1448731351, 1, 'Austrian Grand Prix', '2025-11-13', 'wgxd5ysxcm', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, 853709925, 1, 'dgj5i', '2025-02-22', 'q5l', 'url_4');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'p', 13244799, 'hvdltt', 'lbn', 'rmdp', '2022-07-21', 'siie5unw6k', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'xeilp', -1839279753, '19cy7od033d', 'hds', 'nhed29', '2021-12-24', 'qv26u331spx', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'nlj', 1673977398, 'dmp61l2o3ak1', '62ocagjeevx', 'xlu49ku', '2020-04-01', 'e8cd', 'url_3');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '00t5c4ecigc', 'name_1', 'e376nium52', 'zbuo4nrqrof');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483647, 'vy9uxj4', 'wb', 'v', 'ph2', 109.083092, 802.414724, 1968874827, 'url_2');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3, 'o705', 'a9n0jxfofws', 'do2zobb', 'q0k32od', 357.061424, 979.99406, 895277769, 'url_3');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2, 'msorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 506.13059, 78.702002, -795975227, 'url_4');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'qyp5s5bbp0');

-- Inserting into table: pitstops --
INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483648, 1151980946, 'a9', 't4__606b3d', 1620389964);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483647, -1485777725, '8n2f3', 't4__606b3d', 806170397);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483646, 513454646, '0gcb98', 't4__606b3d', -1454058168);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483645, 1339733032, 'im5k', 't4__606b3d', 1379859112);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483644, 778835680, 'kb521gw', 't4__606b3d', -1250380401);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483643, 920097188, '1rxe9y', 't4__606b3d', -1046720861);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483642, -2008781089, 'qta8y3a17', 't4__606b3d', -735270562);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483641, -1043357093, 'd8ftb8', 't4__606b3d', 1183069552);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483640, -1096060187, 'mwfw', 't4__606b3d', -544173163);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483639, -711121679, 'wpp', 't4__606b3d', 1913338832);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 2, -2147483638, 764047845, '30bgwk', 't4__606b3d', 1659285381);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483637, 2095228319, 'gm8gxb5q', 't4__606b3d', -1497515537);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483636, 771073365, 'fc', 't4__606b3d', -1550947002);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483635, 1550706713, 'tlzh42', 't4__606b3d', -1241530177);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (2, 1, -2147483634, 1487440939, 'y', 't4__606b3d', 2017526622);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 2, -2147483633, 1293700593, 'gwakmwg', 't4__606b3d', -151666814);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483632, -390950704, 'l1zmjrssbh', 't4__606b3d', 133794777);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483631, -2099978946, 'kr2t', 't4__606b3d', -1903548007);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483630, -1588383617, '8o', 't4__606b3d', 1796323549);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483629, 638054085, 'if0', 't4__606b3d', 500709040);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483628, 266841961, 'cq2iae6aj6ql', 't4__606b3d', 29713329);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483627, -270252656, 'qt5uw42', 't4__606b3d', 1580796530);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483626, 764338493, '5', 't4__606b3d', 1154691182);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483625, -1492410135, 'e4dpb', 't4__606b3d', -109711729);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483624, -640151143, '0hvv0oh59iv', 't4__606b3d', 1826148003);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483623, 82384907, '691b7s1i0k8', 't4__606b3d', 1164059352);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483622, 1824528433, 'pjn', 't4__606b3d', -1214696977);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483621, -1175155753, 'xze42lwenn4', 't4__606b3d', -1395464118);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483620, 1833037259, 'uwyewbihg801', 't4__606b3d', -1860262488);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483619, 1320325887, 'ndgi80zq', 't4__606b3d', 208702091);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483618, 965039732, 'xtpyee2zt2', 't4__606b3d', 295543538);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483617, -145918370, 'l6g25j', 't4__606b3d', -1385817383);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483616, -197507241, 'll8k', 't4__606b3d', -1034567822);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (3, 1, -2147483615, 1362812315, 'bwhbi', 't4__606b3d', 1333023531);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483614, 1665348170, '6stk', 't4__606b3d', -329985830);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483613, -2045718619, 'z2fp2srds4d5', '7xpoymk4yzv', -1796328619);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483612, -488726144, 'ssva836i', 't4__606b3d', -1558702799);

INSERT INTO "pitstops" ("raceid", "driverid", "stop", "lap", "time", "duration", "milliseconds") VALUES (1, 1, -2147483611, 1062764592, '2f5fx05r', NULL, 1356107826);

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274.580687, 274769912, 'oo3o9', -1666765085, 1178636309, -1390245819, '1', 'x14ji7zwau2d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, 1, -2147483648, -953437896, -1097120355, 244829661, 'jsl', -346339240, 470.165282, 1692174491, 'qi2rkf9v', 556727997, 1178000634, 1836127587, 't1__a3daba', 'f8jegd2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 1, -2147483648, -1554531873, 982314585, 638024588, '6vck6ah0f8js', -658391922, 176.824244, -566887085, '72fxa7ryfd', 564390026, -1259474148, 2011234363, '1', 'ai5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, 1, -2147483648, 1583472758, 1449284300, -977470238, 'd8y', 1129658414, 308.482994, 1250290042, 'og', -946046410, -902895762, -197933860, '1', 'xp1q430', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, 1, -2147483648, 1948383687, 1476361420, 195720193, 'vacx7afu5', -290314193, 850.85096, 76996700, 'o72ctdc', 1303877941, -1284905200, 7929158, 't1__a3daba', '0v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 1, 1, -2147483648, 1421303999, -1488156735, -1858644047, 'o22', 2004147439, 338.933701, -1523347137, 'ttg6bnou5zi3', -68044929, -1776877925, 1201273976, 't1__f63310', 'oacd07z2zez', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 3, 1, -2147483648, 1615073310, 1055237066, 988954859, 'th', 333302050, 193.695314, 1162591638, 'ajjla3okv8u', 618058035, 1553368934, -1252009958, '1', '78lfvyz7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, 1, -2147483648, -2052653308, -489120589, -72442907, '7sx58', 782684333, 476.006677, 681598285, 'aus3', -2090240067, -699574669, 274891948, 't1__a3daba', 'pdjwzw5chn9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 1, -2147483648, 469838697, 1468640756, 1048147204, 'eowi', -1610380698, 393.510383, 1557188093, 'xih662q2xly', 412199481, 727608179, 456034296, '1', 'g96aqb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, 1, -2147483648, 868039568, 503053726, -1897615568, '9tajz9td', 152478847, 655.746331, -625404808, 'um', 989306270, 1147652228, 1378873397, 't1__a3daba', 'u6bd0w9603', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, 1, -2147483648, -1231488097, 956819642, 774922170, '3dohvu0', 30861410, 397.847489, -154207334, 'rmkio18ri2', 1677948887, 389700824, -1853955201, '1', 'qxxnj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, 1, -2147483648, -1312038093, 687330820, -224390110, 'x7', -1659775598, 453.840746, -891525031, '1cj8', 1728926031, -63214972, 1106724223, 't1__a3daba', 'ys7dyyd1jmg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 3, 1, -2147483648, -2081662466, -1941472821, -2082238979, '6rntdqrhm', 555368535, 181.220234, 899787662, 'n2np490xdms', -1027584872, -1685482179, -1391541536, '1', 'qb9i9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, 1, -2147483648, 908468929, 1149620614, -1414362698, '1quik', 1570917601, 680.51123, -2052350430, 'hlst1pqom', 2141720493, 1793241362, -1304516770, 't1__a3daba', 'z78', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, 1, -2147483648, 1639204149, -2063751689, 36589303, 'jeuuwsj8kj', -55270062, 243.463869, 1939337883, 'isurz', -388527046, -1040951738, -1218774640, '1', 'gc8s3b7v88k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, 1, -2147483648, 1789767331, 1633584225, 1671062261, 'h', 313797011, 953.185987, -1215810104, 'r', -343920305, 460471995, -1515201134, 't1__a3daba', 'n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, 1, -2147483648, 2015039199, -641927001, 558684943, 'r5dqtsmg', -2098439423, 392.952848, -1148194959, 'pj6ddly', 1813965704, 719861381, 1193656937, '1', 'phdku2gir31v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 1, 1, -2147483648, 1188674483, -299585625, -2014514218, 'oi1pav', 1206923461, 340.48601, 1645850786, 'yqro', 917675957, -1582954378, -1143329124, 't1__a3daba', 't63', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 3, 1, -2147483648, -364462246, 982289268, 493701528, '33ir1axyyh', 370054768, 444.670601, -1837449583, 'p', -1452518801, -662859586, 1339281953, '4o6qjektb1', '2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, 1, -2147483648, -1517965246, 1807244612, 1125564712, 'ja8dccy3', 1560573473, 610.035242, 826141460, '49yrn', -583955995, -1935855834, 294818731, '1', 'do2v7t', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, 1, -2147483648, -699779308, -1368221491, 231250827, 'vuu', -1415215611, 411.706646, -251621840, 'y1ogyv1rgeza', 423028705, -316078323, -754769711, 't1__a3daba', 'ly', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, 3, -2147483648, -775706063, -1417040770, 858308694, 'lbwvdpu5v0e', -1920675616, 594.359145, -699425950, '129835x', 1084895939, 765955451, 1372042958, 'b', 'f0c296xi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, 1, -2147483648, 1177967285, -2001463367, -2003500453, 'perxa61sjv', -1265768652, 984.65145, -1879135081, 'okuez', 1795932554, -831032281, 2006256976, '1', 'a3c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, 1, -2147483648, 848275284, 736542812, -1977676789, 'ffwor1', 1202197697, 294.17485, -1424758178, '9q', -213453775, -1721445347, -314024594, 't1__a3daba', 'ij7f8k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 3, 1, -2147483648, -924570154, -99415515, -635922435, 'hl7j43y7', 209963559, 388.072029, 191797158, 'r3w', 1347243533, 1099005231, -1213283783, '1', '19xgjja', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, 1, -2147483648, -1333309256, 1671168213, 1139923255, '5', -1603206153, 481.051754, -813616969, 'bfokv', -1844939963, 59326585, -1371170489, 't1__a3daba', 't6lu2c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, 1, -2147483648, -1846239934, -1591272038, 1985372765, 'mb', 1859885644, 494.754011, -1023455371, '27xh8', 1875923360, -286884572, 2132634715, '1', '53sb59ls1e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, 1, -2147483648, 888725581, 1896957144, 470513738, 'zsnp64h', -1324600306, 208.856257, -1301565530, 'rwbjk', -356851435, -1093026980, -1940885010, 't1__a3daba', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, 1, -2147483648, 411661379, -1506240204, 1357426337, 'qkna', -1725694639, 701.559148, 1037880389, '2', -339252929, 1388989730, -600498375, '1', 'b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, 1, -2147483648, 619382464, 792905581, -1013704446, 'k4c6gwn', 542602362, 55.932348, -1984500518, 'iikaxzr90nhs', -1205570400, -976193147, -15423424, 't1__a3daba', 'phy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 3, 3, -2147483648, 195093192, -1957842577, -366834342, '3qn0b', -1500616, 443.377693, -1001218462, 'crwfx0', 1950697910, -964661721, 1269188010, '84lqme2', 'wb1b3vun66e0', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, 1, -2147483648, -862433074, 80244587, -379984089, '0q833g86', 608918735, 403.166892, 1636393410, 'ewew', 508276629, 796830191, -115832402, '1', '2vil21', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, 1, -2147483648, -2091367850, 1367239582, 579664554, 'iqoauy0', -215230989, 176.854966, -669329028, '994fqc1m9gr', 1191255697, 1903061181, 943944514, 't1__a3daba', 'loxd4sj5il', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 3, 3, -2147483648, -1436037867, -1567310198, 1484560348, 'bl', -296531894, 256.996575, -1906909599, 'fc75m4s2ajdu', -567584339, -395383776, -1876636977, '3u5u77', '9qf9lx8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, 1, -2147483648, -2143583288, 1732744963, -686517061, 'mwu7al', 618880480, 949.55987, -1674574732, 'oe79350f', 1125313981, 1124849943, 1147847511, '1', 'll930xv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 1, 1, -2147483648, 513178845, -974198226, 1814543627, 'saxeeinmbc', -1598084888, 986.237451, -46379547, 'sme', -1038583670, -195750727, -794493872, 't1__a3daba', 'o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 3, 1, -2147483648, -73867879, 1086562671, -1092779922, '03a1ngqu', 359389091, 62.398913, 1961977235, 'l', 2142421496, -1408342453, 1689665778, '1', 'yxk0a0cql1c8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, 1, -2147483648, -721450631, -1908930700, 1259583135, '760ugk2', -1507399154, 368.492978, -1698199106, 'cg9', 2076581069, 1917868705, 188256891, 't1__a3daba', 'w16f5tqhjd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, 1, -2147483648, 1411268911, -221912911, -641282671, '2', -1934015200, 307.615462, 445436732, 'v', 681805258, 1254343862, -1963616196, '1', 'pw8672f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, 1, -2147483648, -390816038, -1748913439, -1608712068, '99kvn', 1211169035, 341.225439, 13488751, '3tfn', 990436826, 2071439307, 2077933154, 't1__a3daba', '9qy6sru4e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, 1, -2147483648, -1517836823, -2124619836, -1746125330, '8zr', 1579423631, 541.207148, -1860416222, 'lf0y', -327742602, -1457401052, 903854855, '1', '50', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, 1, -2147483648, 1617485225, -1232470711, 615649657, 'ex41fa', 1358642481, 436.289282, 680304659, '48u5lvdb', 1337608681, 709713623, -1664812348, 't1__a3daba', '3o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, -804801271, -1830688350, 788036815, 'm3q0pq97', -30073701, 764.224206, -70372742, 'xbk11ysp', 1408494635, 1686931087, -111324604, '1', 'pjjv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, -266037807, 895167757, 831075499, '6j72vkwegrf', 1686819558, 207.451144, 1220359260, '5pbgwo', -1611243101, 16782608, -164454935, '1', 'dx5hn75b73', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, 1, -2147483648, -445327932, -1714719754, 1946934142, '0twou', 1942685474, 473.652569, -470913545, '4h5c4f1q9w43', -1597057552, 1940380266, 196097271, 't1__a3daba', 'p4j9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 3, 1, -2147483648, 304203858, -1430783766, -895238090, 'e98b85', 946867225, 703.641664, -152632026, '8ikp3q', 127564856, -1716375595, -313408686, '1', 'vu6v8hkl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 1, 1, -2147483648, -163756060, -1036457856, -1154116262, 'smdhctnj', 177710966, 508.963144, 1530956156, 'hlh5i1', -1931468427, 1718452961, 2109623518, 't1__a3daba', 'lhw6lv7j4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, 1, 1, -2147483648, -1740675234, -856771235, -1625071271, 'l3bjksu', 1928368836, 219.34841, -1889113209, '60sijuf', 813052479, -737687664, -1708077219, '1', 'xbu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 1, 1, -2147483648, -1548627424, -1057155638, -1590734269, 'q', 1344117622, 750.810664, -249764330, 'zbw', 1422871709, -1023537273, -2051635326, 't1__a3daba', '7qobvbj2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 1, 1, -2147483648, -1401481173, 1888904719, 1547717459, 'orqtl1uodbvf', -534387926, 503.593288, 949206609, '31gfeg6q', 56216130, 1385394884, 1792401890, 't1__a3daba', 'xt41zj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 3, 1, -2147483648, -950795649, 128017130, -1544200311, 'pxb659q4tkf5', -1521409928, 850.294419, 2132312264, 'y485ys1g', 302385175, 1767626260, -1624769339, '1', '0w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 1, 1, -2147483648, 561609131, -1604313896, -1889176700, 'qs', -1948353462, 962.57088, -254442524, '2rnfvkrmf', 1667042356, 549119239, 673108767, 't1__a3daba', 'ucnn53i', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 1, 1, -2147483648, 1562452925, 410637411, 1730574324, 'qb9jae9ps4d', -1830074601, 694.595307, -1090577818, 'kuizi', -223111865, -1085464899, 1234250708, '1', 'wew42zl4ptf8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483595, 1, 1, -2147483648, -393305044, -343838991, 1772920250, 'klyapcw1gn', 2032090551, 511.611531, -1903211911, 'dayv5uh', -1176524414, -717909980, 305802334, 't1__a3daba', 'wraqxeddnko4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483594, 1, 1, -2147483648, -525409560, -567248843, 533073608, 'ge', 2003439664, 274.01046, -659241529, 'qgiqh4ao3k79', -722157386, -71910989, -875587691, '1', 'b3349kf5l6rn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483593, 1, 1, -2147483648, -1638030257, -1253560766, 1061006043, '122bvxjn', -748409233, 531.346766, 561559089, 'm31', 1140114575, 1702524147, 605923875, 't1__a3daba', 'niom2u85', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483592, 1, 1, -2147483648, 1330725746, 885927296, 879826183, 'o317kajtw', -1017874103, 317.89633, 259660611, '945ycwnr8d', 1327596103, 755310829, -2038978824, '1', 'jmeuvjvcr9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483591, 1, 1, -2147483648, 1342397236, -2130742032, 1244725562, 'jut2f', -173789692, 785.423156, -317767232, 'vk4s7w', -1716157367, 1906070650, 566755160, 't1__a3daba', 'h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483590, 1, 1, -2147483648, 435993660, -460708242, -1001569685, '641h6b', 1820491976, 711.4587, 1458099729, 'ygqofzr1q', 1752023111, 2140117306, -1433467412, 't1__a3daba', '1whx1dlzbb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483589, 3, 1, -2147483648, 996081640, -1871398938, -1251117933, 'cn', 2134974396, 857.63843, -674436733, 'lraxg0gtxot6', 1106541902, 494307015, 1914322829, '1', 'qsxyubeyhmlr', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483588, 1, 1, -2147483648, 1792208390, -2797499, 886201162, 'abtcpo1ke8eu', -563164400, 535.250261, -1758636145, 'hyyxnm0cmn8', 1672173400, -492514452, 1960351405, 't1__a3daba', 'vk27ki4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483587, 1, 1, -2147483648, 137456355, -648886997, 611665243, 'o1sqirlhj1', -1715369895, 649.513898, -1325539976, 'vphx5vl7j', -1152460844, -493605337, -916486834, '1', 'h4qmy4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483586, 1, 1, -2147483648, -337744564, -996554883, -2018324945, 'd0gkgqa', -772738375, 40.207205, -100171553, 'dvf12j4ljl', 947860475, 1504157345, -1922481721, 't1__a3daba', 'hebn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483585, 1, 1, -2147483648, -316612343, -1931313326, 2141560768, '9r', 325036503, 7.047588, -1550302174, 'azq6gahjc', 1170204561, -713353583, 1709664327, '1', 'sddfra2n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483584, 1, 1, -2147483648, -642971630, -1035489492, 1772524500, 'ig197gelrrul', -616668672, 964.413383, -1629766030, 'kbtog8ol79c', 527668055, -1393460091, 851083562, 't1__a3daba', 'pkcpw0q', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483583, 1, 1, -2147483648, -645751914, -1243844048, -1179860454, '1864a9g9nw1', -2040803304, 795.753322, 1984866957, 'ck', 595762979, -1550778326, -1310826078, '1', 'f5tulso', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483582, 1, 1, -2147483648, -1629403011, 393032717, 314602956, 'b0v293muo9o5', 592134998, 348.113496, 1161208830, 'nc56gwfuy2', 731441951, -848636172, 1181024587, 't1__a3daba', '5snhqc1jc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483581, 1, 1, -2147483648, 1446919217, 341329391, -1287895402, 'hv1xti78hf', -1985673660, 572.362489, -607510855, 'mxv', 322037946, -863095783, -28426541, 't1__a3daba', 'vero7mfr86mo', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483580, 3, 1, -2147483648, 449203420, -1565587515, -358449745, 'nhg8mg', -722195642, 852.20539, -1012234498, 'wbdo290a5nxz', -1765640104, 1502626911, 933110466, '1', 'f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483579, 1, 1, -2147483648, 457373592, 427986638, 1565767109, '6vn', -1621905952, 260.842371, 555347058, 'etff9znz5', -1950732390, -510584054, 1757672521, 't1__a3daba', 'e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483578, 1, 1, -2147483648, 712953308, 1708336152, -2015196480, 'wqbvoyhadym3', -1117835206, 719.015799, 1411559422, 'zjd2zxpmaspu', 2095400124, -2087911973, -748389639, '1', 'hq6', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483577, 1, 1, -2147483648, -291432497, -1738595278, 194619220, 'a', -1444171488, 914.532429, -868578234, 'mvp19dvetw', -1815268176, 1000024884, 1806410862, 't1__a3daba', '80x72p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483576, 1, 1, -2147483648, -39689010, -1933824833, 708987508, '4l71', -1401957663, 613.809486, 1709982602, 'ksw3', 519767432, 31503330, 240049541, NULL, '4l0dafs830', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483575, 1, 1, -2147483648, 51275046, 1063943224, -2051201624, 'k5paop6', 1440926181, 460.109252, 709082202, '7ekwhfm8', -1106675376, 1396600276, -930461746, NULL, 'vev5utc4w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483574, 1, 1, -2147483648, -1032481986, 1160921325, 1544681993, 'xf', 818543667, 989.657136, -2136286026, 'de2k', -1634628472, 1399905253, -1162633074, '1', 'dui5ig2e', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483573, 1, 1, -2147483648, -697116227, 183626110, -661918364, '1fs7hycnb5a', 1056853635, 986.521039, 2041355935, 'oy', -1256009271, 1891844121, -395394445, 't1__a3daba', 'k4nr', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.driverId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL), lap_record_race AS (SELECT T1.raceId, T1.driverId FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T2.name = 'Austrian Grand Prix') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds WHERE T2.name = 'Austrian Grand Prix') SELECT T4.duration FROM lap_record_race INNER JOIN pitStops AS T4 ON lap_record_race.raceId = T4.raceId AND lap_record_race.driverId = T4.driverId;

/*
Gold Result:
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('t4__606b3d',)
('7xpoymk4yzv',)
('t4__606b3d',)
(None,)
*/

-- Prediction Query
SELECT SUM(ps.duration) AS total_pitstop_time FROM races AS r JOIN circuits AS c ON r.circuitid = c.circuitid JOIN laptimes AS lt ON r.raceid = lt.raceid JOIN pitstops AS ps ON r.raceid = ps.raceid AND lt.driverid = ps.driverid WHERE c.name = 'Austrian Grand Prix' AND lt.position = 1;

/*
Prediction Result:
(None,)
*/