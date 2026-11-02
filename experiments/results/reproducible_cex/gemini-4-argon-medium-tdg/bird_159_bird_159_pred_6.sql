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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Ostrava', 'North', '300', '30', '30', '30', 3, 3, 85.0, 8500, 3.0, 3.0, 85, 85, 85);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3356, 'F', '1965-12-12', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1000, 'M', '1990-06-06', 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1000, 10, 'POPLATEK MESICNE', '1994-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2000, 10, 'POPLATEK MESICNE', '1994-06-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3356, 10, 'POPLATEK MESICNE', '1994-07-07');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 3356, 1000, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 1000, 2000, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 1000, 3356, 'DISPONENT');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (9001, 1000, '1996-01-01', 'VYDAJ', 'VYBER', 500, 4500, NULL, NULL, 2000);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (9002, 1000, '1996-01-02', 'VYDAJ', 'VYBER', 500, 4000, NULL, NULL, 2000);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (9003, 2000, '1996-01-03', 'VYDAJ', 'VYBER', 500, 3500, NULL, NULL, 1000);
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (9004, 3356, '1996-01-04', 'VYDAJ', 'VYBER', 500, 3000, NULL, NULL, 1000);
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 1, 'VYBER', '1995-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 1000, '1995-05-05', 12000, 12, 1000.0, 'A');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 1000, 'AB', 2000, 3356.0, 'VYBER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.trans_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN trans AS T4 ON T3.account_id = T4.account_id WHERE T1.client_id = 3356 AND T4.operation = 'VYBER';

/*
Gold Result:
(9001,)
(9002,)
*/

-- Prediction Query
SELECT trans.trans_id FROM trans INNER JOIN account ON trans.account_id = account.account_id INNER JOIN client ON account.district_id = client.district_id WHERE client.client_id = 3356 AND trans.operation = 'VYBER';

/*
Prediction Result:
(9001,)
(9002,)
(9003,)
(9004,)
*/