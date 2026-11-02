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
-- DATASET 1
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'A', 'B', 'C', 'D', 'E', 'F', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
-- Accounts with wrong frequency, or right frequency
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1997-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'POPLATEK TYDNE', '1997-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'POPLATEK TYDNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 1, 'POPLATEK TYDNE', '1996-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 1, 'POPLATEK TYDNE', '1997-08-01');
-- Loan 1: Smallest amount overall (50), valid date (1997), but wrong frequency on account 10
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 10, '1997-06-15', 50, 12, 10.0, 'A');
-- Loan 2: Small amount (60), right frequency (acc 20), but wrong year on loan.date (1996), while account.date is 1997
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 20, '1996-12-31', 60, 12, 10.0, 'A');
-- Loan 3: Small amount (70), right frequency (acc 20), boundary year 1998 on loan.date
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 20, '1998-01-01', 70, 12, 10.0, 'A');
-- Loan 4: Valid match, amount 100 (smallest valid), account.date is NOT 1997 (tests T1.date vs T2.date)
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 30, '1997-01-01', 100, 24, 20.0, 'B');
-- Loan 5: Valid match, larger amount (200), smaller payments (5.0) and duration (6) to kill wrong ORDER BY column or DESC
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (5, 40, '1997-12-31', 200, 6, 5.0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(30,)
*/

-- Prediction Query
SELECT T1.account_id, T1.amount FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.status = 'A' AND STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount ASC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(40, 200)
*/