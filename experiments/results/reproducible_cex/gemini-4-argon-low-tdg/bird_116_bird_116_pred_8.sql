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
-- DATASET 2
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Brno', 'South', '2000', '2', '2', '2', 2, 2, 90.0, 9000, 2.0, 2.0, 20, 20, 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK TYDNE', '1992-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'POPLATEK PO OBRATU', '1993-03-22');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'POPLATEK MESICNE', '1998-12-27');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (100, 10, '1993-07-05', 50000, 36, 1388.9, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (101, 10, '1993-07-05', 60000, 48, 1250.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (200, 20, '1993-07-05', 30000, 12, 2500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (300, 30, '1993-07-05', 40000, 24, 1666.7, 'B');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1001, 10, '1993-03-22', 'PRIJEM', 'VKLAD', 10, 100, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1002, 10, '1993-03-22', 'PRIJEM', 'VKLAD', 20, 100, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1003, 10, '1998-12-27', 'PRIJEM', 'VKLAD', 30, 350, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (2001, 20, '1993-03-22', 'PRIJEM', 'VKLAD', 15, 300, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3001, 30, '1998-12-27', 'PRIJEM', 'VKLAD', 25, 400, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T3.date = '1998-12-27', T3.balance, 0)) - SUM(IIF(T3.date = '1993-03-22', T3.balance, 0))) AS REAL) * 100 / SUM(IIF(T3.date = '1993-03-22', T3.balance, 0)) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN trans AS T3 ON T3.account_id = T2.account_id WHERE T1.date = '1993-07-05';

/*
Gold Result:
(57.142857142857146,)
*/

-- Prediction Query
SELECT CAST((SUM(CASE WHEN T2.date = '1998-12-27' THEN T2.balance ELSE 0 END) - SUM(CASE WHEN T2.date = '1993-03-22' THEN T2.balance ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN T2.date = '1993-03-22' THEN T2.balance ELSE 0 END) FROM loan AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date = '1993-07-05' GROUP BY T1.account_id;

/*
Prediction Result:
(75.0,)
(-100.0,)
(None,)
*/