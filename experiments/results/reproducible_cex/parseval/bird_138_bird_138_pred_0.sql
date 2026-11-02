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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-1, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 590.639932, 280.204907, 781505063, 1, 418417917);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, 'fqyp', 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -453362185, 481163439, 313.384575, 2123196517, 920.013763, 689.091906, 364869063, 0, -953437896);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '3pyu78d', '9rljsl0b4', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, 654.149, -792092619, 585.18838, 152.494591, -1612443122, -2050247126, -736979194);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884, 37673509, 591.134092, 834709651, 418.948509, 532.326819, -932772113, 0, -639539893);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 1129658414, 1250290042, 100.07927, -1696173285, 127.371696, 665.416511, 678047687, 1, -1478134144);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 76996700, -435350511, 689.065203, 1992637800, 308.935851, 37.950999, 481546706, 1, -1784554553);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', -406331049, -461418236, 703.87087, -468701684, 837.309049, 523.290303, -604098478, 1, 1248858185);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 1162591638, -2136247961, 155.873695, -2096405521, 588.850908, 230.994112, 1803796945, 1, 872694102);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4', -1122409769, 1849819405, 693.650436, -929383517, 13.328055, 337.117577, 274891948, 1, 609771851);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'j', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', -613916489, 2061558815, 708.448101, 364043263, 938.014057, 289.231402, -1177989415, 1, -1352968577);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'ngc1dj9', 'rh', 'izgk1yoeyo6', 'l0hdt6fuqyx', 'uzkb521gwnl', 's', 469838697, 1468640756, 744.040787, -1814875250, 349.149444, 125.054027, -457369423, 1, 1557188093);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'xih662q2xly', 'otow9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', 1295379066, 1071401016, 420.240058, 40558455, 460.649748, 672.384779, 2018368241, 1, 920097188);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483635, 'rxe9yfk', 'qk162nh55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', -1853955201, -805997097, 363.494801, 1664452437, 919.033168, 830.662489, -1485875026, 1, -2080232972);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, 'mzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 306260487, 1168225104, 383.770043, 1509621238, 833.617436, 578.439563, 1032339628, 1, 608093726);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'p', '6rntdqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', -1025517017, 1374676344, 555.47049, -788896327, 141.072566, 862.602858, -325680600, 1526238907, -796609690);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '1yh', '0', 'hlst1pqom', 'ztv', '6', '4iz7', 195316816, 1728201214, 180.890175, 948460309, 21.957253, 281.001583, 1183069552, 1526238907, -1057355067);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'e6bje', 'uuwsj8kjh8', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', 313797011, 1946419004, 814.396154, -1215810104, 9.534625, 271.316398, 1981548099, 1526238907, -913430713);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', -1019350771, -225571092, 439.048919, -1079009577, 878.502931, 50.158445, -1385967617, 1526238907, 1813965704);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'u6iphdku2gi', '31vwq', '1oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 721232773, 323781506, 738.89705, -1599077491, 644.309882, 467.345809, 1589523321, 1526238907, 586437419);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'vm', 'wpp', '6mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', -1837449583, 1299933788, 603.11072, 679285124, 908.088707, 824.632363, -1052659852, 1526238907, 1092207544);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', -1900450199, -232312083, 848.951769, 1805923837, 337.06993, 181.436108, 231250827, 1526238907, -1519752081);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, 'uun7k10z2my1', 'gyv1', 'gezax', '1', 'l', 'upgly78oit', -563920971, 1484825817, 240.007077, 1009703228, 421.254208, 770.869988, 227939734, 1526238907, -1164657946);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, '033dlhdsvnh', 'd2', '9lqv26u331s', 'xpw3', 'bgwkxgi', 'nlj6idmp61', 1530380378, 1069076646, 866.50801, -2106733603, 996.049277, 936.327627, -229524038, 1526238907, -1954048590);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, 'je', 'vx', 'xlu49ku', 'o', '8c', 'e', 1557266002, -775706063, 578.246695, -1417040770, 699.840562, 645.56382, -2065694089, 1526238907, 1868665501);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (15, 'p', '5v0edu', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 312333412, 871812581, 639.881602, -977983676, 2.719199, 506.492598, 1082379969, 1526238907, -878613380);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (16, '8nv3dd', 'okuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -213453775, -1721445347, 426.885449, -786313930, 153.024976, 627.305072, 184502432, 1526238907, 1387373331);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (18, 'gm8gxb5q', 'lsa', 'sp4kwi', 'hl7j43y7', '5ybv83kr3', 'w4jn2z19xgj', 319828561, 1912528652, 189.564745, 1671168213, 765.40906, 825.738392, -2031993254, 1526238907, -1603206153);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, '180terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', 1875923360, -286884572, 658.849327, 2132634715, 572.142851, 463.627072, -2074118737, 1526238907, 1772219707);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (19, '1ehn1', 'daqq', 'yy', 'snp64hm', 'nw4m', 'rrwbjk0', -2076821826, 1851648795, 763.150685, -616998913, 524.111747, 738.02665, -1519375860, 1526238907, -1398612932);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (17, 'lzh42', 'nyj5yrji5m', 'kna38', 'fx', 'wb2d0', 'mxwdb7o', 1424429365, 619382464, 773.70242, 792905581, 263.978543, 426.138328, 1548141293, 1526238907, 404180628);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (21, 'gwnkd4kc3', 'iikaxzr90nhs', '9gob', '6', 'rn5u', 'phy', -2074051940, 1487440939, 801.740073, -534612951, 744.369685, 112.194268, 754506713, 1526238907, -500097534);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (22, '8scr0fs3qn', 'b5m2rlx', 'r', 'fx03rz', 'z8', 'lqme2wb1', -179078143, 2066951993, 685.181165, 61145737, 854.384433, 132.870825, -862433074, 1526238907, 80244587);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (20, '50q8', '3g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', -463551703, -1030741026, 5.865511, -791611500, 410.232279, 468.560384, 1236313039, 1526238907, -2006209112);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483645, '9gr8', 'jqblox', '4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', -487579632, -1884996250, 50.554806, 1221655010, 983.668401, 373.337612, 832710468, 1526238907, 1018356621);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (23, '10qx6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', '9l', '8qzabi', -686517061, -803494685, 343.945029, -2091687257, 140.885725, 412.368161, 618880480, 1526238907, 1930844936);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', -890072422, -1842328080, 343.28249, 1844867559, 270.352471, 915.424655, -562113476, 1526238907, 560506797);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (25, 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', -384734946, 1690470489, 42.301918, 1276457499, 432.947895, 43.925565, 1951564466, 1526238907, -721450631);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (26, 'b', 'p0760ugk2h', 'jzxpg1lcg9', '4', 'kj', 'og8dw16f5tqh', -1920701595, 1845526962, 11.060544, 1132226816, 448.796063, 714.453655, -1903548007, 1526238907, -1578115092);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2022-09-24', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'M', '2025-08-17', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'M', '2024-12-21', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 't1__22b0a4', '2023-12-09', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'M', '2023-02-03', 9);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'M', '2025-06-24', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'M', '2025-06-04', 7);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'M', '2021-04-06', 15);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'M', '2021-06-19', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'M', '2023-07-16', 13);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'M', '2024-07-07', 21);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, 'M', '2021-06-23', 18);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, 'M', '2024-08-12', 19);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'M', '2024-12-26', 25);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (10, 'M', '2025-01-10', 20);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (11, 'M', '2023-05-24', 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A15 = (SELECT T3.A15 FROM district AS T3 ORDER BY T3.A15 DESC, T3.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(T1.gender) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A15 = (SELECT MAX(A15) FROM district WHERE A15 < (SELECT MAX(A15) FROM district)) AND T1.gender = 'M';

/*
Prediction Result:
(0,)
*/