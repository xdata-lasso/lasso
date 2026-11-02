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
-- 1. COUNT(T2.account_id) vs COUNT(DISTINCT T2.account_id) by having multiple 'USER' dispositions for the same account.
-- 2. Join condition (T2.account_id = T1.account_id) vs incorrect join keys (e.g., disp_id, client_id, district_id).
-- 3. WHERE predicates (T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'USER') vs OR / missing filters / domain values ('OWNER', 'DISPONENT', 'POPLATEK MESICNE').
-- 4. Accounts without dispositions (testing INNER JOIN vs LEFT JOIN).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '1', '1', '1', 1, 1, 50.0, 8000, 1.0, 2.0, 100, 10, 20);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R10', '1000', '1', '1', '1', 1, 1, 50.0, 8000, 1.0, 2.0, 100, 10, 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (20, 'F', '1975-05-05', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (100, 'M', '1980-10-10', 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK TYDNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'POPLATEK TYDNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 10, 'POPLATEK TYDNE', '1995-01-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 1, 'POPLATEK PO OBRATU', '1995-01-05');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (100, 100, 10, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (101, 20, 10, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (102, 10, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (10, 10, 30, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (20, 10, 50, 'DISPONENT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T2.account_id = T1.account_id WHERE T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'USER';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id WHERE account.frequency = 'POPLATEK TYDNE' AND disp.type = 'OWNER';

/*
Prediction Result:
(1,)
*/