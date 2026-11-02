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
-- Tests:
-- 1. Account with multiple loans (kills COUNT(DISTINCT T1.account_id) vs COUNT(T1.account_id))
-- 2. Account without any loans (kills LEFT JOIN loan or missing loan join)
-- 3. District where A2 = 'Prague' instead of A3 = 'Prague' (kills wrong column reference)
-- 4. District where A3 != 'Prague' (kills missing WHERE clause)
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1200000', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Prague', 'central Bohemia', '80000', '10', '5', '2', 2, 1, 60.5, 9000, 1.5, 1.8, 120, 2000, 2500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Brno', 'south Moravia', '400000', '0', '0', '0', 1, 1, 100.0, 11000, 2.0, 2.5, 140, 15000, 18000);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (11, 1, 'POPLATEK MESICNE', '1993-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'POPLATEK TYDNE', '1994-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 3, 'POPLATEK PO OBRATU', '1995-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (100, 10, '1993-07-05', 96396, 12, 8033.0, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (101, 10, '1994-07-05', 48000, 24, 2000.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (200, 20, '1994-08-05', 12000, 12, 1000.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (300, 30, '1995-09-05', 60000, 60, 1000.0, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T1.district_id = T3.district_id WHERE T3.A3 = 'Prague';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.account_id) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T2.A3 = 'Prague';

/*
Prediction Result:
(1,)
*/