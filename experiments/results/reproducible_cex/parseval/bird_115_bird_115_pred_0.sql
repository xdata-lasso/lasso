-- Schema DDL
CREATE TABLE account (account_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, district_id INTEGER DEFAULT 0 NOT NULL, frequency TEXT NOT NULL, date DATE NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE card (card_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, disp_id INTEGER NOT NULL, type TEXT NOT NULL, issued DATE NOT NULL, FOREIGN KEY (disp_id) REFERENCES disp (disp_id));

CREATE TABLE client (client_id INTEGER NOT NULL PRIMARY KEY, gender TEXT NOT NULL, birth_date DATE NOT NULL, district_id INTEGER NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE disp (disp_id INTEGER NOT NULL PRIMARY KEY, client_id INTEGER NOT NULL, account_id INTEGER NOT NULL, type TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (client_id) REFERENCES client (client_id));

CREATE TABLE district (district_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, A2 TEXT NOT NULL, A3 TEXT NOT NULL, A4 TEXT NOT NULL, A5 TEXT NOT NULL, A6 TEXT NOT NULL, A7 TEXT NOT NULL, A8 INTEGER NOT NULL, A9 INTEGER NOT NULL, A10 REAL NOT NULL, A11 INTEGER NOT NULL, A12 REAL NULL, A13 REAL NOT NULL, A14 INTEGER NOT NULL, A15 INTEGER NULL, A16 INTEGER NOT NULL);

CREATE TABLE loan (loan_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, date DATE NOT NULL, amount INTEGER NOT NULL, duration INTEGER NOT NULL, payments REAL NOT NULL, status TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE "order" (order_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, bank_to TEXT NOT NULL, account_to INTEGER NOT NULL, amount REAL NOT NULL, k_symbol TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE trans (trans_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER DEFAULT 0 NOT NULL, date DATE NOT NULL, type TEXT NOT NULL, operation TEXT NULL, amount INTEGER NOT NULL, balance INTEGER NOT NULL, k_symbol TEXT NULL, bank TEXT NULL, account INTEGER NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', 'south Bohemia', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 'wbbp6luhvdlt', 'south Bohemia', 't1__72eb9a', 'ilbnp', 'mdpos', 'ie5', -1209887326, -1399556171, 741.842896, 1419861592, 663.001988, 587.103196, 1274489983, -1683203397, 528680845);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483646, '6nium52zb', 'south Bohemia', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'ex1', 'south Bohemia', 't1__72eb9a', 'ji7zwau2', 'dwyrq13pyu78', '9', 244829661, -1362461264, 943.791649, -904834265, 419.361606, 470.165282, 1692174491, -1025564911, -227162283);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'f9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, 795.815869, -1264842910, 893.16532, 254.83756, -1245682094, -1660358170, -1106350634);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, 'tu0', 'south Bohemia', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 638024588, -688098735, 915.583344, 37673509, 591.134092, 694.345982, -348113485, 138842628, -932772113);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'lq7xb7', 'south Bohemia', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', -946046410, -902895762, 453.914926, 2111987706, 360.694313, 959.196496, 1792827279, 804529642, -1538707438);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, 'den8c68x', 'south Bohemia', 'vacx7afu5', '1of77p', 'o72ctdc', 'mfg62', -1744557630, 1870300798, 492.883123, 820970595, 537.702873, 830.92312, -1488156735, -1858644047, -1180042408);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '78507cvt', 'south Bohemia', 'ptt', '6b', 'ou5z', '36c', 1722106924, -2072838897, 166.297151, -1173368267, 707.057079, 589.134984, -406331049, -461418236, -468701684);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, 'wgxd5ysxcm', 'south Bohemia', '0oztd', 'j5', '3lq', '5lnpim5k58qs', 1615073310, 1055237066, 452.630377, 988954859, 99.674786, 796.553419, 333302050, 1162591638, -2136247961);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'la3', 'south Bohemia', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', -705922211, 1043710187, 574.117269, -233617564, 574.707916, 518.470483, 1735561423, 756202403, 782684333);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'pmaus3au', 'south Bohemia', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 1719800120, -210159774, 562.960947, -2071531094, 407.368744, 983.253685, -366775518, 575038073, -1161141730);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'cl5ams', 'south Bohemia', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412, -277407746, 343.967529, -2140468103, 509.069144, 609.392845, 1468640756, 1048147204, -1814875250);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'ii1z5n', 'xih662q2xly', 't1__72eb9a', 'otow9oaawg', '6aqb0tbin', 'z', 2085299664, 2038321753, 151.892832, 1376887048, 560.916337, 49.319338, 748154000, 1148916014, -1988582944);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'mbc3td', 'south Bohemia', 't1__72eb9a', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', -1046720861, 643589729, 213.271827, 956819642, 680.425625, 990.308943, -141591627, 440797047, -732999244);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483633, '6dza35r', 'south Bohemia', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3', -891525031, -1154091048, 40.960298, 1728926031, 485.281618, 207.572242, 1106724223, 1966809332, 1487347213);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'h', 'qta8y3a17', 't1__72eb9a', 'v4ygmayq3qdp', 'uap96rntdqr', 'm5', -648564084, -1573704891, 520.723549, -1260548409, 828.220682, 570.042362, -1104749933, 379651188, -592014051);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'sqtg', 'south Bohemia', 't1__72eb9a', 'lc', 'qb9i9f', 'ccukjq1q', -796609690, -1459013972, 696.949621, -1670335771, 414.619293, 110.367767, 1862728578, 1909521477, 2101986789);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483630, 'mizt', 'south Bohemia', 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', -1486030107, 1138926079, 358.01048, 486475144, 618.852675, 341.710003, 1205111943, -459075802, -1472584267);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, '88kwdmdbdht6', 'j47nxar50h', 't1__72eb9a', 'sjhanzxdpu', 'mwfw', 'qrlawk', 558684943, -120625031, 490.559457, 572453185, 814.082349, 309.882408, -911953404, 1084127083, -1019350771);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'o20pj6dd', 'south Bohemia', 't1__72eb9a', 'ysu', 'iphdku2gi', '31vwq', 1188674483, -299585625, 0.318929, -2014514218, 877.229735, 313.493303, -1184608964, 1994296595, -1971610898);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483627, 'wnyqrouirlrp', 'south Bohemia', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 370054768, -1837449583, 13.527735, 1299933788, 603.11072, 658.158392, 1752727653, 1394285393, -1052659852);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'jektb', '1d2nzg3rjk', 't1__72eb9a', 'ns47j2', 'a8d', 'c', -526608193, 1560573473, 610.035242, 826141460, 863.666767, 473.382328, -516707997, 1014871129, -583955995);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, '6dvdxdo2v7', 'south Bohemia', 't1__72eb9a', '3gvpl', '9fj', 'uun7k1', -251621840, -1720233199, 343.508269, -966886446, 63.756677, 9.845649, -560601844, 541973266, -1970162044);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483624, 'upgly78oit', 'south Bohemia', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', -169055351, -894726713, 367.690725, -1089715864, 461.542982, 22.436232, -607931326, 1659285381, 1693638235);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, 'dmp', '1l2o3ak16', 't1__72eb9a', 'ocagjeev', 'zxlu49', 'ubo', 833662145, -1943810603, 862.579245, -775706063, 578.246695, 170.069479, 858308694, 625191846, -2065694089);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, 'dpu5v0', 'south Bohemia', 't1__72eb9a', 'du', 'y9v2z12983', '5xoepacxdb2f', -344881050, -537413388, 968.398112, 1755688363, 298.019011, 774.266879, -2001463367, -2003500453, 1280646590);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483621, 'a61sjv', 'south Bohemia', 'nv3ddroku', 'zc', 'ehia3', 'm', -682353894, -1077762203, 421.798302, -1798310553, 352.020718, 226.639809, -1853296452, 2056318381, 1749319777);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, '8k', 'hiu5g', 't1__72eb9a', '8gxb', 'qjlsawsp', 'kwi3hl7j', -113489293, 209963559, 388.072029, 191797158, 167.456919, 941.428702, 722968762, 1347243533, 1099005231);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (15, 'n2z19xgjjacg', 'south Bohemia', 't1__72eb9a', 'ukfb', 'if4180te', 'bfokv', -1844939963, 59326585, 180.749493, -759584258, 618.173643, 851.584006, 1143458360, -769244829, 479662575);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483618, 'l8', 'south Bohemia', 'mhfcimn5eni', '0fm', 'bgz5oqxs27', 'h888y1', -30240851, -887179029, 494.523323, 1904358742, 793.660461, 586.10766, 1115155768, 428576631, -1253720301);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2025-03-28', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 't2__bbb642', '2022-08-08', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 't2__56799f', '2025-11-13', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'yd1jmgj', '2020-02-06', 4);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'qtncgc8s3b7', '2023-09-27', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'sr54o', '2025-08-26', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'nlj', '2025-09-23', 10);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, '2qg01huij', '2025-12-10', 12);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, 'daqq', '2021-05-03', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN T2.gender = 'M' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'south Bohemia' AND T1.A4 = (SELECT MAX(A4) FROM district WHERE A3 = 'south Bohemia');

/*
Prediction Result:
(None,)
*/