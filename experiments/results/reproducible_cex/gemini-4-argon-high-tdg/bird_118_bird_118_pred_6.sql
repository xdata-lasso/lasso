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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Brno', 'south Moravia', '387570', '0', '0', '0', 1, 1, 100.0, 9897, 1.6, 1.96, 140, 18721, 18696);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'POPLATEK MESICNE', '1993-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 1, 'POPLATEK MESICNE', '1993-05-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 1, 'POPLATEK MESICNE', '1993-05-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4, 1, 'POPLATEK MESICNE', '1993-05-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (5, 1, 'POPLATEK MESICNE', '1993-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (6, 1, 'POPLATEK MESICNE', '1993-05-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (7, 1, 'POPLATEK MESICNE', '1993-05-07');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (8, 1, 'POPLATEK MESICNE', '1993-05-08');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (9, 1, 'POPLATEK MESICNE', '1993-05-09');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1993-05-10');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 1, '1995-01-01', 99999, 12, 8333.25, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 2, '1995-01-02', 20000, 12, 1666.67, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3, 3, '1995-01-03', 80000, 24, 3333.33, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (4, 4, '1995-01-04', 10000, 12, 833.33, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (5, 5, '1995-01-05', 30000, 24, 1250.0, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (6, 6, '1995-01-06', 40000, 36, 1111.11, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (7, 7, '1995-01-07', 60000, 48, 1250.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (8, 8, '1995-01-08', 70000, 60, 1166.67, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (9, 9, '1995-01-09', 100000, 24, 4166.67, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (10, 10, '1995-01-10', 100001, 24, 4166.71, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(status = 'C') AS REAL) * 100 / COUNT(amount) FROM loan WHERE amount < 100000;

/*
Gold Result:
(37.5,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF(loan.amount < 100000, 1, 0)) AS REAL) * 100 / SUM(CASE WHEN loan.status = 'C' THEN 1 ELSE 0 END) AS percentage FROM loan WHERE loan.status = 'C';

/*
Prediction Result:
(100.0,)
*/