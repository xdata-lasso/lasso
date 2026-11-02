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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, 1, 'a2ypuzhsrwbb', '2022-08-24', 'luhvdltti', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, -2147483648, -961217731, 1, 'dr', '2024-06-23', '16nijjai5dh', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, 1980131681, 1, 'iztv', '2020-03-12', 'm4iz78aqq', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -1096060187, 3, 'mwfw', '2024-03-09', 'rlawk', 'url_4');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'nprmdposii', -1823627488, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', '2024-06-13', 'u', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '4nrq', 'name_1', 'rofqyp5s5b', 'p');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483647, 'qv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', 598.428216, 949.322482, 602161869, 'url_2');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (3, 'w', 'l', '5amsorlwyngc', 'Italy', 424.71131, 605.551549, 211603887, 'url_3');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (2, 'izgk1yoeyo6', 'l0hdt6fuqyx', 'uzkb521gwnl', 's', 509.069144, 609.392845, 1468640756, 'url_4');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '02eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, -2147483648, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1775126557, 482.572691, 105869088, 'au2dwy', -953437896, -1097120355, 244829661, 'res_cbb272', 'jsl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, 1649269347, -1116181514, 1255852738, '2rk', -705985602, 604.643336, 537874887, 'z0f8jegd21vy', -792092619, -1492524358, -1612443122, 't1__88ec0a', 'd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, -2147483648, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 866.804244, -988981234, 'u0dz7', 401805964, -1485777725, -1255130038, 't1__095ffd', '3d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, -458359144, 600440952, 1568069663, 'fgogritsj3ay', -598313376, 959.196496, 1792827279, '4301jh3den8', 195720193, 1774087382, 1732258051, 'res_cbb272', 'afu5w1of7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, -1957268147, -1928431425, 1303877941, 'mfg62g0v5q8q', -1488156735, 67.250709, -1180042408, '78507cvt', -1523347137, 1582582341, 453836040, 'res_cbb272', '6b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, -2147483648, -2147483648, -29242208, 1691780814, 1944978593, 'bfkfoacd', 2115816682, 668.776683, 76987628, 'zezjo7wg', 1248858185, -57705450, -915385605, 't1__88ec0a', 'm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, -2147483648, 853709925, -870767087, -1699185893, '5i3lq5lnpim5', -1125548818, 848.622384, -95808609, 'h2mna', -1524425594, -1351793914, 1919033056, 't1__f60719', 'v8u', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, -2147483648, -2147483648, 1553368934, -1252009958, 1908593332, 'vy', -451030047, 636.053055, -2052653308, 'yvkv42q7s', 1735561423, 756202403, 782684333, 't1__095ffd', 'pmaus3au', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, -1140595602, -609553675, 989018473, 'chn9mo70', 628082526, 648.64235, -1245584612, 'xfo', -1793230843, -441521858, 2015094998, 't1__05357b', '2zobb0q0k32o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, -2147483648, -2147483648, -647898186, -1610380698, -457369423, 'xih6', -251205568, 446.264042, 287256667, 'otow9oa', 456034296, -628433041, 1044710644, 'res_cbb272', 'qb0tbindz39t', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, -2147483648, -2147483648, 261633665, 748154000, 1148916014, 'g', -794767771, 30.758515, 989306270, 'tdu6bd0w96', -379749892, -541917667, -961629819, 't1__88ec0a', '9y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, -2147483648, -2147483648, 312804300, -246257698, -516345261, 'o', -732999244, 885.125365, 30861410, 'a35rmki', -1160642134, 769234989, 168442149, 't1__095ffd', 'tp6ewtqxxn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, -2147483648, -2147483648, 687330820, -224390110, -1810873111, 'h33p6sto1', -1971560508, 835.790392, 1728926031, 'knzys7dy', -531932574, 357443379, -1502591405, 'res_cbb272', 'h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, -2147483648, -2147483648, -531872415, -2125172723, 339193890, 'ygmayq3q', 1032339628, 248.642518, 608093726, 'p', -845136979, -1042976410, -1670945624, 't1__88ec0a', 'wlic7dn2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, -2147483648, -2147483648, 379651188, -592014051, 1744849810, 'sqtgelcuqb', 1374676344, 555.47049, -788896327, 'q1q', -796609690, -1459013972, -1670335771, 't1__095ffd', '8hlst1p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, -2147483647, -2147483648, -2147483648, 1183069552, -1057355067, -1004098188, '6bjeuuwsj8k', -1486030107, 537.801391, 1138926079, 'pxlvri', 986268139, 2042428747, 1228655416, 'res_cbb272', 'kaqtncg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, -2147483648, -2147483648, 1501227157, -1462262193, -2070247503, 't6', 313797011, 953.185987, -1215810104, 'r', -343920305, 460471995, -1515201134, 't1__88ec0a', 'n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 3, -2147483648, -2147483648, -967107842, -1011152325, 1298113538, 'g97a', -1019350771, 447.480136, -261782899, 'pj6ddlysu6ip', -1664440372, 1849928338, 1113005977, 't1__095ffd', '31vwq51oa2sb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, -2147483647, -2147483648, -2147483648, -1971610898, 2095277250, 1971816668, 'rouir', -1143329124, 818.621532, 3208964, 'xyfvmjwpp26', 1913338832, -2061050846, 1893953818, 'res_cbb272', '0ju', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, -2147483648, -2147483648, 1089332183, -167036460, -987989989, 'x', -485095266, 606.332644, -1617977597, 'l2i9esap8pg', 1752727653, 1394285393, -1052659852, 't1__88ec0a', 'sr54o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, -2147483648, -2147483648, 889799750, -860028884, 328574939, '2', -460035045, 961.420907, 1794943626, 'rjkwns47j2ja', 173803229, -1971104604, -526608193, 't1__095ffd', 'vjwq49yrnx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 2, -2147483648, -2147483648, -1195137401, 134065688, 1770139230, 'gvplj9fjvu', 1200703349, 525.356167, -307050678, 'z2my1ogyv1r', -1712532464, -445145297, 423028705, 'res_cbb272', '1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, -2147483648, -2147483648, -1131290294, 892508923, 653399300, '8oitxeilp', -1839279753, 659.940979, -1958403507, 'od033dlhd', -929713613, -1239290359, -1832294694, 't1__88ec0a', '9lqv26u3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, -2147483648, -2147483648, -1125491025, 764047845, -660620878, 'bgwkxgi', 404445908, 184.825054, -1919229426, '61l2', 1069076646, 1574139922, -2106733603, 't1__095ffd', '62ocagj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 2, -2147483648, -2147483648, -1381068866, 207561330, -781096377, 'e8cd', -92242817, 66.604507, 426006253, 'll', -2065694089, 1868665501, -1896445805, 'res_cbb272', '5v0edu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, -2147483648, -2147483648, -432771718, 516500236, 171585273, '5xoepacxdb2f', -344881050, 444.074683, -537413388, 'et8xjhc', -1805244571, 66352888, 312333412, 't1__88ec0a', 'erxa61sjv8nv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 3, -2147483648, -2147483648, -958249959, -1446721688, -1963148607, 'hi', 1509710997, 38.620596, 652687353, '7', 848275284, 736542812, -1977676789, 't1__095ffd', 'ffwor1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, -2147483647, -2147483648, -2147483648, -213453775, -1721445347, -314024594, 'ij7f8k', 1387373331, 928.280038, 1599677804, 'u5g', -1728059226, 1652765764, 854201197, 'res_cbb272', 'lsa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, -2147483648, -2147483648, -99415515, -635922435, -150306637, '7j4', -189319798, 754.156177, -51114840, 'v', -197208169, 2089151689, -561387633, 't1__88ec0a', 'jac', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, -2147483648, -2147483648, 1671168213, 1139923255, -2031993254, 'f41', -813616969, 266.308211, -1147551293, 'ee6slt', -759584258, 1143458360, -769244829, 't1__095ffd', 'cel8mhfcim', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, -2147483648, -2147483648, 1985372765, 1443327784, -2013600868, '5oqxs27', -494119248, 159.703774, -30240851, 'b59ls', 369829594, 1115155768, 428576631, 'res_cbb272', '1mda', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, -2147483648, -2147483648, -514593578, -1224799639, 28414592, 'mn', -1250452845, 992.470053, -1301565530, 'rwbjk', -356851435, -1093026980, -1940885010, 't1__88ec0a', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, -2147483648, -2147483648, -1398612932, 1297861259, 916632486, 'j5yrji5', 2039586655, 791.808115, 1070662443, 'a38gfxswb2d', 1823879859, -1318060436, -613511812, 't1__095ffd', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 3, -2147483648, -2147483648, 749598659, 902707245, -1449454815, '4kc3iikaxz', 1008864713, 897.975119, -1660176735, '9gob', -976193147, -15423424, 1774110337, 'res_cbb272', 'hybn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, -2147483648, -2147483648, 2017526622, -693920036, 195093192, 'r', -366834342, 287.505213, 1378228777, '0b5m', -1001218462, -1965995887, -1756413046, 't1__88ec0a', '3rzgz84', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 1, -2147483648, -2147483648, -1833815393, 931351333, -2071541072, '3', -367478888, 199.321149, 499998313, 't07', 354693690, 399119867, 207340898, 't1__095ffd', '50q8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 3, -2147483648, -2147483648, 1939546744, 1290157948, 2014227445, 'p40u2vil21x', -937869073, 54.041756, -49162316, 'qoa', 380206420, -528798198, -215230989, 'res_cbb272', 'wh9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, -2147483648, -2147483648, 1782348250, -270163507, 1981331984, '8xjqb', -1172741948, 58.425628, 1887949884, 'j5il9', 1338378083, 945802166, 47431001, 't1__88ec0a', 'ygwakm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, -2147483648, -2147483648, 104130853, -1764222999, -144370926, 'dip', 1484560348, 88.511241, 373735911, 'qx6j6d4', 1950702818, 877176214, 109383153, 't1__095ffd', '4s2a', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 2, -2147483648, -2147483648, -395383776, -1876636977, -557260064, '5u7709', 564132547, 85.220863, 562558425, 'abivuum', -670250982, -2091687257, 618880480, 'res_cbb272', 'k6hh2o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, -2147483648, -2147483648, 1100953564, 1125313981, 1124849943, '1ll930', 286693031, 167.84281, -728757169, 'ql6n0rlpsax', -1827274099, 1178397242, -2045667486, 't1__88ec0a', 'v5o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 2, -2147483648, -2147483648, 830725610, -1392585113, 1868325581, 'ssbh7', 1250861085, 412.954252, 1550708132, '303a1ngq', -745290521, 898805626, -77974859, 'res_cbb272', 'ojdlhl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 1, -2147483648, -2147483648, 842122481, 1791555361, 463171538, '0', -1965798280, 797.198416, 1951564466, 'adbp07', 1386881333, -1474004959, -1507399154, 't1__88ec0a', 'pg1lcg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 3, -2147483648, -2147483648, 188256891, 286007666, 1314064183, 'qhjd5', 1845526962, 11.060544, 1132226816, 'tzdlb6i4', 1957002795, 1239479860, 1549626896, 't1__095ffd', 'c29dwt1h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 3, -2147483648, -2147483648, -1126619065, 1821429906, 1770083132, 'jf4i5t9', 1124850667, 881.539265, -1211007003, 'hvi6tp3tfnd', 2071439307, 2077933154, 232457376, 'res_cbb272', '6sru4eu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 1, -2147483648, -2147483648, 2062633134, 183049515, 1796323549, 'qgjradfhj', -417454764, 788.478438, 1579423631, 'e5olf0yf1', 1790647855, 718729522, -405021191, 't1__88ec0a', '0g50j597fz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 1, -2147483648, -2147483648, -779262852, -592652905, -271011446, 'x', -2006745200, 147.976687, -1815891316, '8u5lvdbp', 709713623, -1664812348, -1156619022, 't1__095ffd', 'cii', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, -2147483647, -2147483648, -2147483648, -1110321935, 972288112, 1349808277, 'q0pq97j5', 410371541, 151.254546, 1616702542, '11y', 1685354754, -455334817, -587900447, 'res_cbb272', '4pmpjj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 1, -2147483648, -2147483648, -266037807, 895167757, 831075499, '6j72vkwegrf', 1686819558, 207.451144, 1220359260, '5pbgwo', -1611243101, 16782608, -164454935, 't1__88ec0a', 'dx5hn75b73', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 3, -2147483648, -2147483648, -2096555342, 453154609, 823950453, 'c4f1q9w4', -168704210, 14.81995, 535909504, '82sp4j9fodt9', 1090670329, 1783185410, -211490974, 'res_cbb272', 'ae6aj6ql167', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 1, -2147483648, -2147483648, 304203858, -1430783766, -895238090, 'e98b85', 946867225, 703.641664, -152632026, '8ikp3q', 127564856, -1716375595, -313408686, 't1__88ec0a', 'vu6v8hkl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 3, -2147483648, -2147483648, -459025447, 170924712, 1694002877, '4qpog5smdhct', 931265534, 541.376556, 1530956156, 'hlh5i1', -1931468427, 1718452961, 2109623518, 't1__095ffd', 'lhw6lv7j4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 3, -2147483648, -2147483648, -817991918, -752197316, -120730142, '20gw', -856771235, 121.633605, 1991996064, 'uye6h', 1761543456, 2031309238, -2047658636, 'res_cbb272', 'dlz6', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483595, 1, -2147483648, -2147483648, -1506337328, 858439412, 813052479, 'vfghixbu', -1744541202, 139.432082, -1057155638, 'sdq', 1344117622, 1077223608, -249764330, 't1__88ec0a', 'zbw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483594, 1, -2147483648, -2147483648, 1092707574, -965918853, -1007920797, 'bvbj26kpxc56', -693134353, 902.638617, 1094417174, 'tlco', 2137119179, -854263126, 1706969416, 't1__095ffd', 'dbvf', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483593, 1, -2147483648, -2147483648, 782312950, -1775845767, -1736300823, 'fjtvxt41zjf', -304309687, 152.521189, -882949069, 'dpb4l6ru', -950795649, 128017130, -1544200311, NULL, 'pxb659q4tkf5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483592, 1, -2147483648, -2147483648, 2132312264, 570999682, 1786584480, '5ys1gz7p3', -1624769339, 96.48494, -633154726, 'zip2a', 762889994, 1290341173, 1232852817, NULL, '4zc19', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483591, 1, -2147483648, -2147483648, 1354931772, 1345356721, -1430943766, 'foqp', -755719771, 206.393553, 1410336613, '3i98owqw', -1639837436, 1306618480, -1188391030, NULL, '9ivnipn6', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
('res_cbb272',)
*/

-- Prediction Query
SELECT T1.time FROM lapTimes AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy' ORDER BY T1.milliseconds ASC, T1.raceid NULLS LAST, T1.driverid NULLS LAST, T1.lap NULLS LAST, T2.raceid NULLS LAST, T3.circuitid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/