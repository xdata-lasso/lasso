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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '10000', '10', '10', '10', 1, 1, 50.0, 8000, 1.5, 2.0, 100, 100, 200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '20000', '20', '20', '20', 2, 2, 60.0, 9000, 2.5, 3.0, 120, 150, 250);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 2, 'POPLATEK MESICNE', '1997-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 2, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'POPLATEK MESICNE', '1996-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 1, 'POPLATEK MESICNE', '1996-06-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 1, 'POPLATEK MESICNE', '1997-07-07');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (100, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (200, 'F', '1996-03-03', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (300, 'M', '1997-04-04', 2);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1000, 100, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2000, 100, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3000, 100, 30, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (4000, 200, 40, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (5000, 300, 50, 'DISPONENT');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 10, '1996-02-15', 1000, 12, 500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 10, '1996-08-20', 2000, 24, 500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 20, '1997-03-10', 1000, 12, 100.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 20, '1997-07-22', 1500, 24, 100.0, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (5, 20, '1997-11-05', 1500, 36, 100.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (6, 30, '1995-06-15', 50000, 12, 4166.7, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (7, 30, '1998-01-10', 60000, 24, 2500.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (8, 40, '1996-04-12', 5000, 12, 416.7, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (9, 40, '1997-09-18', 9000, 24, 375.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (10, 50, '1996-05-20', 7000, 12, 583.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (11, 50, '1997-10-25', 2000, 24, 83.3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT ((SUM(CASE WHEN STRFTIME('%Y', loan.date) = '1997' THEN loan.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', loan.date) = '1996' THEN loan.amount ELSE 0 END)) / SUM(CASE WHEN STRFTIME('%Y', loan.date) = '1996' THEN loan.amount ELSE 0 END)) * 100 AS growth_rate FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN account ON disp.account_id = account.account_id INNER JOIN loan ON account.account_id = loan.account_id WHERE client.gender = 'M';

/*
Prediction Result:
(0,)
*/