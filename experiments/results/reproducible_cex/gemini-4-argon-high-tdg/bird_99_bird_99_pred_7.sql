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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Dist1', 'Reg1', '10000', '10', '5', '2', 1, 1, 60.5, 8500, 2.1, 2.5, 100, 200, 250);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1993-01-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK MESICNE', '1993-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 1, 'POPLATEK MESICNE', '1991-03-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 1, 'POPLATEK MESICNE', '1993-08-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 1, 'POPLATEK MESICNE', '1992-11-11');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (106, 1, 'POPLATEK MESICNE', '1993-04-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (301, 'M', '1960-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (302, 'F', '1965-02-02', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (303, 'M', '1970-03-03', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (304, 'F', '1975-04-04', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (305, 'M', '1980-05-05', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (901, 301, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (902, 302, 102, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (903, 303, 103, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (904, 304, 104, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (905, 305, 105, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (501, 101, '1993-02-10', 90000, 12, 7500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (502, 102, '1992-12-31', 200000, 12, 16666.67, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (503, 103, '1993-06-15', 100000, 12, 500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (504, 104, '1994-01-01', 250000, 12, 20833.33, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (505, 105, '1993-12-15', 300000, 24, 12.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (506, 106, '1993-07-20', 500000, 12, 41666.67, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
(103,)
*/

-- Prediction Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 12 AND STRFTIME('%Y', T2.date) = '1993' ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/