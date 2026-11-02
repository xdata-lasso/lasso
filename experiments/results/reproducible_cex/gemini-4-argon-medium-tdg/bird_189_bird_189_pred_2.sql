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
-- DATASET 5
-- Tests:
-- 1. Tie-breaking on T1.client_id and T2.district_id when both T1.birth_date and T2.A11 are identical.
-- 2. Distinguishes joins that accidentally equate T1.client_id = T3.account_id or T1.district_id = T3.account_id.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Dist5', 'R1', '100', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 10, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (6, 'Dist6', 'R1', '100', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 10, 10, 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (100, 'F', '1985-08-08', 6);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (200, 'F', '1985-08-08', 5);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (700, 6, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 5, 'POPLATEK MESICNE', '1995-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(700,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T2.gender = 'F' ORDER BY T2.birth_date ASC, T3.A11 ASC, T1.account_id NULLS LAST, T2.client_id NULLS LAST, T3.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(100,)
*/