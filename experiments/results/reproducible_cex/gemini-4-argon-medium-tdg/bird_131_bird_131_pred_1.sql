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
-- 1. WHERE T3.status IN ('C', 'D') vs missing WHERE or including 'A'/'B' ('North' has massive 'A'/'B' loans).
-- 2. SUM(T3.amount) vs MAX(T3.amount), AVG(T3.amount), or COUNT(*) ('South' has single largest loan, 'West' has highest count, 'East' has highest sum of 'C' and 'D').
-- 3. GROUP BY T2.A3 vs GROUP BY T2.district_id or T2.A2 ('East' is split across two districts 1 and 2).
-- 4. Both 'C' and 'D' required (excluding 'C' or excluding 'D' makes 'South' win over 'East').
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Dist_East_1', 'East', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Dist_East_2', 'East', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Dist_South', 'South', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'Dist_West', 'West', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Dist_North', 'North', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 2, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 3, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 4, 'POPLATEK MESICNE', '1995-01-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 4, 'POPLATEK MESICNE', '1995-01-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (106, 4, 'POPLATEK MESICNE', '1995-01-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (107, 5, 'POPLATEK MESICNE', '1995-01-07');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1001, 101, '1996-01-01', 600, 12, 50.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1002, 102, '1996-01-02', 600, 12, 50.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1003, 103, '1996-01-03', 1000, 20, 50.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1004, 104, '1996-01-04', 100, 10, 10.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1005, 105, '1996-01-05', 100, 10, 10.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1006, 106, '1996-01-06', 100, 10, 10.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1007, 107, '1996-01-07', 5000, 50, 100.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1008, 107, '1996-01-08', 5000, 50, 100.0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('East',)
*/

-- Prediction Query
SELECT d.A3 AS district_name, COUNT(l.loan_id) AS active_loan_count FROM district AS d INNER JOIN account AS a ON d.district_id = a.district_id INNER JOIN loan AS l ON a.account_id = l.account_id WHERE l.status IN ('C', 'D') GROUP BY d.A3 ORDER BY active_loan_count DESC, district_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('West', 3)
*/