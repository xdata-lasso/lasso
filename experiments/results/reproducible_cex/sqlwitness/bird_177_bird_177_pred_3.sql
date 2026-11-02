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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (852, 'default1', 'default1', 'default2', 'default1', 'default2', 'default2', 3, 3, 0.0, 3, 852.0, 850.0, 0, 5, 1), (4, 'default1', 'default2', 'default2', 'default1', 'default1', 'default1', 1, 5, 5.0, 4, NULL, 5.0, 850, 852, 851), (3, 'default2', 'default2', 'default1', 'default1', 'default1', 'default2', 851, 5, 4.0, 4, NULL, 852.0, 850, 3, 851), (851, 'default2', 'default1', 'default1', 'default2', 'default1', 'default2', 852, 5, 4.0, 850, 851.0, 5.0, 1, 4, 4), (850, 'default2', 'default2', 'default1', 'default2', 'default2', 'default2', 3, 852, 850.0, 1, 5.0, 850.0, 852, 4, 3), (0, 'default2', 'default1', 'default2', 'default1', 'default1', 'default2', 3, 850, 851.0, 4, 851.0, 0.0, 1, 852, 4), (5, 'default1', 'default1', 'default1', 'default1', 'default1', 'default1', 852, 4, 0.0, 850, 1.0, 4.0, 851, 3, 3), (1, 'default2', 'default1', 'default1', 'default2', 'default2', 'default1', 850, 850, 1.0, 852, 851.0, 0.0, 0, 4, 5), (2, 'default2', 'default2', 'default1', 'default1', 'default2', 'default1', 850, 850, 4.0, 3, 5.0, 1.0, 5, 5, 851), (6, 'default1', 'default1', 'default2', 'default2', 'default1', 'default2', 851, 5, 852.0, 5, 850.0, 5.0, 850, NULL, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (852, 6, 'default2', '2023-01-01'), (1, 5, 'default2', '2023-01-02'), (0, 0, 'default2', '2023-01-01'), (5, 852, 'default2', '2023-01-02'), (4, 0, 'default1', '2023-01-02'), (851, 4, 'default1', '2023-01-01'), (850, 2, 'default1', '2023-01-01'), (3, 852, 'default1', '2023-01-01'), (2, 6, 'default2', '2023-01-02'), (6, 6, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4, 6, 'default2', '2023-01-01'), (1, 0, 'default1', '2023-01-02'), (850, 852, 'default2', '2023-01-01'), (852, 4, 'default2', '2023-01-02'), (3, 852, 'default1', '2023-01-02'), (851, 0, 'default1', '2023-01-02'), (5, 0, 'default1', '2023-01-02'), (0, 3, 'default2', '2023-01-01'), (2, 6, 'default1', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (852, 850, '2023-01-02', 'default1', 'default1', 1, 0, NULL, 'default2', 850), (5, 0, '2023-01-02', 'default1', NULL, 1, 4, 'default1', 'default1', 0), (4, 1, '2023-01-01', 'default1', 'default1', 4, 3, 'default1', 'default2', NULL), (0, 5, '2023-01-01', 'default2', 'default1', 4, 3, 'default1', NULL, 0), (850, 5, '2023-01-01', 'default2', NULL, 0, 4, 'default2', 'default2', 851), (851, 851, '2023-01-02', 'default1', 'default1', 850, 0, 'default1', 'default2', 1), (3, 3, '2023-01-02', 'default1', 'default2', 3, 3, 'default1', NULL, 852);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (850, 851, 4, 'default2'), (4, 851, 1, 'default2'), (1, 851, 850, 'default1'), (851, 2, 6, 'default2'), (852, 0, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(0, 'default1')
*/

-- Prediction Query
SELECT T1.gender, T3.balance FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T2.client_id = 4 AND T3.trans_id = 851;

/*
Prediction Result:
('default1', 0)
*/