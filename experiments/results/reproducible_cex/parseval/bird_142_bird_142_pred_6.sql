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
-- Inserting into table: account --
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'fqyp', '2025-06-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'bbp02eut', '2022-02-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, 'q13py', '2023-09-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 4, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 5, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 6, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, 7, '4nrq', '2023-01-30');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 'Pisek', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'Pisek', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, 795.815869, -1264842910, 893.16532, 254.83756, -1245682094, -1660358170, -1106350634);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'tu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 'ozk3zbily', 'kn6vc', 1784916884, 37673509, 591.134092, 834709651, 418.948509, 532.326819, -932772113, -639539893, 1255343543);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 't3__9521ba', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 't3__9521ba', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'Pisek', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 't3__9521ba', 'lbn', 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', -1683203397, 528680845, 467.07027, -1585009206, 191.847248, 807.142508, -53231346, -443340271, 757448742);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2021-05-27', 'bnp', 'mdpos', -1576219117, -1823627488, 'SIPO', 'nw6klf', 1038707349);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '2024-07-24', '00t5c4ecigc', 'e376nium52', -443340271, 757448742, 'SIPO', '4nrq', 418417917);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 3, '2021-07-19', 'a11ry', 'ytoo3o9hl7', 1178636309, -1390245819, 'SIPO', 'x14ji7zwau2d', 1485335077);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 4, '2025-11-02', 'd99rljsl0', '4', 1649269347, -1116181514, 'SIPO', 'i2rkf', 222415430);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 1, '2020-03-27', '72fxa7ryfd', 'z16ni', 2011234363, -1483100200, 'SIPO', '5dh', 1583472758);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '2021-01-25', 'gjd8y', 't1afgog', -946046410, -902895762, 'SIPO', 'ayxp1q43', 1235416111);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 3, '2024-10-12', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, 'SIPO', '5w1of7', 76996700);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 4, '2024-06-20', '72ct', 'c', 1303877941, -1284905200, 'SIPO', '62', -1744557630);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 1, '2023-10-13', 'q8qdjpe1', 'o22', 2004147439, -691774480, 'SIPO', 'ptt', 1467355421);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2022-06-10', 'u5zi', '6c4bfkfo', -1950324754, 2115816682, 'SIPO', '7z2zezjo7wg', 1248858185);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 3, '2020-07-27', 'ysxcmr0o', 'ztdgj5i3lq5l', 1339733032, -1556979799, 'SIPO', 'k58qs27p', 988954859);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 4, '2021-02-12', 'h2mna', 'jla', 1919033056, -1428186898, 'SIPO', 'uttmu2ne5', -1402164108);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 1, '2023-10-17', 'yz7zzbe8yvk', 'v42q7sx58b4p', 319284352, 1164790775, 'SIPO', 'auvmkrpd', -609553675);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '2023-11-16', 'chn9mo70', 'a9n0jxfo', -1793230843, -441521858, 'SIPO', '2zob', -2019656607);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2022-12-01', '0k32odwcl5a', 'msorlwyngc', -323362455, 453340472, 'SIPO', '9erhizgk1yoe', 1483450542);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2022-07-24', 'l0hdt6fuq', 'xuzkb52', -277407746, -670154354, 'SIPO', 'as6', -2076274980);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '2020-11-13', 'wii1', '5nxih66', -251205568, 287256667, 'SIPO', 'otow9oa', 456034296);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '2023-12-19', '96', 'aqb0tbindz39', 2085299664, 2038321753, 'SIPO', 'z9t', 748154000);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483630, 1, '2023-12-22', 'g', 'mbc3td', 1964331395, -1943814113, 'SIPO', '9603vz', 920097188);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483629, 1, '2023-12-09', 'rxe9yfk', 'qk162nh55', 2105860871, -141591627, 'SIPO', 'ohvu06dza3', 1595632888);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483628, 1, '2022-02-22', 'io1', 'ri2hy08ft', 2066302536, 24053253, 'SIPO', 'tqxxnj', 917362079);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483627, 1, '2024-03-23', 'mzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 'SIPO', 'zys7', 1487347213);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483626, 1, '2024-03-21', 'yd1jmgjach8', 'qta8y3a17v4y', 306260487, 1168225104, 't1__4ba25a', 'q3qdpua', 1291298007);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483625, 1, '2022-05-09', 'dqrhm', 'wlic7dn2', 1409697108, -1104749933, 't1__3b166f', '0xdmsqtge', -1391541536);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483624, 1, '2023-08-10', 'qb9i9f2ccu', 'jq1', 1584429327, -1575692857, 'SIPO', 'yhb08hl', 1040753276);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483623, 1, '2024-10-04', 'qomi', 'tvb6m4i', -2128972904, -1043357093, 'SIPO', 'd8ftb8', 1183069552);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483622, 1, '2024-10-24', 'qbre6bje', 'uuwsj8kjh8', -55270062, -1101814296, 'SIPO', 'lvrisurz0k', -1040951738);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483621, 1, '2022-06-04', 'g', 'c8s3b7v88k', -622923312, 1789767331, 'SIPO', 'b', -1924635316);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 5, '2021-05-27', 'bnp', 'mdpos', -1576219117, -1823627488, 'SIPO', 'nw6klf', 1038707349);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 6, '2021-05-27', 'bnp', 'mdpos', -1576219117, -1823627488, 't1__4ba25a', 'nw6klf', 1038707349);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 7, '2024-06-15', 'value', 'value', 1, 1, NULL, 'value', 1);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (7, 8, '2024-06-15', 'value', 'value', 1, 1, NULL, 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.k_symbol = 'SIPO' AND T3.A2 = 'Pisek';

/*
Gold Result:
(1,)
(3,)
(4,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN "order" AS T3 ON T1.account_id = T3.account_id WHERE T2.A2 = 'Pisek' AND T3.k_symbol = 'SIPO';

/*
Prediction Result:
*/