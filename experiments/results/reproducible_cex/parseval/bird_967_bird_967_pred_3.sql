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

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (0, 'uhv', 1526238907, 'tti', 'bnp', 'mdpos', '2021-06-28', 'Dutch', 'url_2');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, 'e5u', 1861536320, '6klfa9', '00t5c4e', 'cigce376nium', '2025-06-20', 'Dutch', 'url_3');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483645, 'zbuo4nrq', 418417917, 'fqyp', 's5bbp02e', 'tliqa1', '2024-10-14', 'Dutch', 'url_4');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483644, 'yytoo', 1644911394, '9hl7', 'klex14ji', '7zwau2dwyr', '2022-12-09', 'Dutch', 'url_5');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483643, '3pyu78d', -977635379, 'sl0', '4', 'p5qi2rk', '2021-01-15', 'Dutch', 'url_6');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, 'vqx58pz0f', 176555546, 'gd', '1vy9uxj4', 'wb', '2020-07-26', 'Dutch', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'lph2gn', 1968874827, 'nqcx5h', 'cprj', 'u0dz7', '2021-01-15', 'gq8', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483646, 'n2f3dqv0gcb9', 172461907, 'k3zbily', 'kn6vc', '6ah', '2024-09-12', '8j', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483641, 'wwlq7', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', '2025-06-24', 'grgj', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483638, '8', -458359144, '1afgogritsj', 'ayxp1q43', '1jh3den', '2020-07-09', 'Dutch', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483637, '68x8vacx7a', 2078438287, '5w1of7', 'pzo72ctdc', 'mfg62', '2021-01-19', 'Dutch', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483636, 'v5q8qdj', -1139855872, 'io22785', '7cvtjpt', 'tg6bnou5zi', '2025-03-18', 'Dutch', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2, 'c4bfkfoac', -406331049, 'ezjo7wg', 'd5ysxc', 'r0oz', '2023-05-02', 'g', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-1, '5i3', -1405314653, '5lnpim5k58qs', '7p2r94gt', '2m', '2022-05-15', 'ajjla3okv8u', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'tmu2n', -1817527403, '78lfvyz7zz', 'be8yvkv42q7', 'x58b4', '2022-09-04', 'aus3', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483632, 'u', -699574669, 'rpd', 'wzw', 'chn9mo70', '2025-06-15', 'Dutch', 'url_17');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483631, 'a9n0jxfofws', 1719800120, 'o', '2zobb0q0k32o', 'w', '2020-06-05', 'Dutch', 'url_18');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483630, '5am', -1177989415, 'wyn', 'gc1dj9erhi', 'zgk1yoeyo6l0', '2021-05-23', 'Dutch', 'url_19');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483649, 't', -795975227, 'xuzkb52', 'gwnlas6', 'elboeowii1', '2024-05-30', 'nxih662q', 'url_20');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, 'xlyotow9', 727608179, 'awg96aqb0tbi', 'ndz39tajz9', 'd8n5w', '2020-05-31', 'um', 'url_21');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, 'c', 1295379066, 'd0w9603vzxw1', 'xe9yf', '7qk', '2024-11-02', '62nh55y3dohv', 'url_22');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483626, '06dza3', 1595632888, 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', '2022-03-07', 'Dutch', 'url_23');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483625, 'n2mfx7h', -156175571, '6sto', 'cj8sh5k', 'zys7', '2020-09-08', 'Dutch', 'url_24');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483624, 'yd1jmgj', -2108844113, '8q', 'ta8y3a17v4', 'ygmayq3qdpu', '2020-03-03', 'Dutch', 'url_25');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483650, '96rn', 2013152515, 'q', 'hm5wl', 'c7d', '2022-04-25', 'np490xdm', 'url_26');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, 'sqtgelcuqb', 1374676344, 'f2ccukjq1', 'uik1y', 'hb08hlst1pq', '2022-07-23', 'iztv', 'url_27');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, '6', -1304516770, 'z78', 'q', 'lud8f', '2023-06-04', '8', 'url_28');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483620, '9114q', -2063751689, '6b', 'jeuuwsj8kj', '85', '2024-01-06', 'Dutch', 'url_29');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483619, 'xlvr', 1205111943, '0kaqtnc', 'gc8s3b7v88k', 'dmdbdh', '2023-05-27', 'Dutch', 'url_30');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483618, 'j47nxar50', -913430713, 'an', 'xdpunmw', 'wx', '2022-11-22', 'Dutch', 'url_31');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483633, 'lawk0', -300547632, '5dqts', 'g97a', 'z2o20', '2022-10-15', '6dd', 'url_32');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483628, 'ysu', 1193656937, 'phdku2gir31v', 'q51oa2', 'sb3uoi1pavcv', '2023-11-10', 'yqro', 'url_33');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483629, 'uirlrpouit', 1589523321, 'yfvmjwpp26m', '3', 'j', '2024-08-27', 'u0h', 'url_34');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483614, 'r133ir1a', -569461411, 'hpl2i9e', 'ap8pg', 'k', '2022-11-10', 'Dutch', 'url_35');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483613, 'tsr54o', 17776256, 'ekt', '1', '2', '2022-05-17', 'Dutch', 'url_36');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483612, 'zg3rjkwns47j', -233564324, '8', 'c', 'y', '2025-03-21', 'Dutch', 'url_37');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483653, 'vjwq49yrnx', 1511946366, 'dxdo2v', '7t3gvplj9f', 'vuu', '2022-05-30', 'k10z2my1o', 'url_38');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483652, 'gyv1rgezaxc', 541973266, 'l', 'upgly78oit', 'xeilpe019cy', '2025-10-17', 'd033', 'url_39');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483651, 'dlhdsvnhed29', -1066046077, '26u331spxpw3', 'bgwkxgi', 'nlj6idmp61', '2022-02-03', 'o3ak162o', 'url_40');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483608, 'cagjeevxzxlu', 207561330, 'boe8cd', '4u', 'kh', '2021-12-28', 'Dutch', 'url_41');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483607, 'lbwvdpu5v0e', -1920675616, 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', '2020-09-28', 'Dutch', 'url_42');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483606, '8xjhc', -1805244571, '6cfperxa61s', 'v8n', '3ddrok', '2023-08-31', 'Dutch', 'url_43');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483615, 'zc', -831032281, 'hia3cmvb7v', 'pc0xffwor1e', 'ksf9q', '2025-01-18', 'g01hu', 'url_44');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, 'j7f', -1663813652, 'u5gm8gxb5qj', 'saw', 'p4kwi', '2025-03-19', 'l7', 'url_45');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483611, 'j43y795ybv83', -1428261633, 'w4jn2z19', 'xgjjacgmuk', 'b5', '2021-06-03', '41', 'url_46');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483602, '80terbfokvee', 59326585, 'tut', '6lu2cel8mh', 'ci', '2022-02-19', 'Dutch', 'url_47');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483601, 'n5enii0fmbgz', -22531339, 'xs27x', '88', 'y1k253sb5', '2021-12-08', 'Dutch', 'url_48');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483600, '1ehn1', 1134827548, 'daqqhyyzsn', '64hm', 'nw4m', '2024-09-16', 'Dutch', 'url_49');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T1.nationality FROM drivers AS T1 ORDER BY JULIANDAY(T1.dob) DESC, T1.driverid NULLS LAST LIMIT 3) AS T3 WHERE T3.nationality = 'Dutch';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN nationality = 'Dutch' THEN 1 END) AS Dutch_Drivers FROM drivers ORDER BY (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', dob)) ASC, drivers.driverid NULLS LAST LIMIT 3;

/*
Prediction Result:
(28,)
*/