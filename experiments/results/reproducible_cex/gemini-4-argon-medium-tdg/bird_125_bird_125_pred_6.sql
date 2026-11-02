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
-- Tests basic arithmetic, filtering on loan.status = 'D', and non-matching status rows ('A', 'B', 'C').
-- Also tests whether a mutant wrongly joins via client instead of account, or uses wrong district columns (e.g., A10, A11, A15, A16).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '1000', '10', '10', '10', 1, 1, 50.5, 8000, 4.0, 5.0, 100, 200, 300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '2000', '20', '20', '20', 2, 2, 60.5, 9000, 2.0, 6.0, 150, 250, 350);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 20, 'POPLATEK TYDNE', '1996-01-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1000, 'M', '1970-01-01', 20);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (10000, 1000, 100, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 100, '1997-01-01', 50000, 12, 4166.67, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 200, '1997-02-01', 60000, 24, 2500.00, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 200, '1997-03-01', 70000, 36, 1944.44, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 200, '1997-04-01', 80000, 48, 1666.67, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((T3.A13 - T3.A12) AS REAL) * 100 / T3.A12 FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.status = 'D';

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT d.district_id, (CAST(d.A13 AS REAL) - CAST(d.A12 AS REAL)) * 100.0 / CAST(d.A12 AS REAL) AS unemployment_rate_increment FROM loan AS l INNER JOIN account AS a ON l.account_id = a.account_id INNER JOIN district AS d ON a.district_id = d.district_id WHERE l.status = 'D';

/*
Prediction Result:
(10, 25.0)
*/