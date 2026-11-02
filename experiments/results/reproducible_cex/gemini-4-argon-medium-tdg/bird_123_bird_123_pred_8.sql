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
-- DATASET 3
-- Testing duplicate rows (DISTINCT mutants), multiple qualifying loans per account, and multiple accounts per district.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (50, 'Prague', 'Bohemia', '1000', '10', '5', '2', 1, 1, 100.0, 10000, 0.5, 0.5, 100, 200, 300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (60, 'Brno', 'Moravia', '2000', '20', '10', '4', 2, 2, 80.0, 9000, 1.5, 1.5, 110, 210, 310);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (500, 50, 'MONTHLY', '1997-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (501, 50, 'MONTHLY', '1997-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (600, 60, 'WEEKLY', '1997-03-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (901, 500, '1998-01-01', 350000, 36, 9722.2, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (902, 500, '1998-06-01', 400000, 48, 8333.3, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (903, 501, '1998-07-01', 500000, 60, 8333.3, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (904, 600, '1998-08-01', 310000, 24, 12916.7, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (905, 600, '1998-09-01', 200000, 12, 16666.7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.amount > 300000;

/*
Gold Result:
(500, 'Prague', 'Bohemia')
(500, 'Prague', 'Bohemia')
(501, 'Prague', 'Bohemia')
(600, 'Brno', 'Moravia')
*/

-- Prediction Query
SELECT DISTINCT T2.account_id, T4.A2, T4.A3 FROM loan AS T2 JOIN account AS T3 ON T2.account_id = T3.account_id JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T2.amount > 300000;

/*
Prediction Result:
(500, 'Prague', 'Bohemia')
(501, 'Prague', 'Bohemia')
(600, 'Brno', 'Moravia')
*/