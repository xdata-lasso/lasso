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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, -2147483648, -992890117, -2147483648, 'Canadian Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, -2147483648, 1443629118, -2147483648, 'Canadian Grand Prix', '2025-03-14', 'bilyrkn', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, -2147483648, 1784916884, -2147483648, 'ah0f8jsww', '2021-12-25', '7xb72', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, -2147483648, -598313376, -2147483648, 'q4301jh', '2025-03-06', 'e', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, -2147483648, 2004147439, -2147483648, 'tjpttg', '2025-09-24', 'n', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, -2147483648, -59984348, -2147483648, 't2__341a24', '2023-11-15', 'qcgsk9', 'url_6');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'p6luhvdlttil', 429706943, 'rmdp', 'siie', 'unw6klfa', '2024-07-24', '00t5c4ecigc', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'g', -20116244, 'lq5lnpim', 'k58qs27p', 'r94gth2m', '2022-05-15', 'ajjla3okv8u', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'cxl8e4bkfp', 684639412, 'yyxnm0cmn8u', 'y4c1v', '27k', '2021-06-24', 'uvof5ndg', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'hxd', -1081595696, 'eb', 'yaax', 'pyee2', '2024-06-17', '2ugy7', 'url_4');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'e376nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (3, 'b');

INSERT INTO "status" ("statusid", "status") VALUES (2, 'tmu2ne578l');

INSERT INTO "status" ("statusid", "status") VALUES (4, 'a9n0jxfofws');

INSERT INTO "status" ("statusid", "status") VALUES (5, 'eyo6');

INSERT INTO "status" ("statusid", "status") VALUES (1, '7s1i0k8thq');

