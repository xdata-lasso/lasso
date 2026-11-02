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
-- Tests basic positive match, boundary client_ids (3355, 3357), different operations, and NULL operation.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 50.0, 1000, 1.0, 1.0, 10, 10, 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3355, 'M', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3356, 'F', '1985-05-05', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3357, 'M', '1990-10-10', 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 1, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (201, 3355, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (202, 3356, 102, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (203, 3357, 103, 'OWNER');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1001, 102, '1996-01-01', 'VYDAJ', 'VYBER', 500, 5000, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1002, 102, '1996-01-02', 'PRIJEM', 'VKLAD', 500, 5500, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1003, 102, '1996-01-03', 'VYDAJ', NULL, 100, 5400, 'SLUZBY', NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1004, 101, '1996-01-01', 'VYDAJ', 'VYBER', 500, 5000, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1005, 103, '1996-01-01', 'VYDAJ', 'VYBER', 500, 5000, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.trans_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN trans AS T4 ON T3.account_id = T4.account_id WHERE T1.client_id = 3356 AND T4.operation = 'VYBER';

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT T3.date, T3.amount, T3.balance FROM disp AS T1 INNER JOIN client AS T2 ON T1.client_id = T2.client_id INNER JOIN trans AS T3 ON T1.account_id = T3.account_id WHERE T1.client_id = 3356 AND T3.operation = 'VYBER';

/*
Prediction Result:
('1996-01-01', 500, 5000)
*/