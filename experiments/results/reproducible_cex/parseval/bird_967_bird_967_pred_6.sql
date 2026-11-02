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
-- Inserting into table: drivers --
INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', '2025-08-22', 'Dutch', 'url_1');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, 'uhv', 1526238907, 'tti', 'bnp', 'mdpos', '2021-06-28', 'Dutch', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'e5u', 1861536320, '6klfa9', '00t5c4e', 'cigce376nium', '2025-06-20', 'Dutch', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483645, 'zbuo4nrq', 418417917, 'fqyp', 's5bbp02e', 'tliqa1', '2024-10-14', 'Dutch', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483644, 'yytoo', 1644911394, '9hl7', 'klex14ji', '7zwau2dwyr', '2022-12-09', 'Dutch', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, '3pyu78d', -977635379, 'sl0', '4', 'p5qi2rk', '2021-01-15', 'Dutch', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483643, 'vqx58pz0f', 176555546, 'gd', '1vy9uxj4', 'wb', '2020-07-26', 'Dutch', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483641, 'lph2gn', 1968874827, 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'Dutch', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, 'gq8', -1255130038, '3d', 'qv0gcb98ozk', 'zbilyrkn', '2025-09-09', 'Dutch', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, 'ck6ah0', -1520489792, 'wlq7xb', '72fxa7ryfd', 'z16ni', '2021-09-12', 'Dutch', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483650, 'ai5', 1360271423, 'ogrgjd8y', 't1afgog', 'itsj3', '2020-03-04', 'xp1q430', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483649, 'jh3den8', 195720193, 'vacx7afu5', '1of77p', 'o72ctdc', '2023-06-03', 'mfg62g0v5q8q', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'j', -1139855872, 'io22785', '7cvtjpt', 'tg6bnou5zi', '2025-03-18', 'c4bfkfoac', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483635, '0', 76987628, 'zezjo7wg', 'd5ysxc', 'r0oz', '2023-05-02', 'Dutch', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483634, 'g', -20116244, 'lq5lnpim', 'k58qs27p', 'r94gth2m', '2022-05-15', 'Dutch', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483633, 'ajjla3okv8u', 618058035, '2ne578', 'fvy', '7zzbe8y', '2023-10-06', 'Dutch', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483653, 'v42', -2060082151, 'pmaus3auvmkr', 'pdjwzw5chn9', 'o705', '2020-01-18', '9n0jxfofwsz', 'url_17');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483651, 'o', 1010672881, 'obb0q0k', '2odwcl5a', 'msorlwyngc', '2024-10-05', 'j', 'url_18');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483652, '9erhizgk1yoe', 1483450542, 'o6l0hdt6fu', 'yxuzk', '5', '2025-01-25', 'gwnlas6', 'url_19');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483629, 'elboeowii1', -457369423, 'xih6', '2q2xlyoto', '9oaawg', '2025-10-12', 'Dutch', 'url_20');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483628, 'aqb0tbindz39', 2085299664, 'j', '9td8n5w', 'g', '2023-07-14', 'Dutch', 'url_21');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483627, 'bc3t', 1378873397, 'u6bd0w9603', 'vzxw1rxe9y', 'k7', '2022-11-15', 'Dutch', 'url_22');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483646, '162', -1231488097, '55y3dohvu06d', 'a35rmki', '18ri', '2025-01-15', 'y0', 'url_23');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483636, '8ftp6ewtqx', 2013745856, 'b', 'mzn2mfx', 'h33p6sto1', '2020-06-16', '8sh', 'url_24');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483637, 'knzys7dy', -531932574, 'jmgjach', 'qta8y3a17', 'v4ygmayq3qdp', '2023-07-13', 'p', 'url_25');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483623, '6rntdqrhm', 555368535, 'ic7', 'dn2np490xdm', 'sqtgelcuqb', '2021-07-17', 'Dutch', 'url_26');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483622, 'f2ccukjq1', 1584429327, 'k1y', 'hb08hlst1pq', 'mizt', '2023-10-15', 'Dutch', 'url_27');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483621, '6', -1304516770, 'z78', 'q', 'lud8f', '2023-06-04', 'Dutch', 'url_28');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483654, '8', 1183069552, '4qbre6b', 'jeuuwsj8kj', '85', '2024-01-06', 'xlvr', 'url_29');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483625, 'sur', -459075802, 'aqt', 'ncgc8s3b7v', '88kwdmdbdht6', '2021-08-26', '7nxar50h', 'url_30');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483626, 'sjhanzxdpu', 2014610660, 'wfwx', 'rlawk', '14r5dqt', '2023-03-24', 'g97a', 'url_31');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483617, 'z2o20', -1079009577, 'ddlysu6ip', 'dk', 'u2gir31vwq5', '2024-10-28', 'Dutch', 'url_32');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483616, 'a2sb', 1731005516, 'i1pa', 'cvwnyq', 'ouirl', '2023-01-21', 'Dutch', 'url_33');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483615, 'pouit63xyf', 1394459557, 'jwpp', '6mb3aj0j', '0h3r13', '2025-03-13', 'Dutch', 'url_34');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483618, 'r1a', -569461411, 'hpl2i9e', 'ap8pg', 'k', '2022-11-10', 'tsr54o', 'url_35');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'qjektb1d2', -460035045, '3rjkwns47j2j', '8', 'c', '2020-07-02', '3vjwq49', 'url_36');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483612, 'yrnxs6dvdx', -1900450199, 'v7t3gvpl', '9fj', 'uun7k1', '2024-08-13', 'Dutch', 'url_37');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483611, 'z2my1ogyv1r', -1712532464, 'axc1clu', 'gly7', '8oitxeilpe0', '2024-10-18', 'Dutch', 'url_38');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483610, 'cy7od033d', -1665891229, 'vnhed', '9lqv26u3', '1spxpw30', '2020-04-01', 'Dutch', 'url_39');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, 'wk', 1659285381, 'in', 'j6i', 'dmp61l2o3ak1', '2025-09-15', 'ocagjeev', 'url_40');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'zxlu49', -1459357985, 'o', '8c', 'e', '2025-05-14', 'ekhllb', 'url_41');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483607, 'vdpu5v', -400879450, 'u', 'y9v2z12983', '5xoepacxdb2f', '2024-09-15', 'Dutch', 'url_42');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483606, '2', 8608094, 'yet', 'xjhcf46cf', 'perxa61sjv', '2022-04-20', 'Dutch', 'url_43');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483605, '3ddrok', -744133723, 'ctehia3', 'm', 'vb7vpc0xff', '2023-12-12', 'Dutch', 'url_44');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483609, 'r1es', 2056318381, 'f9q82', 'g01hu', 'j7f', '2021-10-06', 'hiu5g', 'url_45');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483608, '8gxb', 854201197, 'lsa', 'sp4kwi', 'hl7j43y7', '2025-06-22', 'bv83kr3', 'url_46');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483602, 'w4jn2z19xgj', 319828561, 'c', 'gmukfb5if4', '80terbf', '2022-08-11', 'Dutch', 'url_47');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T1.nationality FROM drivers AS T1 ORDER BY JULIANDAY(T1.dob) DESC, T1.driverid NULLS LAST LIMIT 3) AS T3 WHERE T3.nationality = 'Dutch';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT code, COUNT(CASE WHEN nationality = 'Netherlands' THEN 1 ELSE NULL END) AS netherlands_count FROM (SELECT code, nationality FROM drivers ORDER BY dob DESC, drivers.driverid NULLS LAST LIMIT 3) GROUP BY code;

/*
Prediction Result:
('3d', 0)
('in', 0)
('xih6', 0)
*/