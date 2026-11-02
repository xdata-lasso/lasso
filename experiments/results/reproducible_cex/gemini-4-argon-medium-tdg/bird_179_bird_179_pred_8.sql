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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '200', '2', '2', '2', 2, 2, 2.0, 2, 2.0, 2.0, 2, 2, 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (617, 'M', '1970-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (618, 'F', '1975-05-05', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (619, 'M', '1980-10-10', 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 10, 'POPLATEK MESICNE', '1998-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 20, 'POPLATEK MESICNE', '1996-02-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (617, 20, 'POPLATEK MESICNE', '1997-03-03');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (101, 618, 1, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (102, 617, 3, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (103, 619, 2, 'OWNER');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1001, 1, '1998-01-01', 'PRIJEM', 'VKLAD', 100, 500, 'UROK', 'AB', 111);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1002, 1, '1998-12-31', 'VYDAJ', 'VYBER', 100, 400, 'SLUZBY', 'CD', 222);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1003, 2, '1998-06-15', 'PRIJEM', 'VKLAD', 250, 1250, 'UROK', 'EF', 333);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1004, 1, '1997-12-31', 'PRIJEM', 'VKLAD', 1000, 1500, 'UROK', 'GH', 444);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1005, 2, '1999-01-01', 'PRIJEM', 'VKLAD', 2000, 3250, 'UROK', 'IJ', 555);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1006, 3, '1998-07-07', 'PRIJEM', 'VKLAD', 4000, 8000, 'UROK', 'KL', 666);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1007, 617, '1998-08-08', 'PRIJEM', 'VKLAD', 8000, 9000, 'UROK', 'MN', 777);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.amount) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1998' AND T1.client_id = 617;

/*
Gold Result:
(450,)
*/

-- Prediction Query
SELECT SUM(T1.amount) FROM trans AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T2.client_id = 617 AND STRFTIME('%Y', T1.date) = '1998';

/*
Prediction Result:
(4000,)
*/