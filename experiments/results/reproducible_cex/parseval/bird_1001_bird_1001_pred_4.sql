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
INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (1, 2008, 757448742, 1, '4nrq', '2023-01-30', 'fqyp', 'url_1');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483648, 2008, -921187550, 1, 'bbp02eutliqa', '2024-10-16', 'ryytoo3', 'url_2');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2008, 1250290042, -2147483648, 'og', '2023-02-19', 'tsj', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 1, 450555855, 1, '1gwnlas6', '2020-09-24', 'lboeowii1z5', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1, -1943814113, -2147483648, '9603vz', '2024-03-11', '1rxe9y', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483643, 2008, 1968783602, 1, 'qk162nh55', '2024-04-04', 'dohvu06d', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 1, -493230039, -2147483648, 'mayq3qdpua', '2022-08-30', '6rntdqrhm', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483641, 2008, -648564084, -2147483648, 'c7d', '2022-04-25', 'np490xdm', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1, -1101814296, -2147483648, 'lvrisurz0k', '2020-02-06', 'qtncgc8s3b7', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483639, 2008, 180947503, -2147483648, 'dmdbdh', '2023-05-27', 'j47nxar50', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2008, 1754053934, -2147483648, 'v', '2023-11-10', 'yqro', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483637, 2008, -1582954378, -2147483648, 'rpo', '2023-07-07', 't63', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2008, -1971104604, -2147483648, '3vjwq49', '2024-04-04', 'nxs6d', 'url_13');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483635, 2008, 294818731, -2147483648, 'do2v7t', '2025-02-11', 'gvplj9fjvu', 'url_14');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 2008, -306339789, -2147483648, 'o3ak162o', '2020-07-03', 'g', 'url_15');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483633, 2008, 1361395061, 1, 'vx', '2024-07-14', 'lu49ku', 'url_16');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 2008, -958249959, -2147483648, 'uez', '2020-06-24', 'ehia3', 'url_17');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483631, 2008, 806158445, 1, 'vb7vpc0xff', '2023-12-12', 'r1es', 'url_18');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 1, 1085074663, -2147483648, 'rb', '2020-12-12', 'kvee', 'url_19');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483629, 2008, -1371170489, -2147483648, 't6lu2c', '2020-09-16', 'l8mhfcimn5e', 'url_20');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 2008, -1940885010, -2147483648, '7', '2021-09-19', 'plw', 'url_21');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483627, 2008, -1369846060, -2147483648, '42', '2022-05-13', 'j5yrji5', 'url_22');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'tilbn', 462974032, 'posiie5unw6k', 't2__8b6cca', 't2__3e3577', '2021-12-14', 'a9', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, '00t5c4e', 1274489983, 'gce', 't2__8b6cca', 't2__3e3577', '2025-03-28', '6nium52zb', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'rljsl0b4y', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', '2021-09-16', 'hwbdvlph', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'u0dz7', 401805964, 'gq8', 't2__8b6cca', 't2__3e3577', '2022-05-01', 'f3dqv0gc', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '9', 172461907, 'k3zbily', 'kn6vc', '6ah', '2024-09-12', '8j', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '16nijjai5dh', 1583472758, 'rg', 't2__8b6cca', 't2__3e3577', '2021-09-30', '8', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 'j', -1139855872, 'io22785', 't2__8b6cca', 't2__3e3577', '2024-08-05', '7cvtjpttg6b', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'xih6', -251205568, 'xlyotow9', 'aawg', '6aqb0tbin', '2020-08-26', '39tajz9', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'a35rmki', -1160642134, 'ri2hy08ft', '6ewt', 'xxnja', '2020-03-05', 'mzn2mfx', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'sqtgelcuqb', 1374676344, 'f2ccukjq1', 'uik1y', 'hb08hlst1pq', '2022-07-23', 'iztv', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'sj', -1652411404, 'zxdp', 'nmwfwx', 'rlawk', '2024-09-05', '14r5dqtsmg97', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'xyfvmjwpp26', 1913338832, '3', 'j', '0ju0h3r133ir', '2024-11-25', 'x', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'n7k10z', 629588446, 'y1og', 'v1rgeza', 'xc1clupgly', '2025-11-25', '8oitxeilpe0', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (11, 'o', 833662145, 'e', 'uekhllbw', 'dpu5v0', '2020-10-14', 'u', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (12, 'sf9', 1494789426, 'g01hu', 'j7f', '8kqhiu5gm8', '2021-02-03', 'b5qjls', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (13, 'ii0f', -2013600868, '5oqxs27', 'h888y1', '253', '2023-04-16', '5', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (14, 'qkna', -1725694639, 'xswb2d0zmxwd', '7', 'tp5q', '2022-08-11', 'k4c6gwn', 'url_17');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '9hl7', 'name_1', 'klex14ji', '7zwau2dwyr');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', 'Marina Bay Street Circuit', '9n8', '4', 249.706432, 99.523333, -734455130, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '4h', 'Marina Bay Street Circuit', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'url_2');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: qualifying --
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1, 1, 2, -2147483648, -1021749117, 392822403, 'yu78', '9', 't1__876535');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483648, 1, 3, -2147483648, 1298861365, 1968874827, 'nqcx5h', 'cprj', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483646, 1, 0, -2147483648, -639539893, 1255343543, '7', '2fxa7ryfdrz', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483645, 1, 1, -2147483648, 2111987706, -598313376, 'q4301jh', 'den8c68x', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483644, 1, 0, -2147483648, 2035306060, 1523825314, 'u5', '1of77p', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483643, 1, 1, -2147483648, 1992637800, -820614248, 't', 'mfg62g0v5q8q', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483642, 1, -1, -2147483648, 944975670, -1575410149, 'c4bfkfoac', '0', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483641, 1, 1, -2147483648, -461418236, -468701684, '7wgx', '5', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483640, 1, -1, -2147483648, -546516406, -405743609, 'g', '5i3', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483639, 1, 1, -2147483648, 1816660482, -1212676731, 'm5k', '8qs27p2r', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483638, 1, 0, -2147483648, -244633520, 418247369, 'jla', 'okv8uttm', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483637, 1, 1, -2147483648, -1252009958, 1908593332, 'vy', '7zzbe8y', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3, 1, 1, -2147483648, 1043710187, 318331233, 'q7sx58b4', 'pmaus3auvmkr', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483635, 1, 1, -2147483648, -1165594842, -634585028, 'do2zobb', 'q0k32od', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483634, 1, 1, -2147483648, 2061558815, 895277769, 'amsorlwyng', '1', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483633, 1, 1, -2147483648, 211603887, -413043724, 'k1yoeyo6l0h', 't', 't1__309962');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2, 2, 5, -2147483648, 748154000, 1148916014, 'g', 'mbc3td', NULL);

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4, 3, 6, -2147483648, -156175571, 1220047834, '6sto1cj8sh5k', 'zys7', 'y');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483630, -2147483643, -1, -2147483648, 357443379, -1502591405, 'h', 'qta8y3a17', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (5, 5, 7, -2147483648, 44959255, -74691962, '78aqqlu', '8', 'tb');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483628, 3, 6, -2147483648, -1057355067, -1004098188, '6bjeuuwsj8k', 'h85', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (6, 6, 8, -2147483648, -1019350771, -225571092, '0pj6ddly', 'u6iph', 'k');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483626, -2147483643, 7, -2147483648, 1154884242, 1352531282, 'vwq51oa', 'sb3uoi1p', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (7, 7, 9, -2147483648, 1498496406, 370054768, 'i9esap8p', 'gckqwtsr54', '6qje');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483624, -2147483637, 3, -2147483648, -1892701926, -460035045, '3rjkwns47j2j', '8', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (8, 8, 10, -2147483648, 227939734, -1164657946, '033dlhdsvnh', 'd2', '9lqv26u331s');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483622, 2, 1, -2147483648, -660620878, -349181074, 'wk', 'xginlj6idm', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (9, 9, 11, -2147483648, 824044840, -214587907, '29835xo', 'pa', 'cxdb2f0c296x');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483620, 3, -1, -2147483648, 1177967285, -2001463367, '6cfperxa', '1sjv8nv3d', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (10, 10, 12, -2147483648, -924570154, -99415515, 'i3hl7j', '3y795ybv', '3kr3w4jn2');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483618, 8, 12, -2147483648, 643485636, -1693332814, 'jacgmukfb5', 'f41', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (11, 11, 13, -2147483648, -1642107656, 888725581, 'qhyyz', 'np64h', 'nnw4');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483616, 11, -1, -2147483648, -973411766, 668449456, 'j', '0bp', 't1__94ce3d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (12, 12, 14, -2147483648, -1984500518, 872275367, 'kax', 'r90nhsp', 'gobb6nrn5');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483614, 7, 4, -2147483648, -1621175100, -2074051940, 'a', 'vhvyx8s', 't1__94ce3d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('vqx58pz0f', '8jegd21vy9ux')
*/

-- Prediction Query
SELECT T1.forename, T1.surname FROM drivers AS T1 INNER JOIN qualifying AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T2.raceId = T3.raceId WHERE T2.position = 1 AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit');

/*
Prediction Result:
*/