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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', 'south Bohemia', 'dis_935679', '9n8', '4', 'gu7v', -1865039888, 1160656988, 268.82475, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'wbbp6luhvdlt', 'south Bohemia', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 1038707349, 1419861592, 663.001988, 374105386, 950.466571, 796.740316, -1683203397, 528680845, -1585009206);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '52zbuo4nrq', 'south Bohemia', 'dis_935679', 'rofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483645, 'ex1', 'south Bohemia', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', -1116181514, 1255852738, 137.842122, -975213201, 811.601922, 92.834164, -705985602, 537874887, -461695645);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -841004020, -361507387, 395.809081, 401805964, 154.065416, 261.415754, -1255130038, -1762857309, 806170397);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, 'qv0gcb98ozk', 'south Bohemia', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 564390026, -1259474148, 968.276986, -1483100200, 128.858335, 498.231061, -1625552518, -1738458256, -1714354341);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, '8', 'south Bohemia', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 1523825314, 2078438287, 313.653498, -47052816, 650.242697, 222.511261, 765724008, -1099855564, 87529806);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, 'ctdctmfg62g0', 'south Bohemia', '5q8qdj', 'e1io', '278507cv', 'jpttg', -2033879835, 1798111945, 322.910151, 944975670, 405.452311, 928.357325, -1575410149, -68044929, -1776877925);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, 'oa', 'south Bohemia', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', -1609653472, -1405314653, 913.609637, 1816660482, 184.430978, 217.651697, 1692046802, -1300180872, -1125548818);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, '4gth2mnaj', 'south Bohemia', 'la3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, 543.387709, -489120589, 161.672605, 332.570125, -72442907, -2060082151, -1122409769);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'us3auvmkrpdj', 'south Bohemia', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -397848196, -366775518, 457.250518, 575038073, 229.650617, 357.061424, 2061558815, 895277769, 364043263);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'orlwyngc1dj', 'south Bohemia', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 1468640756, 1048147204, 228.334858, -1814875250, 349.149444, 125.054027, -457369423, 1557188093, 548968280);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, '62q2xlyot', 'south Bohemia', 'ow9oaawg96a', 'qb0tbindz39t', 'j', '9td8n5w', -1988582944, -794767771, 30.758515, 989306270, 853.967947, 590.777158, 1147652228, 1378873397, 1964331395);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'bd0w9603v', 'xw1rxe9', 'dis_125731', 'fk7qk16', '2nh55y3doh', 'u06dza', -154207334, 729449685, 942.225143, -1580984044, 422.698571, 535.063373, 431832073, 1510892261, 1677948887);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'y08ftp6ewt', 'south Bohemia', 'dis_125731', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 207.572242, 1106724223, 645.867339, 957.933481, 1487347213, 1328948152, -1923069176);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483633, 'jmgjach8qt', 'south Bohemia', 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 555368535, -1369148652, 45.731407, 899787662, 638.478504, 439.465402, 833568923, -384749431, -934098178);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, '9', 'i9f2ccukjq1q', 'dis_125731', 'ik1yhb', '8hlst1p', 'qomiztvb6m', -74691962, -2128972904, 857.91055, -1043357093, 324.663207, 926.201842, 190510318, -835782528, 192271618);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, '9114qbre6bj', 'south Bohemia', 'dis_125731', 'uu', 'sj8kjh', '5wpxlvris', 2042428747, 1228655416, 409.538993, -1040951738, 583.099045, 643.870069, -1218774640, 697582781, 428944759);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483630, 's3b7v88kw', 'south Bohemia', 'm', 'b', 'h', '6j47n', -556370776, 1144507576, 491.36959, -343920305, 607.211987, 147.214741, -2121944911, 1195320303, 1463445550);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, 'mwfw', 'qrlawk', 'dis_125731', '14r5dqt', 'mg97a', 'z2o20', -1079009577, -1385967617, 784.000091, 1813965704, 667.60579, 513.39609, 1193656937, 434520825, -1664440372);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'u2g', 'south Bohemia', 'dis_125731', 'r31', 'wq51oa', 'sb3uoi1p', -1971610898, 2095277250, 959.09934, -1067465394, 223.090529, 566.85513, 1491006943, -980625770, 721232773);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483627, 'pouit63xyf', 'south Bohemia', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', -1617977597, -1366005916, 817.07132, 230411875, 296.668783, 920.0032, -1452518801, -662859586, 1339281953);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'nzg3rjkw', 'ns47j2ja8dc', 'dis_125731', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', 1805923837, -699779308, 181.436108, 231250827, 146.155144, 711.025874, 1200703349, 108903912, -307050678);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, 'z2my1ogyv1r', 'south Bohemia', 'dis_125731', 'ez', 'x', '1', -1970162044, 324939521, 236.600951, 892508923, 652.131381, 526.310762, 139907579, 914471233, -1813651479);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483624, 'pe0', 'south Bohemia', '19cy7od033d', 'hds', 'nhed29', 'qv2', 1032462616, 980224846, 460.638735, -894726713, 367.690725, 246.280755, -165171643, -2051120765, -607931326);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (12, '1l2o3ak16', 'ocagjeev', 'dis_125731', 'zxlu49', 'ubo', '8c', -1943810603, 1557266002, 319.391855, -1417040770, 699.840562, 645.56382, -2065694089, 1868665501, -1896445805);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (13, '5v0edu', 'south Bohemia', 'dis_125731', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 1755688363, 1177967285, 141.586667, -2001463367, 472.834294, 967.546623, -2003500453, 1280646590, -568125159);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483621, '1sjv8nv3d', 'south Bohemia', 'r', 'kuez', 'ctehia3cmvb', '7vpc0xffwo', -980269466, 1202197697, 294.17485, -1424758178, 826.828056, 920.463395, 1494789426, -1048234032, -388744933);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, '7f8kqhiu5g', '8gxb', 'dis_125731', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', -197208169, 2089151689, 437.949634, -561387633, 152.79514, 151.567191, 2062713020, -1725535379, 1709325128);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (15, 'if4180te', 'south Bohemia', 'dis_125731', 'bfokv', 'e6', 'ltut6', 1143458360, -769244829, 611.680143, 1224512097, 913.742628, 679.529504, 1197643380, -1957884289, -1266238892);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483618, 'ni', 'south Bohemia', '0fm', 'bgz5oqxs27', 'h888y1', '253', -887179029, 1904358742, 793.660461, 369829594, 801.466663, 759.64243, 428576631, -1253720301, 1134827548);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2022-02-24', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'cli_0e7366', '2023-01-31', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'cli_0e7366', '2020-01-10', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'cli_0e7366', '2023-03-30', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'cli_0e7366', '2021-07-21', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'cli_19824a', '2021-04-29', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'gelcu', '2022-12-05', 4);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'p', '2023-08-16', 6);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, '4o6qjektb1', '2020-08-30', 8);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'xginlj6idm', '2022-08-24', 10);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'ui', '2021-09-18', 12);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'daqqhyyzsn', '2022-08-29', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(16.666666666666668,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN client.gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(client.client_id) AS male_percentage FROM client INNER JOIN district ON client.district_id = district.district_id WHERE district.a3 = 'south Bohemia' AND district.a4 = (SELECT MAX(a4) FROM district WHERE a3 = 'south Bohemia');

/*
Prediction Result:
(None,)
*/