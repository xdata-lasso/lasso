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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (25, 'default1', 'default1', 'default1', 'default2', 'default2', 'POPLATEK TYDNE', 0, 24, 25.0, 0, 0.0, 0.0, 1, 25, 0), (23, 'C', 'C', 'default2', 'default1', 'C', 'C', 25, 24, 23.0, 24, 24.0, 1.0, 24, 23, 23), (1, 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 'default2', 'C', 'default1', 24, 0, 1.0, 0, 25.0, 24.0, 0, 23, 23), (24, 'default1', 'default1', 'default2', 'C', 'C', 'default2', 25, 25, 25.0, 24, NULL, 23.0, 23, 1, 23), (0, 'default1', 'C', 'C', 'default1', 'default2', 'POPLATEK TYDNE', 1, 24, 23.0, 1, 24.0, 24.0, 25, 23, 1), (2, 'default2', 'C', 'default2', 'default1', 'default1', 'C', 24, 24, 23.0, 25, 24.0, 0.0, 25, 0, 23), (3, 'POPLATEK TYDNE', 'default2', 'POPLATEK TYDNE', 'default1', 'POPLATEK TYDNE', 'C', 24, 24, 0.0, 1, 0.0, 24.0, 0, NULL, 23), (4, 'POPLATEK TYDNE', 'C', 'POPLATEK TYDNE', 'C', 'C', 'default1', 1, 23, 0.0, 24, 1.0, 25.0, 25, 25, 25), (5, 'default1', 'POPLATEK TYDNE', 'default2', 'C', 'C', 'POPLATEK TYDNE', 25, 23, 1.0, 25, 1.0, 1.0, 24, 25, 24), (6, 'default1', 'default1', 'default2', 'default1', 'C', 'C', 24, 25, 1.0, 25, 1.0, 25.0, 25, 23, 23), (7, 'C', 'default2', 'default2', 'default2', 'default2', 'C', 24, 0, 24.0, 24, 0.0, 24.0, 24, 25, 25), (8, 'default1', 'default1', 'C', 'C', 'C', 'default2', 24, 0, 24.0, 23, 1.0, 25.0, 25, 24, 0), (9, 'default2', 'default1', 'POPLATEK TYDNE', 'C', 'POPLATEK TYDNE', 'default1', 0, 23, 0.0, 24, 0.0, 25.0, 23, 0, 25), (10, 'C', 'default2', 'C', 'default2', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 25, 24, 0.0, 0, NULL, 23.0, 25, 24, 23), (11, 'POPLATEK TYDNE', 'default1', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 'POPLATEK TYDNE', 24, 24, 25.0, 1, 0.0, 24.0, 1, 23, 23), (12, 'default2', 'C', 'C', 'default2', 'default2', 'default2', 25, 25, 0.0, 24, NULL, 23.0, 24, 0, 0), (13, 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'C', 'default1', 'default2', 'default2', 23, 25, 0.0, 1, 1.0, 1.0, 0, 25, 1), (14, 'C', 'default2', 'POPLATEK TYDNE', 'default1', 'default1', 'POPLATEK TYDNE', 25, 1, 24.0, 24, 25.0, 25.0, 0, 0, 24), (15, 'default2', 'default1', 'C', 'POPLATEK TYDNE', 'C', 'default1', 1, 1, 1.0, 24, 0.0, 1.0, 23, 0, 25), (16, 'C', 'default1', 'C', 'C', 'POPLATEK TYDNE', 'C', 1, 25, 0.0, 25, 23.0, 24.0, 23, 24, 25);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (25, 6, 'default2', '2023-01-02'), (0, 4, 'POPLATEK TYDNE', '2023-01-02'), (1, 23, 'default2', '2023-01-02'), (24, 3, 'C', '2023-01-02'), (23, 2, 'C', '2023-01-01'), (2, 0, 'default1', '2023-01-01'), (3, 15, 'default2', '2023-01-01'), (4, 23, 'default1', '2023-01-02'), (5, 0, 'default1', '2023-01-02'), (6, 0, 'POPLATEK TYDNE', '2023-01-02'), (7, 6, 'default1', '2023-01-02'), (8, 23, 'default2', '2023-01-02'), (9, 9, 'default1', '2023-01-01'), (10, 0, 'default1', '2023-01-02'), (11, 4, 'default2', '2023-01-02'), (12, 0, 'POPLATEK TYDNE', '2023-01-01'), (13, 1, 'C', '2023-01-02'), (14, 14, 'C', '2023-01-02'), (15, 4, 'POPLATEK TYDNE', '2023-01-01'), (16, 13, 'C', '2023-01-02'), (17, 14, 'default1', '2023-01-01'), (18, 11, 'POPLATEK TYDNE', '2023-01-02'), (19, 10, 'C', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (23, 6, '2023-01-01', 0, 23, 23.0, 'C'), (0, 25, '2023-01-02', 25, 24, 24.0, 'C'), (1, 17, '2023-01-01', 1, 0, 0.0, 'default2'), (25, 8, '2023-01-02', 0, 1, 1.0, 'default1'), (24, 9, '2023-01-02', 0, 0, 24.0, 'POPLATEK TYDNE'), (2, 1, '2023-01-02', 24, 1, 1.0, 'C'), (3, 25, '2023-01-01', 0, 25, 1.0, 'default1'), (4, 0, '2023-01-02', 25, 23, 0.0, 'default1'), (5, 25, '2023-01-02', 24, 1, 25.0, 'default1'), (6, 6, '2023-01-01', 23, 23, 25.0, 'POPLATEK TYDNE'), (7, 13, '2023-01-01', 24, 0, 25.0, 'C'), (8, 15, '2023-01-01', 23, 24, 25.0, 'C'), (9, 13, '2023-01-01', 25, 24, 23.0, 'default1'), (10, 18, '2023-01-01', 24, 1, 0.0, 'default2'), (11, 8, '2023-01-02', 0, 0, 0.0, 'default1'), (12, 7, '2023-01-02', 23, 25, 25.0, 'default2'), (13, 8, '2023-01-02', 25, 25, 0.0, 'default1'), (14, 8, '2023-01-02', 23, 1, 24.0, 'POPLATEK TYDNE'), (15, 13, '2023-01-02', 1, 0, 24.0, 'default2'), (16, 0, '2023-01-01', 23, 24, 1.0, 'default2'), (17, 7, '2023-01-02', 1, 24, 0.0, 'C'), (18, 0, '2023-01-01', 24, 24, 23.0, 'POPLATEK TYDNE'), (19, 14, '2023-01-01', 23, 25, 0.0, 'default1'), (20, 10, '2023-01-01', 24, 25, 24.0, 'POPLATEK TYDNE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.duration = 24 AND T1.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT l.account_id) FROM loan AS l JOIN account AS a ON l.account_id = a.account_id WHERE l.duration = 24 AND a.frequency = 'POPLATEK TYDNE' AND l.status = 'C';

/*
Prediction Result:
(1,)
*/