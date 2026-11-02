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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'cprj', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 2, 'dz79fjg', '2022-12-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 1, 'ou5z', '2021-06-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 1, 'jla', '2025-03-08');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, 'kv42q7', '2023-03-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, '9n0jxfofwsz', '2020-08-14');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'wbbp6luhvdlt', '2023-05-30');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', 'North Bohemia', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '9000t5c4ec', 'North Bohemia', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 297.722676, -1068298341, 427.383654, 426.853398, 2137741668, -525979501, 1898504886);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'o3o9hl72klex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, 698.16972, -461695645, 694.765963, 707.476301, 176555546, -1937207087, 1675430660);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', 'North Bohemia', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2021-05-27', 'bnp', 'mdpos', -1576219117, -1823627488, 'nw6klf', 'AB', 1038707349);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '2023-10-23', '9uxj4hw', 'd', -736979194, 2103044118, 'h2gndqwnqcx5', 'AB', 580968159);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 3, '2022-05-01', 'f3dqv0gc', '9', 172461907, 1606439408, '3zb', 'AB', -1554531873);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 1, '2024-04-08', 'kn6vc', '6ah', -348113485, 138842628, 'wwlq7', 'AB', 1255343543);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 3, '2020-03-27', '72fxa7ryfd', 'z16ni', 2011234363, -1483100200, '5dh', 'AB', 1583472758);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '2021-01-25', 'gjd8y', 't1afgog', -946046410, -902895762, 'ayxp1q43', 'AB', 1235416111);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 3, '2024-10-12', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, '5w1of7', 'AB', 76996700);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '2024-06-20', '72ct', 'c', 1303877941, -1284905200, '62', 'AB', -1744557630);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 3, '2023-10-13', 'q8qdjpe1', 'o22', 2004147439, -691774480, 'ptt', 'AB', 1467355421);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2025-03-18', 'c4bfkfoac', '0', 76987628, -253138337, 'zj', 'AB', 1448731351);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2025-11-13', 'wgxd5ysxcm', '0oztd', -1699185893, 875300074, '3lq', 'AB', 1816660482);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2022-01-25', 'pim5', '58q', 1817366143, 1615073310, '7p2r94gth2m', 'AB', 418247369);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 1, '2022-08-04', 'v8u', 'tmu2n', -1817527403, -1402164108, 'yz7zzb', 'AB', 924693315);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '2024-02-23', '58b4pmaus3a', 'vmkrpd', -609553675, 989018473, 'chn9mo70', 'AB', 628082526);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 1, '2022-06-27', '2zobb0q0k32o', 'w', 440115543, 292557306, 'orlwyngc1dj', 'AB', 211603887);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483633, 1, '2023-01-25', 'iz', 'k1', 955267863, -1156828895, 'o6l0hdt', 'AB', -795975227);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '2024-05-11', 'uzkb52', 'gwnlas6', -2076274980, 1731324803, 'wii1', 't_s_f26c7f', -457369423);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '2022-04-28', 'xih662q2xly', 'otow9oaawg', 1044710644, 966412849, '0', 'bindz', 2085299664);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483630, 1, '2020-01-07', 'z9t', '8', 748154000, 1148916014, 'g', 'AB', -794767771);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 4, '2024-06-15', 'value', 'value', 1, 1, 'value', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.bank = 'AB' AND T1.A3 = 'north Bohemia';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(a.account_id) AS num_accounts FROM district AS d INNER JOIN account AS a ON d.district_id = a.district_id INNER JOIN trans AS t ON a.account_id = t.account_id WHERE d.A3 LIKE '%North Bohemia%' AND t.bank = 'AB';

/*
Prediction Result:
(17,)
*/