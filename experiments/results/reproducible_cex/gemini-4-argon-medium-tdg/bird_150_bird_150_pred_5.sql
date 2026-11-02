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
-- DATASET 4
-- Tests case sensitivity, substring/LIKE mutations (e.g. LIKE '%AB%', LIKE '%Bohemia%'), and OUTER JOIN mutations with COUNT(*)
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Decin', 'north Bohemia', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Usti', 'North Bohemia', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Tabor', 'central Bohemia', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
-- Account 1 in 'north Bohemia' with NO transactions (tests LEFT JOIN + COUNT(T2.account_id) or COUNT(*) where trans filter is in ON clause)
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'POPLATEK MESICNE', '1995-01-01');
-- Account 2 in 'north Bohemia' with near-miss bank values
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 1, 'POPLATEK MESICNE', '1995-01-02');
-- Account 3 in 'North Bohemia' (case sensitivity)
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 2, 'POPLATEK MESICNE', '1995-01-03');
-- Account 4 in 'central Bohemia' (substring match on 'Bohemia')
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4, 3, 'POPLATEK MESICNE', '1995-01-04');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 2, '1996-01-01', 'PRIJEM', 'PREVOD Z UCTU', 100, 1000, 'UROK', 'ab', 111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (2, 2, '1996-01-02', 'PRIJEM', 'PREVOD Z UCTU', 100, 1100, 'UROK', 'ABC', 111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3, 3, '1996-01-03', 'PRIJEM', 'PREVOD Z UCTU', 100, 1000, 'UROK', 'AB', 111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (4, 4, '1996-01-04', 'PRIJEM', 'PREVOD Z UCTU', 100, 1000, 'UROK', 'AB', 111);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.bank = 'AB' AND T1.A3 = 'north Bohemia';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(a.account_id) AS num_accounts FROM district AS d INNER JOIN account AS a ON d.district_id = a.district_id INNER JOIN trans AS t ON a.account_id = t.account_id WHERE d.A3 LIKE '%North Bohemia%' AND t.bank = 'AB';

/*
Prediction Result:
(1,)
*/