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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'C', 'default1', 'default1', 'C', 'default2', 'D', 1, 1, 0.0, 0, 1.0, 1.0, 0, NULL, 1), (0, 'D', 'default2', 'default1', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'default2', 0, 0, 0.0, 0, NULL, 1.0, 1, NULL, 1), (2, 'default1', 'C', 'D', 'default1', 'default1', 'C', 1, 1, 0.0, 1, NULL, 0.0, 0, 0, 0), (3, 'default2', 'POPLATEK PO OBRATU', 'default1', 'default1', 'POPLATEK PO OBRATU', 'default1', 0, 0, 0.0, 1, 1.0, 0.0, 0, NULL, 0), (4, 'default2', 'default2', 'POPLATEK PO OBRATU', 'default1', 'POPLATEK PO OBRATU', 'default1', 0, 0, 1.0, 0, 0.0, 1.0, 0, NULL, 0), (5, 'D', 'POPLATEK PO OBRATU', 'default2', 'C', 'POPLATEK PO OBRATU', 'default2', 0, 0, 1.0, 1, 0.0, 0.0, 0, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'POPLATEK PO OBRATU', '2023-01-01'), (1, 5, 'POPLATEK PO OBRATU', '2023-01-01'), (2, 1, 'D', '2023-01-01'), (3, 4, 'C', '2023-01-02'), (4, 3, 'D', '2023-01-01'), (5, 3, 'default1', '2023-01-01'), (6, 1, 'default2', '2023-01-02'), (7, 3, 'D', '2023-01-02'), (8, 4, 'default2', '2023-01-01'), (9, 3, 'D', '2023-01-01'), (10, 5, 'D', '2023-01-02'), (11, 4, 'POPLATEK PO OBRATU', '2023-01-01'), (12, 5, 'D', '2023-01-02'), (13, 5, 'C', '2023-01-01'), (14, 4, 'POPLATEK PO OBRATU', '2023-01-01'), (15, 1, 'D', '2023-01-02'), (16, 0, 'POPLATEK PO OBRATU', '2023-01-02'), (17, 0, 'default1', '2023-01-02'), (18, 5, 'C', '2023-01-02'), (19, 3, 'D', '2023-01-01'), (20, 0, 'POPLATEK PO OBRATU', '2023-01-02'), (21, 2, 'D', '2023-01-02'), (22, 3, 'default2', '2023-01-02'), (23, 4, 'default2', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 17, '2023-01-01', 0, 0, 0.0, 'POPLATEK PO OBRATU'), (0, 7, '2023-01-01', 0, 1, 1.0, 'POPLATEK PO OBRATU'), (2, 13, '2023-01-02', 1, 1, 1.0, 'default1'), (3, 3, '2023-01-01', 0, 1, 1.0, 'default2'), (4, 18, '2023-01-01', 1, 1, 0.0, 'C'), (5, 10, '2023-01-02', 1, 1, 0.0, 'default2'), (6, 10, '2023-01-02', 1, 1, 0.0, 'default1'), (7, 6, '2023-01-01', 1, 1, 0.0, 'default2'), (8, 8, '2023-01-01', 1, 1, 1.0, 'default1'), (9, 8, '2023-01-02', 1, 1, 0.0, 'default1'), (10, 2, '2023-01-02', 1, 1, 1.0, 'default2'), (11, 1, '2023-01-01', 1, 1, 0.0, 'default1'), (12, 22, '2023-01-02', 0, 0, 1.0, 'C'), (13, 6, '2023-01-01', 0, 1, 0.0, 'default2'), (14, 22, '2023-01-02', 1, 0, 0.0, 'default2'), (15, 11, '2023-01-02', 1, 0, 0.0, 'D'), (16, 22, '2023-01-01', 1, 0, 0.0, 'default2'), (17, 6, '2023-01-02', 1, 1, 0.0, 'C'), (18, 19, '2023-01-02', 1, 1, 1.0, 'default1'), (19, 16, '2023-01-02', 1, 0, 0.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.payments) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.status IN ('C', 'D') AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT AVG(T1.amount) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T2.frequency = 'POPLATEK PO OBRATU' AND T1.status IN ('C', 'D');

/*
Prediction Result:
(1.0,)
*/