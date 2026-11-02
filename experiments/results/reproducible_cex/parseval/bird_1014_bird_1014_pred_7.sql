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

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, 1649269347, -1116181514, 1255852738, '2rk', -705985602, 604.643336, 537874887, 'z0f8jegd21vy', -792092619, -1492524358, -1612443122, 't1__781032', 'd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, -2147483648, -1642259219, 1298861365, 1968874827, 'nqcx5h', -1245312912, 866.804244, -988981234, 'u0dz7', 401805964, -1485777725, -1255130038, 't1__2e2ade', '3d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, -458359144, 600440952, 1568069663, 'fgogritsj3ay', -598313376, 959.196496, 1792827279, '4301jh3den8', 195720193, 1774087382, 1732258051, 'res_cbb272', 'afu5w1of7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, -1957268147, -1928431425, 1303877941, 'mfg62g0v5q8q', -1488156735, 67.250709, -1180042408, '78507cvt', -1523347137, 1582582341, 453836040, 'res_cbb272', '6b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 1, -2147483648, -2147483648, -29242208, 1691780814, 1944978593, 'bfkfoacd', 2115816682, 668.776683, 76987628, 'zezjo7wg', 1248858185, -57705450, -915385605, 't1__781032', 'm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, -2147483648, 853709925, -870767087, -1699185893, '5i3lq5lnpim5', -1125548818, 848.622384, -95808609, 'h2mna', -1524425594, -1351793914, 1919033056, 't1__5ca042', 'v8u', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, -2147483648, -2147483648, 1553368934, -1252009958, 1908593332, 'vy', -451030047, 636.053055, -2052653308, 'yvkv42q7s', 1735561423, 756202403, 782684333, 't1__2e2ade', 'pmaus3au', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, -1140595602, -609553675, 989018473, 'chn9mo70', 628082526, 648.64235, -1245584612, 'xfo', -1793230843, -441521858, 2015094998, 't1__4a1a2f', '2zobb0q0k32o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, -2147483648, -2147483648, -647898186, -1610380698, -457369423, 'xih6', -251205568, 446.264042, 287256667, 'otow9oa', 456034296, -628433041, 1044710644, 'res_cbb272', 'qb0tbindz39t', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, -2147483648, -2147483648, 261633665, 748154000, 1148916014, 'g', -794767771, 30.758515, 989306270, 'tdu6bd0w96', -379749892, -541917667, -961629819, 't1__781032', '9y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, -2147483648, -2147483648, 312804300, -246257698, -516345261, 'o', -732999244, 885.125365, 30861410, 'a35rmki', -1160642134, 769234989, 168442149, 't1__2e2ade', 'tp6ewtqxxn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, -2147483648, -2147483648, 687330820, -224390110, -1810873111, 'h33p6sto1', -1971560508, 835.790392, 1728926031, 'knzys7dy', -531932574, 357443379, -1502591405, 'res_cbb272', 'h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, -2147483648, -2147483648, -531872415, -2125172723, 339193890, 'ygmayq3q', 1032339628, 248.642518, 608093726, 'p', -845136979, -1042976410, -1670945624, 't1__781032', 'wlic7dn2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, -2147483648, -2147483648, 379651188, -592014051, 1744849810, 'sqtgelcuqb', 1374676344, 555.47049, -788896327, 'q1q', -796609690, -1459013972, -1670335771, 't1__2e2ade', '8hlst1p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, -2147483647, -2147483648, -2147483648, 1183069552, -1057355067, -1004098188, '6bjeuuwsj8k', -1486030107, 537.801391, 1138926079, 'pxlvri', 986268139, 2042428747, 1228655416, 'res_cbb272', 'kaqtncg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, -2147483648, -2147483648, 1501227157, -1462262193, -2070247503, 't6', 313797011, 953.185987, -1215810104, 'r', -343920305, 460471995, -1515201134, 't1__781032', 'n', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 3, -2147483648, -2147483648, -967107842, -1011152325, 1298113538, 'g97a', -1019350771, 447.480136, -261782899, 'pj6ddlysu6ip', -1664440372, 1849928338, 1113005977, 't1__2e2ade', '31vwq51oa2sb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, -2147483647, -2147483648, -2147483648, -1971610898, 2095277250, 1971816668, 'rouir', -1143329124, 818.621532, 3208964, 'xyfvmjwpp26', 1913338832, -2061050846, 1893953818, 'res_cbb272', '0ju', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, -2147483648, -2147483648, 1089332183, -167036460, -987989989, 'x', -485095266, 606.332644, -1617977597, 'l2i9esap8pg', 1752727653, 1394285393, -1052659852, 't1__781032', 'sr54o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, -2147483648, -2147483648, 889799750, -860028884, 328574939, '2', -460035045, 961.420907, 1794943626, 'rjkwns47j2ja', 173803229, -1971104604, -526608193, 't1__2e2ade', 'vjwq49yrnx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 2, -2147483648, -2147483648, -1195137401, 134065688, 1770139230, 'gvplj9fjvu', 1200703349, 525.356167, -307050678, 'z2my1ogyv1r', -1712532464, -445145297, 423028705, 'res_cbb272', '1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 1, -2147483648, -2147483648, -1131290294, 892508923, 653399300, '8oitxeilp', -1839279753, 659.940979, -1958403507, 'od033dlhd', -929713613, -1239290359, -1832294694, 't1__781032', '9lqv26u3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 1, -2147483648, -2147483648, -1125491025, 764047845, -660620878, 'bgwkxgi', 404445908, 184.825054, -1919229426, '61l2', 1069076646, 1574139922, -2106733603, 't1__2e2ade', '62ocagj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 2, -2147483648, -2147483648, -1381068866, 207561330, -781096377, 'e8cd', -92242817, 66.604507, 426006253, 'll', -2065694089, 1868665501, -1896445805, 'res_cbb272', '5v0edu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, -2147483648, -2147483648, -432771718, 516500236, 171585273, '5xoepacxdb2f', -344881050, 444.074683, -537413388, 'et8xjhc', -1805244571, 66352888, 312333412, 't1__781032', 'erxa61sjv8nv', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 3, -2147483648, -2147483648, -958249959, -1446721688, -1963148607, 'hi', 1509710997, 38.620596, 652687353, '7', 848275284, 736542812, -1977676789, 't1__2e2ade', 'ffwor1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, -2147483647, -2147483648, -2147483648, -213453775, -1721445347, -314024594, 'ij7f8k', 1387373331, 928.280038, 1599677804, 'u5g', -1728059226, 1652765764, 854201197, 'res_cbb272', 'lsa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 1, -2147483648, -2147483648, -99415515, -635922435, -150306637, '7j4', -189319798, 754.156177, -51114840, 'v', -197208169, 2089151689, -561387633, 't1__781032', 'jac', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 1, -2147483648, -2147483648, 1671168213, 1139923255, -2031993254, 'f41', -813616969, 266.308211, -1147551293, 'ee6slt', -759584258, 1143458360, -769244829, 't1__2e2ade', 'cel8mhfcim', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, -2147483648, -2147483648, 1985372765, 1443327784, -2013600868, '5oqxs27', -494119248, 159.703774, -30240851, 'b59ls', 369829594, 1115155768, 428576631, 'res_cbb272', '1mda', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, -2147483648, -2147483648, -514593578, -1224799639, 28414592, 'mn', -1250452845, 992.470053, -1301565530, 'rwbjk', -356851435, -1093026980, -1940885010, 't1__781032', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, -2147483648, -2147483648, -1398612932, 1297861259, 916632486, 'j5yrji5', 2039586655, 791.808115, 1070662443, 'a38gfxswb2d', 1823879859, -1318060436, -613511812, 't1__2e2ade', '7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, -2147483647, -2147483648, -2147483648, -317233455, 1548141293, 404180628, 'gwnkd4kc3', 872275367, 130.699375, 1199100757, 'zr90nh', -888694642, 1611539964, 700001068, 'res_cbb272', 'b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 1, -2147483648, -2147483648, -15423424, 1774110337, -1099209475, 'bnaayvh', -693920036, 367.321577, 195093192, 'r', -366834342, -912658170, 1378228777, 't1__781032', '0b5m', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 3, -2147483648, -2147483648, -1965995887, -1756413046, 1142505194, 'gz84lqm', -1833815393, 716.847132, -2071541072, '3', -367478888, 499998313, 1915216858, 't1__2e2ade', '070zi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 3, -2147483648, -2147483648, -159167628, -43429869, -1887578409, 'ewew092p40', 2074088791, 865.945447, -1357636512, 'xsad6q5', -463551703, -1030741026, -791611500, 'res_cbb272', '23lwh99', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, -2147483648, -2147483648, 1782348250, -270163507, 1981331984, '8xjqb', -1172741948, 58.425628, 1887949884, 'j5il9', 1338378083, 945802166, 47431001, 't1__781032', 'ygwakm', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, -2147483648, -2147483648, 104130853, -1764222999, -144370926, 'dip', 1484560348, 88.511241, 373735911, 'qx6j6d4', 1950702818, 877176214, 109383153, 't1__2e2ade', '4s2a', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 2, -2147483648, -2147483648, -395383776, -1876636977, -557260064, '5u7709', 564132547, 85.220863, 562558425, 'abivuum', -670250982, -2091687257, 618880480, 'res_cbb272', 'k6hh2o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, -2147483648, -2147483648, 1100953564, 1125313981, 1124849943, '1ll930', 286693031, 167.84281, -728757169, 'ql6n0rlpsax', -1827274099, 1178397242, -2045667486, 't1__781032', 'v5o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, -2147483648, -2147483648, -1842328080, 1844867559, -986328637, 'xdoxa0', -1392585113, 637.183912, 1868325581, 'ssbh7', 1250861085, -373858639, 1550708132, 't1__2e2ade', '303a1ngq', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 3, -2147483648, -2147483648, -1908406235, 2142421496, -1408342453, 'dyxk', -384734946, 893.593329, -1965798280, '1c8', 1951564466, -721450631, -1908930700, 'res_cbb272', 'p0760ugk2h', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 3, -2147483648, -2147483648, -1123211891, -312114635, -1959143827, 'a4gkjog8d', 286007666, 424.042261, 1314064183, 'qhjd5', 1845526962, -2099978946, 1132226816, 't1__781032', 'tzdlb6i4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, -2147483648, -2147483648, -641282671, 258755990, -617631089, 'havc2c4', -429097391, 355.299179, 1690729846, 've', -390816038, -1748913439, -1608712068, 't1__2e2ade', '99kvn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, -2147483647, -2147483648, -2147483648, -842223788, -1017434885, 34052637, 'u4euf', -1588383617, 980.244198, 183049515, '6b', 1388472267, -1708036926, 1103152554, 'res_cbb272', 'f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 3, -2147483648, -2147483648, 24627578, 2033421216, 794301748, '8e5o', -1799118529, 790.313329, -327742602, 'r8kzi0g50j5', 1617485225, -1232470711, 615649657, 't1__781032', 'ex41fa', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, 1, -2147483648, -2147483648, -1815891316, -758991421, -1400298523, 'dbp3cehye3', 1673358342, 381.645465, 638054085, 'if0', 500709040, 1346552102, -1110321935, 't1__2e2ade', 'eoh3m3q0pq97', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 3, -2147483648, -2147483648, 1616702542, -316558073, 1980676290, 'pzc7x', -111324604, 195.954511, -1502776895, 'c2', -656237101, -1721897132, -898823195, 'res_cbb272', '45j', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 1, -2147483648, -2147483648, -2077724886, -1188970734, 776771076, 'hh6va3tdx5hn', 67983002, 910.540206, -171251505, '58zb', -1714719754, 1946934142, -852843717, 't1__781032', 'woua4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 2, -2147483648, -2147483648, -1597057552, 1940380266, 196097271, 'p4j9f', 1409447791, 54.073897, 1090670329, '2iae6', -2093375165, 1733360461, 29713329, 'res_cbb272', 'k8qazkjyfxso', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 1, -2147483648, -2147483648, 1633213040, -56395913, 2039485050, 'p3q', 127564856, 367.275481, -1716375595, '24vu6v8', 1646694792, 1349767879, 1277665386, 't1__781032', 'u8yb4qp', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 1, -2147483648, -2147483648, -922296677, -1919962183, 366905309, 'j8y6whwhlh5', 1041671773, 437.074155, -833086980, 'm8r', 209226821, 492568918, 1019149716, 't1__2e2ade', '7j452k1qzqt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483595, 3, -2147483648, -2147483648, 790826026, -1740675234, -856771235, 'k1', 1444022422, 824.540492, 1593058198, 'jksuye6hvzbo', -1186198336, -1352316180, 22415446, 'res_cbb272', 'sijufc2vfgh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483594, 3, -2147483648, -2147483648, -755229206, -579059817, -872444108, '2isdq', 1344117622, 750.810664, -249764330, 'zbw', 1422871709, -1023537273, -2051635326, 't1__781032', '7qobvbj2', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483593, 1, -2147483648, -2147483648, -1985423561, 1154691182, 814465928, '0h2f', -1401481173, 311.980946, 1888904719, 'o', 2137119179, -854263126, 1706969416, 't1__2e2ade', 'dbvf', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483592, 1, -2147483648, -2147483648, 782312950, -1775845767, -1736300823, 'fjtvxt41zjf', -304309687, 152.521189, -882949069, 'dpb4l6ru', -950795649, 128017130, -1544200311, 'res_cbb272', 'pxb659q4tkf5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483591, 1, -2147483648, -2147483648, 2132312264, 570999682, 1786584480, '5ys1gz7p3', -1624769339, 96.48494, -633154726, 'zip2a', 762889994, 1290341173, 1232852817, 't1__781032', '4zc19', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483590, -2147483647, -2147483648, -2147483648, 673108767, -755719771, 1410336613, '3i98owqw', -1639837436, 718.649015, 1306618480, 'oh59ivn', 1246006738, -1080470671, 52953901, 'res_cbb272', 'okt16', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483589, 1, -2147483648, -2147483648, 1491779551, 1295864154, -907384163, 'o', 2001378511, 711.431069, 1940909855, 'b6piqku', 1850954065, 1934880232, -223111865, 't1__781032', '8npqdbw', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483588, 1, -2147483648, -2147483648, -250218274, 1888170894, 1590087415, 'l0lw90t2kl', -2127892574, 36.451443, 1955390593, 'gno6r9d', -411691902, 1169469726, -772755259, 't1__2e2ade', 'rvcc', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483587, 2, -2147483648, -2147483648, -1927640438, -1188144607, 1539201953, '70691', 1807699260, 992.474701, 179445490, 'hqz3rs94x3yy', -567248843, 533073608, -1782708355, 'res_cbb272', 'w0qgiqh', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483586, 3, -2147483648, -2147483648, 1208695669, 250255154, 1169111674, '7swb334', 255947809, 636.762597, 1922661050, '6rn', -1935971129, -1638030257, -1253560766, 't1__781032', 'p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483585, 1, -2147483648, -2147483648, -216136015, -695925555, -1248522499, '84jm31', 1140114575, 896.399789, 605923875, 'niom2u85', -2038491821, 1824528433, -1469337223, 't1__2e2ade', 'nnb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483584, 3, -2147483648, -2147483648, 910724149, -1204936978, 86045378, 'j', 98755104, 956.935293, 1422066671, 'uj9', 262270895, -16092271, 509465713, 'res_cbb272', 'nr8dq5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483583, 1, -2147483648, -2147483648, 2115388252, 1917779970, 1087107269, 'vjvcr9', -392675823, 598.035627, -22172292, '5y8am0qjut2f', -173789692, -317767232, -742079274, 't1__781032', '4s7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483582, 1, -2147483648, -2147483648, 735250406, -461669512, -261162125, 'enn4il', -1964917384, 760.104819, 1441332845, 'w6gv', 1246780528, 538410706, -1406204087, 'res_cbb272', 'mrsv641', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483581, 1, -2147483648, -2147483648, 908208204, 1458099729, 191566928, 'qo', -1748332866, 278.817471, -1060102360, '7z6ikr1whx', -1887887695, -418713192, -2050843803, 't1__781032', '7zzuuwye', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483580, 1, -2147483648, -2147483648, -1614519539, 2028167237, 1313061607, 'v3', -1068238654, 444.590592, -1831394002, 'n', 2134974396, -674436733, 1405721813, 't1__2e2ade', 'axg0g', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483579, 2, -2147483648, -2147483648, 338007473, 931140648, 1127465136, 'yubeyh', 551417265, 177.361806, -953454343, 'ycz8d5ykab', 737863624, 1605015255, 187502135, 'res_cbb272', 'y0kcxl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483578, 3, -2147483648, -2147483648, 493838302, 971585276, 2105067810, 'xnm0cmn', -788022648, 623.650986, -2002127241, 'k27ki4', -697033685, 1320325887, -1218490444, 't1__781032', 'i8', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483577, 1, -2147483648, -2147483648, 208702091, -896388852, 137456355, 'wy4o1', 671921821, 575.545963, -1480774559, 'xi', 338431515, 1672949483, 346776902, 't1__2e2ade', '9vphx5vl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483576, 3, -2147483648, -2147483648, -1445498465, -1625027824, -1044387325, '4gp0kr5', -2018324945, 421.256036, -1427407236, 'qavutce54k', -1890973087, -1801965762, 317664148, NULL, '4lj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483575, 1, -2147483648, -2147483648, -1922481721, -1632873478, -2058818452, 'aaxtpye', 1097132010, 996.879871, -245355754, 'gy7qnkj2dsjl', 648284786, 996091596, 2040233149, NULL, '7dxug9rta6w', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483574, 1, -2147483648, -2147483648, -463649338, -1737335305, -1644157237, 'cu84vxo5sddf', -998328215, 720.433559, -1262942078, 'lwczduqt0i', 132846311, -1873030622, 429757238, NULL, 'lwblht', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH fastest_lap_times AS (SELECT T1.raceId, T1.FastestLapTime, (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) AS time_in_seconds FROM results AS T1 WHERE NOT T1.FastestLapTime IS NULL) SELECT T1.FastestLapTime AS lap_record FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId INNER JOIN (SELECT MIN(fastest_lap_times.time_in_seconds) AS min_time_in_seconds FROM fastest_lap_times INNER JOIN races AS T2 ON fastest_lap_times.raceId = T2.raceId INNER JOIN circuits AS T3 ON T2.circuitId = T3.circuitId WHERE T3.country = 'Italy') AS T4 ON (CAST(SUBSTRING(T1.FastestLapTime, 1, INSTR(T1.FastestLapTime, ':') - 1) AS REAL) * 60) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, ':') + 1, INSTR(T1.FastestLapTime, '.') - INSTR(T1.FastestLapTime, ':') - 1) AS REAL)) + (CAST(SUBSTRING(T1.FastestLapTime, INSTR(T1.FastestLapTime, '.') + 1) AS REAL) / 1000) = T4.min_time_in_seconds LIMIT 1;

/*
Gold Result:
('res_cbb272',)
*/

-- Prediction Query
SELECT circuits.circuitId, MIN(lapTimes.time) AS fastest_lap_time FROM lapTimes INNER JOIN races ON lapTimes.raceId = races.raceId INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Italy' GROUP BY circuits.circuitId;

/*
Prediction Result:
*/