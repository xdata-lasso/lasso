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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'D', 'default2', 'C', 'default1', 'D', 'C', 0, 0, 1.0, 0, NULL, 0.0, 0, 1, 1), (1, 'default1', 'POPLATEK PO OBRATU', 'default2', 'C', 'C', 'C', 1, 0, 1.0, 1, NULL, 1.0, 0, 0, 0), (2, 'default1', 'POPLATEK PO OBRATU', 'default2', 'D', 'default2', 'default1', 0, 0, 1.0, 0, 0.0, 1.0, 0, NULL, 0), (3, 'D', 'default1', 'C', 'C', 'default1', 'C', 1, 0, 0.0, 1, NULL, 1.0, 0, NULL, 1), (4, 'default2', 'default2', 'C', 'POPLATEK PO OBRATU', 'C', 'C', 0, 1, 1.0, 0, 0.0, 0.0, 0, 1, 1), (5, 'D', 'D', 'default2', 'POPLATEK PO OBRATU', 'D', 'default1', 0, 1, 0.0, 0, 0.0, 0.0, 1, 0, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 3, 'D', '2023-01-02'), (0, 4, 'C', '2023-01-02'), (2, 0, 'default2', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 0, '2023-01-02', 'default1', 'C', 0, 1, 'default1', 'default1', 0), (1, 0, '2023-01-02', 'default2', 'default1', 1, 1, 'POPLATEK PO OBRATU', NULL, 0), (2, 2, '2023-01-01', 'default1', 'D', 1, 1, 'POPLATEK PO OBRATU', 'C', 0);
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 1, '2023-01-01', 1, 0, 0.0, 'C'), (0, 2, '2023-01-01', 1, 1, 1.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.payments) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.status IN ('C', 'D') AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.amount) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.status IN ('C', 'D') AND T3.k_symbol = 'POPLATEK PO OBRATU';

/*
Prediction Result:
(1.0,)
*/