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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'wbbp6luhvdlt', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-1, 2, '1vy9uxj4', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'fdrz16n', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, 1, 'jja', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 3, 'dh5ogrgj', '2020-08-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, '78507cvt', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, 'sxcmr0o', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (0, 2, 'ztdgj5i3lq5l', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, 'yz7zzbe8yvk', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'ilbnp', '1996-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't1__3ae097', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '%', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997, 1178000634, 541.393553, 1836127587, 410.133844, 88.474525, -1529584866, 1196308825, 910894705);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483645, 't1__d86242', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', -348113485, 138842628, 282.822068, -639539893, 260.513699, 969.559316, 1255343543, -541746689, 1294666887);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, 't1__d86242', '68x8vacx7a', 'u5', '1of77p', 'o72ctdc', 'mfg62', -1744557630, 1870300798, 492.883123, 820970595, 537.702873, 830.92312, -1488156735, -1858644047, -1180042408);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, 't1__d86242', 'ptt', '6b', 'ou5z', '36c', 'bfkfoacd', 2115816682, 76987628, 441.061634, 641521863, 147.932394, 232.124698, 304189298, -542502665, 1999335832);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 't1__d86242', 'pim5', '58q', 's27p2r94gth2', 'najj', 'a3o', -1428186898, -761353513, 584.372269, -1311735207, 774.197346, 446.676539, -1817527403, -1402164108, 2123471885);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2023-05-30', 'VYDAJ', 'lbn', 462974032, -1137908826, 'siie5unw6k', 'fa9', 1620389964);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (0, -1, '2021-05-25', 'VYDAJ', 'bdvlph', -261132974, -1264842910, 'wnqcx', '5hncprjtu0d', 401805964);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-1, 2, '2024-05-09', 'VYDAJ', 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 357330522);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 1, '2023-09-24', 'VYDAJ', '42q7sx58b4', -1122409769, 1849819405, 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 1, '2022-05-10', 'VYDAJ', 'jxfofws', 1719800120, -210159774, 'obb0q0k32o', 'w', 440115543);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '2022-03-26', 'VYDAJ', 'sorlwyngc1', 681061317, 1935791961, 'izgk1yoeyo6', 'l0hdt6fuqyx', -1418927432);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 1, '2025-07-12', 'VYDAJ', '1gwnlas6', -2076274980, 1731324803, 'wii1', '5nxih66', -251205568);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 4, '2023-01-01', 't3__428fe4', 'dpos', -1576219117, -1823627488, 'nw6klf', 'a9000t5c4eci', 1149850321);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T2.date LIKE '1996-01%' ORDER BY A2 ASC, T1.district_id NULLS LAST, T2.account_id NULLS LAST, T3.trans_id NULLS LAST LIMIT 10;

/*
Gold Result:
(2,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.A2, SUM(T3.amount) AS total_amount FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T3.date LIKE '1996-01%' GROUP BY T1.A2 ORDER BY total_amount DESC, T1.A2 NULLS LAST LIMIT 10;

/*
Prediction Result:
*/