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
-- Tests standard join path (district_id) vs disposition join path (disp) and filters on loan.date and loan.amount.
-- Target: Kills mutants that join via 'disp', use OR instead of AND, omit WHERE conditions, or filter on account.date instead of loan.date.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '200', '2', '2', '2', 2, 2, 2.0, 2, 2.0, 2.0, 2, 2, 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'MONTHLY', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'MONTHLY', '1996-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'MONTHLY', '1995-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 1, 'MONTHLY', '1995-06-06');
-- Client 100 is in District 1 (matches Account 10 via district_id, but has NO disp link to Account 10)
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (100, 'M', '1970-01-01', 1);
-- Client 200 is in District 2 (linked to Account 10 via disp, but in a different district)
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (200, 'F', '1980-02-02', 2);
-- Disposition links Client 200 (District 2) to Account 10 (District 1)
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1000, 200, 10, 'OWNER');
-- Disposition links Client 100 (District 1) to Account 20 (District 2)
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2000, 100, 20, 'OWNER');
-- Loan 1: Matches both date and amount (Valid for Account 10 -> District 1 -> Client 100)
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 10, '1996-01-03', 98832, 12, 8236.0, 'A');
-- Loan 2: Wrong date, right amount (Account 20 has date '1996-01-03' to catch T2.date = '1996-01-03' mutants)
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 20, '1997-01-01', 98832, 12, 8236.0, 'A');
-- Loan 3: Right date, wrong amount
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 30, '1996-01-03', 50000, 12, 4166.0, 'A');
-- Loan 4: Wrong date, wrong amount
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 40, '1998-01-01', 10000, 12, 833.0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('1970-01-01',)
*/

-- Prediction Query
SELECT c.birth_date FROM loan AS l JOIN disp AS d ON l.account_id = d.account_id JOIN client AS c ON d.client_id = c.client_id WHERE l.amount = 98832 AND l.date = '1996-01-03';

/*
Prediction Result:
('1980-02-02',)
*/