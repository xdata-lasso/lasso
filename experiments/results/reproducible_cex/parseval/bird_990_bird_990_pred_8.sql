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

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, 2009, -188151580, -2147483648, 'Singapore Grand Prix', '2021-04-03', '72k', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2009, 580968159, -2147483648, 'Singapore Grand Prix', '2022-05-10', 'p', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2009, -841004020, -2147483648, 'dz79fjg', '2022-12-06', 'n2f3dqv0g', 'url_4');

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
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (1, 't3__f3af33', 'name_1', '5k5swwqcgs', 't3__b44af0');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (2, 't3__f3af33', 'A', 'p', 't3__b44af0');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483647, 't3__f3af33', 'C', '02eutliqa11r', 't3__b44af0');

INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (3, '4', 'name_4', 'p5qi2rk', '9v');

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

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, 2, 1055976837, 1775126557, -74849714, '7zw', 481163439, 313.384575, 2123196517, 'a::aa.aaa', 364869063, -953437896, -1097120355, '78d99r', 'jsl', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, -2147483648, 3, 537874887, -461695645, 836513442, '8jegd21vy9ux', -1492524358, 124.573829, -2050247126, 'a::aa.aaa', -736979194, 2103044118, -1642259219, 'nd', 'wnqcx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, -2147483648, 1, 172461907, 1606439408, 1443629118, 'zbilyrkn', -688098735, 915.583344, 37673509, 'a::aa.aaa', 834709651, -348113485, 138842628, 'wwlq7', 'xb72fxa7ryfd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, -2147483648, 2, -1259474148, 2011234363, -1483100200, '5dh', 1583472758, 837.437794, -977470238, 'a::aa.aaa', -1478247928, 1074760385, 1129658414, '1afgo', 'ri', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 2, -2147483648, 1, -197933860, 2111987706, -598313376, 'q4301jh', -163600466, 881.248682, -1826414375, 'a::aa.aaa', 357330522, -683007527, 2035306060, 'x7afu5w1of77', 'zo72', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, -2147483648, 2, 481546706, -1784554553, -242584410, 'v5q8qdj', -1139855872, 432.865904, 1897687032, 'a::aa.aaa', -241848752, 2004147439, -691774480, 'ptt', '6b', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 2, -2147483648, 1, -29242208, 1691780814, 1944978593, 'bfkfoacd', 2115816682, 668.776683, 76987628, 'a::aa.aaa', -253138337, 641521863, 304189298, 'xd', 'ysxcmr0o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, 2, -1699185893, 875300074, -1609653472, 'q5l', 1339733032, 236.262879, -1556979799, 'a::aa.aaa', -55240145, 1379859112, 195202164, 's27p2r94gth2', 'najj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, 1, 1803796945, 872694102, 618058035, '2ne578', 1908593332, 86.586744, 697257217, 'a::aa.aaa', -451030047, -2052653308, -489120589, 'v42', '7sx58', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, 1, -1122409769, 1849819405, -929383517, 'u', -699574669, 160.717227, 274891948, 'a::aa.aaa', 609771851, -1934017803, 1105964624, 'w5chn9m', 'o705a9n0jxfo', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, -2147483648, 1, -1352968577, -519515742, 1953495465, '1', 681061317, 950.711683, 595714424, 'a::aa.aaa', 1056589776, -499913447, -360096930, 't', 'fuqyxuzkb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, -2147483648, 1, -1686002788, -1250380401, 1718516876, '6elbo', 1731324803, 230.129952, -1589605308, 'a::aa.aaa', -268740517, -564679000, -251205568, 'xlyotow9', 'aawg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, -2147483648, 1, -381485009, 868039568, 503053726, 'z', 2085299664, 974.58376, 1376887048, NULL, 261633665, 748154000, 1148916014, 'g', 'mbc3td', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483634, 1, -2147483648, 1, 1071401016, 40558455, 740386991, 'xw1rxe9', -505019168, 958.39315, 125495479, '162', -1231488097, 956819642, 774922170, '3dohvu0', 'dza35rmki', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483633, 1, -2147483648, 1, 1510892261, 1677948887, 389700824, '08ftp6ewtqxx', 1664452437, 919.033168, -1485875026, 'a::aa.aaa', -2080232972, 462225708, 1528227252, 'fx7h', '3p6sto1c', -2147483648);

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
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('4', '9v')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
('t3__f3af33', 't3__b44af0')
*/

-- Prediction Query
SELECT c.constructorRef, c.url FROM constructorStandings AS cs JOIN races AS r ON cs.raceId = r.raceId JOIN constructors AS c ON cs.constructorId = c.constructorId WHERE r.year = 2009 AND r.name = 'Singapore Grand Prix' ORDER BY cs.points DESC, cs.constructorstandingsid NULLS LAST, r.raceid NULLS LAST, c.constructorid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/