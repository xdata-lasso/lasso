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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 3, 'qv0gcb98ozk', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'den8c68x', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483644, 'acx7af', '2023-07-08');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (0, 3, '7cvtjpttg6b', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, '9y', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, 'ri2hy08ft', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 1, '6ewt', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, 'xxnja', '1996-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'ilbnp', '1996-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't1__fbda59', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '@', '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'A', 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', -1116181514, 1255852738, 137.842122, -975213201, 811.601922, 92.834164, -705985602, 537874887, -461695645);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -841004020, -361507387, 395.809081, 401805964, 154.065416, 261.415754, -1255130038, -1762857309, 806170397);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, 'a', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', -946046410, -902895762, 453.914926, 2111987706, 360.694313, 959.196496, 1792827279, 804529642, -1538707438);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, '`', 'w1of77pz', '72ct', 'c', 'mfg62', '0v', 820970595, 1421303999, 53.966914, -1488156735, 67.250709, 140.053935, -1180042408, 199672698, 2119806856);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'P', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', -176606723, -15162884, 811.930904, -1556979799, 487.138399, 821.273487, 195202164, 1817366143, 1615073310);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483641, 'A', 'vy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 736.632717, 1105964624, 401.500141, 345.578764, -2013213247, 101754718, 628082526);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '#', '9n0jxfofwsz', 'o', '2zobb0q0k32o', 'w', 'l', 895277769, 364043263, 938.014057, -1177989415, 184.987451, 379.040817, 1953495465, -1960313034, 681061317);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483639, '7', 'iz', 'k1', 'yoeyo6l0hdt6', 'uq', 'xuzkb52', -277407746, -670154354, 176.569118, -2140468103, 509.069144, 609.392845, 1468640756, 1048147204, -1814875250);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, '0', 'qb0tbindz39t', 'j', '9td8n5w', 'g', 'mbc3td', 1964331395, -1943814113, 790.320515, 1514371324, 843.769504, 998.234157, -379749892, -541917667, -961629819);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2023-05-30', 'VYDAJ', 'lbn', 462974032, -1137908826, 'siie5unw6k', 'fa9', 1620389964);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (0, 1, '2025-03-14', 'VYDAJ', 'bilyrkn', -688098735, 1784916884, 'ah0f8jsww', 'q7x', -541746689);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 1, '2022-06-10', 'VYDAJ', 'u5zi', 1944978593, 1722106924, 'f', 'foa', 382831862);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 2, '2025-11-05', 'VYDAJ', 'p2r94gth2mna', -1524425594, -1351793914, 'okv8uttm', '2ne578', 1908593332);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 1, '2023-12-01', 'VYDAJ', 'i1z', -564679000, -251205568, 'xlyotow9', 'aawg', 1044710644);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2020-12-14', 'VYDAJ', '7qk', 643589729, -1231488097, '55y3dohvu06d', 'a35rmki', -1160642134);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 4, '2023-01-01', 't3__28393c', 'dpos', -1576219117, -1823627488, 'nw6klf', 'a9000t5c4eci', 1149850321);
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
*/

-- Prediction Query
SELECT d.A2 FROM trans AS t INNER JOIN account AS a ON t.account_id = a.account_id INNER JOIN district AS d ON a.district_id = d.district_id WHERE t.date LIKE '1996-01%' AND t.type = 'VYDAJ' ORDER BY t.amount DESC, t.trans_id NULLS LAST, a.account_id NULLS LAST, d.district_id NULLS LAST LIMIT 10;

/*
Prediction Result:
*/