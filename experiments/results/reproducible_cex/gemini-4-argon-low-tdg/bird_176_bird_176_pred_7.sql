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
-- Target: Decouple district_id join from disp (disposition) join.
-- Client 992 is in District 10, which has Account 101 (Loan 201), but Client 992 is NOT linked to Account 101 in disp.
-- Client 992 IS linked via disp to Account 102 (Loan 202), which belongs to District 20.
-- Also tests boundary conditions for client_id (991, 992, 993).
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '1000', '1', '1', '1', 1, 1, 50.0, 1000, 1.0, 1.0, 10, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '2000', '2', '2', '2', 2, 2, 60.0, 2000, 2.0, 2.0, 20, 20, 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (991, 'M', '1970-01-01', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (992, 'F', '1980-02-02', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (993, 'M', '1990-03-03', 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 20, 'POPLATEK TYDNE', '1996-02-02');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 992, 102, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 991, 101, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 993, 102, 'DISPONENT');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (201, 101, '1997-05-05', 15000, 12, 1250.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (202, 102, '1998-06-06', 84000, 24, 3500.0, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.amount, T3.status FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 992;

/*
Gold Result:
(15000, 'A')
*/

-- Prediction Query
SELECT T3.amount, T3.status FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 992;

/*
Prediction Result:
(84000, 'B')
*/