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

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2008, 1774087382, -2147483648, 'c', '2024-02-23', 'afu5w1of7', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2008, -1250380401, -2147483648, 's', '2025-09-16', 'elboeowii1', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 1, -1943814113, -2147483648, '9603vz', '2024-03-11', '1rxe9y', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483643, 2008, 1968783602, 1, 'qk162nh55', '2024-04-04', 'dohvu06d', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2008, -845136979, -2147483648, 'rhm5w', '2022-01-12', 'c7d', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483641, 2008, 833568923, 1, '90xdmsqt', '2021-03-16', 'lc', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 1, 2042428747, -2147483648, 'z0kaq', '2023-06-21', 'ncgc8s3b7v', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483639, 2008, -622923312, 1, 'dbdh', '2023-05-27', 'j47nxar50', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2008, 1754053934, -2147483648, 'v', '2023-11-10', 'yqro', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483637, 2008, -1582954378, -2147483648, 'rpo', '2023-07-07', 't63', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2008, 946571403, -2147483648, '3r', '2021-08-23', 'wns', 'url_13');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483635, 2008, -1522433566, -2147483648, 'a8d', '2020-06-17', 'y', 'url_14');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 2008, -1832294694, -2147483648, '9lqv26u3', '2025-03-01', 'spxpw30', 'url_15');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483633, 2008, -1725714389, 1, 'xgi', '2022-05-06', 'j6i', 'url_16');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 2008, 2011754567, -2147483648, 'et8xjhcf46c', '2021-01-04', 'perxa61sjv', 'url_17');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483631, 2008, -137586537, 1, 'r', '2022-06-23', 'uez', 'url_18');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 2008, -1725535379, -2147483648, 'kfb5if', '2025-05-24', '80terbf', 'url_19');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483629, 2008, -1429883874, 1, 'e6', '2023-04-23', 'tut', 'url_20');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 2008, 1022316699, -2147483648, 'plw', '2023-06-11', 'lzh42nyj5yrj', 'url_21');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483627, 2008, 1357426337, 1, 'qkna', '2025-02-23', '8gfxswb2d0zm', 'url_22');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'tilbn', 462974032, 'posiie5unw6k', 't2__2650d6', 't2__0fd332', '2021-12-14', 'a9', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, '00t5c4e', 1274489983, 'gce', 't2__2650d6', 't2__0fd332', '2025-03-28', '6nium52zb', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'rljsl0b4y', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', '2021-09-16', 'hwbdvlph', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'u0dz7', 401805964, 'gq8', 't2__2650d6', 't2__0fd332', '2022-05-01', 'f3dqv0gc', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '9', 172461907, 'k3zbily', 'kn6vc', '6ah', '2024-09-12', '8j', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 't1afgog', -946046410, 'tsj3ayxp1q4', 't2__2650d6', 't2__0fd332', '2025-02-15', '1jh3den', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'mfg62g0v5q8q', -1488156735, '1i', '2278', '07cvtjpt', '2023-05-24', '6b', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, '5nxih66', -251205568, 'xlyotow9', 'aawg', '6aqb0tbin', '2020-08-26', '39tajz9', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'a35rmki', -1160642134, 'ri2hy08ft', '6ewt', 'xxnja', '2020-03-05', 'mzn2mfx', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'qb9i9f', -788896327, 'q1q', 'ik1yhb', '8hlst1p', '2022-10-24', 'mizt', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, 'sj', -1652411404, 'zxdp', 'nmwfwx', 'rlawk', '2024-09-05', '14r5dqtsmg97', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'xyfvmjwpp26', 1913338832, '3', 'j', '0ju0h3r133ir', '2024-11-25', 'x', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'vjwq49yr', 1014871129, 'xs6dvdxdo2', '7t3gvp', 'j9f', '2021-08-21', 'uun7k1', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (11, 'dmp61l2o3ak1', 1562909425, 'cagj', 'ev', 'zxlu49', '2021-10-18', 'boe8cd', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (12, 'ctehia3cmvb', -1077762203, 'xffwor1', 'sk', 'f9q82', '2022-11-14', '01', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (13, '6lu2cel8mh', -1957884289, 'n5en', 'i0f', 'bgz5', '2022-07-25', 'xs27x', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (14, 'wdb7ot', 619382464, '5qo1k4c6gwn', 'kd4kc3iikaxz', '90nhs', '2022-09-29', 'gobb6nrn5', 'url_17');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '9hl7', 'name_1', 'klex14ji', '7zwau2dwyr');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', 'Marina Bay Street Circuit', '9n8', '4', 249.706432, 99.523333, -734455130, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '4h', 'Marina Bay Street Circuit', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'url_2');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: qualifying --
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1, 1, 2, -2147483648, -1021749117, 392822403, 'yu78', '9', 't1__9a7b66');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483648, 1, 3, -2147483648, 1298861365, 1968874827, 'nqcx5h', 'cprj', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-1, 1, 4, -2147483648, -658391922, -1388029300, 'xb72fxa7r', 'fdrz16n', 't1__9a7b66');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (0, 1, 0, -2147483648, 2011234363, -1483100200, '5dh', 'ogrgjd8y', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483644, 1, 1, -2147483648, -1173368267, 382831862, '0', '7z2zezjo7wg', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483643, 1, 1, -2147483648, 1999335832, -526612570, 'cmr0oz', 'dgj5i', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483642, 1, 1, -2147483648, -15162884, 1339733032, 'im5k', '8qs27p2r', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483641, 1, 1, -2147483648, -244633520, 418247369, 'jla', 'okv8uttm', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483640, 1, 1, -2147483648, -1252009958, 1908593332, 'vy', '7zzbe8y', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483639, 1, 1, -2147483648, 1043710187, 318331233, 'q7sx58b4', 'pmaus3auvmkr', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483638, 1, 1, -2147483648, -609553675, 989018473, 'chn9mo70', 'a9n0jxfo', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483637, 1, 1, -2147483648, -441521858, 2015094998, '2zobb0q0k32o', 'w', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483636, 1, 1, -2147483648, 895277769, 364043263, 'sorlwyngc1', 'j', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483635, 1, 1, -2147483648, 1935791961, 595714424, 'zgk1yoeyo6l0', 'dt', 't1__70887b');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2, 2, 5, -2147483648, 748154000, 1148916014, 'g', 'mbc3td', NULL);

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483633, 3, -2147483648, -2147483648, -891525031, -1154091048, 'j', 'sh5knzys7', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3, 3, 6, -2147483648, 1328948152, -1923069176, 'jmgjach8qt', 'a8y3a17v4yg', 'mayq3qdpua');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483631, -2147483643, 2, -2147483648, -74691962, -2128972904, 'lud8f', 'tb8r9114qbre', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4, 5, 7, -2147483648, -1537647691, 364280973, 'wsj8kj', '85', 'pxlvri');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483629, 1, 4, -2147483648, -225571092, -261782899, 'pj6ddlysu6ip', 'dk', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (5, 6, 8, -2147483648, 334376591, 1154884242, 'r31', 'wq51oa', 'sb3uoi1p');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483627, 5, 1, -2147483648, 370054768, -1837449583, 'p', 'pgckqwtsr', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (6, 7, 9, -2147483648, -69263912, 17776256, 'ekt', '1', '2');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483625, 5, 8, -2147483648, 629588446, 973615628, '1ogyv1rgezax', '1', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (7, 8, 10, -2147483648, -754769711, 1128553504, 'xeilp', 'e019cy7od0', '3dlhdsvn');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483623, 4, 11, -2147483648, -775706063, -1417040770, 'llbwvdpu5v0e', 'u', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (8, 9, 11, -2147483648, 824044840, -214587907, '29835xo', 'pa', 'cxdb2f0c296x');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483621, 2, -1, -2147483648, 184502432, 1387373331, 'hiu5gm8gxb5', 'qjlsawsp4kw', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (9, 10, 12, -2147483648, -150306637, -1480511510, 'y795ybv8', 'kr3w4jn2', '19xgjja');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483619, 2, 10, -2147483648, -30240851, -887179029, '9ls1ehn1', 'daqq', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (10, 11, 13, -2147483648, -514593578, -1224799639, '4hmnnw4m0', 'rwbjk', 'bph6gdw');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483617, 7, 4, -2147483648, -1621175100, -2074051940, 'a', 'vhvyx8s', 't1__c66b5d');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (11, 12, 14, -2147483648, -972469277, -1763520124, 'qn0b5m2r', 'xcr', 'fx03rz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('vqx58pz0f', '8jegd21vy9ux')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM qualifying AS q JOIN races AS r ON q.raceId = r.raceId JOIN circuits AS c ON r.circuitId = c.circuitId JOIN drivers AS d ON q.driverId = d.driverId WHERE q.q3 = (SELECT MIN(q3) FROM qualifying WHERE raceId = r.raceId) AND r.year = 2008 AND c.name = 'Marina Bay Street Circuit';

/*
Prediction Result:
('vqx58pz0f', '8jegd21vy9ux')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('2278', '07cvtjpt')
('t2__2650d6', 't2__0fd332')
('ev', 'zxlu49')
('t2__2650d6', 't2__0fd332')
('7t3gvp', 'j9f')
('t2__2650d6', 't2__0fd332')
('ik1yhb', '8hlst1p')
('j', '0ju0h3r133ir')
('7t3gvp', 'j9f')
('ev', 'zxlu49')
('sk', 'f9q82')
('i0f', 'bgz5')
('kd4kc3iikaxz', '90nhs')
*/