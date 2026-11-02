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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '1000', '1', '1', '1', 1, 1, 50.0, 8000, 1.0, 1.0, 100, 100, 100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R2', '2000', '2', '2', '2', 2, 2, 60.0, 9000, 2.0, 2.0, 200, 200, 200);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 10, 'POPLATEK MESICNE', '1995-05-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (200, 20, 'POPLATEK MESICNE', '1995-06-06');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1970-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1980-02-02', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (100, 'M', '1990-03-03', 20);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 2, 100, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 1, 200, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1000, 100, '1996-01-03', 98832, 24, 4118.0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('1970-01-01',)
*/

-- Prediction Query
SELECT T3.birth_date FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T1.client_id = T3.client_id WHERE T2.amount = 98832 AND T2.date = '1996-01-03';

/*
Prediction Result:
('1980-02-02',)
*/