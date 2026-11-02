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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'D', 'default2', 'default1', 'C', 'default2', 'D', 2, 1, 1.0, 0, 1.0, 1.0, 2, 2, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'D', '2023-01-02'), (2, 1, 'default2', '2023-01-01'), (0, 1, 'default2', '2023-01-02'), (3, 1, 'default1', '2023-01-01'), (4, 1, 'C', '2023-01-01'), (5, 1, 'C', '2023-01-01'), (6, 1, 'default1', '2023-01-02'), (7, 1, 'C', '2023-01-02'), (8, 1, 'D', '2023-01-01'), (9, 1, 'default1', '2023-01-02'), (10, 1, 'default2', '2023-01-01'), (11, 1, 'D', '2023-01-01'), (12, 1, 'C', '2023-01-01'), (13, 1, 'C', '2023-01-01'), (14, 1, 'D', '2023-01-02'), (15, 1, 'default2', '2023-01-02'), (16, 1, 'default2', '2023-01-01'), (17, 1, 'default1', '2023-01-01'), (18, 1, 'C', '2023-01-02'), (19, 1, 'default1', '2023-01-01'), (20, 1, 'default2', '2023-01-02'), (21, 1, 'D', '2023-01-02'), (22, 1, 'default2', '2023-01-02'), (23, 1, 'D', '2023-01-01'), (24, 1, 'default1', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 17, '2023-01-01', 1, 1, 0.0, 'default2'), (2, 9, '2023-01-01', 0, 0, 0.0, 'default2'), (1, 20, '2023-01-01', 1, 1, 1.0, 'D'), (3, 0, '2023-01-02', 0, 1, 2.0, 'default2'), (4, 0, '2023-01-01', 0, 1, 2.0, 'default1'), (5, 22, '2023-01-02', 2, 2, 1.0, 'C'), (6, 23, '2023-01-02', 0, 2, 1.0, 'D'), (7, 17, '2023-01-02', 1, 2, 0.0, 'default1'), (8, 24, '2023-01-01', 0, 2, 1.0, 'C'), (9, 13, '2023-01-01', 2, 0, 1.0, 'default2'), (10, 10, '2023-01-01', 1, 1, 2.0, 'D'), (11, 4, '2023-01-02', 2, 2, 0.0, 'default2'), (12, 4, '2023-01-01', 1, 0, 0.0, 'C'), (13, 20, '2023-01-02', 1, 0, 2.0, 'C'), (14, 12, '2023-01-02', 2, 2, 1.0, 'D'), (15, 15, '2023-01-02', 1, 2, 2.0, 'default2'), (16, 5, '2023-01-01', 2, 1, 1.0, 'default1'), (17, 8, '2023-01-02', 2, 0, 1.0, 'D'), (18, 21, '2023-01-01', 0, 1, 0.0, 'C'), (19, 8, '2023-01-01', 2, 2, 0.0, 'D'), (20, 13, '2023-01-01', 2, 0, 2.0, 'default1'), (21, 12, '2023-01-01', 0, 0, 2.0, 'D'), (22, 5, '2023-01-01', 0, 2, 0.0, 'D'), (23, 14, '2023-01-01', 1, 1, 1.0, 'default2'), (24, 11, '2023-01-02', 2, 2, 1.0, 'D'), (25, 9, '2023-01-01', 1, 1, 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T1.district_id = 1 AND (T3.status = 'C' OR T3.status = 'D');

/*
Gold Result:
(14,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT loan.account_id) FROM loan INNER JOIN account ON loan.account_id = account.account_id WHERE loan.status IN ('C', 'D') AND account.district_id = 1;

/*
Prediction Result:
(11,)
*/