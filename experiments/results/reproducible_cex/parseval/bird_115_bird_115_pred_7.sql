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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', 'south Bohemia', 'dis_13c3da', '9n8', '4', 'gu7v', -1865039888, 1160656988, 268.82475, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'wbbp6luhvdlt', 'south Bohemia', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 1038707349, 1419861592, 663.001988, 374105386, 950.466571, 796.740316, -1683203397, 528680845, -1585009206);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '52zbuo4nrq', 'south Bohemia', 'dis_13c3da', 'rofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483645, 'ex1', 'south Bohemia', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', -1116181514, 1255852738, 137.842122, -975213201, 811.601922, 92.834164, -705985602, 537874887, -461695645);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -841004020, -361507387, 395.809081, 401805964, 154.065416, 261.415754, -1255130038, -1762857309, 806170397);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, '0gcb98', 'south Bohemia', 'zk3z', 'i', 'yrk', 'n6vck6ah0f', 138842628, -932772113, 351.095514, 1255343543, 21.129657, 525.144763, -541746689, 1294666887, -515895469);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'z16ni', 'south Bohemia', 'jai', 'dh5ogrgj', '8', 'yzt1afgogrit', 678047687, -1478134144, 15.432127, -491938169, 239.245131, 422.041684, -106471771, 1235416111, 1923912467);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, '3d', 'south Bohemia', 'n8', 'c68x8vacx7', 'f', '5w1of7', 76996700, -435350511, 689.065203, 1992637800, 308.935851, 37.950999, 481546706, -1784554553, -242584410);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '5q8qdj', 'south Bohemia', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', 1944978593, 1722106924, 17.379583, -1173368267, 707.057079, 589.134984, -406331049, -461418236, -468701684);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, 'wgxd5ysxcm', 'south Bohemia', '0oztd', 'j5', '3lq', '5lnpim5k58qs', 1615073310, 1055237066, 452.630377, 988954859, 99.674786, 796.553419, 333302050, 1162591638, -2136247961);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'la3', 'south Bohemia', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', -705922211, 1043710187, 574.117269, -233617564, 574.707916, 518.470483, 1735561423, 756202403, 782684333);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'pmaus3au', 'south Bohemia', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 1719800120, -210159774, 562.960947, -2071531094, 407.368744, 983.253685, -366775518, 575038073, -1161141730);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'cl5ams', 'south Bohemia', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412, -277407746, 343.967529, -2140468103, 509.069144, 609.392845, 1468640756, 1048147204, -1814875250);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'i1z', 'nxih662q', 'dis_80f5f8', 'xlyotow9', 'aawg', '6aqb0tbin', -1897615568, 2085299664, 974.58376, 1376887048, 560.916337, 49.319338, 748154000, 1148916014, -1988582944);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'mbc3td', 'south Bohemia', 'dis_80f5f8', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', -1046720861, 643589729, 213.271827, 956819642, 680.425625, 990.308943, -141591627, 440797047, -732999244);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483633, '6dza35r', 'south Bohemia', 'mkio18ri2hy', '08ftp6ewtqxx', 'jaby', 'mzn2mfx7h3', -891525031, -1154091048, 40.960298, 1728926031, 485.281618, 207.572242, 1106724223, 1966809332, 1487347213);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'h', 'qta8y3a17', 'dis_80f5f8', 'v4ygmayq3qdp', 'uap96rntdqr', 'm5', -648564084, -1573704891, 520.723549, -1260548409, 828.220682, 570.042362, -1104749933, 379651188, -592014051);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'sqtg', 'south Bohemia', 'dis_80f5f8', 'lc', 'qb9i9f', 'ccukjq1q', -796609690, -1459013972, 696.949621, -1670335771, 414.619293, 110.367767, 1862728578, 1909521477, 2101986789);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483630, 'mizt', 'south Bohemia', 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', -1486030107, 1138926079, 358.01048, 486475144, 618.852675, 341.710003, 1205111943, -459075802, -1472584267);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, '88kwdmdbdht6', 'j47nxar50h', 'dis_80f5f8', 'sjhanzxdpu', 'mwfw', 'qrlawk', 558684943, -120625031, 490.559457, 572453185, 814.082349, 309.882408, -911953404, 1084127083, -1019350771);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'o20pj6dd', 'south Bohemia', 'dis_80f5f8', 'ysu', 'iphdku2gi', '31vwq', 1188674483, -299585625, 0.318929, -2014514218, 877.229735, 313.493303, -1184608964, 1994296595, -1971610898);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483627, 'wnyqrouirlrp', 'south Bohemia', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 370054768, -1837449583, 13.527735, 1299933788, 603.11072, 658.158392, 1752727653, 1394285393, -1052659852);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'jektb', '1d2nzg3rjk', 'dis_80f5f8', 'ns47j2', 'a8d', 'c', -526608193, 1560573473, 610.035242, 826141460, 863.666767, 473.382328, -516707997, 1014871129, -583955995);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, '6dvdxdo2v7', 'south Bohemia', 'dis_80f5f8', '3gvpl', '9fj', 'uun7k1', -251621840, -1720233199, 343.508269, -966886446, 63.756677, 9.845649, -560601844, 541973266, -1970162044);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483624, 'upgly78oit', 'south Bohemia', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', -169055351, -894726713, 367.690725, -1089715864, 461.542982, 22.436232, -607931326, 1659285381, 1693638235);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, 'dmp', '1l2o3ak16', 'dis_80f5f8', 'ocagjeev', 'zxlu49', 'ubo', 833662145, -1943810603, 862.579245, -775706063, 578.246695, 170.069479, 858308694, 625191846, -2065694089);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, 'dpu5v0', 'south Bohemia', 'dis_80f5f8', 'du', 'y9v2z12983', '5xoepacxdb2f', -344881050, -537413388, 968.398112, 1755688363, 298.019011, 774.266879, -2001463367, -2003500453, 1280646590);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483621, 'a61sjv', 'south Bohemia', 'nv3ddroku', 'zc', 'ehia3', 'm', -682353894, -1077762203, 421.798302, -1798310553, 352.020718, 226.639809, -1853296452, 2056318381, 1749319777);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'M', '2022-02-24', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'cli_64d147', '2022-11-06', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'cli_64d147', '2020-09-03', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'cli_64d147', '2021-08-03', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'cli_64d147', '2024-08-28', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'cli_64d147', '2022-08-08', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'cli_44ce06', '2025-11-13', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'cli_64d147', '2023-12-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'yd1jmgj', '2020-02-06', 4);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'qtncgc8s3b7', '2023-09-27', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'sr54o', '2025-08-26', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'nlj', '2025-09-23', 10);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, '2qg01huij', '2025-12-10', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(CASE WHEN client.gender = 'M' THEN 1 END) AS REAL) * 100) / COUNT(*) AS percentage_male_clients FROM client INNER JOIN district ON client.district_id = district.district_id WHERE district.A3 = 'south Bohemia' AND district.A4 = (SELECT MAX(A4) FROM district WHERE A3 = 'south Bohemia');

/*
Prediction Result:
(None,)
*/