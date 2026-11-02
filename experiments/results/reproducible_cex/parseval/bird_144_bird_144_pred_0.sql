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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, -2147483648, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'e', '2025-03-28');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, '72k', '2021-12-23');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'dposiie5unw', '2025-09-21', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, -2147483648, -2147483648, 'lfa');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483648, -2147483648, 'liqa1');

-- Inserting into table: card --
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483648, 1, '9000t5c4ec', '2021-06-11');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483647, 3, 'ryytoo3', '2022-07-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483646, 3, 'jsl', '2024-09-13');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483645, 3, 'gd', '2025-01-26');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483644, 3, 'cx5hn', '2020-06-20');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483643, 1, 'k3zbily', '2023-02-18');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483642, 1, 'grgj', '2020-08-13');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483641, 1, 'yzt1afgog', '2023-02-19');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483640, 1, 'tsj', '2025-02-02');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483639, 1, 'vacx7afu5', '2023-12-23');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (5, 1, 'bfkfoacd', '2024-08-20');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (7, 1, '7z2zezjo7wg', '2024-03-10');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (2, 1, '5lnpi', '2022-03-19');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (3, 1, 'ia2yp', '2023-08-23');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (4, 1, 'posiie5unw6k', '2021-12-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (6, 1, 'ia2yp', '2023-08-23');

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2021-01-31', '6nium52zb', 'VYBER KARTOU', 757448742, -1179823637, 'rqro', 'fqyp5s5bbp0', 743312762);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 2, '2021-01-31', 'x1', 'VYBER KARTOU', -74849714, 105869088, 'au2dwy', 'q13py', 244829661);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 2, '2021-01-31', '4', 'VYBER KARTOU', 1649269347, -1116181514, 'i2rkf', 'vqx58pz0f', 176555546);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 2, '2021-01-31', 'vy9uxj4', 'VYBER KARTOU', -1612443122, -2050247126, 'lph2gn', 'q', -664193365);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 2, '2021-01-01', 'rjtu', 'VYBER KARTOU', -361507387, 401805964, 'gq8', 'n2f3dqv0gcb9', 172461907);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2021-01-31', 'kn6vck6ah0f8', 'VYBER KARTOU', -1520489792, -658391922, 'q7x', '7', 602161869);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2021-01-31', 'xa', 'VYBER KARTOU', 1294666887, -515895469, 'r', 'z16nijjai5d', -1625552518);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '2024-06-15', 'y', 'p1q430', 1923912467, 518609210, '3d', 'n8', 195720193);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 1, '2024-11-06', 'f77p', 'o72ctdc', 1303877941, -1284905200, '62', '0v', 820970595);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 1, '2022-12-09', 'j', 'e1io', -241848752, 2004147439, 'tjpttg', 'bnou5zi36', 1944978593);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 1, '2021-08-31', '5', 'VYBER KARTOU', -526612570, -546516406, 'r0oz', 'dgj5i', -176606723);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (7, 1, '2002-01-31', '5k5swwqcgs', 'VYBER KARTOU', 247012447, -1980249628, 'gu7v', 'e4', 1160656988);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (8, 1, '2002-04-30', 'hsrwbbp', 'VYBER KARTOU', 13244799, -1659388584, 'l', 'tilbn', 462974032);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (9, 1, '2021-01-01', '5k5swwqcgs', 't1__e14c73', 247012447, -1980249628, 'gu7v', 'e4', 1160656988);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '2021' AND T3.operation = 'VYBER KARTOU';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.amount) FROM trans AS T1 INNER JOIN card AS T2 ON T1.account_id = T2.disp_id WHERE T1.operation = 'VYBER KARTOU' AND STRFTIME('%Y', T1.date) = '2021' AND STRFTIME('%m', T1.date) = '01';

/*
Prediction Result:
(177208612.33333334,)
*/