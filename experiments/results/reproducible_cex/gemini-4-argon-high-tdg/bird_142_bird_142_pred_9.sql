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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Pisek', 'south Bohemia', '70000', '50', '10', '5', 1, 5, 60.5, 8500, 1.5, 2.0, 110, 1200, 1300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'Strakonice', 'Pisek', '65000', '40', '8', '4', 1, 4, 55.0, 8200, 2.1, 2.5, 100, 1000, 1100);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 10, 'POPLATEK MESICNE', '1995-01-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 10, 'POPLATEK MESICNE', '1995-02-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 10, 'POPLATEK MESICNE', '1995-03-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 20, 'POPLATEK MESICNE', '1995-04-25');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1001, 101, '1996-01-05', 'VYDAJ', 'PREVOD NA UCET', 1500, 20000, 'SIPO', 'AB', 201);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1002, 101, '1996-02-05', 'VYDAJ', 'PREVOD NA UCET', 1500, 18500, 'SIPO', 'AB', 102);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1003, 101, '1996-03-05', 'VYDAJ', 'PREVOD NA UCET', 2000, 16500, 'UVER', 'CD', 101);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1004, 102, '1996-01-10', 'VYDAJ', 'PREVOD NA UCET', 3000, 12000, 'UVER', 'EF', 101);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1005, 102, '1996-02-10', 'PRIJEM', 'VKLAD', 5000, 17000, NULL, NULL, NULL);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1006, 201, '1996-01-15', 'VYDAJ', 'PREVOD NA UCET', 1200, 14000, 'SIPO', 'GH', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.k_symbol = 'SIPO' AND T3.A2 = 'Pisek';

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN "order" AS T3 ON T1.account_id = T3.account_id WHERE T2.A2 = 'Pisek' AND T3.k_symbol = 'SIPO';

/*
Prediction Result:
*/