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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 1, -992890117, -2147483648, 'a2ypuzhsrwbb', '2022-08-24', 'luhvdltti', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483647, 1, -953437896, -2147483648, '3pyu78d', '2023-01-20', 'jsl', 'C');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1, 2103044118, -2147483648, 'h2gndqwnqcx5', '2021-04-09', 'cprj', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 1, -541746689, -2147483648, '7ryfdrz16n', '2021-06-18', 'jai', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 1, -59984348, -2147483648, 'wqcgsk', '2022-04-27', '8c4pgu7vfe', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, 1038707349, -2147483648, '9000t5c4ec', '2021-06-11', 'gce376nium52', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1, -1525670226, -2147483648, '7zwau2dwyr', '2022-12-09', '3pyu78d', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 1, -1264842910, -2147483648, 'wnqcx', '2025-07-02', 'hncprjtu0dz', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 1, 1427161052, -2147483648, 'z16ni', '2021-09-12', 'ai5', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 1, 1371234901, -2147483648, '1of77p', '2024-06-20', '72ct', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 1, 1722106924, -2147483648, 'f', '2021-11-12', 'oa', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 1, 1339733032, -2147483648, 'im5k', '2025-07-11', 'qs27p2r94', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 1, -233617564, -2147483648, '7sx58b4pma', '2023-08-31', '3auvm', 'url_13');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'bnp', 1236688122, 'dpos', 'ie5', 'nw6klf', '2020-01-23', '9000t5c4ec', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'gce', 'name_1', '76nium52', 'zbuo4nrqrof');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, 'qyp5s5bbp0');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, -2147483648, -2147483648, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274.580687, 274769912, 'oo3o9', -1666765085, 1178636309, -1390245819, 't1__fe0118', 'x14ji7zwau2d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 1, -2147483648, -2147483648, 1649269347, -1116181514, 1255852738, '2rk', -705985602, 604.643336, 537874887, 'z0f8jegd21vy', -792092619, -1492524358, -1612443122, 't1__fe0118', 'd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 3, -2147483648, -2147483648, -1898531797, -1748371085, -1742081330, 'n2f3dqv0g', 1382410067, 879.800692, 172461907, 'k3zbily', 638024588, -688098735, 1784916884, 't1__6a70a3', 'ah0f8jsww', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, -2147483648, -2147483648, 1583472758, 1449284300, -977470238, 'd8y', 1129658414, 308.482994, 1250290042, 'og', -946046410, -902895762, -197933860, 't1__fe0118', 'xp1q430', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 2, -2147483648, -2147483648, 1476361420, 195720193, 1774087382, 'c', 1523825314, 983.924121, -47052816, '1of77pzo72c', -820614248, 481546706, -1784554553, 't1__fe0118', '2g0v5q8qd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 2, -2147483648, -2147483648, -1180042408, 199672698, 2119806856, '7cvtjpttg6b', -1171104889, 813.864654, -29242208, '36c', 1722106924, -2072838897, -1173368267, 't1__fe0118', 'cd07z2zezjo7', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, 1999335832, -526612570, -546516406, 'r0oz', -870767087, 104.37745, 875300074, '3lq', 1816660482, -1212676731, 1692046802, 't1__fe0118', '5k58', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, 1055237066, 988954859, -1719383707, '2m', 418247369, 145.067008, -1351793914, 'okv8uttm', 1553368934, -1252009958, 1908593332, 't1__6a70a3', 'vy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, -2147483648, -2147483648, 319284352, 1164790775, -200807520, 'vmkrpd', -609553675, 730.273808, -55494714, 'n9', 101754718, 628082526, -1245584612, NULL, 'xfo', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483639, 1, -2147483648, -2147483648, 1719800120, -210159774, 270415200, 'b', -397848196, 983.253685, -366775518, '2odwcl5a', 292557306, 709097796, -984562992, 'yngc1d', 'j9erhizgk1', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483638, 1, -2147483648, -2147483648, 718167481, 1428194830, -1614619556, '6fuqy', 778835680, 908.792879, 1262491793, '5', -206528034, -1686002788, -1250380401, 't1__fe0118', 's', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, -2147483648, -2147483648, -252690330, 1115440883, 1644814318, 'sr', 906324270, 944.247544, 2122220075, 'p6luhvdlttil', 429706943, 462974032, -1137908826, NULL, 'siie5unw6k', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 5, -2147483648, -2147483648, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 705.580387, 743312762, 'eutliqa11r', 2137741668, -525979501, 1898504886, NULL, 'o3o9hl72klex', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 6, -2147483648, -2147483648, -904834265, -346339240, 1692174491, 'qi2rkf9v', 556727997, 860.770887, 1178000634, 'pz0f8jegd', -283454505, 233994589, 1442655647, NULL, 'hwbdvlph', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 7, -2147483648, -2147483648, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk', -155284187, 892.659478, -1554531873, 'yrkn6vck6ah0', -1520489792, -658391922, -1388029300, NULL, 'xb72fxa7r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 8, -2147483648, -2147483648, -1738458256, -1714354341, -458359144, '1afgogritsj', -197933860, 991.735454, -598313376, 'q4301jh', -163600466, -1826414375, 357330522, NULL, '68x8vacx7a', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 9, -2147483648, -2147483648, -1284905200, 7929158, -1744557630, '5q8qdj', -1139855872, 432.865904, 1897687032, '278507cv', -866772222, -847293924, -2033879835, NULL, 'u5zi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 10, -2147483648, -2147483648, 76987628, -253138337, 641521863, 'o7w', -542502665, 965.506647, -526612570, 'cmr0oz', -870767087, -1699185893, 875300074, NULL, '3lq', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (11, 11, -2147483648, -2147483648, 333302050, 1162591638, -2136247961, 'la3', 1803796945, 338.437591, 872694102, 'tmu2n', -1817527403, -1402164108, 2123471885, NULL, 'yz7zzbe8yvk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (12, 12, -2147483648, -2147483648, -1934017803, 1105964624, -663234145, 'h', 101754718, 486.420817, 628082526, '9n0jxfofwsz', -210159774, 270415200, -2071531094, NULL, 'q0k32od', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.year FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE NOT T1.fastestLapTime IS NULL;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT "races"."year" FROM "results" INNER JOIN "races" ON "results"."raceid" = "races"."raceid" ORDER BY "results"."fastestlaptime" ASC, results.resultid NULLS LAST, races.raceid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/