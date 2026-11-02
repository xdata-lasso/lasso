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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Hl.m. Praha', 'Prague', '1200000', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'Brno-mesto', 'south Moravia', '387570', '0', '0', '0', 1, 1, 100.0, 9897, 1.6, 1.96, 140, 18782, 18696);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (30, 'Ostrava-mesto', 'north Moravia', '323870', '0', '0', '0', 1, 1, 100.0, 10618, 4.7, 5.44, 100, 18793, 18801);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (991, 'M', '1970-01-15', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (992, 'F', '1975-05-20', 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 10, 'POPLATEK MESICNE', '1993-02-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 20, 'POPLATEK MESICNE', '1994-03-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (300, 30, 'POPLATEK TYDNE', '1995-04-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (992, 30, 'POPLATEK PO OBRATU', '1996-06-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 991, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 992, 200, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1000, 100, '1994-06-01', 12000, 12, 1000.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2000, 200, '1995-07-01', 50000, 24, 2083.3, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (3000, 992, '1997-01-01', 99000, 36, 2750.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (992, 300, '1996-08-01', 77000, 48, 1604.2, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.amount, T3.status FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 992;

/*
Gold Result:
(12000, 'A')
*/

-- Prediction Query
SELECT l."amount", l."status" FROM "loan" AS l JOIN "disp" AS d ON l."account_id" = d."account_id" WHERE d."client_id" = 992;

/*
Prediction Result:
(50000, 'B')
*/