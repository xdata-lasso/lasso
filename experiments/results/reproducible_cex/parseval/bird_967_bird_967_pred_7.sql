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

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'uhv', 1526238907, 'tti', 'bnp', 'mdpos', '2021-06-28', 'Dutch', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483646, 'e5u', 1861536320, '6klfa9', '00t5c4e', 'cigce376nium', '2025-06-20', 'Dutch', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483645, 'zbuo4nrq', 418417917, 'fqyp', 's5bbp02e', 'tliqa1', '2024-10-14', 'Dutch', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483644, 'yytoo', 1644911394, '9hl7', 'klex14ji', '7zwau2dwyr', '2022-12-09', 'Dutch', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483643, '3pyu78d', -977635379, 'sl0', '4', 'p5qi2rk', '2021-01-15', 'Dutch', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, 'vqx58pz0f', 176555546, 'gd', '1vy9uxj4', 'wb', '2020-07-26', 'Dutch', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483641, 'lph2gn', 1968874827, 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'Dutch', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, 'gq8', -1255130038, '3d', 'qv0gcb98ozk', 'zbilyrkn', '2025-09-09', 'Dutch', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483649, 'ck6ah0', -1520489792, 'wlq7xb', '72fxa7ryfd', 'z16ni', '2021-09-12', 'ai5', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'h', 1583472758, 'rg', 'd8y', 't1afgog', '2023-02-19', 'tsj', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483637, 'ayxp1q43', 1235416111, 'jh3den8', 'c68x8vacx7', 'f', '2023-07-08', 'Dutch', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483636, 'w1of77pz', 87529806, 'ctdctmfg62g0', '5q8qdj', 'e1io', '2024-12-22', 'Dutch', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483635, '78507cvt', -1523347137, 'ttg6bnou5zi3', 'c4bfkfoac', '0', '2025-10-22', 'Dutch', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483651, '2zezjo7', 304189298, 'xd', 'ysxcmr0o', 'ztdgj5i3lq5l', '2022-06-10', 'im5k', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, '8qs27p2r', -95808609, 'h2mna', 'jla', 'okv8uttm', '2023-07-29', 'ne578lfv', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483650, 'yz7zzbe8yvk', 1043710187, '42q7sx58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', '2022-02-22', 'o705a9n0jxfo', 'url_17');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483631, 'ws', 1719800120, 'o', '2zobb0q0k32o', 'w', '2020-06-05', 'Dutch', 'url_18');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483630, '5am', -1177989415, 'wyn', 'gc1dj9erhi', 'zgk1yoeyo6l0', '2021-05-23', 'Dutch', 'url_19');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483629, 't', -795975227, 'xuzkb52', 'gwnlas6', 'elboeowii1', '2024-05-30', 'Dutch', 'url_20');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483653, 'nxih662q', 287256667, 'otow9oa', 'awg96aqb0tbi', 'ndz39tajz9', '2023-05-30', '8', 'url_21');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '5wcg', -794767771, 'c', '3tdu6bd0w960', 'vzxw1rxe', '2024-04-15', 'k7', 'url_22');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483652, 'k162n', -516345261, 'o', 'vu', '6dza35r', '2022-02-22', 'io1', 'url_23');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483625, 'ri2hy08ft', 2066302536, 'ewtqxxnja', 'bymzn2mfx7h3', 'p6sto1cj', '2023-04-07', 'Dutch', 'url_24');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483624, '5k', 1106724223, 'ys7dyyd1jmg', 'jach8qta8y3', '1', '2025-11-15', 'Dutch', 'url_25');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483623, 'v4ygmayq3qdp', -2082238979, '6rntdqrhm', 'wlic7dn2', 'p490', '2024-01-23', 'Dutch', 'url_26');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483634, 'm', 1996699977, 'tgelc', 'qb9i9f', 'ccukjq1q', '2023-07-12', 'k1y', 'url_27');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483632, 'hb08hlst1pq', 1980131681, 'iztv', '6', '4iz7', '2020-01-18', 'qlud8', 'url_28');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483633, 'tb', 192271618, '9114qbre6bj', 'uu', 'sj8kjh', '2025-06-18', 'pxlvri', 'url_29');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483619, 'surz0kaqtncg', 428944759, 's3b7v88kw', 'm', 'b', '2020-07-31', 'Dutch', 'url_30');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483618, 't6', 313797011, '7nxar50h', 'sjhanzxdpu', 'mwfw', '2024-03-09', 'Dutch', 'url_31');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483617, 'rlawk', 558684943, 'r5dqtsmg', '7aqz2o20p', '6dd', '2021-12-27', 'Dutch', 'url_32');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483656, 'su6iphd', 1849928338, '31vwq', '1oa2sb3u', 'i1pa', '2023-09-20', 'v', 'url_33');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483655, 'wnyqrouirlrp', 1026055008, 'it63xy', 'vm', 'wpp', '2024-12-07', 'mb3aj0ju0', 'url_34');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483654, '3r', -167036460, 'r1a', 'yyhpl2', '9es', '2020-02-25', '8pgc', 'url_35');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483613, 'qwt', 1339281953, '4o6qjektb1', '2', 'zg3r', '2021-08-23', 'Dutch', 'url_36');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483612, 'wns', 1125564712, 'ja8dccy3', 'vjwq49yrnx', '6dvdx', '2020-08-23', 'Dutch', 'url_37');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483611, '2v7t', 1770139230, 'gvplj9fjvu', 'n7k10z', '2my1ogyv1rg', '2020-09-18', 'Dutch', 'url_38');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483657, 'axc1clu', -1131290294, 'ly78oitxeilp', 'e019cy7od0', '3dlhdsvn', '2021-04-28', 'd2', 'url_39');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, '9lqv26u331s', -1125491025, 'pw30bgwkxgi', 'nlj6idmp61', '2o3', '2020-02-08', '162', 'url_40');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483638, 'cagj', 1361395061, 'vx', 'xlu49ku', 'o', '2020-09-29', 'cde4uekhl', 'url_41');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483607, 'lbwvdpu5v0e', -1920675616, 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', '2020-09-28', 'Dutch', 'url_42');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483606, '8xjhc', -1805244571, '6cfperxa61s', 'v8n', '3ddrok', '2023-08-31', 'Dutch', 'url_43');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483605, 'zc', -831032281, 'hia3cmvb7v', 'pc0xffwor1e', 'ksf9q', '2025-01-18', 'Dutch', 'url_44');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483659, 'g01hu', -1585280787, '7f8kqhiu5g', '8gxb', 'qjlsawsp', '2025-05-07', 'wi3', 'url_45');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483610, 'l7', -1480511510, 'y795ybv8', 'kr3w4jn2', '19xgjja', '2020-06-13', 'gmukfb5if4', 'url_46');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483658, '80terbf', 1176294340, 'vee', 'sltut6lu2', 'cel8mhfcim', '2022-04-20', 'enii0fmb', 'url_47');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T1.nationality FROM drivers AS T1 ORDER BY JULIANDAY(T1.dob) DESC, T1.driverid NULLS LAST LIMIT 3) AS T3 WHERE T3.nationality = 'Dutch';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT d.code, SUM(CASE WHEN d.nationality = 'Dutch' THEN 1 ELSE 0 END) AS DutchCount FROM drivers AS d ORDER BY d.dob ASC, d.driverid NULLS LAST LIMIT 3;

/*
Prediction Result:
('7f8kqhiu5g', 27)
*/