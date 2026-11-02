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

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-1, 2008, 1836127587, 1, 'f8jegd2', '2024-11-12', 'y9uxj4', 'url_3');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (0, 2008, 1686459626, -2147483648, 'lyr', '2021-11-28', 'n6vck6ah0f', 'url_4');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (4, 2008, -639539893, -2147483648, '7xb72', '2020-11-23', 'a7ryfd', 'url_5');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (2, 2008, 453836040, -2147483648, '6b', '2022-06-10', 'u5zi', 'url_6');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483642, 2008, -1212676731, -2147483648, 'm5k', '2025-07-11', 'qs27p2r94', 'url_7');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (3, 2008, -244633520, -2147483648, 'ajjl', '2020-02-18', 'okv8uttm', 'url_8');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483640, 2008, 2061558815, 1, '5amsorlwyngc', '2024-10-05', 'j', 'url_9');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (5, 2008, -413043724, -2147483648, 'k1yoeyo6l0h', '2020-07-14', '6fuqy', 'url_10');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483638, 2008, 1071401016, 1, 'w9603vz', '2024-03-11', '1rxe9y', 'url_11');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (6, 2008, 1968783602, -2147483648, 'qk162nh55', '2024-04-04', 'dohvu06d', 'url_12');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483636, 2008, -499203870, 1, 'qdpuap96', '2023-02-13', 'tdqr', 'url_13');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (7, 2008, -1324935647, -2147483648, 'wlic7dn2np', '2025-05-21', '0xdmsqtge', 'url_14');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483634, 2008, -609840352, -2147483648, 'lvrisu', '2023-02-07', '0kaqtnc', 'url_15');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (8, 2008, 428944759, -2147483648, 's3b7v88kw', '2020-07-18', 'dbdh', 'url_16');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483632, 2008, 1754053934, 1, 'v', '2023-11-10', 'yqro', 'url_17');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (9, 1, -1582954378, -2147483648, 'rpo', '2023-07-07', 't63', 'url_18');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483630, 2008, -526608193, 1, 'vjwq49yrnx', '2023-04-20', '6dvdxdo2v7', 'url_19');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (10, 1, 1770139230, -2147483648, 'gvplj9fjvu', '2023-08-07', '7k10', 'url_20');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483628, 2008, 1069076646, -2147483648, 'ak162oca', '2021-02-09', 'eev', 'url_21');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (11, 1, -410809407, -2147483648, 'u49', '2021-10-18', 'boe8cd', 'url_22');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (-2147483626, 2008, -958249959, 1, 'uez', '2020-06-24', 'ehia3', 'url_23');

INSERT INTO "races" ("raceid", "year", "round", "circuitid", "name", "date", "time", "url") VALUES (12, 2008, 806158445, -2147483648, 'vb7vpc0xff', '2023-12-12', 'r1es', 'url_24');

