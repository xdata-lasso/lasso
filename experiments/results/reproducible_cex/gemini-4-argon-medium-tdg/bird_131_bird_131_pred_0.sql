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
-- Tests:
-- 1. Tie-breaker in ORDER BY: SUM(T3.amount) DESC, T2.A3 ASC ('Alpha' and 'Beta' both sum to 1000; 'Alpha' should win).
-- 2. SUM(T3.amount) vs SUM(DISTINCT T3.amount) ('Alpha' has two identical loan amounts of 500, 'Beta' has 600 and 400).
-- 3. SUM(T3.amount) vs SUM(T3.payments) or SUM(T3.duration) ('Gamma' has huge payments and duration, but small amount).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D_Beta', 'Beta', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D_Alpha', 'Alpha', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D_Gamma', 'Gamma', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 100, 10, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 1, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (203, 2, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (204, 2, 'POPLATEK MESICNE', '1995-01-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (205, 3, 'POPLATEK MESICNE', '1995-01-05');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2001, 201, '1996-01-01', 600, 12, 50.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2002, 202, '1996-01-02', 400, 12, 33.3, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2003, 203, '1996-01-03', 500, 12, 41.6, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2004, 204, '1996-01-04', 500, 12, 41.6, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2005, 205, '1996-01-05', 100, 6000, 9999.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('Alpha',)
*/

-- Prediction Query
SELECT A3 FROM district WHERE district_id = (SELECT district_id FROM account WHERE account_id = (SELECT account_id FROM loan WHERE status IN ('C', 'D') GROUP BY account_id ORDER BY COUNT(loan_id) DESC, account_id NULLS LAST LIMIT 1));

/*
Prediction Result:
('Beta',)
*/