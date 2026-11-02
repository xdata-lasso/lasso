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
-- Target: Join path mutations (joining via disp instead of district_id) and gender filter mutations ('M' vs 'F').
-- Here, Female clients are in District 1, linked via disp to Accounts in District 2.
-- Accounts in District 1 have loans, while Accounts in District 2 have higher loans.
-- A mutant joining via disp will pick up District 2 loans for Female clients; the gold query joins on district_id and picks District 1 loans.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '1', '1', '1', 1, 1, 10.0, 1000, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '2000', '2', '2', '2', 2, 2, 20.0, 2000, 2.0, 2.0, 2, 2, 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'F', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (20, 'M', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (30, 'F', '1985-01-01', 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 2, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 10, 200, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 20, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 30, 100, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1000, 100, '1996-01-01', 50000, 12, 4166.6, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1001, 101, '1996-02-01', 40000, 12, 3333.3, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2000, 200, '1996-03-01', 90000, 24, 3750.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'F' ORDER BY T3.amount DESC, T1.client_id NULLS LAST, T2.account_id NULLS LAST, T3.loan_id NULLS LAST LIMIT 3;

/*
Gold Result:
(30,)
(10,)
(10,)
*/

-- Prediction Query
SELECT "client"."client_id" FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "loan" ON "disp"."account_id" = "loan"."account_id" WHERE "client"."gender" = 'F' ORDER BY "loan"."amount" DESC, client.client_id NULLS LAST, disp.disp_id NULLS LAST, loan.loan_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(10,)
(30,)
*/