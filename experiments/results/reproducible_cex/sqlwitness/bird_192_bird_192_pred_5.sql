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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'POPLATEK PO OBRATU', 'D', 'D', 'D', 'default1', 'POPLATEK PO OBRATU', 1, 1, 1.0, 1, NULL, 0.0, 1, 1, 1), (1, 'C', 'POPLATEK PO OBRATU', 'default2', 'default2', 'default2', 'POPLATEK PO OBRATU', 0, 1, 1.0, 1, 1.0, 1.0, 0, 0, 1), (2, 'C', 'POPLATEK PO OBRATU', 'default2', 'D', 'D', 'D', 0, 1, 1.0, 0, 0.0, 1.0, 0, NULL, 1), (3, 'POPLATEK PO OBRATU', 'C', 'POPLATEK PO OBRATU', 'default2', 'D', 'default1', 1, 1, 1.0, 1, NULL, 1.0, 1, 0, 1), (4, 'default2', 'C', 'default1', 'default2', 'default1', 'default1', 0, 0, 1.0, 1, 1.0, 1.0, 1, 0, 1), (5, 'D', 'POPLATEK PO OBRATU', 'default1', 'C', 'default2', 'default1', 0, 0, 1.0, 0, 0.0, 1.0, 1, 0, 0), (6, 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 'C', 'default1', 'C', 'POPLATEK PO OBRATU', 1, 0, 1.0, 1, NULL, 1.0, 0, 1, 0), (7, 'default1', 'default2', 'D', 'C', 'D', 'POPLATEK PO OBRATU', 0, 1, 1.0, 1, 1.0, 0.0, 0, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, 'C', '2023-01-02'), (0, 6, 'default2', '2023-01-01'), (2, 1, 'POPLATEK PO OBRATU', '2023-01-01'), (3, 0, 'default1', '2023-01-01'), (4, 4, 'default1', '2023-01-02'), (5, 2, 'C', '2023-01-01'), (6, 1, 'D', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 6, '2023-01-02', 1, 1, 0.0, 'C'), (1, 2, '2023-01-01', 1, 0, 1.0, 'default1'), (2, 0, '2023-01-02', 1, 0, 1.0, 'default1'), (3, 3, '2023-01-02', 1, 0, 1.0, 'default2'), (4, 1, '2023-01-01', 0, 1, 0.0, 'D'), (5, 2, '2023-01-01', 1, 0, 1.0, 'D'), (6, 1, '2023-01-01', 0, 0, 0.0, 'POPLATEK PO OBRATU'), (7, 2, '2023-01-02', 1, 0, 1.0, 'D'), (8, 6, '2023-01-02', 1, 0, 1.0, 'POPLATEK PO OBRATU'), (9, 3, '2023-01-01', 1, 0, 0.0, 'D'), (10, 4, '2023-01-01', 1, 1, 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.payments) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.status IN ('C', 'D') AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(l.amount) AS average_loan_amount FROM loan AS l INNER JOIN account AS a ON l.account_id = a.account_id WHERE l.status = 'C' AND a.frequency = 'POPLATEK PO OBRATU';

/*
Prediction Result:
(None,)
*/