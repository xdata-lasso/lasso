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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, -2147483648, 'cx5hn', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, -2147483648, 'yrk', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, -2147483648, 'dh5ogrgj', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, -2147483648, 'c', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, -2147483648, '7cvtjpttg6b', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, -2147483648, 'm', '1996-10-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, -2147483648, '8uttmu', '1996-10-21');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2023-01-01', 'dpos', 'ie5', 1, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2023-01-30', 'fqyp', 's5bbp02e', 1, -751275471, 'iqa', '1ryytoo', 1644911394);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2022-07-25', 'hl72klex1', 'ji7zwau2', 1, 364869063, 'q13py', '78d99r', -1362461264);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 4, '2025-06-26', 'pz0f8jegd', '1vy9uxj4', 1, -1612443122, 'd', 'lph2gn', 1968874827);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 4, '2020-06-20', 'rjtu', 'dz79fjg', 1, -1255130038, '3d', 'qv0gcb98ozk', -155284187);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 4, '2022-04-12', '6vck6ah0f8js', 'wlq7xb', 1, 602161869, 'xa', '7ryfdrz16n', -1496556994);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 4, '2020-08-13', 'yzt1afgog', 'itsj3', 1, -491938169, '1q43', '1jh3den', 357330522);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 4, '2024-02-23', 'afu5w1of7', 'pzo72ctdc', 1, 1303877941, 'mfg62g0v5q8q', 'j', -1139855872);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 1, '2022-06-10', 'u5zi', '6c4bfkfo', 1, -1950324754, '7z2zezj', '7wgx', -57705450);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2023-01-12', '0oztdgj5i3lq', '5lnpim5k58qs', 1, 1615073310, '7p2r94gth2m', 'ajjl', -2096405521);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 1, '2025-01-03', 'e578', 'fvy', 1, -451030047, 'be8yvkv42q7', 'x58b4', -1122409769);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date = '1996-10-21' ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(trans.amount) AS biggest_transaction_amount FROM card JOIN disp ON card.disp_id = disp.disp_id JOIN trans ON disp.account_id = trans.account_id WHERE card.issued = '1996-10-21';

/*
Prediction Result:
(None,)
*/