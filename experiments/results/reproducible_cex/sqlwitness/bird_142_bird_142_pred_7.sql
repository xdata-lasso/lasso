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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'SIPO', 'Pisek', 'default2', 'Pisek', 'Pisek', 'SIPO', 0, 1, 1.0, 1, NULL, 1.0, 1, 0, 1), (0, 'Pisek', 'SIPO', 'default2', 'SIPO', 'default2', 'default1', 0, 0, 1.0, 1, 1.0, 1.0, 0, NULL, 1), (2, 'SIPO', 'Pisek', 'default1', 'default2', 'Pisek', 'default2', 0, 1, 1.0, 0, 1.0, 1.0, 0, NULL, 1), (3, 'default1', 'default2', 'default1', 'SIPO', 'default2', 'Pisek', 1, 1, 1.0, 0, NULL, 1.0, 0, 1, 0), (4, 'Pisek', 'SIPO', 'default2', 'Pisek', 'Pisek', 'SIPO', 1, 0, 1.0, 1, 0.0, 1.0, 0, 0, 1), (5, 'Pisek', 'default2', 'default2', 'SIPO', 'default2', 'default2', 0, 0, 0.0, 0, NULL, 1.0, 1, 0, 1), (6, 'default1', 'default2', 'Pisek', 'Pisek', 'default2', 'SIPO', 0, 0, 1.0, 0, 0.0, 1.0, 1, 1, 1), (7, 'default1', 'Pisek', 'Pisek', 'SIPO', 'Pisek', 'default2', 1, 1, 0.0, 0, 1.0, 1.0, 1, 0, 1), (8, 'default1', 'SIPO', 'Pisek', 'default1', 'default2', 'default1', 0, 1, 1.0, 0, NULL, 1.0, 0, 1, 1), (9, 'SIPO', 'SIPO', 'default1', 'SIPO', 'Pisek', 'default2', 1, 0, 0.0, 0, 0.0, 1.0, 0, NULL, 0), (10, 'SIPO', 'SIPO', 'Pisek', 'default2', 'SIPO', 'default2', 1, 0, 0.0, 1, NULL, 1.0, 0, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 4, 'Pisek', '2023-01-01'), (1, 9, 'default2', '2023-01-01'), (2, 6, 'default2', '2023-01-01'), (3, 8, 'Pisek', '2023-01-01'), (4, 6, 'default1', '2023-01-02'), (5, 5, 'SIPO', '2023-01-02'), (6, 10, 'default1', '2023-01-01'), (7, 2, 'default2', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 5, '2023-01-02', 'Pisek', 'default2', 0, 0, NULL, 'Pisek', 0), (1, 0, '2023-01-02', 'Pisek', NULL, 0, 1, 'SIPO', 'SIPO', 1), (2, 6, '2023-01-02', 'default1', 'Pisek', 1, 0, 'default2', 'SIPO', 0), (3, 0, '2023-01-02', 'SIPO', NULL, 1, 1, 'SIPO', 'default1', 0), (4, 2, '2023-01-01', 'default2', 'default1', 0, 1, 'default2', 'default2', NULL), (5, 3, '2023-01-01', 'Pisek', 'SIPO', 1, 1, 'SIPO', 'default2', 1), (6, 1, '2023-01-01', 'SIPO', 'default1', 0, 1, 'Pisek', 'default2', 0), (7, 4, '2023-01-02', 'default1', 'Pisek', 0, 0, 'Pisek', NULL, 1), (8, 4, '2023-01-01', 'SIPO', 'default1', 1, 1, 'SIPO', 'default2', 1), (9, 7, '2023-01-02', 'default2', 'default2', 1, 1, 'default1', 'default1', 1), (10, 0, '2023-01-01', 'SIPO', NULL, 1, 0, 'default2', 'default1', NULL), (11, 5, '2023-01-01', 'SIPO', 'default1', 1, 0, NULL, 'default2', 1);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 5, 'default2', 1, 0.0, 'default2'), (0, 5, 'default2', 0, 1.0, 'SIPO'), (2, 2, 'SIPO', 1, 0.0, 'default1'), (3, 3, 'SIPO', 1, 0.0, 'default1'), (4, 2, 'Pisek', 0, 0.0, 'default2'), (5, 0, 'default2', 1, 1.0, 'SIPO'), (6, 2, 'default1', 0, 0.0, 'default1'), (7, 7, 'SIPO', 1, 0.0, 'Pisek'), (8, 6, 'SIPO', 0, 0.0, 'Pisek'), (9, 2, 'default2', 0, 1.0, 'Pisek'), (10, 2, 'Pisek', 0, 1.0, 'SIPO'), (11, 0, 'default2', 1, 1.0, 'SIPO'), (12, 3, 'Pisek', 0, 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.k_symbol = 'SIPO' AND T3.A2 = 'Pisek';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT o.account_id FROM "order" AS o JOIN account AS a ON o.account_id = a.account_id JOIN district AS d ON a.district_id = d.district_id WHERE o.k_symbol = 'SIPO' AND d.a2 = 'Pisek';

/*
Prediction Result:
(5,)
(0,)
*/