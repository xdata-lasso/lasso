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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (852, 'default2', 'default2', 'default2', 'default2', 'default2', 'default2', 0, 851, 851.0, 5, 851.0, 851.0, 850, NULL, 852);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 852, 'default1', '2023-01-01'), (852, 852, 'default2', '2023-01-01'), (4, 852, 'default2', '2023-01-01'), (851, 852, 'default1', '2023-01-01'), (850, 852, 'default1', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 852, 'default2', '2023-01-02'), (852, 852, 'default1', '2023-01-01'), (4, 852, 'default2', '2023-01-02'), (851, 852, 'default1', '2023-01-02'), (850, 852, 'default1', '2023-01-02'), (3, 852, 'default2', '2023-01-02'), (5, 852, 'default1', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (852, 850, '2023-01-01', 'default2', NULL, 3, 4, NULL, 'default2', 1), (851, 850, '2023-01-02', 'default1', NULL, 0, 851, NULL, 'default2', 852), (5, 850, '2023-01-01', 'default1', 'default1', 5, 852, NULL, 'default1', 851), (0, 852, '2023-01-01', 'default1', 'default1', 3, 852, 'default1', 'default2', NULL), (3, 5, '2023-01-01', 'default1', 'default2', 1, 852, 'default1', NULL, 852), (1, 4, '2023-01-02', 'default1', 'default2', 4, 1, 'default2', NULL, 5), (4, 3, '2023-01-01', 'default2', NULL, 850, 3, 'default2', 'default2', 1), (850, 850, '2023-01-02', 'default1', 'default2', 0, 852, NULL, 'default2', NULL), (2, 3, '2023-01-02', 'default1', NULL, 4, 5, 'default1', 'default1', 3), (6, 1, '2023-01-01', 'default2', 'default1', 4, 5, 'default1', 'default2', 5), (7, 4, '2023-01-01', 'default2', NULL, 5, 5, 'default1', NULL, 3), (8, 850, '2023-01-01', 'default2', NULL, 3, 3, 'default2', NULL, 851), (9, 3, '2023-01-02', 'default2', 'default1', 851, 850, 'default1', NULL, 852);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (3, 4, 850, 'default1'), (1, 3, 4, 'default1'), (4, 852, 851, 'default1'), (852, 3, 850, 'default2'), (851, 851, 0, 'default2'), (850, 850, 851, 'default2'), (5, 4, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(851, 'default2')
*/

-- Prediction Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Prediction Result:
*/