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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Prague', 'Central', '100000', '10', '5', '2', 1, 1, 100.0, 10000, 1.5, 2.0, 100, 500, 600);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (20, 'F', '1975-05-12', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (30, 'M', '1980-08-20', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (40, 'F', '1985-11-30', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (50, 'M', '1990-03-15', 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 1, 'POPLATEK PO OBRATU', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 1, 'POPLATEK PO OBRATU', '1995-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (300, 1, 'POPLATEK MESICNE', '1995-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (400, 1, 'POPLATEK MESICNE', '1995-04-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (500, 1, 'POPLATEK PO OBRATU', '1995-05-01');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 10, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 20, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1003, 30, 100, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1004, 40, 200, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1005, 50, 300, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1006, 10, 400, 'DISPONENT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T2.type = 'OWNER' AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.disp_id) AS count FROM disp AS T1 INNER JOIN account AS T2 ON T1.disp_id = T2.district_id WHERE T1.type = 'OWNER' AND T2.frequency = 'POPLATEK PO OBRATU';

/*
Prediction Result:
(0,)
*/