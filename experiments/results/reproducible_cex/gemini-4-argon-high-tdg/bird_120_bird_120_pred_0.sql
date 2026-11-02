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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Pardubice', 'east Bohemia', '100000', '10', '5', '2', 1, 5, 75.5, 8500, 1.2, 1.5, 120, 2000, 2100);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Brno', 'south Moravia', '300000', '20', '10', '4', 2, 8, 88.0, 9200, 2.1, 2.5, 140, 5000, 5200);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '1994-12-31');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 1, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 1, 'POPLATEK TYDNE', '1995-06-15');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (104, 1, 'POPLATEK MESICNE', '1997-08-20');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (105, 1, 'POPLATEK PO OBRATU', '2000-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (106, 1, 'POPLATEK TYDNE', '2000-07-10');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (107, 1, 'POPLATEK MESICNE', '2000-12-31');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (108, 1, 'POPLATEK MESICNE', '2001-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (109, 2, 'POPLATEK MESICNE', '1998-05-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T1.frequency FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'east Bohemia' AND STRFTIME('%Y', T1.date) BETWEEN '1995' AND '2000';

/*
Gold Result:
(102, 'POPLATEK MESICNE')
(103, 'POPLATEK TYDNE')
(104, 'POPLATEK MESICNE')
(105, 'POPLATEK PO OBRATU')
(106, 'POPLATEK TYDNE')
(107, 'POPLATEK MESICNE')
*/

-- Prediction Query
SELECT T1.account_id, T1.frequency, T3.gender FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id INNER JOIN disp AS T4 ON T3.client_id = T4.client_id WHERE T2.A3 = 'east Bohemia' AND T1.date BETWEEN '1995-01-01' AND '2000-12-31' AND T4.type = 'OWNER';

/*
Prediction Result:
*/