INSERT INTO "status" ("statusid", "status") VALUES (6, '8c4p');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274.580687, 274769912, 'oo3o9', -1666765085, 1178636309, -1390245819, 'x14ji7zwau2d', 'yrq13p', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, 1, -2147483648, 244829661, -1362461264, -904834265, 'b4yp5qi', -227162283, 164.583726, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 1675430660, 'y9uxj4', 'wb', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 1, -2147483648, -736979194, 2103044118, -1642259219, 'nd', -1052964641, 209.967034, -1660358170, 'p', -988981234, -841004020, -361507387, '79fjgq8', 'n2f3dqv0gcb9', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, 1, -2147483648, 2094425101, -961217731, -1888505890, 'z16nijjai5d', -1625552518, 849.655083, -1738458256, 'jd', 1074760385, 1129658414, 1250290042, 'og', 'itsj3', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 3, 1, -2147483648, 357330522, -683007527, 2035306060, 'x7afu5w1of77', -1099855564, 224.624401, 87529806, 'ctdctmfg62g0', 1870300798, 820970595, 1421303999, 'j', 'e1io', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 4, 1, -2147483648, 944975670, -1575410149, -68044929, 'kf', 1923659053, 12.330671, -1950324754, '7z2zezj', 1448731351, -604098478, 1248858185, '5', 'sxcmr0o', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, 0, -2147483648, 697257217, -451030047, -2052653308, 'yvkv42q7s', 1735561423, 927.310086, 756202403, '8b4pmaus3au', -699574669, 274891948, 609771851, 'j', 'wzw5chn9mo70', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, 0, -2147483648, 1719800120, -210159774, 270415200, 'b', -397848196, 983.253685, -366775518, '2odwcl5a', 292557306, 709097796, -984562992, 'yngc1d', 'j9erhizgk1', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 0, -2147483648, -360096930, -1942581013, -795975227, 'xuzkb52', -277407746, 343.967529, -2140468103, 'elboeowii', -268740517, -564679000, -251205568, 'xlyotow9', 'aawg', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 2, 0, -2147483648, -381485009, 868039568, 503053726, 'z', 2085299664, 974.58376, 1376887048, 'td8n5wcgu', -1275298282, 1933158443, 1295379066, 'd0w9603vzxw1', 'xe9yf', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 3, 0, -2147483648, 125495479, 312804300, -246257698, '55', 2105860871, 467.033126, 440797047, 'vu', 1654100852, 30861410, -438741674, '5rmkio18', 'i2hy0', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 4, 0, -2147483648, 1299171592, 2066302536, 24053253, 'tqxxnj', 917362079, 376.823393, -1312038093, 'n2mfx7h33p', 63063873, -843082635, -285085577, '8sh', 'knzys7dy', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, 0, -2147483648, -1520090613, 591870819, 729543907, 'c', 973811121, 565.260711, 620355627, '8y3a17v4yg', -2081662466, -1941472821, -2082238979, '6rntdqrhm', 'wlic7dn2', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, 0, -2147483648, -1104749933, 379651188, -592014051, 'sqtg', -1872934808, 40.211911, 422046500, '9', -1750715330, 277649518, 908468929, 'kjq1qu', 'k1y', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, 0, -2147483648, -2052350430, 166124233, 1862197286, 't1pqo', 1222311103, 139.623194, 2141720493, 'vb6m4iz78aq', -1043357093, -753065777, 190510318, 'tb8r9114qbre', '6bjeuuwsj8k', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 2, 0, -2147483648, -609840352, 486475144, -679850352, 'sur', -459075802, 157.137252, 1384307628, 'ncgc8', 1446366856, 438933248, 180947503, 'dmdbdh', '6j47n', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 3, 0, -2147483648, -982188592, 1981548099, -913430713, 'an', 1195320303, 840.734969, -1096060187, 'mwfw', -544173163, -958321297, 2015039199, 'k014r5', 'dqtsmg97aqz2', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 4, 0, -2147483648, -261782899, -1079009577, -1385967617, 'u6iph', -1944869637, 653.320799, 334376591, 'ir', -176968915, -717865822, 2061102304, 'a2sb', 'uoi1pavc', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 1, 0, -2147483648, 1971816668, -1067465394, 1491006943, 'lrpou', 1368469085, 305.710224, 3208964, 'xyfvmjwpp26', 1913338832, -2061050846, 1893953818, '0ju', '0h3r133ir1ax', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, 0, -2147483648, 1498496406, 370054768, -1837449583, 'p', -1452518801, 345.665971, 1339281953, '4o6qjektb1', 1464469520, -209435372, 946571403, '3r', 'jkwns47j2j', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, 0, -2147483648, 173803229, -1971104604, -526608193, 'vjwq49yrnx', 1511946366, 329.006579, -1910754958, 'o', -232312083, 1805923837, -699779308, 'j9f', 'vuu', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 2, 0, -2147483648, -251621840, -1720233199, -672126855, 'gezax', -316078323, 173.77973, -754769711, 'ly', 139907579, 914471233, -1813651479, 'pe0', '19cy7od033d', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 3, 0, -2147483648, 935816178, -1919535047, -690382359, 'ed', 1188203659, 642.766569, -1066046077, '26u331spxpw3', -349181074, -1725714389, -1248881581, '6id', 'p61l', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 4, 0, -2147483648, 1069076646, 1574139922, -2106733603, '62ocagj', 1361395061, 63.114566, 1707457950, 'zxlu49', -1459357985, -2051917235, 833662145, 'e', 'uekhllbw', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, 0, -2147483648, 1104707112, 1551904707, -400879450, 'u', -699425950, 399.23748, 516500236, '835xoepac', 1372042958, 1147974039, -220327705, 'c296xiy', 'et8xjhcf46c', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, 0, -2147483648, 1280646590, -568125159, -329270684, 'v8n', -137586537, 59.584068, -1198828889, 'ezcteh', 660144343, -169414942, 806158445, 'vb7vpc0xff', 'or1esk', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, 0, -2147483648, 1403715810, 1494789426, -1048234032, '1huij7f', -1663813652, 810.481449, 1094664154, '8gxb', 854201197, -1497515537, 1432878454, 'awsp4kwi3h', '7j4', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 2, 0, -2147483648, -480726958, 191797158, -1428261633, 'w4jn2z19', 643485636, 105.740228, 319828561, 'c', -1725535379, 1709325128, -29488259, '41', '80terbfokvee', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 3, 0, -2147483648, -1371170489, -759584258, 1143458360, '2cel8m', 1197643380, 81.334226, -1957884289, 'n5en', -1591272038, 1985372765, 1443327784, 'bgz5', 'qxs2', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 4, 0, -2147483648, 1276865022, 1875923360, -286884572, '253sb59ls1e', 428576631, 208.095494, 1134827548, 'daqqhyyzsn', -105243240, -1324600306, -1250452845, '4m0rrwbjk0', 'p', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, 0, -2147483648, -616998913, 1022316699, -1519375860, 'lwtlzh42nyj5', 411661379, 149.30112, 1357426337, 'qkna', -1725694639, 1037880389, -2059498122, '0', 'mxwdb7o', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, 0, -2147483648, 619382464, 792905581, -1013704446, 'k4c6gwn', 542602362, 55.932348, -1984500518, 'iikaxzr90nhs', -1205570400, -976193147, -15423424, 'phy', 'n', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, 0, -2147483648, 1295963771, -534612951, 754506713, 'x8scr0f', -912658170, 710.920615, 1378228777, '0b5m', -1001218462, -1965995887, -1756413046, '3rzgz84', 'lqme2wb1b3', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 2, 1, -2147483648, 61145737, 1522069539, -1576807806, 'olt070zi90o5', -193700628, 100.260607, 608918735, 'm6dpewe', 2014227445, -1133072015, -243587307, 'l21', 'sad6q5', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483614, 3, 1, -2147483648, -1580770288, -1158897957, 380206420, '023lwh9', -2006209112, 193.215124, -1691663167, 'xjqbloxd4', -928434146, 1083095660, 343349384, 'd6dvygwakmwg', '73fy3d', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483613, 4, 1, -2147483648, -1930352392, 1221655010, -544010785, 'bl10qx6j6d4f', 877176214, 525.46775, 1869989693, 's2ajdu26xu', -395383776, -1876636977, -557260064, '5u7709', 'qf9lx8qzabi', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 1, 0, -2147483648, -1296756845, 1317293788, -1401325547, 'jwk6hh2', -1203705305, 523.45511, 256025362, '0fzrv1ll', 237209369, 1719477248, 286693031, 'viq', '6n0', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, 0, -2147483648, 641545472, 666969074, -1827274099, 'mbci', 1938400567, 222.670586, 2110758629, 'eqv3', -986328637, 1784235325, -562113476, 'oxa0ol1zmjrs', 'bh724', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, 0, -2147483648, -73867879, 1086562671, -1092779922, '03a1ngqu', 359389091, 62.398913, 1961977235, 'l', 2142421496, -1408342453, 1689665778, 'yxk0a0cql1c8', 'w', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, -1089271699, 1386881333, -1474004959, 'jz', -564818339, 104.607205, -1400894698, '9a', 977578358, 278187714, 935509881, 'g8dw16f5tq', 'jd', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, 1845526962, -2099978946, 1132226816, 'tzdlb6i4', 1957002795, 302.680507, 1239479860, 'w5c29dwt1ha', 758391026, 681805258, 1254343862, '4', 'pw8672f', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, 1, -2147483648, -1857994268, -1501533097, -106120329, 't99kvnbh', -681931530, 503.140593, -1082755849, 'fndtw', 232457376, 782631880, -131110552, 'fiof8o', '6b', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 1, 1, -2147483648, -2124619836, -1746125330, 765163181, '6k53p', -1860416222, 221.666419, 1417636430, 'yf1ur8k', -405021191, -351624428, 861728040, 'j597fznqcuex', '1faxc1je', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 1, 1, -2147483648, 455841204, -200145376, 1696094807, 'hye3oylciif', 1978258540, 568.332221, -804801271, 'eoh', 2055250957, -1325997790, 1056881619, 'q97j534j5xbk', '1yspzc7', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, 1, -2147483648, -1305865435, -1502776895, -2011163283, 'rn6j7', -656237101, 99.08958, -898823195, '45j', 1847668366, 1652097981, -1703134386, 'ojnhh6va3tdx', 'hn75b733', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483603, 1, 1, -2147483648, -561761019, -859943149, 1333753099, 'a4yi4h', -20815215, 472.954512, -269097713, '9w43ial8s8', -215535291, -1116027668, 1229352231, '9fodt9kcq2ia', 'e6aj6ql167', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483602, 1, 1, -2147483648, 273358004, -1484908026, 435519779, 'xsove98b85', 946867225, 703.641664, -152632026, '8ikp3q', 127564856, -1716375595, -313408686, 'vu6v8hkl', 'y93zu8y', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483601, 1, 1, -2147483648, -1679192241, -922296677, -1919962183, 't', 931265534, 541.376556, 1530956156, 'hlh5i1', -1931468427, 1718452961, 2109623518, 'lhw6lv7j4', '52k1qzqt5uw', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483600, 1, 1, -2147483648, -1740675234, -856771235, -1625071271, 'l3bjksu', 1928368836, 219.34841, -1889113209, '60sijuf', 813052479, -737687664, -1708077219, 'xbu', 'xi', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483599, 1, 1, -2147483648, -880471265, 1754489362, 1344117622, 'u2fkzbwx', -144653294, 488.136371, 1092707574, '37qob', -674972001, 589902891, -580079713, '67pvp0h2', 'flntlcorqt', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483598, 1, 1, -2147483648, 1038494243, -1749345431, 1641596538, '6', -107283715, 682.146426, -1775845767, '6q', 56216130, 1385394884, 1792401890, 'xt41zj', 'f1qj3se4dp', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483597, 1, 1, -2147483648, -950795649, 128017130, -1544200311, 'pxb659q4tkf5', -1521409928, 850.294419, 2132312264, 'y485ys1g', 302385175, 1767626260, -1624769339, '0w', 'tzip2a6', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483596, 1, 1, -2147483648, -1948353462, -254442524, 145803049, 'rnfvkrmfoqpz', 1821943546, 33.222617, -1244820603, 'i98owqwx', 629484232, 1017634335, -726015117, 'h59i', 'nipn6d', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483595, 1, 0, -2147483648, -1031889571, 1491779551, 1295864154, '4done', 1039998344, 128.924111, 522198308, 'izi623', -1085464899, 1234250708, 868170608, 'ew42zl4ptf8u', 'l0lw90t2kl', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483594, 1, 0, -2147483648, 1754716492, -1089704776, -607398188, 'gno6r9d3zd', 1169469726, 828.814401, -772755259, 'rvcc', 959473834, -990226565, 602958478, 'eddnko', '7dq70691', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483593, 1, 0, -2147483648, -980180561, 209714160, -191511230, 'xg3ufge', 2003439664, 274.01046, -659241529, 'qgiqh4ao3k79', -722157386, -71910989, -875587691, 'b3349kf5l6rn', '3', 1);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483592, 1, 1, -2147483648, 1061006043, 970841205, -216136015, 'v', -559985010, 971.456797, -748409233, '4jm31nfs4', -1152645284, -236062015, -17400164, '2971k', 'jnnb', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483591, 1, 1, -2147483648, -40599967, 1040296707, 1330725746, 'rj6o317kajtw', -1017874103, 317.89633, 259660611, '945ycwnr8d', 1327596103, 755310829, -2038978824, 'jmeuvjvcr9', '03f', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483590, 1, 1, -2147483648, -2130742032, 1244725562, -1487494813, '2f316', 1646925800, 885.420339, 1481930618, 'luvk4s7', -612603238, -1705389050, -198326755, 'zchdq8orxze', '2lwenn4i', 1);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483589, 1, 0, -2147483648, 1154857410, 52570171, 435993660, 'zmrsv641', 425959721, 923.86632, 908208204, 't8', -1056513455, -1748332866, -949971733, 'v7z6i', 'r1w', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483588, 1, 0, -2147483648, -596283718, 1344525827, -1368673332, 'b', -1464232115, 521.594237, 1833037259, 'uwyewbihg801', -1860262488, -192376676, 996081640, '2n', 'hc', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483587, 1, 0, -2147483648, 2134974396, -674436733, 1405721813, 'axg0g', 1368407220, 231.825481, -728378511, '1lrhqsxyube', -496224640, 551417265, -953454343, 'ycz8d5ykab', 'tcpo1ke8euy', 1);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483586, 1, 2, -2147483648, -394850785, -1066927063, -1002122713, 'z82twy4', -1201944605, 290.734313, 671921821, 'rlhj1gxio9', 1672949483, 346776902, -709260001, 'x5', 'l7joby', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483585, 1, 2, -2147483648, -916486834, 2123096833, -88776639, 'y4gp', -337744564, 267.971482, -2018324945, 'd0gkgqa', -772738375, -100171553, -1890973087, '12', '4lj', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483584, 1, 3, -2147483648, 1938457741, 550465673, -316612343, '7dxug', 258294467, 308.508953, 325036503, 'n', -1550302174, 101396312, 2105679482, '6gahj', 'cu84vxo5sddf', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483583, 1, 2, -2147483648, -1262942078, 397280487, -642971630, 'duqt0ig', 652314885, 549.302984, 1203281648, 'rru', 393697580, -616668672, 1994640301, 'tk', 't', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483582, 1, 2, -2147483648, 499326529, -1252329401, -707359942, 'nzpkcpw0q9z4', -145918370, 861.631135, -1679649983, 'jlkkggqx', 646367725, -312001161, -1771659759, 'o', '1864', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483581, 1, 3, -2147483648, 233495545, 267362922, 350405500, '6bb6tec', -2122365401, 231.5989, 1707108892, 'zf5t', -1356099725, 1401780703, -720003270, 'c3', 'b0v293muo9o5', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483580, 1, 2, -2147483648, 294164314, -1955937242, 26370873, 'wfuy2vtctr', 637375243, 719.954929, -1213117574, 'c1jc1', 470534297, -197507241, 155279221, '6qohr35i', 'ptxmlhv1xt', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483579, 1, 2, -2147483648, -1657244403, -1985673660, -607510855, 'mxv', 322037946, 299.044848, -28426541, 'vero7mfr86mo', 2049183742, 131124756, -818906275, 'qbwhbis', 'zzg8eizd0cun', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483578, 1, 3, -2147483648, 1315981105, -1739525341, -1301745780, 'wbd', -1194088179, 953.032319, -379077665, 'nxzfoas9', 1502626911, 933110466, -1894763429, 'e0r841i6vn9', '6', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483577, 1, 2, -2147483648, 70965926, 1245769485, 1325587487, '5cayzma', 1891630969, 790.005302, -1672798111, 'xo6stk', -329985830, -603769972, 712953308, 'sy9i6bswqb', 'oyhady', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483576, 1, 2, -2147483648, 1508846780, 1789545044, 435918223, 'pzj', 1299411857, 719.160835, -540669402, 'maspu0abl7', 1095868744, 700325096, -1761097222, 'q6', 'd1hg2', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483575, 1, 3, -2147483648, 1966777205, -2114988545, 2121523609, 'mvp19d', -713361233, 580.591178, -868470334, 'ec1zu80x72pb', -460777348, 466432863, 593312927, 'rds4d', '7xpoymk4', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483574, 1, 3, -2147483648, -715980661, 809136676, -1754065737, 'e2yc4ssv', 3086382, 332.275211, -1558702799, 'c5cdllp', 1653776824, 986160292, -1401957663, 'q4nksw3506', '6790', 1);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 6, 1, -2147483648, 89267185, -1865039888, 1160656988, 'ia2yp', -1670923962, 663.049759, 906324270, 'b', 1072996612, 13244799, -1659388584, 'l', 'tilbn', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T3.statusId = 3 AND T2.name = 'Canadian Grand Prix' GROUP BY T1.driverId ORDER BY COUNT(T1.driverId) DESC LIMIT 1;

/*
Gold Result:
(19,)
*/

-- Prediction Query
SELECT COUNT(*) FROM results WHERE raceId IN (SELECT raceId FROM races WHERE name = 'Canadian Grand Prix') AND statusId = 3;

/*
Prediction Result:
(35,)
*/