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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 1.0, 13244799, -1659388584, 1526238907);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 517.275698, 1155439218, 805.746877, 1.0, -761141909, 283598170, 742285925);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'u', '4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, 176.308171, 1055976837, 913.303855, 1.0, -74849714, 105869088, -2081315180);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '2dwyrq13pyu7', 'd99rljsl0', '4', 'p5qi2rk', '9v', 'x58pz', -1529584866, 1196308825, 712.084197, -283454505, 1.0, 390.34832, 233994589, 1442655647, -87647544);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 172461907, 1606439408, 836.121091, -155284187, 1.0, 892.659478, -1554531873, 982314585, 638024588);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 'dh5ogrgj', -458359144, 600440952, 865.094662, -1794176801, 1.0, 221.842983, -946046410, -902895762, -197933860);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'xp1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 102.360106, 7929158, 1.0, 93.813527, 1870300798, 820970595, 1421303999);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, 'j', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4', -2072838897, -1173368267, 707.057079, 382831862, 1.0, 60.937725, -406331049, -461418236, -468701684);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143, 1615073310, 628.658254, 1055237066, 1.0, 452.630377, 988954859, -1719383707, 1273687251);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, '2mnajjla3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', -705922211, 1043710187, 574.117269, -233617564, 1.0, 574.707916, 79330142, 1735561423, 756202403);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, '8b4pmaus3au', 'mkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -397848196, -366775518, 457.250518, 575038073, 1.0, 229.650617, -613916489, 2061558815, 895277769);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483637, 'amsorlwyng', '1', 'j', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412, -277407746, 343.967529, -2140468103, 1.0, 509.069144, 469838697, 1468640756, 1048147204);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, 'eowi', '1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', -1897615568, 2085299664, 974.58376, 1376887048, 1.0, 560.916337, 748154000, 1148916014, -1988582944);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483635, 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', 'k162n', '55', 2105860871, -141591627, 602.631056, -732999244, 1.0, 885.125365, 30861410, -438741674, -154207334);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, 'rmkio18ri2', 'y0', '8ftp6ewtqx', 'njabym', 'n2mfx7h', '3p6sto1c', 170892881, -1643065004, 165.118823, -515419519, 1.0, 527.830294, -1884062674, -531932574, 357443379);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483633, 'gjac', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 'p', '6rntdqrhm', 555368535, -1369148652, 45.731407, 899787662, 1.0, 638.478504, 833568923, -384749431, -934098178);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483632, 'gelcu', 'qb9i9f2ccu', 'jq1', 'uik1y', 'hb08hlst1pq', 'mizt', 1793241362, -1304516770, 137.186478, 195316816, 1.0, 250.961854, 1728201214, -1370566258, 948460309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483631, '8', '9114q', 'r', '6b', 'jeuuwsj8kj', '85', -609840352, 486475144, 618.852675, -679850352, 1.0, 128.618112, 1205111943, -459075802, -1472584267);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483630, 'qtncgc8s3b7', 'v88kwdmdbd', 't6', 'j47nxar50h', 'sjhanzxdpu', 'mwfw', -544173163, -958321297, 969.162867, -641927001, 1.0, 417.346356, 558684943, -120625031, 572453185);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483629, 'tsmg9', 'aqz2o20pj', 'ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 1388661799, -1574319760, 762.890435, 473443538, 1.0, 908.397506, 1206923461, 1645850786, -471852873);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483628, 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', -1617977597, -1366005916, 817.07132, 230411875, 1.0, 296.668783, 1803900001, -1452518801, -662859586);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT IIF(AVG(A13) > AVG(A12), '1996', '1995') FROM district;

/*
Gold Result:
('1996',)
*/

-- Prediction Query
SELECT AVG(A12), AVG(A13) FROM district;

/*
Prediction Result:
(118.42272500000001, 383.0001522857143)
*/