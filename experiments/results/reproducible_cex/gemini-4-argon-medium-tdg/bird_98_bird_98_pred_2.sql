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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1997-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK TYDNE', '1995-03-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 1, 'POPLATEK TYDNE', '1994-11-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 1, 'POPLATEK TYDNE', '1993-08-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 1, 'POPLATEK TYDNE', '1997-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 101, '1997-06-15', 1000, 12, 83.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 102, '1996-12-31', 2000, 24, 83.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 102, '1998-01-01', 2500, 24, 104.2, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 103, '1997-01-01', 5000, 36, 138.9, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (5, 104, '1997-12-31', 8000, 48, 166.7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(103,)
*/

-- Prediction Query
SELECT "a"."account_id" FROM "account" AS "a" INNER JOIN "loan" AS "l" ON "a"."account_id" = "l"."account_id" WHERE STRFTIME('%Y', "l"."date") = '1997' AND "a"."frequency" = 'POPLATEK TYDNE' AND "l"."amount" = (SELECT MIN("amount") FROM "loan" AS "l2" WHERE STRFTIME('%Y', "l2"."date") = '1997' AND "l2"."account_id" = "l"."account_id");

/*
Prediction Result:
(103,)
(104,)
*/