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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'ilbnp', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, -2147483648, 'zbuo4nrq', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (0, -2147483648, 'b4yp5qi', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 'kf9vq', '2024-02-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, -2147483648, 'yrk', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, -2147483648, 'zjo7wgxd5ysx', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, -2147483648, '0oztd', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, -2147483648, '5i3lq5lnpim5', '1996-10-21');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2023-01-01', 'dpos', 'ie5', 1, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2023-01-30', 'fqyp', 's5bbp02e', 1, -751275471, 'iqa', '1ryytoo', 1644911394);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2022-07-25', 'hl72klex1', 'ji7zwau2', 1, 364869063, 'q13py', '78d99r', -1362461264);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-1, 4, '2025-06-26', 'pz0f8jegd', '1vy9uxj4', 1, -1612443122, 'd', 'lph2gn', 1968874827);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (0, 4, '2023-11-15', 'qcx5', 'hncprjtu0dz', 0, -1748371085, 'q8', 'n2f3dqv0gcb9', 172461907);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '2021-10-25', 'ah0f8jsww', 'q7x', 1, -541746689, '7ryfdrz16n', 'jja', -7597509);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 1, '2025-06-24', 'grgj', '8', 1, -458359144, '1afgogritsj', 'ayxp1q43', 1235416111);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '2021-08-03', '3d', 'n8', 1, 195720193, 'vacx7afu5', '1of77p', -435350511);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 1, '2020-06-30', 'dctmf', '62', 1, -1744557630, '5q8qdj', 'e1io', -241848752);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2024-08-05', '7cvtjpttg6b', 'ou5z', 1, 1691780814, '6c4bfkfo', 'c', -406331049);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date = '1996-10-21' ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(trans.amount) AS max_transaction_amount FROM card INNER JOIN disp ON card.disp_id = disp.disp_id INNER JOIN account ON disp.account_id = account.account_id INNER JOIN trans ON account.account_id = trans.account_id WHERE card.issued = '1996-10-21';

/*
Prediction Result:
(None,)
*/