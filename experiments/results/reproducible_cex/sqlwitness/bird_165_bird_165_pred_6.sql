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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (6, 'default1', 'default1', 'default1', 'default1', 'default2', 'default1', 1, 5, 5.0, 0, 0.0, 1.0, 5, 6, 6), (1, 'default2', 'default1', 'default2', 'default2', 'default1', 'default1', 1, 6, 1.0, 6, 6.0, 5.0, 4, 0, 6), (5, 'default1', 'default1', 'default2', 'default1', 'default2', 'default2', 1, 5, 6.0, 1, 6.0, 4.0, 4, 0, 1), (4, 'default1', 'default2', 'default1', 'default1', 'default1', 'default1', 1, 0, 0.0, 6, 1.0, 5.0, 0, 5, 0), (0, 'default2', 'default1', 'default2', 'default2', 'default2', 'default2', 6, 6, 5.0, 1, NULL, 1.0, 0, 6, 4), (2, 'default2', 'default2', 'default1', 'default2', 'default1', 'default2', 5, 6, 1.0, 5, 0.0, 5.0, 5, 6, 5), (3, 'default1', 'default1', 'default2', 'default2', 'default1', 'default2', 6, 0, 0.0, 4, NULL, 1.0, 4, 4, 5), (7, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1', 1, 5, 4.0, 4, 6.0, 4.0, 5, 0, 6), (8, 'default1', 'default1', 'default1', 'default2', 'default2', 'default1', 5, 6, 4.0, 4, 6.0, 0.0, 4, 0, 4), (9, 'default1', 'default2', 'default2', 'default2', 'default1', 'default1', 0, 0, 4.0, 0, 1.0, 1.0, 0, 0, 1), (10, 'default1', 'default2', 'default2', 'default1', 'default2', 'default2', 6, 4, 6.0, 4, 5.0, 4.0, 4, NULL, 4), (11, 'default2', 'default2', 'default2', 'default1', 'default2', 'default2', 1, 0, 6.0, 6, 1.0, 5.0, 0, 1, 4), (12, 'default1', 'default2', 'default1', 'default2', 'default1', 'default2', 1, 4, 5.0, 6, 0.0, 1.0, 0, 5, 0), (13, 'default2', 'default1', 'default1', 'default2', 'default2', 'default2', 4, 0, 4.0, 4, 6.0, 0.0, 6, 5, 4);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 3, 'default2', '2023-01-01'), (4, 8, 'default2', '2023-01-02'), (6, 12, 'default1', '2023-01-02'), (5, 0, 'default2', '2023-01-01'), (0, 7, 'default2', '2023-01-01'), (2, 1, 'default1', '2023-01-01'), (3, 11, 'default2', '2023-01-01'), (7, 6, 'default1', '2023-01-01'), (8, 5, 'default2', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 4, '2023-01-02', 'default2', NULL, 5, 6, 'default1', 'default2', 1), (5, 8, '2023-01-02', 'default1', 'default2', 1, 0, NULL, 'default2', 4), (4, 7, '2023-01-01', 'default2', 'default1', 5, 4, 'default1', NULL, NULL), (0, 1, '2023-01-02', 'default2', NULL, 6, 0, NULL, 'default1', 5), (6, 0, '2023-01-02', 'default2', 'default2', 5, 5, 'default2', 'default1', 5), (2, 2, '2023-01-01', 'default2', 'default1', 0, 0, 'default1', 'default1', NULL), (3, 6, '2023-01-02', 'default2', 'default1', 0, 0, 'default2', NULL, 4), (7, 2, '2023-01-02', 'default2', 'default2', 5, 0, 'default1', 'default2', 4), (8, 7, '2023-01-01', 'default1', NULL, 6, 6, 'default1', 'default1', 0), (9, 5, '2023-01-02', 'default2', 'default2', 6, 1, 'default1', NULL, 0), (10, 2, '2023-01-02', 'default2', 'default2', 1, 0, NULL, 'default2', 5), (11, 6, '2023-01-01', 'default1', NULL, 1, 0, 'default2', 'default1', 0), (12, 4, '2023-01-01', 'default1', 'default2', 1, 0, NULL, NULL, 4), (13, 0, '2023-01-01', 'default2', NULL, 5, 1, NULL, NULL, 6), (14, 6, '2023-01-01', 'default2', 'default1', 0, 4, NULL, 'default1', 5), (15, 7, '2023-01-01', 'default1', 'default1', 1, 4, NULL, NULL, 5), (16, 2, '2023-01-01', 'default1', 'default1', 6, 0, NULL, NULL, 6), (17, 2, '2023-01-01', 'default2', NULL, 6, 6, 'default2', NULL, 6), (18, 3, '2023-01-02', 'default2', 'default1', 6, 6, NULL, NULL, 6), (19, 1, '2023-01-02', 'default1', NULL, 0, 1, 'default2', NULL, 5), (20, 5, '2023-01-01', 'default1', 'default2', 5, 5, 'default2', NULL, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.trans_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.district_id = 5;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT t.* FROM trans AS t INNER JOIN account AS a ON t.account_id = a.account_id INNER JOIN district AS d ON a.district_id = d.district_id WHERE d.district_id = 5;

/*
Prediction Result:
(5, 8, '2023-01-02', 'default1', 'default2', 1, 0, None, 'default2', 4)
*/