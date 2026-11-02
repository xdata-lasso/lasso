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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'ilbnp', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'oo3o9', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, '72klex14ji7z', '2023-12-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 'qi2rkf9v', '2022-12-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, '5sw', '1997-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2022-02-26', 'dposiie5unw', 'klfa9000t', 3001, 1408123494, '4', 'ecigce376n', 1313172851);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '2023-08-15', '52zb', 'uo4nrqrofqy', 3001, -1106983592, '5bbp0', '2eutliqa11r', 2137741668);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 3, '2020-03-04', '2dwyrq', '3pyu78d', 3001, -977635379, 'sl0', '4', 1649269347);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 4, '2024-02-23', '8pz0f8je', 'd2', 3001, 1675430660, 'y9uxj4', 'wb', -1929953647);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 3, '2021-04-26', 'gndqwnqc', 'x5hncprjtu0', 3001, -1898531797, '9fjgq8n2f', 'dqv0gcb9', 172461907);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 4, '2024-07-01', '3zb', 'lyr', 3001, 1038566008, 'n6vck6ah0f', 'jswwlq7xb', 602161869);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 3, '2020-02-10', '7ryfdrz16n', 'jja', 3001, -7597509, 'h5ogrgjd8yz', '1afgo', -1696173285);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 4, '2021-06-05', 'tsj3ayxp1q4', '01jh3den', 3001, 357330522, '68x8vacx7a', 'u5', -290314193);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2024-06-20', '72ct', 'c', 3001, 1303877941, 'mfg62g0v5q8q', 'j', -1139855872);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2024-11-08', 'o22', '8507cvtjp', 3001, 1582582341, 'tg6bnou5zi', '6c4bfkfo', -1950324754);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 1, '2021-08-28', '7wgx', '5', 3001, -526612570, 'cmr0oz', 'dgj5i', -176606723);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '2022-12-17', '5lnpim5k58qs', '7p2r94gt', 3001, 1273687251, '2mnajjla3o', 'v8u', 618058035);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 1, '2022-05-03', '57', 'lfvyz7zzb', 3000, 924693315, 'kv42q7', 'x58b4', -1122409769);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '2020-01-10', 'us3auvmkrpdj', 'wzw5chn9mo70', 3000, 628082526, '9n0jxfofwsz', 'o', 1010672881);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 1, '2024-06-24', 'obb0q0k32o', 'w', 1, 440115543, 'msorlwyngc', 'dj9erhi', 1056589776);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483633, 1, '2024-04-20', 'eyo6', 'l0hdt6fuqyx', 3001, -1418927432, '521gwnlas6e', 'lboeowii1z5', 1557188093);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '2024-02-18', 'h66', 'q2xlyoto', 3001, 1774679448, 'oaawg96aq', '0', -850941333);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 5, '2024-01-05', 'cgsk9', '8c4p', 3000, 1871297066, 'u7vfe4hria2y', 'uzhs', 700293388);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T2.date) < '1997' AND T1.amount > 3000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date < '1997-01-01' AND T2.amount > 3000;

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/