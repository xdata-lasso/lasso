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
-- Core match vs. boundary conditions on client_id (3, 4, 5) and trans_id (850, 851, 852).
-- Crucially, Client 4 is linked via `disp` to Account 20, while the district-matched Account is 10.
-- This kills mutants that join `client -> disp -> account` instead of `client.district_id = account.district_id`.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '200', '2', '2', '2', 2, 2, 2.0, 2, 2.0, 2.0, 2, 2, 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'M', '1979-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'F', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'M', '1981-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'M', '1982-01-01', 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'POPLATEK TYDNE', '1995-01-02');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (100, 4, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (101, 6, 10, 'OWNER');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (850, 10, '1996-01-01', 'PRIJEM', 'VKLAD', 111, 1000, 'S1', 'B1', 20);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (851, 10, '1996-01-02', 'PRIJEM', 'VKLAD', 222, 5000, 'S2', 'B2', 20);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (852, 10, '1996-01-03', 'PRIJEM', 'VKLAD', 333, 9000, 'S3', 'B3', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(5000, 'F')
*/

-- Prediction Query
SELECT SUM(trans.amount) AS total_transaction_amount, client.gender FROM client INNER JOIN account ON client.district_id = account.district_id INNER JOIN trans ON account.account_id = trans.account_id WHERE client.client_id = 4 AND trans.trans_id = 851;

/*
Prediction Result:
(222, 'F')
*/