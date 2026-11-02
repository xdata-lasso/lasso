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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2000, 1151980946, -2147483648, 'a9', '2024-07-24', '00t5c4ecigc', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2000, 1661181156, -2147483648, '0b4', '2024-04-25', 'p5qi2rkf9v', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2000, 1178000634, -2147483648, 'pz0f8jegd', '2025-01-26', 'vy9uxj4', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2006, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2000, -1437333179, -2147483648, 'wwqcg', '2023-04-14', '9n8', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2000, 1155439218, -2147483648, 'um5', '2025-01-28', 'zbuo4nrqrof', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2000, 1675430660, -2147483648, 'y9uxj4', '2021-05-25', 'bdvlph', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2000, 1360271423, -2147483648, 'ogrgjd8y', '2024-05-29', '1afgo', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 2000, 1722106924, -2147483648, 'f', '2021-11-12', 'oa', 'url_9');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '2025-08-22', 'uhv', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'zbilyrkn', -688098735, '6ah', 'f8jswwl', '7xb72', '2020-11-23', 'a7ryfd', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'z16nijjai5d', -1625552518, 'grgj', '8', 'yzt1afgogrit', '2023-04-01', '3ay', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '4', -734455130, '4h', 'ia2yp', 'uzhsrwbbp6lu', '2021-04-10', 'dlttil', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, '4', -734455130, '4h', 'ia2yp', 'uzhsrwbbp6lu', '2021-04-10', 'dlttil', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'qyp5s5bbp0', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', '2024-12-21', 'lex', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'gndqwnqc', 555413010, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', '2022-06-25', 'k3zbily', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'ri', -902895762, 'ayxp1q43', '1jh3den', 'c68x8vacx', '2025-10-14', 'f', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'cd07z2zezjo7', 304189298, 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', '2022-06-10', 'im5k', 'url_9');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, 'e376nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, 'l', 'tilbn', 'rmdp', 'siie', 489.397796, 933.422701, 44952191, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2000, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (2006, 'url_2');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_3');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '2eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 1, 1, -2147483648, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1775126557, 482.572691, 1, '7zw', 481163439, 2123196517, 364869063, 'q13py', '78d99r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 2, 1, -2147483648, -2050247126, -736979194, 2103044118, 'h2gndqwnqcx5', 580968159, 210.05299, 1, 'rjtu', -361507387, 401805964, -1485777725, '8n2f3', 'dqv0gcb98ozk', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 1, 2, -2147483648, 1972233925, 1792827279, 804529642, '01jh3den', 357330522, 565.286158, 1, '68x8vacx7afu', 1371234901, -290314193, 76996700, 'o72ctdc', 'mfg62', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483645, 2, 1, -2147483648, 820970595, 1421303999, -1488156735, '1i', 1897687032, 443.690199, 1, '8507cvtjp', 1582582341, 453836040, 1467355421, 'ou5z', '36c', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483644, 1, 2, -2147483648, -1173368267, 382831862, -406331049, 'ezjo7wg', 1248858185, 50.798088, 1, 'ysxcmr0o', 853709925, -870767087, -1699185893, '5i3lq5lnpim5', '58q', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 2, 1, -2147483648, 988954859, -1719383707, 1273687251, '2mnajjla3o', -1428186898, 543.846419, 1, 'uttmu2ne578', 1908593332, 697257217, -451030047, 'be8yvkv42q7', 'x58b4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483642, 1, 2, -2147483648, -929383517, -2090240067, -699574669, 'rpd', -609553675, 730.273808, 1, 'chn9mo70', 628082526, -1245584612, 1731843275, 'fofwsz', 'o', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483641, 2, 1, -2147483648, -2071531094, -397848196, -366775518, '2odwcl5a', 292557306, 665.099697, 1, 'lwyng', -1960313034, 681061317, 1935791961, 'izgk1yoeyo6', 'l0hdt6fuqyx', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483640, 1, 2, -2147483648, 450555855, -206528034, -1686002788, 'las6', -2076274980, 903.105468, 1, 'wii1', -457369423, 1557188093, 548968280, 'h66', 'q2xlyoto', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, 1, -2147483648, 456034296, -628433041, 1044710644, 'qb0tbindz39t', 2038321753, 151.892832, 1, '9td8n5w', -1988582944, -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, 1, -2147483648, -505019168, 1968783602, 125495479, '162', -1231488097, 722.776931, 1, '5y3dohvu06d', -438741674, -154207334, 729449685, 'io1', 'ri2hy08ft', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483637, 1, 1, -2147483648, 1328948152, -1923069176, -1520090613, 'gjach8qta8y', -161108900, 431.027804, 1, 'v4ygmayq3qdp', -2082238979, -845136979, -1042976410, 'm5', 'wlic7dn2np', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483636, 1, 1, -2147483648, -592014051, 1744849810, 1996699977, 'tgelc', -1025517017, 554.543791, 1, '9f2', 277649518, 908468929, 1149620614, 'jq1', 'uik1y', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483635, 1, 1, -2147483648, 1862197286, 1040753276, -324012243, 'qomiztvb6m', -74691962, 398.641235, 1, '78aqqlud8ft', 1183069552, -1057355067, -1004098188, '6bjeuuwsj8k', 'h85', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 4, 4, -2147483648, 462974032, -1137908826, -918961358, 'e5u', 1861536320, 345.718563, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 5, 5, -2147483648, 462974032, -1137908826, -918961358, 'e5u', 1861536320, 345.718563, 44952191, 'fa9', 1620389964, 546571701, 947159877, '5c4ec', 'gce', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 6, 6, -2147483648, -1525670226, -453362185, 481163439, '2dwyrq', -1097120355, 326.912005, 244829661, 'jsl', -346339240, 1692174491, -1025564911, 'rkf9vqx5', 'pz0f8jegd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 7, 7, -2147483648, 32204797, -1672720816, -1520489792, 'wlq7xb', 602161869, 814.417862, 2094425101, '7', 1294666887, -515895469, 1427161052, 'z16ni', 'jai', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 8, 8, -2147483648, -290314193, 76996700, -435350511, '72ctdctmfg62', -1744557630, 935.463334, 820970595, 'qdjpe1io2', 199672698, 2119806856, -1962347906, 'jpttg', 'bnou5zi36', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 9, 9, -2147483648, 1817366143, 1615073310, 1055237066, 'r94gth2m', 418247369, 145.067008, -1351793914, 'okv8uttm', 1553368934, -1252009958, 1908593332, 'vy', '7zzbe8y', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T3.dob) < '1985' AND T1.laps > 50, 1, 0)) AS REAL) * 100 / COUNT(*) FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId INNER JOIN drivers AS T3 ON T1.driverId = T3.driverId WHERE T2.year BETWEEN 2000 AND 2005;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', T2.dob) < '1985' AND T1.lap > 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.driverId) FROM lapTimes AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceId = T3.raceId WHERE T3.year BETWEEN 2000 AND 2005;

/*
Prediction Result:
(None,)
*/