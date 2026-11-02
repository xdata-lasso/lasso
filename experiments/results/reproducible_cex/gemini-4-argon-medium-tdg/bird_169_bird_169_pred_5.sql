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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1000, 1.0, 1.0, 1, 1, 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'M', '1975-05-05', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'F', '1980-03-03', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'M', '1982-07-07', 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 10, 'POPLATEK MESICNE', '1997-06-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 10, 'POPLATEK MESICNE', '1996-06-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (203, 10, 'POPLATEK MESICNE', '1996-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (204, 10, 'POPLATEK MESICNE', '1997-01-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (301, 101, 201, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (302, 102, 202, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (303, 103, 203, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (304, 104, 204, 'DISPONENT');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (401, 201, '1996-02-15', 100, 12, 10.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (402, 201, '1996-08-20', 200, 24, 10.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (403, 202, '1997-03-10', 150, 12, 15.0, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (404, 202, '1997-11-05', 250, 36, 10.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (405, 201, '1995-05-05', 900, 12, 75.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (406, 202, '1998-01-20', 800, 12, 66.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (407, 203, '1996-04-10', 5000, 12, 416.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (408, 203, '1997-04-10', 9000, 12, 750.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (409, 204, '1996-09-10', 3000, 12, 250.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (410, 204, '1997-09-10', 7000, 12, 583.0, 'A');
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
(124.24242424242425,)
*/