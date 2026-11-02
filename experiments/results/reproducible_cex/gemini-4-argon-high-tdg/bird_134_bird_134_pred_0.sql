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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'D10', 'R1', '10000', '10', '10', '10', 1, 1, 50.0, 10000, 1.5, 2.0, 100, 400, 500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'D20', 'R1', '20000', '20', '20', '20', 2, 2, 60.0, 11000, 2.5, 3.0, 110, 450, 500);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (30, 'D30', 'R2', '30000', '30', '30', '30', 3, 3, 70.0, 12000, 3.5, 4.0, 120, 600, 400);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (40, 'D40', 'R2', '40000', '40', '40', '40', 4, 4, 80.0, 13000, 4.5, 5.0, 130, 200, 300);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (50, 'D50', 'R3', '50000', '50', '50', '50', 5, 5, 90.0, 14000, 5.5, 6.0, 140, 100, 100);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1001, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1002, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1003, 20, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1004, 20, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1005, 20, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1006, 30, 'POPLATEK MESICNE', '1995-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1007, 30, 'POPLATEK TYDNE', '1995-02-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1008, 30, 'POPLATEK PO OBRATU', '1995-02-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1009, 30, 'POPLATEK MESICNE', '1995-02-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1010, 30, 'POPLATEK TYDNE', '1995-02-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1011, 30, 'POPLATEK MESICNE', '1995-02-06');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1012, 30, 'POPLATEK MESICNE', '1995-02-07');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1013, 40, 'POPLATEK MESICNE', '1995-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1014, 50, 'POPLATEK MESICNE', '1995-04-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1015, 50, 'POPLATEK TYDNE', '1995-04-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1016, 50, 'POPLATEK PO OBRATU', '1995-04-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1017, 50, 'POPLATEK MESICNE', '1995-04-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id GROUP BY T1.A16 ORDER BY T1.A16 DESC, COUNT(T2.account_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(account_id) FROM account WHERE district_id = (SELECT district_id FROM district ORDER BY A16 DESC, district.district_id NULLS LAST LIMIT 1);

/*
Prediction Result:
(2,)
*/