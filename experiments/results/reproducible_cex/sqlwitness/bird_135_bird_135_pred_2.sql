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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'default2', 'default1', 'default2', 'default2', 'default2', -1, 0, -1.0, 1, -1.0, 1.0, -1, NULL, 0), (-1, 'default1', 'POPLATEK MESICNE', 'VYBER KARTOU', 'default1', 'default1', 'POPLATEK MESICNE', -1, -1, 1.0, 1, NULL, -1.0, -1, -1, 1), (1, 'default2', 'default2', 'default2', 'POPLATEK MESICNE', 'default1', 'POPLATEK MESICNE', 0, 1, -1.0, 1, NULL, -1.0, 1, -1, 1), (2, 'VYBER KARTOU', 'default2', 'default2', 'POPLATEK MESICNE', 'VYBER KARTOU', 'default2', 1, 0, -1.0, -1, 1.0, -1.0, 0, 0, 0), (3, 'default2', 'default1', 'POPLATEK MESICNE', 'VYBER KARTOU', 'default2', 'POPLATEK MESICNE', -1, 1, 1.0, 0, 1.0, -1.0, 0, -1, 0), (4, 'default1', 'VYBER KARTOU', 'default2', 'VYBER KARTOU', 'VYBER KARTOU', 'VYBER KARTOU', 1, 0, 1.0, 1, -1.0, -1.0, 1, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (-1, 1, 'default1', '2023-01-01'), (1, 1, 'default2', '2023-01-01'), (0, 0, 'default1', '2023-01-01'), (2, -1, 'default2', '2023-01-01'), (3, -1, 'POPLATEK MESICNE', '2023-01-01'), (4, 4, 'default2', '2023-01-02'), (5, 4, 'default1', '2023-01-01'), (6, 2, 'default1', '2023-01-01'), (7, 1, 'POPLATEK MESICNE', '2023-01-02'), (8, 1, 'default1', '2023-01-01'), (9, 1, 'default1', '2023-01-01'), (10, 4, 'default2', '2023-01-01'), (11, 1, 'POPLATEK MESICNE', '2023-01-02'), (12, 2, 'VYBER KARTOU', '2023-01-02'), (13, 1, 'POPLATEK MESICNE', '2023-01-01'), (14, -1, 'VYBER KARTOU', '2023-01-02'), (15, 0, 'default2', '2023-01-02'), (16, 0, 'VYBER KARTOU', '2023-01-01'), (17, 0, 'default1', '2023-01-02'), (18, 2, 'default1', '2023-01-02'), (19, 3, 'VYBER KARTOU', '2023-01-02'), (20, -1, 'default1', '2023-01-01'), (21, 3, 'VYBER KARTOU', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (-1, -1, 'POPLATEK MESICNE', '2023-01-02'), (0, 2, 'POPLATEK MESICNE', '2023-01-01'), (1, 3, 'default2', '2023-01-02'), (2, -1, 'default1', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (-1, 1, '2023-01-02', 'default1', 'POPLATEK MESICNE', 0, -1, 'VYBER KARTOU', NULL, NULL), (1, 2, '2023-01-02', 'default1', 'default1', 0, 1, 'default1', 'VYBER KARTOU', -1), (0, 1, '2023-01-01', 'default2', 'default1', -1, 1, NULL, 'default1', 1), (2, 0, '2023-01-02', 'VYBER KARTOU', NULL, 1, 0, 'default2', 'default1', NULL), (3, 2, '2023-01-01', 'VYBER KARTOU', 'default2', 1, -1, NULL, 'default1', -1), (4, 2, '2023-01-01', 'POPLATEK MESICNE', NULL, -1, -1, 'default1', NULL, 1), (5, 0, '2023-01-02', 'VYBER KARTOU', 'POPLATEK MESICNE', 1, 0, 'default2', NULL, 0), (6, 1, '2023-01-01', 'default1', 'VYBER KARTOU', -1, 0, 'VYBER KARTOU', NULL, -1), (7, 0, '2023-01-01', 'VYBER KARTOU', 'default1', -1, 0, 'POPLATEK MESICNE', 'VYBER KARTOU', NULL), (8, 0, '2023-01-01', 'POPLATEK MESICNE', NULL, 0, 0, 'default2', 'VYBER KARTOU', 1), (9, 0, '2023-01-01', 'default2', 'VYBER KARTOU', 1, -1, 'default1', 'default1', 0), (10, 2, '2023-01-01', 'default1', NULL, -1, -1, NULL, 'default2', 1), (11, 2, '2023-01-02', 'default2', 'VYBER KARTOU', 1, 1, 'default1', 'default1', 1), (12, 2, '2023-01-01', 'VYBER KARTOU', 'VYBER KARTOU', -1, 0, NULL, NULL, -1), (13, -1, '2023-01-01', 'default1', 'POPLATEK MESICNE', -1, 1, 'default2', 'POPLATEK MESICNE', 0);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 2, 6, 'VYBER KARTOU'), (0, 2, 12, 'VYBER KARTOU'), (-1, -1, 11, 'default1'), (2, 1, 11, 'default1');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 2, 'default2', '2023-01-01'), (-1, 0, 'default2', '2023-01-01'), (0, -1, 'default2', '2023-01-01'), (2, 0, 'default2', '2023-01-01'), (3, 2, 'default1', '2023-01-02'), (4, 2, 'default1', '2023-01-01'), (5, 2, 'POPLATEK MESICNE', '2023-01-02'), (6, 2, 'default1', '2023-01-01'), (7, -1, 'VYBER KARTOU', '2023-01-01'), (8, 2, 'default1', '2023-01-01'), (9, 1, 'POPLATEK MESICNE', '2023-01-02'), (10, 0, 'VYBER KARTOU', '2023-01-02'), (11, 2, 'POPLATEK MESICNE', '2023-01-01'), (12, 0, 'POPLATEK MESICNE', '2023-01-02'), (13, -1, 'default1', '2023-01-01'), (14, 1, 'default2', '2023-01-01'), (15, -1, 'VYBER KARTOU', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.balance < 0 AND T1.operation = 'VYBER KARTOU' AND T2.frequency = 'POPLATEK MESICNE';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "account"."account_id") FROM "account" INNER JOIN "trans" ON "account"."account_id" = "trans"."account_id" INNER JOIN "disp" ON "account"."account_id" = "disp"."account_id" INNER JOIN "card" ON "disp"."disp_id" = "card"."disp_id" WHERE "trans"."operation" = 'VYBER KARTOU' AND "account"."frequency" = 'POPLATEK MESICNE' AND "trans"."balance" < 0;

/*
Prediction Result:
(0,)
*/