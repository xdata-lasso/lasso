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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'D', 'POPLATEK PO OBRATU', 'default2', 'C', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 1, 0, 1.0, 1, 1.0, 0.0, 0, NULL, 0), (0, 'C', 'default1', 'C', 'POPLATEK PO OBRATU', 'C', 'C', 1, 1, 1.0, 0, 0.0, 1.0, 1, 0, 1), (2, 'C', 'POPLATEK PO OBRATU', 'default2', 'D', 'default2', 'C', 0, 1, 1.0, 0, 0.0, 0.0, 0, 1, 1), (3, 'POPLATEK PO OBRATU', 'default1', 'D', 'D', 'default2', 'default1', 0, 0, 1.0, 1, 1.0, 1.0, 0, NULL, 1), (4, 'POPLATEK PO OBRATU', 'default2', 'C', 'D', 'default1', 'POPLATEK PO OBRATU', 1, 1, 1.0, 0, NULL, 0.0, 0, 0, 1), (5, 'POPLATEK PO OBRATU', 'D', 'D', 'D', 'C', 'D', 1, 0, 0.0, 0, 0.0, 1.0, 1, NULL, 0), (6, 'default2', 'default2', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'D', 'D', 1, 1, 1.0, 1, 0.0, 1.0, 0, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 2, 'D', '2023-01-01'), (1, 5, 'POPLATEK PO OBRATU', '2023-01-02'), (2, 3, 'POPLATEK PO OBRATU', '2023-01-02'), (3, 5, 'default2', '2023-01-01'), (4, 1, 'D', '2023-01-01'), (5, 6, 'default1', '2023-01-01'), (6, 2, 'default2', '2023-01-01'), (7, 6, 'D', '2023-01-02'), (8, 6, 'default2', '2023-01-01'), (9, 6, 'C', '2023-01-02'), (10, 4, 'D', '2023-01-01'), (11, 2, 'default2', '2023-01-02'), (12, 0, 'POPLATEK PO OBRATU', '2023-01-01'), (13, 3, 'D', '2023-01-02'), (14, 5, 'POPLATEK PO OBRATU', '2023-01-02'), (15, 6, 'D', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 14, '2023-01-01', 1, 1, 1.0, 'D'), (1, 12, '2023-01-02', 0, 0, 1.0, 'D'), (2, 12, '2023-01-02', 0, 0, 1.0, 'default1'), (3, 1, '2023-01-01', 0, 0, 0.0, 'C'), (4, 6, '2023-01-02', 0, 1, 0.0, 'D'), (5, 13, '2023-01-01', 1, 0, 0.0, 'D'), (6, 10, '2023-01-01', 1, 0, 1.0, 'D'), (7, 4, '2023-01-02', 0, 1, 1.0, 'default1'), (8, 11, '2023-01-01', 0, 0, 1.0, 'C'), (9, 9, '2023-01-01', 0, 0, 1.0, 'POPLATEK PO OBRATU'), (10, 13, '2023-01-01', 1, 0, 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.payments) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.status IN ('C', 'D') AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(0.6666666666666666,)
*/

-- Prediction Query
SELECT AVG(loan.amount) AS average_loan_amount FROM loan INNER JOIN account ON loan.account_id = account.account_id WHERE account.frequency = 'POPLATEK PO OBRATU' AND loan.status IN ('C', 'D');

/*
Prediction Result:
(0.3333333333333333,)
*/