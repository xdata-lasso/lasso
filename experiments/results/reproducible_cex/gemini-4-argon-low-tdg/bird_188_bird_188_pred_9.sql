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
-- DATASET 4
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'A', 'B', 'C', 'D', 'E', 'F', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 1, 'MONTHLY', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 1, 'MONTHLY', '1995-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 100, '1996-01-01', 5000, 36, 100.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 200, '1996-01-01', 5000, 36, 100.0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 24 AND STRFTIME('%Y', T2.date) < '1997' ORDER BY T1.amount ASC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(200,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a JOIN loan AS l ON a.account_id = l.account_id WHERE a.date < '1997-01-01' AND l.duration > 24 AND l.amount = (SELECT MIN(l.amount) AS min_amount FROM loan AS l JOIN (SELECT a.account_id FROM account AS a JOIN (SELECT account_id FROM loan WHERE duration > 24) AS l ON a.account_id = l.account_id WHERE a.date < '1997-01-01') AS filtered_accounts ON l.account_id = filtered_accounts.account_id);

/*
Prediction Result:
(200,)
(100,)
*/