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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '1', '1', '1', 1, 1, 50.0, 10000, 1.0, 1.0, 10, 10, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'MONTHLY', '2020-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'MONTHLY', '2020-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'MONTHLY', '2020-01-03');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1985-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1990-01-01', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 101, 10, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 102, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1003, 103, 30, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (501, 10, '2021-01-01', 90000, 12, 7500.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (502, 20, '2021-01-02', 50000, 60, 833.3, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (503, 30, '2021-01-03', 10000, 12, 8333.3, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT T3.client_id FROM account AS T1 JOIN loan AS T2 ON T1.account_id = T2.account_id JOIN disp AS T4 ON T1.account_id = T4.account_id JOIN client AS T3 ON T4.client_id = T3.client_id ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.loan_id NULLS LAST, T4.disp_id NULLS LAST, T3.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(101,)
*/