-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, 'tilbn', 462974032, 'posiie5unw6k', 't2__3e850c', 't2__f03574', '2021-12-14', 'a9', 'C');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, '00t5c4e', 1274489983, 'gce', 't2__3e850c', 't2__f03574', '2025-03-28', '6nium52zb', 'A');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'wb', -1929953647, 'ph2', 'nd', 'wnqcx', '2025-07-02', 'hncprjtu0dz', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, '6c4bfkfo', -1950324754, '7z2zezj', '7wgx', '5', '2024-03-25', 'xcmr0', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '2ne578', 1908593332, 'vy', '7zzbe8y', 'kv42q7', '2023-03-03', '58b4pm', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'uzkb52', -277407746, 'nlas6e', 'lboeowii1z5', 'xih6', '2025-08-17', 'q2xlyoto', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, 'a35rmki', -1160642134, 'ri2hy08ft', '6ewt', 'xxnja', '2020-03-05', 'mzn2mfx', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, 'cuq', -1750715330, 'ccukjq1qui', '1yh', '0', '2021-03-28', 'st1', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (8, '6j47n', -556370776, '50hsj', 'an', 'xdpunmw', '2020-12-14', 'xqrlaw', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (9, 'xyfvmjwpp26', 1913338832, '3', 'j', '0ju0h3r133ir', '2024-11-25', 'x', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (10, 'z2my1ogyv1r', -1712532464, 'axc1clu', 'gly7', '8oitxeilpe0', '2024-10-18', 'cy7od033d', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (11, '4u', 426006253, 'll', 'w', 'dpu5v0', '2020-10-14', 'u', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (12, 'sf9', 1494789426, 'g01hu', 'j7f', '8kqhiu5gm8', '2021-02-03', 'b5qjls', 'url_13');

-- Inserting into table: constructors --
INSERT INTO "constructors" ("constructorid", "constructorref", "name", "nationality", "url") VALUES (-2147483648, '9hl7', 'name_1', 'klex14ji', '7zwau2dwyr');

-- Inserting into table: circuits --
INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (1, '5k5swwqcgs', 'Marina Bay Street Circuit', '9n8', '4', 249.706432, 99.523333, -734455130, 'url_1');

INSERT INTO "circuits" ("circuitid", "circuitref", "name", "location", "country", "lat", "lng", "alt", "url") VALUES (-2147483648, '4h', 'Marina Bay Street Circuit', 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'url_2');

-- Inserting into table: seasons --
INSERT INTO "seasons" ("year", "url") VALUES (2008, 'url_1');

INSERT INTO "seasons" ("year", "url") VALUES (1, 'url_2');

-- Inserting into table: qualifying --
INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (1, 1, 1, -2147483648, -1021749117, 392822403, 'yu78', '9', 't1__cfa3cc');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483648, 1, 1, -2147483648, -1362461264, -904834265, 'b4yp5qi', 'rkf9vqx5', 't1__3ff43a');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (0, -1, 4, -2147483648, -1485777725, -1255130038, '3d', 'qv0gcb98ozk', 't1__cfa3cc');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-1, 0, 4, -2147483648, -2115841792, 1746373317, 'h', 'ogrgjd8y', 't1__cfa3cc');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (2, 1, 1, -2147483648, -1478134144, -491938169, '1q43', '1jh3den', 't1__cfa3cc');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (3, 1, 1, -2147483648, -683007527, 2035306060, 'x7afu5w1of77', 'zo72', 't1__3ff43a');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (4, 2, 2, -2147483648, 853709925, -870767087, 'j5', '3lq', NULL);

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (5, 3, 3, -2147483648, -929383517, -2090240067, 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483640, -2147483648, 4, -2147483648, 1719800120, -210159774, 'obb0q0k32o', 'w', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (6, 5, 5, -2147483648, 205676091, -2094843966, '96', 'aqb0tbindz39', 'ajz9t');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483638, 1, 3, -2147483648, -625404808, -1694533100, 'bc3t', 'u', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (7, 6, 6, -2147483648, -156175571, 1220047834, '6sto1cj8sh5k', 'zys7', 'y');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483636, -2147483638, 6, -2147483648, -1923069176, -1520090613, 'gjach8qta8y', 'a17v4ygm', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (8, 7, 7, -2147483648, -1333785554, 1784997708, 'tvb6m4iz78', 'q', 'lud8f');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483634, 6, 3, -2147483648, 192271618, -312228770, 'qbre6bje', 'uuwsj8kjh8', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (9, 8, 8, -2147483648, 558684943, -120625031, 'dqtsmg97', 'aqz2o20pj6d', 'dlysu6iphd');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483632, 2, 5, -2147483648, 1154884242, 1352531282, 'vwq51oa', 'sb3uoi1p', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (10, 9, 9, -2147483648, 1498496406, 370054768, 'i9esap8p', 'gckqwtsr54', '6qje');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483630, 2, 3, -2147483648, 328574939, 1464469520, 'nzg3rjkw', 'ns47j2ja8dc', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (11, 10, 10, -2147483648, 935816178, -1919535047, 'nhed29', 'qv2', 'u331spxpw');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483628, -2147483634, 6, -2147483648, -1725714389, -1248881581, '6id', 'p61l', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (12, 11, 11, -2147483648, 824044840, -214587907, '29835xo', 'pa', 'cxdb2f0c296x');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483626, 4, 6, -2147483648, 1177967285, -2001463367, '6cfperxa', '1sjv8nv3d', 't1__21ae39');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (13, 12, 12, -2147483648, -924570154, -99415515, 'i3hl7j', '3y795ybv', '3kr3w4jn2');

INSERT INTO "qualifying" ("qualifyid", "raceid", "driverid", "constructorid", "number", "position", "q1", "q2", "q3") VALUES (-2147483624, -2147483636, 6, -2147483648, -1693332814, 319828561, 'c', 'gmukfb5if4', 't1__21ae39');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.forename, T2.surname FROM qualifying AS T1 INNER JOIN drivers AS T2 ON T1.driverId = T2.driverId INNER JOIN races AS T3 ON T1.raceid = T3.raceid WHERE NOT q3 IS NULL AND T3.year = 2008 AND T3.circuitId IN (SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit') ORDER BY CAST(SUBSTRING(q3, 1, INSTR(q3, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTRING(q3, INSTR(q3, ':') + 1, INSTR(q3, '.') - INSTR(q3, ':') - 1) AS REAL) + CAST(SUBSTRING(q3, INSTR(q3, '.') + 1) AS REAL) / 1000 ASC, T1.qualifyid NULLS LAST, T2.driverid NULLS LAST, T3.raceid NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__3e850c', 't2__f03574')
*/

-- Prediction Query
SELECT d.forename, d.surname FROM qualifying AS q INNER JOIN races AS r ON q.raceId = r.raceId INNER JOIN circuits AS c ON r.circuitId = c.circuitId INNER JOIN drivers AS d ON q.driverId = d.driverId WHERE r.year = 2008 AND c.name = 'Marina Bay Street Circuit' AND q.position = 1;

/*
Prediction Result:
*/