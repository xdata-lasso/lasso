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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 2, '1vy9uxj4', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -1, 'fdrz16n', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, -1, 'jja', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 0, 'dh5ogrgj', '2020-08-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 2, '68x8vacx7a', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, -1, 'qdjpe1io2', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 2, '6c4bfkfo', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 0, 'im5k', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 2, '2ne578', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 0, 'us3auvmkrpdj', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 3, 'ilbnp', '1996-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't1__965f91', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, '!', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 556727997, 1178000634, 541.393553, 1836127587, 410.133844, 88.474525, -1529584866, 1196308825, 910894705);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-1, '$', 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', -348113485, 138842628, 282.822068, -639539893, 260.513699, 969.559316, 1255343543, -541746689, 1294666887);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2023-05-30', 'VYDAJ', 'lbn', 462974032, -1137908826, 'siie5unw6k', 'fa9', 1620389964);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '2021-05-25', 'VYDAJ', 'bdvlph', -261132974, -1264842910, 'wnqcx', '5hncprjtu0d', 401805964);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 3, '2024-05-09', 'VYDAJ', 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 357330522);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 1, '2021-01-02', 'VYDAJ', '5w1of7', 76996700, -435350511, '72ctdctmfg62', '0v', 820970595);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 3, '2024-12-31', 'VYDAJ', '8507cvtjp', 1582582341, 453836040, '6b', 'ou5z', 1691780814);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '2020-02-20', 'VYDAJ', 'cd07z2zezjo7', 304189298, -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 1339733032);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 3, '2025-07-11', 'VYDAJ', 'qs27p2r94', -1719383707, 1273687251, '2mnajjla3o', 'v8u', 618058035);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '2021-12-11', 'VYDAJ', 'vy', -451030047, -2052653308, 'yvkv42q7s', '58b4pm', 1849819405);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 3, '2024-01-06', 'VYDAJ', 'w5chn9m', 823835795, -354292049, 'a9n0jxfofws', 'do2zobb', -397848196);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2024-08-25', 'VYDAJ', '32o', -1898678660, 440115543, 'msorlwyngc', 'dj9erhi', 1056589776);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 1, '2021-03-12', 'VYDAJ', 'k1yoeyo6l0h', -1942581013, -795975227, 'xuzkb52', 'gwnlas6', -2076274980);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '2020-11-13', 'VYDAJ', 'wii1', -457369423, 1557188093, 'xih662q2xly', 'otow9oaawg', 1044710644);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 1, '2022-11-13', 'VYDAJ', '0', -850941333, -1216952047, '39tajz9', 'd8n5w', -1988582944);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 4, '2023-01-01', 't3__a67267', 'dpos', -1576219117, -1823627488, 'nw6klf', 'a9000t5c4eci', 1149850321);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T2.date LIKE '1996-01%' ORDER BY A2 ASC, T1.district_id NULLS LAST, T2.account_id NULLS LAST, T3.trans_id NULLS LAST LIMIT 10;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.A2, SUM(T3.amount) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T3.operation <> 'VYBER KARTOU' AND T3.date LIKE '1996-01%' GROUP BY T1.A2 ORDER BY SUM(T3.amount) DESC, T1.A2 NULLS LAST LIMIT 10;

/*
Prediction Result:
*/