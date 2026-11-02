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

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, 'g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', -406331049, -461418236, 703.87087, -468701684, 837.309049, 523.290303, -604098478, 1, 1248858185);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 1162591638, -2136247961, 155.873695, -2096405521, 588.850908, 230.994112, 1803796945, 1, 872694102);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, 'tmu2ne578l', 'vy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 736.632717, 1105964624, 401.500141, 345.578764, -2013213247, 1, 101754718);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887, -413043724, 677.305163, 1504707292, 722.415629, 230.654784, 1483450542, 1, 513375398);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'l0hdt6fuqyx', 'uzkb521gwnl', 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', 1774679448, 205676091, 735.218284, -2094843966, 94.271224, 515.50742, -1048779857, 1, -381485009);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'i', 'ndz39tajz9', 'd8n5w', 'g', 'mbc3td', 'u6bd0w9603', -541917667, -961629819, 968.548418, -505019168, 958.39315, 529.21919, 312804300, 1, -246257698);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483635, '5y3dohvu06d', 'a35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', -2080232972, 462225708, 399.670941, 1528227252, 202.604041, 363.548253, -1659775598, 1, -891525031);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, '1cj8', 'h5knz', 'ys7dyyd1jmg', 'jach8qta8y3', '1', 'v4ygmayq3', 1432875972, 1032339628, 248.642518, 608093726, 871.372603, 237.529885, 1291298007, 1, 1982265552);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', -788896327, -1541581575, 862.602858, -325680600, 763.851917, 314.524853, -1459013972, 1526238907, -1670335771);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '8hlst1p', 'qomiztvb6m', 'iz78aqql', 'd8ftb8', '9114q', 'r', 36589303, -1537647691, 584.815773, 1592061050, 345.910609, 291.673489, -1451520332, 1526238907, -55270062);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'xlvr', 'sur', '0kaqtnc', 'gc8s3b7v88k', 'dmdbdh', '6j47n', -556370776, 1144507576, 491.36959, -343920305, 607.211987, 147.214741, -2121944911, 1526238907, 1195320303);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'dpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', -1079009577, -1385967617, 784.000091, 1813965704, 667.60579, 513.39609, 1193656937, 1526238907, 434520825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 721232773, 323781506, 738.89705, -1599077491, 644.309882, 467.345809, 1589523321, 1526238907, 586437419);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'vm', 'wpp', '6mb3aj0j', '0h3r13', 'ir1axyyh', 'l2i9', -1837449583, 1299933788, 603.11072, 679285124, 908.088707, 824.632363, -1052659852, 1526238907, 1092207544);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', -1900450199, -232312083, 848.951769, 1805923837, 337.06993, 181.436108, 231250827, 1526238907, -1519752081);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, 'uun7k10z2my1', 'gyv1', 'gezax', '1', 'l', 'upgly78oit', -563920971, 1484825817, 240.007077, 1009703228, 421.254208, 770.869988, 227939734, 1526238907, -1164657946);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, '033dlhdsvnh', 'd2', '9lqv26u331s', 'xpw3', 'bgwkxgi', 'nlj6idmp61', 1530380378, 1069076646, 866.50801, -2106733603, 996.049277, 936.327627, -229524038, 1526238907, -1954048590);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, 'je', 'vx', 'xlu49ku', 'o', '8c', 'e', 1557266002, -775706063, 578.246695, -1417040770, 699.840562, 645.56382, -2065694089, 1526238907, 1868665501);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, 'p', '5v0edu', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 312333412, 871812581, 639.881602, -977983676, 2.719199, 506.492598, 1082379969, 1526238907, -878613380);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (15, '8nv3dd', 'okuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', -213453775, -1721445347, 426.885449, -786313930, 153.024976, 627.305072, 184502432, 1526238907, 1387373331);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, 'gm8gxb5q', 'lsa', 'sp4kwi', 'hl7j43y7', '5ybv83kr3', 'w4jn2z19xgj', 319828561, 1912528652, 189.564745, 1671168213, 765.40906, 825.738392, -2031993254, 1526238907, -1603206153);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2, '180terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', 1875923360, -286884572, 658.849327, 2132634715, 572.142851, 463.627072, -2074118737, 1526238907, 1772219707);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (17, '1ehn1', 'daqq', 'yy', 'snp64hm', 'nw4m', 'rrwbjk0', -2076821826, 1851648795, 763.150685, -616998913, 524.111747, 738.02665, -1519375860, 1526238907, -1398612932);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (16, 'lzh42', 'nyj5yrji5m', 'kna38', 'fx', 'wb2d0', 'mxwdb7o', 1424429365, 619382464, 773.70242, 792905581, 263.978543, 426.138328, 1548141293, 1526238907, 404180628);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (19, 'gwnkd4kc3', 'iikaxzr90nhs', '9gob', '6', 'rn5u', 'phy', -2074051940, 1487440939, 801.740073, -534612951, 744.369685, 112.194268, 754506713, 1526238907, -500097534);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (20, '8scr0fs3qn', 'b5m2rlx', 'r', 'fx03rz', 'z8', 'lqme2wb1', -179078143, 2066951993, 685.181165, 61145737, 854.384433, 132.870825, -862433074, 1526238907, 80244587);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (22, '50q8', '3g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', -463551703, -1030741026, 5.865511, -791611500, 410.232279, 468.560384, 1236313039, 1526238907, -2006209112);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (18, '9gr8', 'jqblox', '4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', -487579632, -1884996250, 50.554806, 1221655010, 983.668401, 373.337612, 832710468, 1526238907, 1018356621);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (23, '10qx6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', '9l', '8qzabi', -686517061, -803494685, 343.945029, -2091687257, 140.885725, 412.368161, 618880480, 1526238907, 1930844936);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (21, '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', -890072422, -1842328080, 343.28249, 1844867559, 270.352471, 915.424655, -562113476, 1526238907, 560506797);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (25, 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', -384734946, 1690470489, 42.301918, 1276457499, 432.947895, 43.925565, 1951564466, 1526238907, -721450631);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (26, 'b', 'p0760ugk2h', 'jzxpg1lcg9', '4', 'kj', 'og8dw16f5tqh', -1920701595, 1845526962, 11.060544, 1132226816, 448.796063, 714.453655, -1903548007, 1526238907, -1578115092);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2022-09-24', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'M', '2025-08-17', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'M', '2023-07-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'M', '2025-10-08', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'M', '2021-04-03', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 't1__2f1828', '2025-07-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'M', '2023-02-03', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'M', '2025-06-24', 7);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'M', '2025-06-04', 9);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'M', '2021-04-06', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'M', '2021-06-19', 12);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 'M', '2023-07-16', 14);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'M', '2024-07-07', 13);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'M', '2021-06-23', 17);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'M', '2024-08-12', 19);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, 'M', '2024-12-26', 22);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, 'M', '2025-01-10', 23);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483631, 'M', '2023-05-24', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A15 = (SELECT T3.A15 FROM district AS T3 ORDER BY T3.A15 DESC, T3.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client AS T2 WHERE T2.gender = 'M' AND T2.district_id = (SELECT T1.district_id FROM district AS T1 WHERE NOT T1.A15 IS NULL ORDER BY T1.A15 DESC, T1.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Prediction Result:
(0,)
*/