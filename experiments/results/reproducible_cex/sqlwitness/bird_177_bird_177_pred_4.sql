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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default2', 'default2', 'default2', 'default1', 'default1', 851, 1, 851.0, 5, 0.0, 851.0, 852, 0, 850), (5, 'default2', 'default1', 'default2', 'default2', 'default2', 'default2', 1, 851, 3.0, 0, 5.0, 0.0, 850, 0, 850);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (4, 5, 'default2', '2023-01-01'), (852, 5, 'default1', '2023-01-02'), (5, 5, 'default2', '2023-01-02'), (851, 0, 'default1', '2023-01-01'), (0, 5, 'default2', '2023-01-01'), (1, 5, 'default2', '2023-01-02'), (3, 0, 'default1', '2023-01-01'), (850, 0, 'default2', '2023-01-02'), (2, 0, 'default1', '2023-01-02'), (6, 0, 'default2', '2023-01-02'), (7, 0, 'default1', '2023-01-02'), (8, 5, 'default2', '2023-01-02'), (9, 0, 'default1', '2023-01-02'), (10, 5, 'default1', '2023-01-02'), (11, 0, 'default1', '2023-01-01'), (12, 0, 'default2', '2023-01-02'), (13, 0, 'default2', '2023-01-01'), (14, 0, 'default2', '2023-01-02'), (15, 0, 'default1', '2023-01-02'), (16, 0, 'default2', '2023-01-02'), (17, 0, 'default2', '2023-01-01'), (18, 5, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 5, 'default2', '2023-01-01'), (850, 0, 'default1', '2023-01-02'), (852, 5, 'default1', '2023-01-01'), (4, 0, 'default1', '2023-01-01'), (5, 5, 'default1', '2023-01-01'), (1, 5, 'default2', '2023-01-02'), (0, 0, 'default2', '2023-01-02'), (851, 5, 'default2', '2023-01-02'), (2, 5, 'default2', '2023-01-01'), (6, 5, 'default1', '2023-01-02'), (7, 0, 'default1', '2023-01-02'), (8, 5, 'default2', '2023-01-02'), (9, 0, 'default2', '2023-01-01'), (10, 5, 'default2', '2023-01-02'), (11, 5, 'default1', '2023-01-02'), (12, 0, 'default2', '2023-01-01'), (13, 5, 'default2', '2023-01-02'), (14, 5, 'default2', '2023-01-01'), (15, 5, 'default1', '2023-01-01'), (16, 5, 'default2', '2023-01-01'), (17, 0, 'default2', '2023-01-01'), (18, 5, 'default1', '2023-01-01'), (19, 5, 'default1', '2023-01-01'), (20, 5, 'default2', '2023-01-02'), (21, 5, 'default1', '2023-01-01'), (22, 5, 'default1', '2023-01-01'), (23, 5, 'default2', '2023-01-01'), (24, 0, 'default1', '2023-01-02'), (25, 0, 'default2', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (850, 852, '2023-01-02', 'default2', NULL, 852, 852, NULL, 'default1', 0), (852, 850, '2023-01-01', 'default1', 'default1', 851, 851, 'default1', 'default1', 1), (851, 23, '2023-01-01', 'default1', 'default2', 851, 1, 'default2', NULL, 3), (4, 12, '2023-01-01', 'default2', 'default1', 3, 3, 'default2', 'default2', 852), (1, 14, '2023-01-02', 'default1', 'default2', 4, 851, 'default1', 'default1', 4), (3, 14, '2023-01-02', 'default1', 'default1', 4, 3, 'default1', 'default2', 5), (5, 13, '2023-01-02', 'default1', 'default1', 0, 850, NULL, 'default2', 851), (0, 7, '2023-01-02', 'default1', 'default1', 851, 1, 'default2', 'default1', 852), (2, 3, '2023-01-01', 'default2', NULL, 5, 1, 'default1', NULL, 3), (6, 0, '2023-01-01', 'default1', NULL, 851, 1, 'default2', 'default2', 852), (7, 18, '2023-01-02', 'default2', 'default2', 852, 0, NULL, 'default2', 852), (8, 852, '2023-01-01', 'default2', NULL, 852, 850, NULL, 'default2', 852), (9, 6, '2023-01-01', 'default2', 'default1', 0, 5, 'default1', NULL, 4), (10, 19, '2023-01-02', 'default2', NULL, 0, 852, 'default1', NULL, 1), (11, 4, '2023-01-01', 'default2', NULL, 0, 5, 'default2', 'default1', 3), (12, 13, '2023-01-02', 'default1', 'default1', 850, 852, NULL, NULL, 3), (13, 4, '2023-01-02', 'default2', 'default2', 4, 850, 'default2', 'default1', 852), (14, 9, '2023-01-02', 'default2', 'default2', 0, 0, 'default1', 'default1', NULL), (15, 851, '2023-01-01', 'default2', NULL, 850, 3, 'default2', NULL, NULL);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 9, 13, 'default1'), (3, 12, 3, 'default1'), (851, 2, 15, 'default2'), (852, 0, 7, 'default2'), (5, 10, 11, 'default2'), (1, 12, 10, 'default1'), (4, 19, 6, 'default2'), (850, 0, 850, 'default2'), (2, 8, 4, 'default1'), (6, 19, 10, 'default2'), (7, 17, 16, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
SELECT t.balance, c.gender FROM trans AS t JOIN disp AS d ON t.account_id = d.account_id JOIN client AS c ON d.client_id = c.client_id WHERE t.trans_id = 851 AND c.client_id = 4;

/*
Prediction Result:
*/