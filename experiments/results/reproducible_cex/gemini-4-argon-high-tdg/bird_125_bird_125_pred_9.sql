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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 1.6, 2.3, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'Karvina', 'north Moravia', '285387', '0', '2', '1', 4, 5, 89.9, 10177, 4.5, 3.2, 81, 9872, 10124);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (30, 'Brno - mesto', 'south Moravia', '387570', '0', '0', '0', 1, 1, 100.0, 9897, 2.0, 6.0, 140, 18721, 19610);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (40, 'Ostrava - mesto', 'north Moravia', '323870', '0', '0', '0', 1, 1, 100.0, 10618, 5.0, 7.5, 100, 18204, 19129);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 10, 'POPLATEK MESICNE', '1993-02-26');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 20, 'POPLATEK TYDNE', '1994-05-12');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 30, 'POPLATEK MESICNE', '1995-01-19');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 40, 'POPLATEK PO OBRATU', '1995-08-03');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1001, 101, '1994-07-05', 96396, 12, 8033.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1002, 102, '1995-03-15', 45000, 24, 1875.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1003, 103, '1995-11-22', 60000, 36, 1666.7, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1004, 103, '1996-02-10', 72000, 24, 3000.0, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1005, 104, '1996-06-01', 120000, 48, 2500.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1006, 104, '1996-09-14', 36000, 12, 3000.0, 'd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((T3.A13 - T3.A12) AS REAL) * 100 / T3.A12 FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.status = 'D';

/*
Gold Result:
(43.74999999999998,)
(-28.888888888888882,)
*/

-- Prediction Query
SELECT T1.A3, CAST((T1.A13 - T1.A12) AS REAL) * 100 / T1.A12 FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T3.status = 'D';

/*
Prediction Result:
('Prague', 43.74999999999998)
('north Moravia', -28.888888888888882)
*/