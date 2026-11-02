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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '0', '0', '0', 1, 1, 50.0, 1000, 1.0, 1.0, 10, 10, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'MONTHLY', '1997-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'MONTHLY', '1996-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'MONTHLY', '1996-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 1, 'MONTHLY', '1997-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 1, 'MONTHLY', '1995-01-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (100, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (200, 'F', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (300, 'M', '1970-01-01', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1000, 100, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2000, 100, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3000, 200, 30, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (4000, 300, 40, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (5000, 100, 50, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 10, '1996-05-15', 300, 12, 25.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 20, '1997-06-20', 400, 24, 16.6, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 30, '1996-07-01', 1000, 12, 83.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 30, '1997-07-01', 2000, 12, 166.6, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (5, 40, '1996-08-01', 1500, 12, 125.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (6, 40, '1997-08-01', 5000, 12, 416.6, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (7, 50, '1995-03-10', 800, 12, 66.6, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (8, 50, '1998-09-10', 900, 12, 75.0, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1997' THEN T3.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1996' THEN T3.amount ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1996' THEN T3.amount ELSE 0 END) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'M';

/*
Prediction Result:
(200.0,)
*/