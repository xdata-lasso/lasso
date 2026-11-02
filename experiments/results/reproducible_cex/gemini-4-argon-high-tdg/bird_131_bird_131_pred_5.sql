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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1200000', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Brno - mesto', 'south Moravia', '387570', '0', '0', '0', 1, 1, 100.0, 9897, 1.6, 1.96, 140, 18721, 18696);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Ostrava - mesto', 'north Moravia', '323870', '0', '0', '0', 1, 1, 100.0, 10673, 4.7, 5.44, 100, 18782, 18347);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (11, 1, 'POPLATEK MESICNE', '1994-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (12, 1, 'POPLATEK MESICNE', '1994-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (21, 2, 'POPLATEK MESICNE', '1994-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (22, 2, 'POPLATEK MESICNE', '1994-02-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (23, 2, 'POPLATEK MESICNE', '1994-02-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (31, 3, 'POPLATEK MESICNE', '1994-03-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (101, 11, '1995-01-01', 8000, 24, 333.3, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (102, 12, '1995-01-02', 3000, 12, 250.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (201, 21, '1995-02-01', 4000, 24, 166.7, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (202, 22, '1995-02-02', 4000, 24, 166.7, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (203, 23, '1995-02-03', 1000, 12, 83.3, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (301, 31, '1995-03-01', 10000, 12, 833.3, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('Prague',)
*/

-- Prediction Query
SELECT d.A3 AS district_name FROM loan AS l INNER JOIN account AS a ON l.account_id = a.account_id INNER JOIN district AS d ON a.district_id = d.district_id WHERE l.status IN ('C', 'D') GROUP BY d.A3 ORDER BY COUNT(l.loan_id) DESC, district_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('south Moravia',)
*/