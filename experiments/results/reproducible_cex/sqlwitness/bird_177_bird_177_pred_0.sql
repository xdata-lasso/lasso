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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (850, 'default2', 'default1', 'default2', 'default1', 'default2', 'default2', 851, 3, 850.0, 852, NULL, 5.0, 3, 851, 5);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 850, 'default2', '2023-01-01'), (4, 850, 'default2', '2023-01-01'), (852, 850, 'default1', '2023-01-01'), (1, 850, 'default2', '2023-01-02'), (851, 850, 'default2', '2023-01-01'), (850, 850, 'default1', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (852, 850, 'default2', '2023-01-01'), (3, 850, 'default2', '2023-01-02'), (850, 850, 'default2', '2023-01-02'), (4, 850, 'default1', '2023-01-01'), (0, 850, 'default1', '2023-01-02'), (851, 850, 'default2', '2023-01-02'), (5, 850, 'default1', '2023-01-01'), (1, 850, 'default1', '2023-01-02'), (2, 850, 'default2', '2023-01-02'), (6, 850, 'default2', '2023-01-01'), (7, 850, 'default2', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (850, 0, '2023-01-01', 'default2', NULL, 5, 3, 'default1', 'default2', 852), (5, 852, '2023-01-02', 'default2', NULL, 4, 0, NULL, 'default2', 851), (851, 1, '2023-01-02', 'default2', 'default2', 0, 3, 'default1', 'default1', 1), (4, 851, '2023-01-01', 'default1', 'default1', 5, 3, NULL, 'default1', 851), (3, 6, '2023-01-01', 'default2', NULL, 5, 850, 'default1', NULL, 852), (0, 1, '2023-01-02', 'default2', 'default2', 850, 5, 'default1', 'default1', 1), (852, 4, '2023-01-02', 'default2', NULL, 0, 4, NULL, 'default2', 5), (1, 3, '2023-01-01', 'default2', 'default1', 4, 5, NULL, 'default1', 4), (2, 6, '2023-01-01', 'default1', 'default1', 0, 4, NULL, 'default2', 0), (6, 3, '2023-01-02', 'default2', 'default2', 851, 851, 'default1', 'default2', 3), (7, 850, '2023-01-01', 'default1', NULL, 1, 0, 'default2', NULL, NULL), (8, 4, '2023-01-02', 'default1', 'default2', 1, 4, 'default1', 'default1', 5), (9, 4, '2023-01-01', 'default2', 'default2', 851, 851, 'default2', 'default1', 852), (10, 852, '2023-01-02', 'default2', 'default2', 850, 5, 'default1', NULL, 0), (11, 7, '2023-01-01', 'default1', NULL, 850, 852, NULL, 'default2', 852), (12, 851, '2023-01-01', 'default1', 'default1', 0, 5, 'default1', 'default1', 5), (13, 851, '2023-01-02', 'default1', 'default1', 5, 850, 'default1', 'default2', 850), (14, 4, '2023-01-02', 'default2', NULL, 4, 852, 'default1', NULL, 850), (15, 3, '2023-01-01', 'default1', 'default2', 3, 852, NULL, NULL, 4), (16, 2, '2023-01-02', 'default2', 'default2', 3, 850, 'default1', NULL, NULL);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (851, 3, 0, 'default1'), (1, 852, 852, 'default2'), (850, 852, 4, 'default1'), (5, 6, 1, 'default2'), (852, 7, 0, 'default2'), (0, 1, 1, 'default2'), (4, 2, 851, 'default2'), (3, 850, 1, 'default2'), (2, 5, 0, 'default2'), (6, 851, 0, 'default1'), (7, 7, 0, 'default2'), (8, 2, 850, 'default2'), (9, 850, 4, 'default2'), (10, 6, 0, 'default2'), (11, 6, 851, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(3, 'default2')
*/

-- Prediction Query
SELECT T1.balance, T3.gender FROM trans AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id WHERE T1.trans_id = 851 AND T3.client_id = 4;

/*
Prediction Result:
*/