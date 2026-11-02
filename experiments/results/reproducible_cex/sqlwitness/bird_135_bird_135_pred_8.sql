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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'VYBER KARTOU', 'POPLATEK MESICNE', 'default2', 'VYDAJ', 'default1', 'default1', 0, -1, -1.0, 1, 0.0, -1.0, 1, 0, -1), (1, 'default2', 'VYBER KARTOU', 'VYBER KARTOU', 'VYDAJ', 'default2', 'VYDAJ', -1, 0, 0.0, 1, -1.0, 0.0, -1, NULL, 0), (-1, 'VYDAJ', 'default1', 'default1', 'default2', 'POPLATEK MESICNE', 'VYDAJ', -1, 0, 1.0, -1, -1.0, -1.0, 1, 1, -1), (2, 'VYDAJ', 'VYBER KARTOU', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'VYDAJ', -1, -1, 1.0, 0, -1.0, 0.0, -1, 0, 1), (3, 'VYBER KARTOU', 'VYBER KARTOU', 'VYBER KARTOU', 'VYBER KARTOU', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 0, 1, 0.0, 0, NULL, -1.0, -1, NULL, 1), (4, 'POPLATEK MESICNE', 'VYDAJ', 'default1', 'VYDAJ', 'VYDAJ', 'POPLATEK MESICNE', -1, 0, 1.0, 1, 1.0, 0.0, -1, 0, 0), (5, 'VYBER KARTOU', 'POPLATEK MESICNE', 'default1', 'VYDAJ', 'POPLATEK MESICNE', 'default2', -1, 0, 1.0, -1, NULL, 1.0, -1, 1, 0), (6, 'VYBER KARTOU', 'POPLATEK MESICNE', 'default1', 'default1', 'VYBER KARTOU', 'POPLATEK MESICNE', 1, 1, -1.0, -1, 1.0, -1.0, 0, 0, 0), (7, 'default1', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'default2', 'VYBER KARTOU', 0, 0, -1.0, 0, NULL, 0.0, 0, NULL, 0), (8, 'default1', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'VYDAJ', 'default2', 1, 1, 0.0, 0, NULL, -1.0, 0, -1, -1), (9, 'POPLATEK MESICNE', 'VYBER KARTOU', 'default1', 'default1', 'default1', 'VYDAJ', -1, -1, -1.0, 1, -1.0, 0.0, 0, 1, -1), (10, 'default2', 'VYBER KARTOU', 'VYDAJ', 'default1', 'VYBER KARTOU', 'VYDAJ', 0, -1, 1.0, -1, NULL, -1.0, 0, NULL, -1), (11, 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'VYDAJ', 'VYBER KARTOU', 'VYDAJ', 'default2', 0, 0, 1.0, 1, 1.0, -1.0, -1, 1, -1), (12, 'default2', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'VYDAJ', 'default2', 'default2', 0, -1, 1.0, 1, -1.0, 0.0, 0, -1, 0), (13, 'VYDAJ', 'default2', 'default2', 'VYBER KARTOU', 'default2', 'default2', 0, -1, 0.0, 1, -1.0, 1.0, 0, -1, 0), (14, 'default2', 'default1', 'VYBER KARTOU', 'default1', 'VYBER KARTOU', 'default2', 0, 0, -1.0, 0, NULL, -1.0, -1, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'POPLATEK MESICNE', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 0, '2023-01-02', 'default1', 'POPLATEK MESICNE', 0, 0, 'POPLATEK MESICNE', 'default1', 0), (-1, 0, '2023-01-02', 'default1', 'VYDAJ', -1, -1, 'default2', 'VYBER KARTOU', 0), (0, 0, '2023-01-02', 'default2', 'default1', 0, -1, 'default1', 'default1', 1), (2, 0, '2023-01-02', 'VYDAJ', 'default1', 0, 0, 'VYDAJ', 'default2', -1), (3, 0, '2023-01-01', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 1, -1, 'POPLATEK MESICNE', 'VYBER KARTOU', NULL), (4, 0, '2023-01-02', 'VYBER KARTOU', 'VYDAJ', 0, 1, 'POPLATEK MESICNE', 'default1', 0), (5, 0, '2023-01-02', 'POPLATEK MESICNE', NULL, 1, 0, 'default1', 'default1', 0), (6, 0, '2023-01-02', 'VYDAJ', NULL, 1, 0, 'VYBER KARTOU', 'POPLATEK MESICNE', 1), (7, 0, '2023-01-02', 'VYBER KARTOU', 'POPLATEK MESICNE', 0, 1, 'POPLATEK MESICNE', 'default2', 0), (8, 0, '2023-01-01', 'POPLATEK MESICNE', 'VYDAJ', 0, 0, NULL, NULL, 1), (9, 0, '2023-01-02', 'VYDAJ', 'default1', 0, -1, 'default1', 'VYDAJ', -1), (10, 0, '2023-01-01', 'VYDAJ', 'default1', 0, 1, NULL, 'default2', NULL), (11, 0, '2023-01-01', 'VYBER KARTOU', 'default2', -1, 0, 'POPLATEK MESICNE', 'VYBER KARTOU', 0), (12, 0, '2023-01-01', 'POPLATEK MESICNE', NULL, -1, -1, 'default1', 'VYBER KARTOU', 1), (13, 0, '2023-01-02', 'VYDAJ', NULL, -1, -1, 'default1', 'default2', NULL), (14, 0, '2023-01-01', 'default1', 'VYBER KARTOU', -1, 0, 'default1', NULL, NULL), (15, 0, '2023-01-02', 'default2', 'VYDAJ', 1, -1, 'VYDAJ', 'VYDAJ', NULL), (16, 0, '2023-01-02', 'VYDAJ', NULL, -1, 1, 'default1', 'default2', 1), (17, 0, '2023-01-01', 'default1', 'VYBER KARTOU', -1, 0, 'default2', 'default2', 0), (18, 0, '2023-01-02', 'POPLATEK MESICNE', 'VYBER KARTOU', 1, -1, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.balance < 0 AND T1.operation = 'VYBER KARTOU' AND T2.frequency = 'POPLATEK MESICNE';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T.account_id) FROM (SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'VYDAJ' AND T1.operation = 'VYBER KARTOU' AND T1.balance < 0 AND T2.frequency = 'POPLATEK MESICNE' GROUP BY T1.account_id) AS T;

/*
Prediction Result:
(0,)
*/