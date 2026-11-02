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
-- Tests COUNT(T2.account_id) vs COUNT(DISTINCT T2.account_id), and basic WHERE filtering (AND vs OR, '=' vs '!=', NULL handling)
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Teplice', 'north Bohemia', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Prague', 'Prague', '200', '2', '2', '2', 2, 2, 2.0, 2, 2.0, 2.0, 2, 2, 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 2, 'POPLATEK MESICNE', '1995-01-03');
-- Multiple matching transactions for the same account (tests DISTINCT vs non-DISTINCT count)
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (100, 10, '1996-01-01', 'PRIJEM', 'PREVOD Z UCTU', 500, 1500, 'UROK', 'AB', 999);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (101, 10, '1996-01-02', 'PRIJEM', 'PREVOD Z UCTU', 600, 2100, 'UROK', 'AB', 999);
-- Non-matching bank (wrong bank value & NULL bank value) in matching district
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (102, 10, '1996-01-03', 'PRIJEM', 'PREVOD Z UCTU', 700, 2800, 'UROK', 'CD', 999);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (103, 20, '1996-01-04', 'PRIJEM', 'VKLAD', 800, 800, NULL, NULL, NULL);
-- Matching bank in non-matching district
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (104, 30, '1996-01-05', 'PRIJEM', 'PREVOD Z UCTU', 900, 1900, 'UROK', 'AB', 888);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.bank = 'AB' AND T1.A3 = 'north Bohemia';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.A3 = 'north Bohemia' AND T3.bank = 'AB';

/*
Prediction Result:
(1,)
*/