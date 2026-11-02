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

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'e5u', 1861536320, '6klfa9', '00t5c4e', 'cigce376nium', '2025-06-20', 'Dutch', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483645, 'zbuo4nrq', 418417917, 'fqyp', 's5bbp02e', 'tliqa1', '2024-10-14', 'Dutch', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483644, 'yytoo', 1644911394, '9hl7', 'klex14ji', '7zwau2dwyr', '2022-12-09', 'Dutch', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483643, '3pyu78d', -977635379, 'sl0', '4', 'p5qi2rk', '2021-01-15', 'Dutch', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, 'vqx58pz0f', 176555546, 'gd', '1vy9uxj4', 'wb', '2020-07-26', 'Dutch', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483641, 'lph2gn', 1968874827, 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'Dutch', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'gq8', -1255130038, '3d', 'qv0gcb98ozk', 'zbilyrkn', '2025-09-09', 'ck6ah0', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483646, '8j', -932772113, 'lq7xb7', '2fxa7ryfdrz', '16nijjai5dh', '2025-06-24', 'grgj', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, '8', -458359144, '1afgogritsj', 'ayxp1q43', '1jh3den', '2020-07-09', '68x8vacx7a', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483637, 'u5', -290314193, 'f77pzo72ctd', 't', 'mfg62g0v5q8q', '2020-08-09', 'Dutch', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483636, 'jpe1io22785', 2119806856, '7cvtjpttg6b', 'ou5z', '36c', '2025-06-06', 'Dutch', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483635, 'f', -1173368267, 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', '2021-03-03', 'Dutch', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, '5i3', -1405314653, '5lnpim5k58qs', '7p2r94gt', '2m', '2022-05-15', 'ajjla3okv8u', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, 'tmu2n', -1817527403, '78lfvyz7zz', 'be8yvkv42q7', 'x58b4', '2022-09-04', 'aus3', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, 'u', -699574669, 'rpd', 'wzw', 'chn9mo70', '2025-06-15', 'a9n0jxfofws', 'url_17');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483631, 'do2zobb', -397848196, '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', '2024-07-12', 'Dutch', 'url_18');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483630, 'k1', 955267863, 'eyo6', 'l0hdt6fuqyx', 'uzkb521gwnl', '2020-01-07', 'Dutch', 'url_19');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483629, '6elbo', 1731324803, 'wii1', '5nxih66', 'q2xlyoto', '2023-11-24', 'Dutch', 'url_20');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'oaawg96aq', -2061634386, 'bindz', '9tajz9td', 'n5wcgumbc', '2025-02-08', 'tdu6bd0w96', 'url_21');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, '3vzxw1r', 237552112, 'k7', 'k162n', '55', '2024-04-04', 'dohvu06d', 'url_22');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'a35rmki', -1160642134, 'ri2hy08ft', '6ewt', 'xxnja', '2020-03-05', 'mzn2mfx', 'url_23');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483625, 'h33p6sto1', -1971560508, 'sh5knzys7', 'y', 'yd1jmgjach8', '2022-11-06', 'Dutch', 'url_24');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483624, 'ta8y3a17v4', 614314115, 'ma', 'q3qdpua', '96rn', '2023-05-27', 'Dutch', 'url_25');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483623, 'q', -951706262, '5wli', '7', 'dn2np490xdm', '2023-03-03', 'Dutch', 'url_26');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483649, 'tgelc', -1025517017, 'i9f2ccukj', '1quik', 'yhb08hl', '2023-03-17', 't1pqomiztvb6', 'url_27');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (6, '4iz7', 195316816, 'qlud8', 'tb', 'r9114qbre', '2025-09-13', 'j', 'url_28');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483634, 'uu', -1451520332, '85', 'pxlvri', 'surz0kaqtncg', '2020-05-16', 's3b7v88kw', 'url_29');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483619, 'm', 1633584225, 'd', 't6', 'j47nxar50h', '2023-03-22', 'Dutch', 'url_30');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483618, 'han', 1195320303, 'dpunmw', 'wx', 'rlawk', '2024-09-05', 'Dutch', 'url_31');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483617, '14r5dqtsmg97', -2098439423, '2o20pj6', 'd', 'ysu', '2025-10-03', 'Dutch', 'url_32');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483651, 'phd', 1849928338, '31vwq', '1oa2sb3u', 'i1pa', '2023-09-20', 'v', 'url_33');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483622, 'wnyqrouirlrp', 1026055008, 'it63xy', 'vm', 'wpp', '2024-12-07', 'mb3aj0ju0', 'url_34');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483650, '3r', -167036460, 'r1a', 'yyhpl2', '9es', '2020-02-25', '8pgc', 'url_35');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483613, 'qwt', 1339281953, '4o6qjektb1', '2', 'zg3r', '2021-08-23', 'Dutch', 'url_36');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483612, 'wns', 1125564712, 'ja8dccy3', 'vjwq49yrnx', '6dvdx', '2020-08-23', 'Dutch', 'url_37');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483611, '2v7t', 1770139230, 'gvplj9fjvu', 'n7k10z', '2my1ogyv1rg', '2020-09-18', 'Dutch', 'url_38');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483633, 'axc1clu', -1131290294, 'ly78oitxeilp', 'e019cy7od0', '3dlhdsvn', '2021-04-28', 'd2', 'url_39');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (7, '9lqv26u331s', -1125491025, 'pw30bgwkxgi', 'nlj6idmp61', '2o3', '2020-02-08', '162', 'url_40');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483632, 'cagj', 1361395061, 'vx', 'xlu49ku', 'o', '2020-09-29', 'cde4uekhl', 'url_41');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483607, 'lbwvdpu5v0e', -1920675616, 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', '2020-09-28', 'Dutch', 'url_42');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483606, '8xjhc', -1805244571, '6cfperxa61s', 'v8n', '3ddrok', '2023-08-31', 'Dutch', 'url_43');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483605, 'zc', -831032281, 'hia3cmvb7v', 'pc0xffwor1e', 'ksf9q', '2025-01-18', 'Dutch', 'url_44');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483652, 'g01hu', -1585280787, '7f8kqhiu5g', '8gxb', 'qjlsawsp', '2025-05-07', 'wi3', 'url_45');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483621, 'l7', -1480511510, 'y795ybv8', 'kr3w4jn2', '19xgjja', '2020-06-13', 'gmukfb5if4', 'url_46');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483628, '80terbf', 1176294340, 'vee', 'sltut6lu2', 'cel8mhfcim', '2022-04-20', 'enii0fmb', 'url_47');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T1.nationality FROM drivers AS T1 ORDER BY JULIANDAY(T1.dob) DESC, T1.driverid NULLS LAST LIMIT 3) AS T3 WHERE T3.nationality = 'Dutch';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT code, SUM(CASE WHEN nationality IN ('Netherlandic', 'Dutch') THEN 1 ELSE 0 END) AS netherlandic_count FROM (SELECT code, nationality FROM drivers ORDER BY dob ASC, drivers.driverid NULLS LAST LIMIT 3) AS top_drivers;

/*
Prediction Result:
('eyo6', 1)
*/