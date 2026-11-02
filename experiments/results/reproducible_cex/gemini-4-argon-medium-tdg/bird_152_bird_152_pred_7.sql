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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'D1', 'R1', '1000', '10', '10', '10', 1, 1, 50.0, 8000, 1.5, 2.0, 100, 4000, 4100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'D2', 'R2', '2000', '20', '20', '20', 2, 2, 60.0, 9000, 2.5, 3.0, 110, 4001, 4200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (3, 'D3', 'R3', '3000', '30', '30', '30', 3, 3, 70.0, 10000, 3.5, 4.0, 120, 5000, 5200);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (4, 'D4', 'R4', '4000', '40', '40', '40', 4, 4, 80.0, 11000, NULL, 5.0, 130, NULL, 5500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'D5', 'R5', '5000', '50', '50', '50', 5, 5, 90.0, 12000, 4.5, 6.0, 140, 8000, 8500);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1997-05-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 2, 'POPLATEK MESICNE', '1997-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 3, 'POPLATEK MESICNE', '1998-06-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 3, 'POPLATEK MESICNE', '1999-12-31');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 3, 'POPLATEK MESICNE', '1996-12-31');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (106, 4, 'POPLATEK MESICNE', '1998-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.A15) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE STRFTIME('%Y', T2.date) >= '1997' AND T1.A15 > 4000;

/*
Gold Result:
(4667.0,)
*/

-- Prediction Query
SELECT AVG(T1.A15) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T1.A4 > 4000 AND T2.date >= '1997-01-01' AND T2.date < '1998-01-01';

/*
Prediction Result:
(None,)
*/