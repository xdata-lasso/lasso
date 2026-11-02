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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '100', '1', '1', '1', 1, 1, 50.0, 1000, 1.0, 1.0, 10, 10, 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1972-05-05', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1968-03-10', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '1975-11-20', 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'POPLATEK MESICNE', '1992-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'POPLATEK MESICNE', '1993-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 1, 'POPLATEK MESICNE', '1993-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 1, 'POPLATEK MESICNE', '1993-04-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 101, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 102, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1003, 103, 20, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1004, 104, 30, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1005, 101, 40, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (501, 20, '1993-06-15', 50000, 12, 100.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (502, 10, '1993-07-20', 10000, 12, 900.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (503, 30, '1994-01-10', 90000, 12, 7500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (504, 40, '1993-08-05', 95000, 24, 3958.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (505, 50, '1993-09-01', 99000, 12, 8250.0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.duration > 12 AND STRFTIME('%Y', T1.date) = '1993' ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(40,)
*/