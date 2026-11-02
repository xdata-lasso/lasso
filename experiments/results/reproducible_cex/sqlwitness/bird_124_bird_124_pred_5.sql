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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default1', 'default2', 'default2', 'default2', 'default1', 'default1', 0, 0, 60.0, 61, NULL, 61.0, 60, 61, 59), (61, 'default2', 'default1', 'default2', 'default2', 'default1', 'default2', 1, 59, 0.0, 1, 60.0, 1.0, 1, 60, 1), (0, 'default1', 'default1', 'default2', 'default2', 'default2', 'default2', 1, 60, 60.0, 60, 60.0, 61.0, 59, 59, 59), (59, 'default2', 'default2', 'default2', 'default1', 'default1', 'default1', 1, 1, 1.0, 59, 60.0, 61.0, 0, 0, 60), (60, 'default2', 'default2', 'default1', 'default1', 'default1', 'default2', 1, 0, 1.0, 61, 59.0, 59.0, 61, 1, 60), (2, 'default2', 'default1', 'default1', 'default1', 'default1', 'default2', 61, 59, 60.0, 60, 1.0, 60.0, 0, NULL, 1), (3, 'default2', 'default1', 'default1', 'default1', 'default1', 'default2', 59, 0, 60.0, 60, 60.0, 61.0, 59, 59, 59), (4, 'default2', 'default1', 'default1', 'default1', 'default1', 'default1', 59, 1, 1.0, 61, 0.0, 61.0, 0, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'default2', '2023-01-02'), (60, 61, 'default1', '2023-01-02'), (59, 0, 'default2', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (60, 0, '2023-01-02', 1, 1, 59.0, 'default2'), (1, 0, '2023-01-01', 59, 1, 59.0, 'default2'), (61, 59, '2023-01-01', 59, 61, 0.0, 'default2'), (59, 0, '2023-01-02', 1, 1, 1.0, 'default2'), (0, 60, '2023-01-02', 61, 0, 60.0, 'default1'), (2, 60, '2023-01-02', 1, 60, 0.0, 'default1'), (3, 0, '2023-01-01', 1, 61, 0.0, 'default2'), (4, 59, '2023-01-01', 1, 0, 61.0, 'default2'), (5, 59, '2023-01-02', 61, 61, 61.0, 'default2'), (6, 60, '2023-01-01', 59, 59, 60.0, 'default2'), (7, 0, '2023-01-01', 61, 1, 0.0, 'default1'), (8, 59, '2023-01-01', 60, 0, 60.0, 'default2'), (9, 60, '2023-01-02', 1, 0, 61.0, 'default1'), (10, 59, '2023-01-01', 1, 60, 0.0, 'default1'), (11, 60, '2023-01-01', 1, 59, 59.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.loan_id, T2.A2, T2.A11 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.duration = 60;

/*
Gold Result:
(2, 'default2', 1)
(10, 'default1', 60)
*/

-- Prediction Query
SELECT T1.loan_id, T3.A3, T3.A11 FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.duration = 60;

/*
Prediction Result:
(2, 'default1', 1)
(10, 'default1', 60)
*/