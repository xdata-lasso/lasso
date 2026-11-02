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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', 'south Bohemia', 'dis_de5914', '9n8', '4', 'gu7v', -1865039888, 1160656988, 268.82475, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'wbbp6luhvdlt', 'south Bohemia', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 1038707349, 1419861592, 663.001988, 374105386, 950.466571, 796.740316, -1683203397, 528680845, -1585009206);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '52zbuo4nrq', 'south Bohemia', 'dis_de5914', 'rofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483645, 'ex1', 'south Bohemia', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', -1116181514, 1255852738, 137.842122, -975213201, 811.601922, 92.834164, -705985602, 537874887, -461695645);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -841004020, -361507387, 395.809081, 401805964, 154.065416, 261.415754, -1255130038, -1762857309, 806170397);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, 'qv0gcb98ozk', 'south Bohemia', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 564390026, -1259474148, 968.276986, -1483100200, 128.858335, 498.231061, -1625552518, -1738458256, -1714354341);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, '8', 'south Bohemia', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 1523825314, 2078438287, 313.653498, -47052816, 650.242697, 222.511261, 765724008, -1099855564, 87529806);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, 'ctdctmfg62g0', 'south Bohemia', '5q8qdj', 'e1io', '278507cv', 'jpttg', -2033879835, 1798111945, 322.910151, 944975670, 405.452311, 928.357325, -1575410149, -68044929, -1776877925);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, 'oa', 'south Bohemia', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', -1609653472, -1405314653, 913.609637, 1816660482, 184.430978, 217.651697, 1692046802, -1300180872, -1125548818);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, '4gth2mnaj', 'south Bohemia', 'la3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, 543.387709, -489120589, 161.672605, 332.570125, -72442907, -2060082151, -1122409769);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'u', 'south Bohemia', '3auvm', 'rpd', 'wzw', 'chn9mo70', 628082526, -1245584612, 903.226183, -582376271, 228.613802, 352.249155, 1719800120, -210159774, 270415200);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'b', 'south Bohemia', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 1483450542, 513375398, 514.470353, 718167481, 832.527521, 124.067083, 1435223075, 1617348603, -477129795);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'uzkb521gwnl', 'south Bohemia', 's', 'elboeowii', 'z5nxih6', '2q2xlyoto', 1774679448, 205676091, 735.218284, -2094843966, 94.271224, 515.50742, -1048779857, -381485009, 868039568);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483635, 'ndz39tajz9', 'south Bohemia', 'd8n5w', 'g', 'mbc3td', 'u6bd0w9603', -541917667, -961629819, 968.548418, -505019168, 958.39315, 529.21919, 312804300, -246257698, -516345261);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'o', 'vu', 'dis_02cd64', '6dza35r', 'mkio18ri2hy', '08ftp6ewtqxx', 1664452437, -1485875026, 779.614625, -2080232972, 607.620308, 399.670941, 1528227252, -1277305894, -1659775598);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'p6sto1cj', 'south Bohemia', 'dis_02cd64', 'sh5knzys7', 'y', 'yd1jmgjach8', 973811121, 280292620, 644.437797, -531872415, 5.194667, 523.794239, 339193890, -493230039, -2081662466);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483632, '96rn', 'south Bohemia', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', -1872934808, -1974774786, 598.265359, -1750715330, 564.645313, 711.519405, 1149620614, -1414362698, 1046248997);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'uik1y', 'hb08hlst1pq', 'dis_02cd64', 'mizt', 'vb6m4iz78aq', 'lud8f', -835782528, 192271618, 990.66185, -312228770, 876.781557, 881.656954, -2063751689, 36589303, -1537647691);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'uuwsj8kjh8', 'south Bohemia', 'dis_02cd64', 'wpxlvris', 'urz0kaqtncg', 'c8s3b7v88k', -622923312, 1789767331, 880.348467, 1671062261, 51.885919, 303.260196, 313797011, 1946419004, -1215810104);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483629, 'hsjhanz', 'south Bohemia', 'dpunmw', 'wx', 'rlawk', '14r5dqt', 1298113538, -1340460158, 977.087263, -2098439423, 392.952848, 232.665028, 944310519, 6224071, 1928920679);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, 'ysu', 'iphdku2gi', 'dis_02cd64', '31vwq', '1oa2sb3u', 'i1pa', 1754053934, 1206923461, 340.48601, 1645850786, 960.01108, 212.582014, -471852873, -1005394301, 917675957);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'rlr', 'south Bohemia', 'dis_02cd64', 'pouit63xyf', 'mjwpp2', 'mb3aj0ju0', 493701528, 461842658, 463.478104, 1805058154, 437.034078, 367.411929, 1498496406, 370054768, -1837449583);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483626, 'gckqwtsr54', 'south Bohemia', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 1560573473, 472597763, 630.926892, 826141460, 863.666767, 473.382328, -516707997, 1014871129, -583955995);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, '6dvdxdo2v7', '3gvpl', 'dis_02cd64', '9fj', 'uun7k1', 'z2my1og', -489473841, -333485269, 101.269961, -445145297, 598.494048, 46.864581, -316078323, -754769711, 1128553504);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, 'xeilp', 'south Bohemia', 'dis_02cd64', 'e019cy7od0', '3dlhdsvn', 'ed', 1188203659, -1066046077, 726.542267, 1032462616, 728.226382, 460.638735, -894726713, -1089715864, -165171643);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483623, 'xgi', 'south Bohemia', 'nlj6idmp61', '2o3', 'k', '62ocagj', 1361395061, 1707457950, 364.303078, -572986964, 324.633755, 590.23327, -1459357985, -2051917235, 833662145);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, 'e', 'uekhllbw', 'dis_02cd64', 'dpu5v0', 'du', 'y9v2z12983', 1870044139, -1147311649, 872.452671, 745344960, 746.976306, 42.323074, -563021857, -2062902911, -1809620481);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, '2', 'south Bohemia', 'dis_02cd64', '6xiyet8xj', 'hcf46cfperxa', '1sjv8nv3d', -1891572006, -1198828889, 326.742866, 2063578992, 833.471534, 967.547853, 1795932554, -831032281, 2006256976);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483620, 'vb7vpc0xff', 'south Bohemia', 'or1esk', 'f9q82', 'g01hu', 'j7f', -1663813652, 1094664154, 188.706193, -1728059226, 884.814516, 493.547402, 854201197, -1497515537, 1432878454);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, 'awsp4kwi3h', '7j4', 'dis_02cd64', 'y795ybv8', 'kr3w4jn2', '19xgjja', 2062713020, -1725535379, 320.34146, 1709325128, 493.134224, 88.401381, 143843552, 1085074663, -1819463450);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (15, 'f', 'south Bohemia', 'dis_02cd64', 'kvee', 'sltut6lu2', 'cel8mhfcim', 858757143, 1865625247, 209.88755, -1800278299, 575.700402, 97.977734, 1859885644, -22531339, -1023455371);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483617, 'k253sb5', 'south Bohemia', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', -973411766, 668449456, 16.251399, 1353959969, 162.611398, 16.452232, 1851648795, 1130223592, -616998913);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (16, 'jjplwtlzh', '42nyj5yrji5m', 'dis_02cd64', 'kna38', 'fx', 'wb2d0', -1318060436, -613511812, 897.150993, 1769687183, 981.929822, 970.470487, 1424429365, 619382464, 792905581);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (17, 'o1k4c', 'south Bohemia', 'dis_02cd64', 'gwnkd4kc3', 'iikaxzr90nhs', '9gob', -976193147, -15423424, 913.067252, -1099209475, 388.599284, 215.23512, -2125510968, 2017526622, -693920036);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2022-02-24', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'cli_a3282b', '2023-01-31', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, '3qdpu', '2020-03-03', 4);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'r', '2025-07-05', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'p', '2022-10-19', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'g', '2024-01-08', 10);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'a3c', '2022-04-09', 12);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, '27xh8', '2024-04-25', 14);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, '8scr0f', '2023-03-23', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "client"."gender" = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("client"."client_id") FROM "client" INNER JOIN "district" ON "client"."district_id" = "district"."district_id" WHERE "district"."a3" = 'south Bohemia' AND "district"."a4" = (SELECT MAX("a4") FROM "district" WHERE "a3" = 'south Bohemia');

/*
Prediction Result:
(None,)
*/