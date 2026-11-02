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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2008, -992890117, -2147483648, 'Australian Grand Prix', '2020-01-20', 'ypuzhsrw', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2008, 1072996612, -2147483648, 'luhvdltti', '2022-01-16', 'n', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2008, 1606439408, -2147483648, 'Australian Grand Prix', '2021-10-23', 'zbilyrkn', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2008, -1962347906, -2147483648, 'jpttg', '2025-09-24', 'n', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2008, -915385605, -2147483648, 'm', '2023-01-12', '0oztdgj5i3lq', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2008, 79330142, -2147483648, '58b4pm', '2020-01-10', 'us3auvmkrpdj', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2008, 681061317, -2147483648, 'iz', '2021-03-12', 'k1yoeyo6l0h', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2008, -457901285, -2147483648, 'tajz9td8n', '2025-06-14', 'cgumbc', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 2008, 1299171592, -2147483648, '6ewt', '2022-11-11', 'xnjaby', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 2008, -845136979, -2147483648, 'rhm5w', '2022-01-12', 'c7d', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 2008, 44959255, -2147483648, 'iz78aqql', '2023-08-22', '8', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 2008, 438933248, -2147483648, '88kwdmdbdht6', '2021-08-26', '7nxar50h', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (13, 2008, 1216978423, -2147483648, 'su6iphd', '2021-11-21', 'u2gir31vwq5', 'url_13');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'rmdp', 2026480202, 'ie5', 'nw6klf', 'a9000t5c4eci', '2021-03-18', 'e', 'url_1');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '76nium52', 'name_1', 'zbuo4nrqrof', 'qyp5s5bbp0');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 86.520366, 65.761562, 1160656988, 'url_1');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'url_1');

-- Inserting into table: status --
INSERT INTO "status" ("statusid", "status") VALUES (-2147483648, '2eutliqa11r');

-- Inserting into table: results --
INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483648, 2, -2147483648, -2147483648, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', 1, 913.303855, -74849714, 't1__141d44', 105869088, -2081315180, 1909986641, 'yrq13p', 'u78d99r', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483647, 2, -2147483648, -2147483648, -346339240, 1692174491, -1025564911, 'rkf9vqx5', 1, 541.393553, 1836127587, 't1__141d44', -1529584866, 1196308825, 910894705, '1vy9uxj4', 'wb', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483646, 2, -2147483648, -2147483648, -1642259219, 1298861365, 1968874827, 'nqcx5h', 1, 210.05299, 1575412235, 't1__141d44', -988981234, -841004020, -361507387, '79fjgq8', 'n2f3dqv0gcb9', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (2, 1, -2147483648, -2147483648, 37673509, 834709651, -348113485, 'jswwlq7xb', 1, 598.428216, 602161869, 't1__141d44', 1350414441, 2094425101, -961217731, 'dr', 'z16nijjai5d', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (3, 1, -2147483648, -2147483648, 1449284300, -977470238, -1478247928, 'yzt1afgog', 1, 279.731401, -902895762, 't1__e6d9d1', -197933860, 2111987706, -598313376, 'q4301jh', 'den8c68x', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (-2147483643, 1, -2147483648, -2147483648, -1928431425, 1303877941, -1284905200, '62', 1, 93.813527, 1870300798, 't1__141d44', 820970595, 1421303999, -1488156735, '1i', '2278', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (4, 2, -2147483648, -2147483648, 1691780814, 1944978593, 1722106924, 'f', -1173368267, 707.057079, 382831862, '0', 76987628, -253138337, 641521863, 'o7w', 'xd', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (5, 4, -2147483648, -2147483648, 1692046802, -1300180872, -1125548818, '94gth', 333302050, 193.695314, 1162591638, 'ajjla3okv8u', 618058035, 1553368934, -1252009958, '78lfvyz7', 'zzbe8yvkv4', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (6, 6, -2147483648, -2147483648, -55494714, -1674145149, 234957614, 'o705a9n0jxfo', -1793230843, 296.34381, -441521858, '2zob', -2019656607, 375841374, -1449226553, '2odwcl5amso', 'lwyng', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (7, 3, -2147483648, -2147483648, -477129795, -1418927432, -30041412, 'gwnlas6', -2076274980, 903.105468, -1159083009, 'i1z', -564679000, -251205568, 287256667, 'otow9oa', 'awg96aqb0tbi', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (8, 8, -2147483648, -2147483648, -1943814113, 1514371324, -379749892, 'vzxw1rxe9y', -1046720861, 931.189708, 643589729, 'h55y', -141591627, 440797047, -732999244, '6dza35r', 'mkio18ri2hy', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (9, 4, -2147483648, -2147483648, -1277305894, -1659775598, -891525031, '1cj8', 1728926031, 485.281618, 1106724223, 'ys7dyyd1jmg', 729543907, -2108844113, 973811121, 'ta8y3a17v4', 'ygmayq3qdpu', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (10, 4, -2147483648, -2147483648, -384749431, -934098178, -827883679, 'lc', -1025517017, 554.543791, 1374676344, 'f2ccukjq1', 1584429327, -1575692857, 1570917601, 'hb08hlst1pq', 'mizt', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (11, 2, -2147483648, -2147483648, -312228770, 1618264449, 1639204149, 'r', 36589303, 760.996078, -1537647691, 'uuwsj8kjh8', -55270062, -1101814296, 1939337883, 'isurz', 'kaqtncg', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (12, 10, -2147483648, -2147483648, -2121944911, 1195320303, 1463445550, 'p', -1243923337, 786.644633, -1782325492, 'qrlawk', 558684943, -120625031, 572453185, 'tsmg9', 'aqz2o20pj', -2147483648);

INSERT INTO "results" ("resultid", "raceid", "driverid", "constructorid", "number", "grid", "position", "positiontext", "positionorder", "points", "laps", "time", "milliseconds", "fastestlap", "rank", "fastestlaptime", "fastestlapspeed", "statusid") VALUES (13, 7, -2147483648, -2147483648, 1907670428, 1265709623, 1731005516, 'i1pa', 1754053934, 781.008765, 1645850786, 'yqro', 917675957, -1582954378, -1143329124, 't63', 'xyfvmjwpp26', -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH time_in_seconds AS (SELECT T1.positionOrder, CASE WHEN T1.positionOrder = 1 THEN (CAST(SUBSTRING(T1.time, 1, 1) AS REAL) * 3600) + (CAST(SUBSTRING(T1.time, 3, 2) AS REAL) * 60) + CAST(SUBSTRING(T1.time, 6) AS REAL) ELSE CAST(SUBSTRING(T1.time, 2) AS REAL) END AS time_seconds FROM results AS T1 INNER JOIN races AS T2 ON T1.raceId = T2.raceId WHERE T2.name = 'Australian Grand Prix' AND NOT T1.time IS NULL AND T2.year = 2008), champion_time AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = 1), last_driver_incremental AS (SELECT time_seconds FROM time_in_seconds WHERE positionOrder = (SELECT MAX(positionOrder) FROM time_in_seconds)) SELECT (CAST((SELECT time_seconds FROM last_driver_incremental) AS REAL) * 100) / (SELECT time_seconds + (SELECT time_seconds FROM last_driver_incremental) FROM champion_time);

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (CAST((SUM(CASE WHEN rank = 50 THEN milliseconds ELSE 0 END) - SUM(CASE WHEN rank = 1 THEN milliseconds ELSE 0 END)) AS REAL) * 100) / SUM(CASE WHEN rank = 1 THEN milliseconds ELSE 0 END) FROM results WHERE raceId IN (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix');

/*
Prediction Result:
(None,)
*/