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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2007, 1151980946, -2147483648, 'Bahrain Grand Prix', '2020-12-06', 'a9000t5c4eci', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2007, -1025564911, -2147483648, 'Bahrain Grand Prix', '2025-01-05', 'kf9vq', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2007, 1836127587, -2147483648, 'f8jegd2', '2024-11-12', 'y9uxj4', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2007, -1437333179, -2147483648, 'Bahrain Grand Prix', '2023-03-15', 'wqcgsk', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2007, -443340271, -2147483648, 'Bahrain Grand Prix', '2023-08-27', '4nrq', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2007, 537874887, -2147483648, 'Bahrain Grand Prix', '2024-05-26', 'f8jegd2', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2007, -639539893, -2147483648, 'Bahrain Grand Prix', '2022-12-03', 'xb72fxa7r', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2007, 87529806, -2147483648, 'Bahrain Grand Prix', '2020-06-30', 'dctmf', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 2007, -870767087, -2147483648, 'Bahrain Grand Prix', '2021-03-03', '5i3', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 2007, -790819470, -2147483648, 'Bahrain Grand Prix', '2022-04-09', 'rpd', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 2007, 1617348603, -2147483648, 'Bahrain Grand Prix', '2022-11-07', 'xuzkb52', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 2007, -1943814113, -2147483648, 'Bahrain Grand Prix', '2024-01-04', '603vzxw1r', 'url_12');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '2025-08-22', 'uhv', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'ozk3zbily', 638024588, '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', '2023-02-06', 'z16nijjai5d', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'ogrgjd8y', 1129658414, '1afgo', 'ri', 'tsj3ayxp1q4', '2025-02-15', '1jh3den', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '9n8c4pgu7v', -1865039888, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', '2022-01-16', 'n', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'rofqyp5s5b', 2107872094, '02eutliqa11r', 'ytoo3o9', 'l7', '2024-12-21', 'lex', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'vy9uxj4', -1612443122, 'd', 'lph2gn', 'q', '2023-11-15', 'qcx5', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'fdrz16n', -1496556994, 'i', 'dh5ogrgj', '8', '2024-05-09', 't1afgog', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, '62', -1744557630, '5q8qdj', 'e1io', '278507cv', '2023-05-06', 'ptt', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'q5l', 1339733032, 'im5k', '8qs27p2r', '4gth2mnaj', '2021-09-30', 'a3o', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'wzw', -55494714, 'n9', 'o705', 'a9n0jxfofws', '2024-06-14', 'o', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (11, 'gwnlas6', -2076274980, 'ow', 'i1z', 'nxih662q', '2025-01-01', 'lyotow', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (12, 'e9yfk7', -1046720861, '162nh55y3d', 'ohvu06dza3', 'rmkio18r', '2021-07-23', 'hy08ftp6', 'url_12');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'gce376nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'l', 'tilbn', 'rmdp', 'siie', 489.397796, 933.422701, 44952191, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2007, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '2eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1775126557, 482.572691, 105869088, NULL, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 2, 1, -2147483648, -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5', 580968159, 210.05299, 1575412235, NULL, -988981234, -841004020, -361507387, '79fjgq8', 'n2f3dqv0gcb9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 2, -2147483648, 1774087382, 1732258051, -1762140823, 'w1of77pz', 87529806, 752.977863, -1957268147, NULL, -1928431425, 1303877941, -1284905200, '62', '0v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, 1, -2147483648, -1488156735, -1858644047, -1180042408, '78507cvt', -1523347137, 789.724834, 1582582341, NULL, 453836040, 1467355421, -1171104889, '5zi36c4bfkfo', 'c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, 2, -2147483648, -253138337, 641521863, 304189298, 'xd', 1999335832, 377.388457, -546516406, NULL, -405743609, -1935752926, -20116244, 'lq5lnpim', 'k58qs27p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 2, 1, -2147483648, -1719383707, 1273687251, 333302050, 'najj', -1351793914, 462.366429, 1919033056, NULL, -1428186898, -761353513, 362376128, 'mu2ne578lf', 'yz7zzb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, 2, -2147483648, -72442907, -2060082151, -1122409769, 'u', 1164790775, 453.245856, -790819470, NULL, -1278087274, -1140595602, -609553675, 'w5chn9mo705a', '9n0jxfofwsz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 2, 1, -2147483648, -1197954156, -2019656607, 375841374, '32o', -1898678660, 38.169466, 440115543, NULL, 292557306, 709097796, -984562992, 'yngc1d', 'j9erhizgk1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 2, -2147483648, 1483450542, 513375398, 718167481, 'hdt6fuq', 1294064538, 361.042997, 778835680, NULL, 1755752040, 1262491793, 450555855, '1gwnlas6', 'elboeowii1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, 548968280, -1552469358, 7342822, '2xlyo', 727608179, 886.204918, 456034296, NULL, -628433041, 1044710644, 966412849, '0', 'bindz', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, 2038321753, 1376887048, 261633665, '8', 748154000, 767.502854, -1988582944, NULL, -794767771, 989306270, 1147652228, 'u', 'bd0w9603v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, 1, -2147483648, 431832073, 1510892261, 1677948887, 'y08ftp6ewt', -1051623642, 361.5356, 2013745856, NULL, 917362079, -1312038093, 687330820, 'mfx7h33p', '6sto1cj8sh5k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, 1, -2147483648, 1487347213, 1328948152, -1923069176, 'jmgjach8qt', 620355627, 839.760651, -531872415, NULL, -2125172723, 339193890, -493230039, 'mayq3qdpua', '96rn', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, 1, -2147483648, -951706262, -1324935647, -648564084, 'c7d', 594760660, 439.465402, 833568923, 't2__f85e12', -384749431, -934098178, -827883679, 'lc', 'qb9i9f', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, 1, -2147483648, 908468929, 1149620614, -1414362698, '1quik', 1570917601, 680.51123, -2052350430, 'hlst1pqom', 2141720493, 1793241362, -1304516770, 'z78', 'q', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, 1, -2147483648, -753065777, 190510318, -835782528, 'r9114qbre', 316163741, 71.721662, -752650834, 'j8kjh', 1138926079, -609840352, 486475144, 'vrisurz0ka', 'qtncgc8s3b7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483632, 1, 1, -2147483648, -2070247503, -1629148699, 103252327, 'ar50hs', -1515201134, 5.946198, 1195320303, NULL, 1463445550, -1096060187, 2014610660, 'wfwx', 'rlawk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, 4, -2147483648, 2087640001, 907682809, 2026480202, 'ie5', -1209887326, 992.733505, -1399556171, NULL, 1038707349, 1419861592, 700088193, 'ecigce376n', 'um5', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 5, 5, -2147483648, -1525670226, -453362185, 481163439, '2dwyrq', -1097120355, 326.912005, 244829661, NULL, -1362461264, -904834265, -346339240, 'yp5qi2rk', '9v', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 6, 6, -2147483648, -1106350634, -1509264256, -792947627, 'z', -1748371085, 94.390081, 894242932, NULL, -211209314, -1056308489, -1454058168, 'bilyrkn', '6vck6ah0f8js', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 7, 7, -2147483648, -902895762, -197933860, 2111987706, 'p1q430', 1923912467, 571.595144, 518609210, NULL, 1948383687, 1476361420, 195720193, 'vacx7afu5', '1of77p', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 8, 8, -2147483648, -1171104889, -29242208, 1691780814, '6c4bfkfo', -1950324754, 992.626961, 76987628, NULL, -253138337, 641521863, 304189298, 'xd', 'ysxcmr0o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 9, 9, -2147483648, -761353513, 362376128, -1311735207, 'ne578lfv', -526633767, 823.908713, 448935289, NULL, 458835042, 924693315, -705922211, 'v42q7sx58b4p', 'aus3', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 10, 10, -2147483648, 270415200, -2071531094, -397848196, '0k32odwcl5a', 292557306, 665.099697, -984562992, NULL, -605061107, -1689155697, -323362455, 'j9erhizgk1', 'yoeyo6l0hdt6', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (11, 11, 11, -2147483648, 456034296, -628433041, 1044710644, 'qb0tbindz39t', 2038321753, 151.892832, 1376887048, NULL, 261633665, 748154000, 1148916014, 'g', 'mbc3td', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (12, 12, 12, -2147483648, -805997097, -586285368, 1664452437, 'jabymzn2mfx7', -1659775598, 453.840746, -891525031, NULL, -1154091048, -1971560508, 1728926031, 'knzys7dy', 'yd1jmgjach8', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.driverId) FROM races AS T1 INNER JOIN results AS T2 ON T2.raceId = T1.raceId INNER JOIN drivers AS T3 ON T3.driverId = T2.driverId WHERE T1.year = 2007 AND T1.name = 'Bahrain Grand Prix' AND T2.time IS NULL;

/*
Gold Result:
(19,)
*/

-- Prediction Query
SELECT COUNT(*) AS drivers_not_finished FROM races AS r INNER JOIN results AS res ON r.raceId = res.raceId WHERE r.name = 'Bahrain Grand Prix' AND r.year = 2007 AND NOT res.time IS NULL;

/*
Prediction Result:
(3,)
*/