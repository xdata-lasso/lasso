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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'Beroun', 'central Bohemia', '75232', '55', '26', '4', 1, 5, 41.7, 8980, 1.9, 2.21, 111, 2824, 2813);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 3, 'POPLATEK TYDNE', '1995-03-24');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 1, 'POPLATEK MESICNE', '1997-07-07');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (3, 3, 'AB', 11111, 1000.0, 'UVER');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (10, 3, 'CD', 22222, 3539.0, 'SIPO');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (11, 3, 'EF', 33333, 5000.0, 'POJISTNE');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (12, 1, 'GH', 3, 3539.0, 'LEASING');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (100, 3, '1998-01-15', 'VYDAJ', 'PREVOD NA UCET', 3539, 15000, 'SLUZBY', 'IJ', 44444);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.frequency, T2.k_symbol FROM account AS T1 INNER JOIN "order" AS T2 ON T1.account_id = T2.account_id WHERE T1.account_id = 3 AND T2.amount = 3539;

/*
Gold Result:
('POPLATEK MESICNE', 'SIPO')
*/

-- Prediction Query
SELECT COUNT(*) AS total_requests, SUM(amount) AS total_debit_amount FROM trans JOIN account ON trans.account_id = account.account_id WHERE trans.account_id = 3 AND trans.k_symbol = 'SVAT';

/*
Prediction Result:
(0, None)
*/