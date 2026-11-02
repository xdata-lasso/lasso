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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, -2147483648, 'a2ypuzhsrwbb', '2022-08-24', 'luhvdltti', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -1255130038, -2147483648, '3d', '2022-11-06', '0gcb98', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, -691774480, -2147483648, 'ptt', '2021-03-15', 'bnou5zi36', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, -2147483648, 1849819405, -2147483648, 'us3auvmkrpdj', '2024-01-06', 'w5chn9m', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, -59984348, -2147483648, 'wqcgsk', '2022-04-27', '8c4pgu7vfe', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -992890117, -2147483648, 'a2ypuzhsrwbb', '2022-08-24', 'luhvdltti', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, -2147483648, 1775126557, -2147483648, 'ji7zwau2', '2020-08-25', 'yrq13p', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, -2147483648, 176555546, -2147483648, 'gd', '2025-01-26', 'vy9uxj4', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, -2147483648, -1762857309, -2147483648, 'dqv0gcb98ozk', '2025-03-14', 'bilyrkn', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, -2147483648, 600440952, -2147483648, 'f', '2021-02-13', 'grit', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, -2147483648, -1784554553, -2147483648, '2g0v5q8qd', '2021-09-20', 'e1io', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, -2147483648, -542502665, -2147483648, 'ysxcmr0o', '2024-07-19', 'dgj5i', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, -2147483648, -1311735207, -2147483648, 'ne578lfv', '2024-03-25', '7zzbe8y', 'url_13');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, -2147483648, -1514700303, -2147483648, 'of', '2023-12-13', 'zdo2z', 'url_14');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'bnp', 1236688122, 'dpos', 'ie5', 'nw6klf', '2020-01-23', '9000t5c4ec', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'gce', 'name_1', '76nium52', 'zbuo4nrqrof');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'qyp5s5bbp0');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, -2147483648, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274.580687, 274769912, 'r_s_cbaaa1', -188151580, 226938182, 90119032, 'lex', '4ji7zwa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, 1485335077, -511185946, -1021749117, '3pyu78d99r', -1362461264, 943.791649, -904834265, 'r_s_befb99', -346339240, 1692174491, -1025564911, 'rkf9vqx5', 'pz0f8jegd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, -2147483648, 233994589, 1442655647, -87647544, 'bdvlph', -261132974, 795.815869, -1264842910, 'r_s_1d07bb', -1052964641, -1245682094, -1660358170, 'p', 'jtu0d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, -155284187, 1686459626, -1554531873, 'yrkn6vck6ah0', -1520489792, 346.706184, -1388029300, 'r_s_cbaaa1', -566887085, 602161869, 1350414441, 'a7ryfd', 'z16ni', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, -7597509, -1625552518, -1738458256, 'jd', 1074760385, 763.019095, 1250290042, 'r_s_befb99', -1717646459, -1696173285, 710458518, 'sj3ayxp1q430', 'jh3den8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, -2147483648, -2147483648, 1732258051, -1762140823, 1371234901, '1of77p', -435350511, 689.065203, 1992637800, 'r_s_1d07bb', -820614248, 481546706, -1784554553, '2g0v5q8qd', 'jpe1io22785', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, -2147483648, -1776877925, 1201273976, 1923659053, 'c', -406331049, 392.567695, -468701684, 'r_s_cbaaa1', 1448731351, -604098478, 1248858185, '5', 'sxcmr0o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, -2147483648, -2147483648, -1699185893, 875300074, -1609653472, 'q5l', 1339733032, 236.262879, -1556979799, 'r_s_befb99', -55240145, 1379859112, 195202164, 's27p2r94gth2', 'najj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 86.586744, 697257217, 'r_s_1d07bb', -451030047, -2052653308, -489120589, 'v42', '7sx58', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 0, -2147483648, -2147483648, 238533676, -1514700303, -1796351243, 'ws', 1719800120, 55.294573, -210159774, 'r_s_cbaaa1', 270415200, -2071531094, -397848196, '0k32odwcl5a', 'msorlwyngc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 0, -2147483648, -2147483648, 211603887, -413043724, 761519897, 'yoeyo6l', 1428194830, 124.067083, 1435223075, 'r_s_befb99', 1617348603, -477129795, -1418927432, '521gwnlas6e', 'lboeowii1z5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 0, -2147483648, -2147483648, -251205568, 287256667, 1614799674, 'ow9oaawg96a', 966412849, 19.988339, -850941333, 'r_s_1d07bb', -1216952047, -457901285, -2140923099, '9td8n5w', 'g', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 0, -2147483648, -2147483648, 1147652228, 1378873397, 1964331395, 'bd0w9603v', 2018368241, 685.760212, 920097188, 'r_s_cbaaa1', -639616320, 1689143863, 237552112, 'k7', 'k162n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 0, -2147483648, -2147483648, 2105860871, -141591627, 440797047, 'vu', 1654100852, 507.185482, -438741674, 'r_s_befb99', -154207334, 729449685, -1580984044, '8ri2hy0', '8ftp6ewtqx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 0, -2147483648, -2147483648, 917362079, -1312038093, 687330820, 'mfx7h33p', 63063873, 303.704524, -285085577, 'r_s_1d07bb', 170892881, -1643065004, -1438303683, 'zys7dyyd1jmg', 'jach8qta8y3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, -2147483648, -2147483648, 306260487, 1168225104, -499203870, 'qdpuap96', 1291298007, 961.532162, 2013152515, 'r_s_cbaaa1', 1139012231, -951706262, -1324935647, 'wlic7dn2np', '90xdmsqt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, -2147483648, -2147483648, -1974774786, 422046500, -1750715330, 'ccukjq1qui', -1459013972, 696.949621, -1670335771, 'r_s_befb99', 1862728578, 1909521477, 2101986789, 'mizt', 'vb6m4iz78aq', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 1, -2147483648, -2147483648, 948460309, 1183069552, -1057355067, 'e6bje', 364280973, 870.680595, -1451520332, 'r_s_1d07bb', -55270062, -1101814296, 1939337883, 'isurz', 'kaqtncg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 1, -2147483648, -2147483648, 180947503, -622923312, 1789767331, 'b', -1924635316, 303.260196, 313797011, 'r_s_cbaaa1', 1946419004, -1215810104, -982188592, 'hsjhanz', 'dpunmw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, -2147483648, -2147483648, -1040088060, -2081798075, -1439417265, '14r5dqtsmg97', -2098439423, 392.952848, -1148194959, 'r_s_befb99', 944310519, 6224071, 1928920679, 'ysu', 'iphdku2gi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, -2147483648, -2147483648, -717865822, 2061102304, -1204806277, 'sb3uoi1p', -1971610898, 722.756601, 2095277250, 'r_s_1d07bb', 1971816668, -1067465394, 1491006943, 'lrpou', 't63', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 1, -2147483648, -2147483648, -2061050846, 1893953818, -364462246, '0h3r13', -156860347, 654.86752, 1805058154, 'r_s_1d07bb', -270436559, -569461411, 1498496406, 'l2i9', 'sa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, -2147483648, -2147483648, -69263912, 17776256, -1464066437, '1', 1464469520, 451.237024, 946571403, 'r_s_1d07bb', -1517965246, 1807244612, 1125564712, 'ja8dccy3', 'vjwq49yrnx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, -2147483648, -2147483648, -1680744918, -1136928894, -1789708299, 'uun7k1', -251621840, 887.571765, -1720233199, 'r_s_1d07bb', -672126855, -966886446, -1873650788, 'x', '1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, -2147483648, -2147483648, -1813651479, -1353862813, -1839279753, '19cy7od033d', -1665891229, 283.534179, -1239290359, 'r_s_1d07bb', -1832294694, 1188203659, -1066046077, '26u331spxpw3', 'bgwkxgi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, -2147483648, -2147483648, 1574139922, -2106733603, -229524038, 'cagjeevxzxlu', 207561330, 318.136826, -1195170145, 'r_s_1d07bb', -2007399097, -92242817, 426006253, 'll', 'w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, -2147483648, -2147483648, 1551904707, -400879450, -1920675616, 'y9v2z12983', 1870044139, 363.048023, -1147311649, NULL, 1599672055, 745344960, -563021857, 'b2f0c296xiye', '8xjhc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 1, -2147483648, -2147483648, 312333412, 871812581, -977983676, '6', -329270684, 146.627287, -1265768652, NULL, 2081562124, -1879135081, -958249959, 'uez', 'ctehia3cmvb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, -2147483648, -2147483648, -1798310553, -1174073066, -1853296452, 'sf9', 1494789426, 255.938993, -388744933, NULL, -1618292687, -1585280787, 128895724, '8kqhiu5gm8', 'xb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, -2147483648, -2147483648, -99415515, -635922435, -150306637, '7j4', -189319798, 754.156177, -51114840, 'r_s_cbaaa1', -2018922963, -197208169, 2089151689, 'z19xgjja', 'cgmukfb5if4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, -2147483648, -2147483648, -1819463450, -2055620484, 1176294340, 'vee', 59326585, 180.749493, -759584258, 'r_s_befb99', 1143458360, -769244829, 479662575, 'l8', 'mhfcimn5eni', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, -2147483648, -2147483648, -2013600868, -415366855, 1778447090, 's27xh8', 1875923360, 433.204481, 2132634715, 'r_s_1d07bb', 309851181, -156220540, -2074118737, 'ls1ehn1md', 'aqqhyyzsnp64', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 2, -2147483648, -2147483648, 462974032, -1137908826, -918961358, 'e5u', 1861536320, 345.718563, 44952191, 'r_s_cbaaa1', 1151980946, 1620389964, 546571701, '0t5c4ecigc', 'e376nium52', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 2, -2147483648, -2147483648, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 705.580387, 743312762, 'r_s_befb99', -1822992503, -868774469, -1068298341, '1ryytoo', 'o9hl72kl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 5, -2147483648, -2147483648, -977635379, 1661181156, -1372125820, '4', 1649269347, 598.741024, -1116181514, NULL, 1255852738, -1555456236, -975213201, '9v', 'x58pz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 6, -2147483648, -2147483648, -1929953647, 1581736075, -261132974, 'dqwn', -1070063173, 629.317167, 722884590, NULL, 580968159, -1245312912, 1575412235, 'jtu0d', '79fjgq8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 7, -2147483648, -2147483648, 37673509, 834709651, -348113485, 'jswwlq7xb', 602161869, 814.417862, 2094425101, NULL, -961217731, -1888505890, 777149609, '16nijjai5dh', 'ogrgjd8y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 8, -2147483648, -2147483648, -491938169, -106471771, 1235416111, 'jh3den8', 195720193, 897.348977, 1774087382, NULL, 1732258051, -1762140823, 1371234901, '1of77p', 'o72ctdc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 9, -2147483648, -2147483648, 2119806856, -1962347906, -866772222, 'ttg6', 1467355421, 217.602841, -1171104889, NULL, -29242208, 1691780814, 1944978593, 'bfkfoacd', '7z2zezj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (11, 10, -2147483648, -2147483648, 1816660482, -1212676731, 1692046802, '5k58', -1125548818, 848.622384, -95808609, NULL, -244633520, 418247369, -1524425594, 'a3o', 'v8u', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (12, 11, -2147483648, -2147483648, 318331233, -233617564, 79330142, '58b4pm', 1849819405, 693.650436, -929383517, NULL, -2090240067, -699574669, 274891948, 'pdjwzw5chn9', 'o705', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (13, 12, -2147483648, -2147483648, -397848196, -366775518, 575038073, 'dwcl', 895277769, 988.402461, 364043263, NULL, -1177989415, -1352968577, -519515742, 'gc1dj9erhi', 'zgk1yoeyo6l0', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT raceId FROM results GROUP BY raceId ORDER BY COUNT(NOT time IS NULL) DESC, raceId NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT r.raceId FROM results AS r JOIN races AS cr ON r.raceId = cr.raceId WHERE NOT r.time IS NULL GROUP BY r.raceId ORDER BY COUNT(r.raceId) DESC, r.raceId NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/