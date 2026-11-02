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
-- Tests:
-- 1.Zero numerator edge case: 0 'M' clients and 3 'F' clients matching 'POPLATEK TYDNE'.
-- 2.Result should be 0.0 (kills mutants that check gender = 'F' or gender != 'M', or use COUNT(gender) in numerator).
-- 3.Includes 'M' clients in districts that only have 'POPLATEK PO OBRATU' accounts.
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '2000', '2', '2', '2', 2, 2, 60.0, 2000, 2.0, 2.0, 20, 20, 20);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '2000', '2', '2', '2', 2, 2, 60.0, 2000, 2.0, 2.0, 20, 20, 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'F', '1985-03-15', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (11, 'F', '1988-07-20', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (12, 'M', '1990-11-11', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (13, 'M', '1992-12-12', 20);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 10, 'POPLATEK TYDNE', '1996-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 20, 'POPLATEK PO OBRATU', '1996-02-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 20, 'POPLATEK MESICNE', '1996-02-03');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (10, 12, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (11, 13, 100, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (12, 10, 101, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.client_id = T2.account_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(None,)
*/