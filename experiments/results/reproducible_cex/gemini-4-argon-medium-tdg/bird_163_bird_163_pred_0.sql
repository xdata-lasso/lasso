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
-- DATASET 2
-- Tests COUNT(T2.account_id) vs COUNT(DISTINCT T2.account_id).
-- District 1 has 1 account with 3 'A' loans (COUNT = 3, DISTINCT = 1).
-- District 2 has 2 accounts, each with 1 'A' loan (COUNT = 2, DISTINCT = 2).
-- Also tests SUM(amount) vs COUNT: District 2 has much larger loan amounts than District 1.
-- Expected result: 1
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '1', '1', '1', 1, 1, 50.0, 8000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '2000', '2', '2', '2', 2, 2, 60.0, 9000, 2.0, 2.0, 110, 20, 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (11, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (21, 2, 'POPLATEK MESICNE', '1993-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (22, 2, 'POPLATEK MESICNE', '1993-02-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (111, 11, '1994-01-01', 1000, 12, 83.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (112, 11, '1994-05-01', 1000, 12, 83.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (113, 11, '1994-09-01', 1000, 12, 83.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (211, 21, '1994-02-01', 500000, 12, 41666.7, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (221, 22, '1994-02-02', 500000, 12, 41666.7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T3.status = 'A' GROUP BY T1.district_id ORDER BY COUNT(T2.account_id) DESC, T1.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T.district_id FROM (SELECT T1.district_id, COUNT(DISTINCT T2.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.status = 'A' GROUP BY T1.district_id ORDER BY COUNT(DISTINCT T2.account_id) DESC, T1.district_id NULLS LAST LIMIT 1) AS t;

/*
Prediction Result:
(2,)
*/