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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-1, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 590.639932, 280.204907, 781505063, 1, 418417917);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, 'fqyp', 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', 'klex14ji', -453362185, 481163439, 313.384575, 2123196517, 920.013763, 689.091906, 364869063, 0, -953437896);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '3pyu78d', '9rljsl0b4', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, 654.149, -792092619, 585.18838, 152.494591, -1612443122, -2050247126, -736979194);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884, 37673509, 591.134092, 834709651, 418.948509, 532.326819, -932772113, 0, -639539893);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 1129658414, 1250290042, 100.07927, -1696173285, 127.371696, 665.416511, 678047687, 1, -1478134144);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 76996700, -435350511, 689.065203, 1992637800, 308.935851, 37.950999, 481546706, 1, -1784554553);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', -406331049, -461418236, 703.87087, -468701684, 837.309049, 523.290303, -604098478, 1, 1248858185);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 's27p2r94gth2', 1162591638, -2136247961, 155.873695, -2096405521, 588.850908, 230.994112, 1803796945, 1, 872694102);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', 'x58b4', -1122409769, 1849819405, 693.650436, -929383517, 13.328055, 337.117577, 274891948, 1, 609771851);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'j', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', -613916489, 2061558815, 708.448101, 364043263, 938.014057, 289.231402, -1177989415, 1, -1352968577);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'ngc1dj9', 'rh', 'izgk1yoeyo6', 'l0hdt6fuqyx', 'uzkb521gwnl', 's', 469838697, 1468640756, 744.040787, -1814875250, 349.149444, 125.054027, -457369423, 1, 1557188093);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'xih662q2xly', 'otow9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', 1295379066, 1071401016, 420.240058, 40558455, 460.649748, 672.384779, 2018368241, 1, 920097188);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483635, '1rxe9y', 'k7', 'k162n', '55', '3dohvu0', 'dza35rmki', -1160642134, 769234989, 949.964729, 168442149, 616.727797, 802.486958, 2066302536, 1, 24053253);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, 'tqxxnj', 'b', 'mzn2mfx', 'h33p6sto1', 'j', 'sh5knzys7', 1487347213, 1328948152, 52.250567, -1520090613, 637.805664, 669.860178, -2108844113, 1, 973811121);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', 'wlic7dn2', 'p490', -592014051, 1744849810, 840.039966, 1996699977, 260.74675, 107.568093, -1391541536, 1526238907, -1025517017);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'i9f2ccukj', '1quik', 'yhb08hl', 't1pqo', 'iztv', '6', -1304516770, -1558272216, 906.372539, 195316816, 250.961854, 902.378196, -1370566258, 1526238907, 948460309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, '8', '9114q', 'r', '6b', 'jeuuwsj8kj', '85', -609840352, 486475144, 618.852675, -679850352, 128.618112, 289.561925, 1205111943, 1526238907, -459075802);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'aqt', 'ncgc8s3b7v', '88kwdmdbdht6', 'j47nxar50h', 'sjhanzxdpu', 'mwfw', -544173163, -958321297, 969.162867, -641927001, 417.346356, 930.12583, 558684943, 1526238907, -120625031);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'dqtsmg97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'r31', 'wq51oa', 1813968674, 1907670428, 794.695981, 1731005516, 823.323021, 133.450116, 473443538, 1526238907, 1754053934);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'v', 'wnyqrouirlrp', 'ouit63xyfvmj', 'wpp26mb3aj0j', '0h3r13', 'ir1axyyh', 370054768, -1837449583, 13.527735, 1299933788, 603.11072, 658.158392, 1752727653, 1526238907, 1394285393);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, 'r54o6', 'jektb', '1d2nzg3rjk', 'ns47j2', 'a8d', 'c', -526608193, 1560573473, 610.035242, 826141460, 863.666767, 473.382328, -516707997, 1526238907, 1014871129);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, 'xs6dvdxdo2', '7t3gvp', 'j9f', 'vuu', '7k10', 'z2my1ogyv1r', -1712532464, -445145297, 598.494048, -316078323, 173.77973, 324.26648, 1128553504, 1526238907, 1374917235);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', '1spxpw30', 'g', -607931326, 1659285381, 894.330875, 1718551923, 594.167398, 184.825054, -1919229426, 1526238907, 495658460);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, '2o3', 'k', '62ocagj', 'ev', 'zxlu49', 'ubo', 833662145, -1943810603, 862.579245, -775706063, 578.246695, 170.069479, 858308694, 1526238907, 625191846);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, 'w', 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 1755688363, 1177967285, 141.586667, -2001463367, 472.834294, 967.546623, -2003500453, 1526238907, 1280646590);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (15, 'a61sjv', 'nv3ddroku', 'zc', 'ehia3', 'm', 'vb7vpc0xff', -1174073066, -1853296452, 978.77393, 1749319777, 541.094406, 450.301418, -1721445347, 1526238907, -314024594);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', 1424689173, 1847608594, 695.324328, 643485636, 105.740228, 574.465887, 1912528652, 1526238907, -1333309256);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (16, 'fb5', 'f41', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', -22531339, -1023455371, 291.182955, 1775901296, 518.953937, 797.293299, 1875923360, 1526238907, -286884572);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (18, '253sb59ls1e', 'hn1mdaqqhy', 'zsnp64h', 'nnw4', 'm0rrwbjk0b', 'h6gd', -616998913, 1022316699, 146.24274, -1398612932, 306.888303, 700.3372, 1297861259, 1526238907, 916632486);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (17, 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 749598659, 902707245, 207.246012, -1449454815, 619.852882, 964.264081, 825979697, 1526238907, -1565247126);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (20, 'axz', '90nhs', '9gob', '6', 'rn5u', 'phy', -2074051940, 1487440939, 801.740073, -534612951, 744.369685, 112.194268, 754506713, 1526238907, -500097534);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (21, '8scr0fs3qn', 'b5m2rlx', 'r', 'fx03rz', 'z8', 'lqme2wb1', -179078143, 2066951993, 685.181165, 61145737, 854.384433, 132.870825, -862433074, 1526238907, 80244587);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (22, '50q8', '3g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', -463551703, -1030741026, 5.865511, -791611500, 410.232279, 468.560384, 1236313039, 1526238907, -2006209112);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2, '9gr8', 'jqblox', '4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', -487579632, -1884996250, 50.554806, 1221655010, 983.668401, 373.337612, 832710468, 1526238907, 1018356621);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (23, '10qx6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', '9l', '8qzabi', -686517061, -803494685, 343.945029, -2091687257, 140.885725, 412.368161, 618880480, 1526238907, 1930844936);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (19, '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', -890072422, -1842328080, 343.28249, 1844867559, 270.352471, 915.424655, -562113476, 1526238907, 560506797);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (25, 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', -384734946, 1690470489, 42.301918, 1276457499, 432.947895, 43.925565, 1951564466, 1526238907, -721450631);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (26, 'b', 'p0760ugk2h', 'jzxpg1lcg9', '4', 'kj', 'og8dw16f5tqh', -1920701595, 1845526962, 11.060544, 1132226816, 448.796063, 714.453655, -1903548007, 1526238907, -1578115092);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2022-09-24', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'M', '2025-08-17', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'M', '2024-12-21', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'M', '2022-11-10', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'M', '2023-11-16', 7);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'M', '2023-05-11', 9);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'M', '2023-07-22', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'M', '2021-06-20', 12);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'M', '2021-09-18', 14);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, 'M', '2024-07-07', 13);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, 'M', '2021-06-23', 18);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 'M', '2024-08-12', 20);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (10, 'M', '2024-12-26', 22);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (11, 'M', '2025-01-10', 23);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'M', '2023-05-24', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A15 = (SELECT T3.A15 FROM district AS T3 ORDER BY T3.A15 DESC, T3.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(client_id) FROM client WHERE district_id = (SELECT district_id FROM district ORDER BY a15 DESC, district.district_id NULLS LAST LIMIT 1 OFFSET 1) AND gender = 'M';

/*
Prediction Result:
(0,)
*/