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
-- 1. GROUP BY T1.A16 vs GROUP BY T1.district_id (Districts 1 and 2 share the max A16=100; grouping by A16 yields count 5, grouping by district_id yields 2 or 3).
-- 2. ORDER BY T1.A16 DESC vs ORDER BY COUNT(T2.account_id) DESC (District 3 has A16=50 with 6 accounts; ordering by count yields 6 instead of 5).
-- 3. ORDER BY T1.A16 DESC vs ASC (District 4 has min A16=10 with 1 account).
-- 4. COUNT(T2.account_id) vs COUNT(DISTINCT T1.district_id) or COUNT(DISTINCT T2.district_id).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '10', '10', '10', 1, 1, 50.0, 8000, 1.0, 1.0, 100, 10, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '2000', '20', '20', '20', 2, 2, 60.0, 9000, 2.0, 2.0, 200, 20, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '3000', '30', '30', '30', 3, 3, 70.0, 8500, 3.0, 3.0, 150, 30, 50);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'D4', 'R4', '4000', '40', '40', '40', 4, 4, 80.0, 9500, 4.0, 4.0, 250, 40, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 2, 'POPLATEK TYDNE', '1995-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 2, 'POPLATEK TYDNE', '1995-02-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (203, 2, 'POPLATEK PO OBRATU', '1995-02-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (301, 3, 'POPLATEK MESICNE', '1995-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (302, 3, 'POPLATEK MESICNE', '1995-03-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (303, 3, 'POPLATEK MESICNE', '1995-03-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (304, 3, 'POPLATEK MESICNE', '1995-03-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (305, 3, 'POPLATEK MESICNE', '1995-03-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (306, 3, 'POPLATEK MESICNE', '1995-03-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (401, 4, 'POPLATEK MESICNE', '1995-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id GROUP BY T1.A16 ORDER BY T1.A16 DESC, COUNT(T2.account_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(account_id) FROM account WHERE district_id = (SELECT district_id FROM district ORDER BY A16 DESC, district.district_id NULLS LAST LIMIT 1);

/*
Prediction Result:
(2,)
*/