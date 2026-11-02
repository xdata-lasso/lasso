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

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, -2147483648, -59984348, -2147483648, 't2__b237fd', '2023-11-15', 'qcgsk9', 'url_6');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'p6luhvdlttil', 429706943, 'rmdp', 'siie', 'unw6klfa', '2024-07-24', '00t5c4ecigc', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'ri2hy08ft', 2066302536, 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', '2023-04-07', '5k', 'url_2');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'e376nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (-2147483648, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (3, 'b');

INSERT INTO "status" ("statusid", "status") VALUES (2, 'j5');

INSERT INTO "status" ("statusid", "status") VALUES (4, '57');

INSERT INTO "status" ("statusid", "status") VALUES (5, 'a9n0jxfofws');

INSERT INTO "status" ("statusid", "status") VALUES (1, '6lk8qazkjy');

INSERT INTO "status" ("statusid", "status") VALUES (6, '8c4p');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274.580687, 274769912, 'oo3o9', -1666765085, 1178636309, -1390245819, 'x14ji7zwau2d', 'yrq13p', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, 1, -2147483648, 244829661, -1362461264, -904834265, 'b4yp5qi', -227162283, 164.583726, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 1675430660, 'y9uxj4', 'wb', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 1, -2147483648, -736979194, 2103044118, -1642259219, 'nd', -1052964641, 209.967034, -1660358170, 'p', -988981234, -841004020, -361507387, '79fjgq8', 'n2f3dqv0gcb9', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, 1, -2147483648, 2094425101, -961217731, -1888505890, 'z16nijjai5d', -1625552518, 849.655083, -1738458256, 'jd', 1074760385, 1129658414, 1250290042, 'og', 'itsj3', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 3, 1, -2147483648, 357330522, -683007527, 2035306060, 'x7afu5w1of77', -1099855564, 224.624401, 87529806, 'ctdctmfg62g0', 1870300798, 820970595, 1421303999, 'j', 'e1io', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 4, 1, -2147483648, 944975670, -1575410149, -68044929, 'kf', 1923659053, 12.330671, -1950324754, '7z2zezj', 1448731351, -604098478, 1248858185, '5', 'sxcmr0o', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, 1, -2147483648, -1609653472, -1405314653, 1816660482, 'npi', -1300180872, 167.377262, -1125548818, '94gth', 333302050, 1162591638, -2136247961, 'la3', 'okv8uttmu2', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 1, 1, -2147483648, -1402164108, 2123471885, -526633767, 'zzbe8yvkv', 318331233, 445.606673, 79330142, '58b4pm', 1849819405, -929383517, -2090240067, 'mkrpdj', 'wzw5chn9mo70', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 1, -2147483648, 1719800120, -210159774, 270415200, 'b', -397848196, 983.253685, -366775518, '2odwcl5a', 292557306, 709097796, -984562992, 'yngc1d', 'j9erhizgk1', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 2, 1, -2147483648, 1483450542, 513375398, 718167481, 'hdt6fuq', 1294064538, 361.042997, 778835680, 'kb521gw', -1250380401, 1718516876, -2076274980, 'ow', 'i1z', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 3, 1, -2147483648, 1557188093, 548968280, -1552469358, '62q2xlyot', 1083479253, 913.199755, 205676091, 'aawg96aqb0tb', -1216952047, -457901285, -2140923099, '9td8n5w', 'g', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 4, 1, -2147483648, -1275298282, 1933158443, 1295379066, 'd0w9603vzxw1', 1689143863, 372.360229, 237552112, 'k7', -1046720861, 643589729, -1231488097, '55y3dohvu06d', 'a35rmki', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, 0, -2147483648, -515419519, -1884062674, -531932574, 'jmgjach', 1122899168, 462.488905, -735270562, 'ygmayq3qdpu', 1595033206, 1291298007, 1982265552, 'dqrhm', 'wlic7dn2', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, 0, -2147483648, -1104749933, 379651188, -592014051, 'sqtg', -1872934808, 40.211911, 422046500, '9', -1750715330, 277649518, 908468929, 'kjq1qu', 'k1y', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, 0, -2147483648, -2052350430, 166124233, 1862197286, 't1pqo', 1222311103, 139.623194, 2141720493, 'vb6m4iz78aq', -1043357093, -753065777, 190510318, 'tb8r9114qbre', '6bjeuuwsj8k', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 2, 0, -2147483648, -609840352, 486475144, -679850352, 'sur', -459075802, 157.137252, 1384307628, 'ncgc8', 1446366856, 438933248, 180947503, 'dmdbdh', '6j47n', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 3, 0, -2147483648, -982188592, 1981548099, -913430713, 'an', 1195320303, 840.734969, -1096060187, 'mwfw', -544173163, -958321297, 2015039199, 'k014r5', 'dqtsmg97aqz2', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483631, 4, 0, -2147483648, -261782899, -1079009577, -1385967617, 'u6iph', -1944869637, 653.320799, 334376591, 'ir', -176968915, -717865822, 2061102304, 'a2sb', 'uoi1pavc', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483630, 1, 0, -2147483648, 1971816668, -1067465394, 1491006943, 'lrpou', 1368469085, 305.710224, 3208964, 'xyfvmjwpp26', 1913338832, -2061050846, 1893953818, '0ju', '0h3r133ir1ax', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483629, 1, 0, -2147483648, 1498496406, 370054768, -1837449583, 'p', -1452518801, 345.665971, 1339281953, '4o6qjektb1', 1464469520, -209435372, 946571403, '3r', 'jkwns47j2j', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483628, 1, 0, -2147483648, 173803229, -1971104604, -526608193, 'vjwq49yrnx', 1511946366, 329.006579, -1910754958, 'o', -232312083, 1805923837, -699779308, 'j9f', 'vuu', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483627, 2, 1, -2147483648, -251621840, -1720233199, -672126855, 'gezax', -316078323, 173.77973, -754769711, 'ly', 139907579, 914471233, -1813651479, 'pe0', '19cy7od033d', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483626, 3, 1, -2147483648, 935816178, -1919535047, -690382359, 'ed', 1188203659, 642.766569, -1066046077, '26u331spxpw3', -349181074, -1725714389, -1248881581, '6id', 'p61l', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483625, 4, 1, -2147483648, 1069076646, 1574139922, -2106733603, '62ocagj', 1361395061, 63.114566, 1707457950, 'zxlu49', -1459357985, -2051917235, 833662145, 'e', 'uekhllbw', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483624, 1, 0, -2147483648, 1104707112, 1551904707, -400879450, 'u', -699425950, 399.23748, 516500236, '835xoepac', 1372042958, 1147974039, -220327705, 'c296xiy', 'et8xjhcf46c', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483623, 1, 0, -2147483648, 1280646590, -568125159, -329270684, 'v8n', -137586537, 59.584068, -1198828889, 'ezcteh', 660144343, -169414942, 806158445, 'vb7vpc0xff', 'or1esk', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483622, 1, 0, -2147483648, 1403715810, 1494789426, -1048234032, '1huij7f', -1663813652, 810.481449, 1094664154, '8gxb', 854201197, -1497515537, 1432878454, 'awsp4kwi3h', '7j4', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483621, 2, 0, -2147483648, -480726958, 191797158, -1428261633, 'w4jn2z19', 643485636, 105.740228, 319828561, 'c', -1725535379, 1709325128, -29488259, '41', '80terbfokvee', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483620, 3, 0, -2147483648, -1371170489, -759584258, 1143458360, '2cel8m', 1197643380, 81.334226, -1957884289, 'n5en', -1591272038, 1985372765, 1443327784, 'bgz5', 'qxs2', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483619, 4, 0, -2147483648, 1276865022, 1875923360, -286884572, '253sb59ls1e', 428576631, 208.095494, 1134827548, 'daqqhyyzsn', -105243240, -1324600306, -1250452845, '4m0rrwbjk0', 'p', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483618, 1, 0, -2147483648, -616998913, 1022316699, -1519375860, 'lwtlzh42nyj5', 411661379, 149.30112, 1357426337, 'qkna', -1725694639, 1037880389, -2059498122, '0', 'mxwdb7o', 2);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483617, 1, 0, -2147483648, 619382464, 792905581, -1013704446, 'k4c6gwn', 542602362, 55.932348, -1984500518, 'iikaxzr90nhs', -1205570400, -976193147, -15423424, 'phy', 'n', 4);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483616, 1, 0, -2147483648, 1295963771, -534612951, 754506713, 'x8scr0f', -912658170, 710.920615, 1378228777, '0b5m', -1001218462, -1965995887, -1756413046, '3rzgz84', 'lqme2wb1b3', 5);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, 61145737, 1522069539, -1576807806, 'olt070zi90o5', -193700628, 100.260607, 608918735, 'm6dpewe', 2014227445, -1133072015, -243587307, 'l21', 'sad6q5', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, -1580770288, -1158897957, 380206420, '023lwh9', -2006209112, 193.215124, -1691663167, 'xjqbloxd4', -928434146, 1083095660, 343349384, 'd6dvygwakmwg', '73fy3d', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483615, 1, 1, -2147483648, -1930352392, 1221655010, -544010785, 'bl10qx6j6d4f', 877176214, 525.46775, 1869989693, 's2ajdu26xu', -395383776, -1876636977, -557260064, '5u7709', 'qf9lx8qzabi', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483612, 1, 1, -2147483648, 1317293788, -1401325547, 1580782292, 'jwk6hh2oe7', 1342717090, 408.066092, 1100953564, 'zrv1ll930xvk', 2045017461, 513178845, -974198226, 'saxe', 'in', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483611, 1, 1, -2147483648, -46379547, -890072422, -1842328080, '3r3uxd', 560506797, 362.317546, 830725610, 'l1zm', -983850650, -903927747, 1250861085, '4qpp330', 'a1ngqut8', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483610, 1, 1, -2147483648, -1908406235, 2142421496, -1408342453, 'dyxk', -384734946, 893.593329, -1965798280, '1c8', 1951564466, -721450631, -1908930700, 'p0760ugk2h', 'jzxpg1lcg9', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483609, 1, 1, -2147483648, 935509881, 371075029, -644805902, '6f5tqhjd5m', -2099978946, 188.367968, 1132226816, 'tzdlb6i4', 1957002795, 1239479860, 1549626896, 'c29dwt1h', 'v', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483608, 1, 1, -2147483648, -1126619065, 1821429906, 1770083132, 'jf4i5t9', 1124850667, 881.539265, -1211007003, 'hvi6tp3tfnd', 2071439307, 2077933154, 232457376, '6sru4eu', 'io', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483607, 1, 1, -2147483648, -1022360195, -1517836823, -2124619836, 'fhj8zr6k53', 376872332, 494.491571, -1799118529, 'f1ur8kz', 903854855, -1701090371, -1531116262, '7fznqcuex', '1faxc1je', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483606, 1, 1, -2147483648, 455841204, -200145376, 1696094807, 'hye3oylciif', 1978258540, 568.332221, -804801271, 'eoh', 2055250957, -1325997790, 1056881619, 'q97j534j5xbk', '1yspzc7', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483605, 1, 1, -2147483648, -1305865435, -1502776895, -2011163283, 'rn6j7', -656237101, 99.08958, -898823195, '45j', 1847668366, 1652097981, -1703134386, 'ojnhh6va3tdx', 'hn75b733', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483604, 1, 1, -2147483648, -561761019, -859943149, 1333753099, 'a4yi4h', -20815215, 472.954512, -269097713, '9w43ial8s8', -215535291, -1116027668, 1229352231, '9fodt9kcq2ia', 'e6aj6ql167', 3);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 6, 1, -2147483648, 89267185, -1865039888, 1160656988, 'ia2yp', -1670923962, 663.049759, 906324270, 'b', 1072996612, 13244799, -1659388584, 'l', 'tilbn', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.driverId) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T3.statusId = 3 AND T2.name = 'Canadian Grand Prix' GROUP BY T1.driverId ORDER BY COUNT(T1.driverId) DESC LIMIT 1;

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN status AS T3 ON T1.statusId = T3.statusId WHERE T2.name = 'Canadian Grand Prix' AND T3.status = 'Accident' GROUP BY T1.driverId ORDER BY COUNT(*) DESC LIMIT 1;

/*
Prediction Result:
*/