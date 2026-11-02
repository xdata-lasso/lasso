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
-- DATASET 3
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Plzen', 'West_Bohemia', '170000', '12', '6', '3', 4, 2, 85.0, 10200, 1.5, 1.8, 130, 5000, 5500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (6, 'Liberec', 'North_Bohemia', '100000', '15', '7', '4', 5, 3, 80.0, 9800, 2.1, 2.5, 125, 4000, 4200);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 5, 'POPLATEK MESICNE', '1993-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 5, 'POPLATEK MESICNE', '1993-06-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 6, 'POPLATEK TYDNE', '1994-01-20');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (501, 10, '1994-05-01', 350000, 36, 9722.2, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (502, 10, '1995-05-01', 420000, 48, 8750.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (503, 20, '1994-07-10', 200000, 24, 8333.3, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (504, 20, '1995-07-10', 250000, 36, 6944.4, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (505, 30, '1994-11-11', 500000, 60, 8333.3, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (506, 30, '1995-11-11', 50000, 12, 4166.7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.amount > 300000;

/*
Gold Result:
(10, 'Plzen', 'West_Bohemia')
(10, 'Plzen', 'West_Bohemia')
(30, 'Liberec', 'North_Bohemia')
*/

-- Prediction Query
SELECT DISTINCT T2.account_id, T4.A2, T4.A3 FROM loan AS T2 JOIN account AS T3 ON T2.account_id = T3.account_id JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T2.amount > 300000;

/*
Prediction Result:
(10, 'Plzen', 'West_Bohemia')
(30, 'Liberec', 'North_Bohemia')
*/