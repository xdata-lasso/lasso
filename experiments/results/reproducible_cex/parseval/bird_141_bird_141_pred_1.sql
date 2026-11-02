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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 1, 'yrq13p', '2024-03-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'u5', '2023-12-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, '1of77pzo72c', '2023-06-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 1, 'c', '2023-06-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483647, 'g6', '2024-12-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, '66', '2024-12-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 1, 'ri2hy08ft', '2022-09-10');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, '7dyyd', '2024-10-07');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 1, 'rhm5w', '2022-01-12');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 1, '9', '2021-07-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 3, '5s5b', '2020-04-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 3, '02eu', '2023-05-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483635, 5, 'iqa', '2024-10-16');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, '52zb', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, 176.308171, 1055976837, 913.303855, 482.572691, 105869088, -2081315180, 1909986641);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 172461907, 1606439408, 836.121091, -155284187, 892.659478, 138.057338, 982314585, 638024588, -688098735);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', -7597509, -1625552518, 849.655083, -1738458256, 100.84577, 54.980195, -458359144, 600440952, 1568069663);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 590.639932, 280.204907, 781505063, 418417917, -1031969798);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '1997-01-01', 'dpos', 'ie5', 1, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '1997-01-01', '78d99r', 'jsl', 10001, -346339240, 'yp5qi2rk', '9v', 556727997);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 1, '1997-01-01', '8pz0f8je', 'd2', 1, 1675430660, 'y9uxj4', 'wb', -1929953647);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 1, '1997-01-01', 'fgogritsj3ay', 'p1q430', 1, 1923912467, 'jh3den8c68', '8vacx7', 1523825314);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 2, '1997-01-01', '0v', 'q8qdjpe1', 1, -1180042408, '78507cvt', 'ptt', 1467355421);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '1997-01-01', 'ou5z', '36c', 1, 1722106924, 'f', 'foa', 382831862);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 2, '1997-01-01', '0', '7z2zezjo7wg', 1, 1248858185, '5', 'sxcmr0o', 853709925);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '1997-01-01', 'dgj5i', 'lq5lnpim', 1, -55240145, '8qs27p2r', '4gth2mnaj', -1478011227);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 2, '1997-01-01', '3', 'okv8uttmu2', 1, -1252009958, '78lfvyz7', 'zzbe8yvkv4', -233617564);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '1997-01-01', '7sx58b4pma', 'us3auvmkrpdj', 1, 1105964624, 'w5chn9m', 'o705a9n0jxfo', -1793230843);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 2, '1997-01-01', 'zdo2z', 'obb0q0k32o', 1, -1898678660, 'l', '5amsorlwyngc', -323362455);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '1997-01-01', 'j9erhizgk1', 'yoeyo6l0hdt6', 1, 1435223075, 'qyxuzk', '5', -206528034);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 2, '1997-01-01', 'wn', 'as6', 1, -2076274980, 'ow', 'i1z', -564679000);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '1997-01-01', '2xlyo', 'tow9oaawg96a', 1, 966412849, '0', 'bindz', 2085299664);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '1997-01-01', 'j', '9td8n5w', 10001, -1988582944, 'mbc3td', 'u6bd0w9603', -541917667);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '1997-01-01', 'rxe9yfk', 'qk162nh55', 1, 2105860871, 'dohvu06d', 'a35rmki', -1160642134);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '1997-01-01', 'ewtqxxnja', 'bymzn2mfx7h3', 1, -891525031, '1cj8', 'h5knz', 1966809332);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '1997-01-01', 'jmgjach8qt', 'a8y3a17v4yg', 1, -2081662466, '3qdpu', 'p', -845136979);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483630, 1, '1997-01-01', 'c7d', 'n2np490xdms', 1, -1027584872, 'el', 'u', 422046500);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483629, 1, '1997-01-01', 'f2ccukjq1', 'uik1y', 1, 775289854, '0', 'hlst1pqom', 2141720493);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483628, 1, '2024-06-15', 'vb6m4iz78aq', 'lud8f', 1, -835782528, 'r9114qbre', '6bjeuuwsj8k', -1486030107);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483627, 1, '2024-06-15', '5wpxlvris', 'urz0kaqtncg', 1, 428944759, 's3b7v88kw', 'm', 1633584225);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, -2147483642, '1997-01-01', 'yytoo', 'o9hl72kl', 2, -305670381, 'i7z', 'au2dwy', -953437896);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, -2147483642, '1997-01-01', '3pyu78d99r', 'jsl', 3, -346339240, 'yp5qi2rk', '9v', 556727997);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483624, 6, '1997-01-01', '8pz0f8je', 'd2', 1675430660, -688509700, '9uxj4hwbdvl', 'h2gn', 1968874827);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T1.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1997' GROUP BY T1.district_id HAVING SUM(T3.amount) > 10000;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT district.A2 FROM district JOIN account ON district.district_id = account.district_id JOIN trans ON account.account_id = trans.account_id WHERE trans.amount > 10000 AND STRFTIME('%Y', trans.date) = '1997';

/*
Prediction Result:
('5k5swwqcgs',)
*/