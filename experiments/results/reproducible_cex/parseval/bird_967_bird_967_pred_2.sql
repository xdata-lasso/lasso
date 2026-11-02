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

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2, 'vqx58pz0f', 176555546, 'gd', '1vy9uxj4', 'wb', '2020-07-26', 'lph2gn', 'url_7');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (2, 'q', -664193365, 'cx5hn', 'p', 'jtu0d', '2024-06-09', '9fjgq8n2f', 'url_8');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (3, 'dqv0gcb9', 172461907, 'k3zbily', 'kn6vc', '6ah', '2024-09-12', '8j', 'url_9');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483639, 'wwlq7', 1255343543, '7', '2fxa7ryfdrz', '16nijjai5dh', '2025-06-24', 'Dutch', 'url_10');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483638, 'grgj', -458359144, '1afgogritsj', 'ayxp1q43', '1jh3den', '2020-07-09', 'Dutch', 'url_11');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483637, '68x8vacx7a', 2078438287, '5w1of7', 'pzo72ctdc', 'mfg62', '2021-01-19', 'Dutch', 'url_12');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483646, 'v5q8qdj', -1139855872, 'io22785', '7cvtjpt', 'tg6bnou5zi', '2025-03-18', 'c4bfkfoac', 'url_13');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (4, '0', 76987628, 'zezjo7wg', 'd5ysxc', 'r0oz', '2023-05-02', 'g', 'url_14');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (5, '5i3', -1405314653, '5lnpim5k58qs', '7p2r94gt', '2m', '2022-05-15', 'ajjla3okv8u', 'url_15');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483633, 'tmu2n', -1817527403, '78lfvyz7zz', 'be8yvkv42q7', 'x58b4', '2022-09-04', 'Dutch', 'url_16');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483632, 'aus3', -2090240067, 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', '2020-12-03', 'Dutch', 'url_17');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483631, 'szdo2z', 270415200, 'b', 'q0k32od', 'cl5ams', '2022-07-13', 'Dutch', 'url_18');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483649, 'lwyng', -1960313034, 'j', '9erhizgk1yoe', 'o6l0hdt', '2025-09-04', 'uq', 'url_19');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483648, 'xuzkb52', -277407746, 'nlas6e', 'lboeowii1z5', 'xih6', '2025-08-17', 'q2xlyoto', 'url_20');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483647, '9oaawg', 1044710644, 'qb0tbindz39t', 'j', '9td8n5w', '2020-05-31', 'um', 'url_21');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483627, 'c', 1295379066, 'd0w9603vzxw1', 'xe9yf', '7qk', '2024-11-02', 'Dutch', 'url_22');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483626, '62nh55y3dohv', -1934709172, '3', 'rmkio18r', 'i2hy08ftp6', '2020-10-06', 'Dutch', 'url_23');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483625, 'tqxxnj', 917362079, 'mzn2mfx', 'h33p6sto1', 'j', '2023-04-07', 'Dutch', 'url_24');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483651, '5k', 1106724223, 'ys7dyyd1jmg', 'jach8qta8y3', '1', '2025-11-15', 'v4ygmayq3qdp', 'url_25');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483650, 'uap96rntdqr', -1670945624, 'wlic7dn2', 'p490', 'dmsqtg', '2020-09-18', 'cuq', 'url_26');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483636, '9', -1750715330, 'ccukjq1qui', '1yh', '0', '2021-03-28', 'st1', 'url_27');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483621, 'qomi', 1784997708, 'tvb6m4iz78', 'q', 'lud8f', '2023-06-04', 'Dutch', 'url_28');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483620, '8', 1183069552, '4qbre6b', 'jeuuwsj8kj', '85', '2024-01-06', 'Dutch', 'url_29');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483619, 'xlvr', 1205111943, '0kaqtnc', 'gc8s3b7v88k', 'dmdbdh', '2023-05-27', 'Dutch', 'url_30');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483654, 'j47nxar50', -913430713, 'an', 'xdpunmw', 'wx', '2022-11-22', 'lawk0', 'url_31');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483653, '14r5dqtsmg97', -2098439423, '2o20pj6', 'd', 'ysu', '2025-10-03', 'phd', 'url_32');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483652, 'u2g', 1352531282, 'vwq51oa', 'sb3uoi1p', 'avcvwnyqroui', '2023-01-17', 'rpo', 'url_33');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483615, 'it63xy', -711121679, 'wpp', '6mb3aj0j', '0h3r13', '2025-03-13', 'Dutch', 'url_34');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483614, 'r1a', -569461411, 'hpl2i9e', 'ap8pg', 'k', '2022-11-10', 'Dutch', 'url_35');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483613, 'tsr54o', 17776256, 'ekt', '1', '2', '2022-05-17', 'Dutch', 'url_36');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483635, 'zg3rjkwns47j', -233564324, '8', 'c', 'y', '2025-03-21', 'vjwq49yrnx', 'url_37');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483624, '6dvdx', -1900450199, 'v7t3gvpl', '9fj', 'uun7k1', '2024-08-13', 'z2my1ogyv1r', 'url_38');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483622, 'ez', -560601844, '1clupgly78o', 'txe', 'lpe', '2024-09-21', '19cy7od033d', 'url_39');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483609, 'hds', -690382359, 'ed', '9lqv26u3', '1spxpw30', '2020-04-01', 'Dutch', 'url_40');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483608, 'wk', 1659285381, 'in', 'j6i', 'dmp61l2o3ak1', '2025-09-15', 'Dutch', 'url_41');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483607, 'ocagjeev', -582813835, 'lu49ku', 'o', '8c', '2020-07-13', 'Dutch', 'url_42');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483642, '4u', 426006253, 'll', 'w', 'dpu5v0', '2020-10-14', 'u', 'url_43');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483641, 'y9v2z12983', 1870044139, 'oepacx', 'b', 'f0c296xi', '2024-05-13', 'et8xjhcf46c', 'url_44');

INSERT INTO "drivers" ("driverid", "driverref", "number", "code", "forename", "surname", "dob", "nationality", "url") VALUES (-2147483640, 'pe', -977983676, '6', 'sjv8nv3', 'd', '2023-02-08', 'kuez', 'url_45');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T1.nationality FROM drivers AS T1 ORDER BY JULIANDAY(T1.dob) DESC, T1.driverid NULLS LAST LIMIT 3) AS T3 WHERE T3.nationality = 'Dutch';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(driverId) FROM drivers WHERE nationality = 'Netherlands' ORDER BY dob DESC, drivers.driverid NULLS LAST LIMIT 3;

/*
Prediction Result:
(0,)
*/