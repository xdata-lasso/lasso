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
-- Tests subquery scope: Subquery AVG must include ALL 1998 operations (not just 'VYBER KARTOU') and must exclude non-1998 transactions.
-- Also tests outer query filtering on operation and year.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1000, 1.0, 1.0, 1, 1, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (203, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (204, 1, 'POPLATEK MESICNE', '1993-01-01');
-- 1998 'VYBER KARTOU' transactions: 100 and 200. (AVG of only 'VYBER KARTOU' in 1998 is 150).
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 201, '1998-01-15', 'VYDAJ', 'VYBER KARTOU', 100, 1000, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (2, 202, '1998-05-15', 'VYDAJ', 'VYBER KARTOU', 200, 1000, NULL, NULL, NULL);
-- 1998 'VKLAD' transaction with large amount: 900.
-- Pulls overall 1998 AVG to (100 + 200 + 900 + 50) / 4 = 312.5.
-- Because 200 < 312.5, account 202 MUST be returned. (If mutant restricts subquery to 'VYBER KARTOU', AVG is 150 and 202 is missed).
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3, 203, '1998-08-15', 'PRIJEM', 'VKLAD', 900, 5000, NULL, NULL, NULL);
-- 1998 transaction with small amount (50) but wrong operation ('VYBER') and another with NULL operation.
-- Kills mutants that omit or alter the outer operation = 'VYBER KARTOU' filter.
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (4, 204, '1998-09-15', 'VYDAJ', 'VYBER', 50, 1000, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (5, 204, '1998-10-15', 'VYDAJ', NULL, 50, 950, NULL, NULL, NULL);
-- 1997 transaction with 'VYBER KARTOU' and small amount (10).
-- Kills mutants that omit the outer year '1998' filter.
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (6, 204, '1997-12-31', 'VYDAJ', 'VYBER KARTOU', 10, 1000, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(201,)
(202,)
*/

-- Prediction Query
SELECT account_id FROM trans WHERE trans_id IN (SELECT trans_id FROM trans WHERE STRFTIME('%Y', date) = '1998' AND operation = 'VYBER KARTOU' AND amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998' AND operation = 'VYBER KARTOU'));

/*
Prediction Result:
(201,)
*/