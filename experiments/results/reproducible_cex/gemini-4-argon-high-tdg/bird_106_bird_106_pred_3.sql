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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '1000', '10', '10', '10', 1, 1, 50.0, 8000, 1.0, 1.0, 100, 100, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '2000', '20', '20', '20', 2, 2, 60.0, 9000, 2.0, 2.0, 200, 200, 200);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 10, 'POPLATEK MESICNE', '1996-10-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 10, 'POPLATEK MESICNE', '1996-10-21');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 20, 'POPLATEK TYDNE', '1996-10-21');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4, 20, 'POPLATEK MESICNE', '1996-10-22');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (5, 10, 'POPLATEK PO OBRATU', '1995-10-21');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (100, 1, '1996-10-21', 'PRIJEM', 'VKLAD', 9999, 15000, 'UROK', 'AB', 2);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (101, 2, '1996-12-31', 'PRIJEM', 'VKLAD', 200, 9500, 'UROK', 'CD', 3);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (102, 3, '1996-11-15', 'PRIJEM', 'VKLAD', 1000, 3000, 'UROK', 'EF', 1);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (103, 3, '1996-10-21', 'VYDAJ', 'VYBER', 50, 1000, 'SLUZBY', 'GH', 1);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (104, 4, '1996-10-21', 'PRIJEM', 'VKLAD', 8888, 9999, 'UROK', 'IJ', 2);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (105, 5, '1996-10-21', 'PRIJEM', 'VKLAD', 7777, 8888, 'UROK', 'KL', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date = '1996-10-21' ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1000,)
*/

-- Prediction Query
SELECT MAX(T3.amount) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.issued = '1996-10-21';

/*
Prediction Result:
(None,)
*/