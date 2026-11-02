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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, '6nium52zb', '2023-08-27');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'nrqrofqy', '2022-09-19');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'dposiie5unw', '2025-09-21', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483646, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483642, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483641, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483640, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483639, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 1, 1, '72k');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, 1, 1, 'x1');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '2021-10-25', 1, 1151980946, 83.204633, '9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2024-07-24', 1, 546571701, 801.414196, '0t5c4ecigce');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (0, 3, '2025-06-25', 1, 1884179925, 499.570479, 'bbp02eutliqa');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-1, 3, '2024-10-16', 1, 2074205376, 274.580687, 'ytoo3o9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2025-05-30', -1525670226, -453362185, 612.02959, '2dwyrq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 1, '2024-11-10', 392822403, 2142703426, 375.832821, '8d99rljsl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT c.client_id FROM client AS c JOIN disp AS d ON c.client_id = d.client_id JOIN account AS a ON d.account_id = a.account_id JOIN loan AS l ON a.account_id = l.account_id ORDER BY l.amount DESC, c.client_id NULLS LAST, d.disp_id NULLS LAST, a.account_id NULLS LAST, l.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/