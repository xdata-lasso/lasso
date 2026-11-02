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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'yrq13p', '2024-03-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 1, '78d99r', '2022-01-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'qdjpe1io2', '2024-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, '8507cvtjp', '2023-06-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, '6b', '2022-06-10');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, '162nh55y3d', '2022-07-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 1, 'rhm5w', '2022-01-12');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, '9', '2021-07-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 1, 'vb6m4iz78aq', '2022-11-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 1, '85', '2024-01-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 3, '5s5b', '2020-04-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483636, 1, '02eu', '2023-05-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 3, 'iqa', '2024-10-16');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, '52zb', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, 176.308171, 1055976837, 913.303855, 482.572691, 105869088, -2081315180, 1909986641);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'nqcx5h', 'cprj', 'u0dz7', 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 508.771546, 834709651, 418.948509, 532.326819, -932772113, -639539893, 1255343543);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 't1afgog', 'itsj3', -491938169, -106471771, 787.642728, 1923912467, 571.595144, 620.748111, 1948383687, 1476361420, 195720193);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 590.639932, 280.204907, 781505063, 418417917, -1031969798);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '1997-01-01', 'dpos', 'ie5', 10001, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '1997-01-01', 'sl0', '4', 10001, 1649269347, 'p5qi2rkf9v', 'x58pz', -1529584866);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 1, '1997-01-01', 'd2', 'vy9uxj4', 1, -1612443122, 'd', 'lph2gn', 1968874827);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 1, '1997-01-01', 'vacx7afu5', '1of77p', 10001, -435350511, '72ctdctmfg62', '0v', 820970595);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 5, '1997-01-01', 'u5zi', '6c4bfkfo', 10001, -1950324754, '7z2zezj', '7wgx', -57705450);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '1997-01-01', 'xcmr0', 'ztdg', 10001, -20116244, 'lq5lnpim', 'k58qs27p', 988954859);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 5, '1997-01-01', 'th', '2mnajjla3o', 10001, -1428186898, 'uttmu2ne5', '78lfvyz7zz', -2052653308);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '1997-01-01', 'yvkv42q7s', '58b4pm', 10001, 1849819405, 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 5, '1997-01-01', '9n0jxfofwsz', 'o', 10001, 1010672881, 'obb0q0k', '2odwcl5a', 292557306);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '1997-01-01', 'orlwyngc1dj', '9erhizgk1yoe', 10001, 1483450542, 'o6l0hdt6fu', 'yxuzk', 450555855);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 5, '1997-01-01', '1gwnlas6', 'elboeowii1', 10001, -457369423, 'xih6', '2q2xlyoto', 1774679448);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '1997-01-01', 'oaawg96aq', '0', 10001, -850941333, 'indz39tajz', 'td8n5wcgu', -1275298282);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 5, '1997-01-01', '3', 'tdu6bd0w96', 10001, -379749892, 'vzxw1rxe9y', 'k7', -1046720861);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '1997-01-01', 'vu', '6dza35r', 10001, 2072023304, 'io18ri2hy08', 'tp', 24053253);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '1997-01-01', 'tqxxnj', 'b', 10001, -1312038093, 'n2mfx7h33p', '6sto1cj8sh5k', 1106724223);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '1997-01-01', 'ys7dyyd1jmg', 'jach8qta8y3', 1, -2125172723, 'v4ygmayq3', 'dpuap', -845136979);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '1997-01-01', 'c7d', 'n2np490xdms', 10001, -1027584872, 'el', 'u', 422046500);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '1997-01-01', 'f2ccukjq1', 'uik1y', 10001, 775289854, '0', 'hlst1pqom', 2141720493);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483630, 1, '1997-01-01', 'ud8', 'tb', 10001, 192271618, '9114qbre6bj', 'uu', -1451520332);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483629, 1, '1997-01-01', 'xlvr', 'sur', 10001, -459075802, 'aqt', 'ncgc8s3b7v', 180947503);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483628, 1, '2024-06-15', 'dmdbdh', '6j47n', 1, -556370776, '50hsj', 'an', 1195320303);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, -2147483642, '1997-01-01', 'yytoo', 'o9hl72kl', 2, -305670381, 'i7z', 'au2dwy', -953437896);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, -2147483642, '1997-01-01', '3pyu78d99r', 'jsl', 3, -346339240, 'yp5qi2rk', '9v', 556727997);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483625, 6, '1997-01-01', '8pz0f8je', 'd2', 1675430660, -688509700, '9uxj4hwbdvl', 'h2gn', 1968874827);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T1.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1997' GROUP BY T1.district_id HAVING SUM(T3.amount) > 10000;

/*
Gold Result:
(1,)
(3,)
(5,)
*/

-- Prediction Query
SELECT D.A2 AS district_name FROM trans AS T INNER JOIN account AS A ON T.account_id = A.account_id INNER JOIN district AS D ON A.district_id = D.district_id WHERE T.amount > 10000 AND STRFTIME('%Y', T.date) = '1997';

/*
Prediction Result:
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('nqcx5h',)
('5k5swwqcgs',)
('nqcx5h',)
('5k5swwqcgs',)
('nqcx5h',)
('5k5swwqcgs',)
('nqcx5h',)
('5k5swwqcgs',)
('nqcx5h',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
*/