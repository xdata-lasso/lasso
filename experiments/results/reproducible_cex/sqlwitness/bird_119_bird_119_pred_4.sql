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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', '1993%', '%Y', '%Y', 'default2', 'default2', 0, 1, 0.0, 0, 1.0, 1.0, 0, 1, 1), (0, '1993%', 'default1', 'default2', '1993', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', 1, 1, 0.0, 1, 0.0, 1.0, 0, 1, 0), (2, 'POPLATEK PO OBRATU', '%Y', 'default1', 'POPLATEK PO OBRATU', '1993', 'default1', 1, 1, 1.0, 0, 1.0, 1.0, 1, 0, 1), (3, 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', '1993%', '%Y', 'default1', 'default2', 0, 0, 0.0, 0, 1.0, 0.0, 1, 0, 1), (4, '%Y', 'default2', '%Y', '1993', 'default2', '1993', 0, 1, 1.0, 0, 0.0, 0.0, 1, NULL, 1), (5, '1993', '1993', '%Y', 'default1', '%Y', 'default2', 1, 1, 0.0, 1, NULL, 0.0, 0, 0, 1), (6, 'default1', '1993', '1993%', '1993%', 'default2', 'POPLATEK PO OBRATU', 1, 1, 0.0, 0, 1.0, 0.0, 1, 1, 1), (7, '1993%', '1993%', '1993%', 'default2', 'default2', '1993', 0, 1, 1.0, 0, NULL, 1.0, 1, 1, 1), (8, '1993', 'POPLATEK PO OBRATU', '1993%', 'default2', '1993%', 'default2', 0, 0, 0.0, 1, 0.0, 1.0, 1, NULL, 1), (9, 'default1', 'POPLATEK PO OBRATU', 'default1', '%Y', 'default2', 'POPLATEK PO OBRATU', 0, 1, 1.0, 0, 1.0, 1.0, 0, NULL, 0), (10, '%Y', 'default1', '%Y', 'default1', 'POPLATEK PO OBRATU', 'default1', 1, 1, 1.0, 0, NULL, 1.0, 0, 0, 0), (11, '1993%', '1993%', '1993', '1993%', 'default2', 'default2', 0, 0, 1.0, 0, 0.0, 1.0, 1, 1, 1), (12, '1993', 'POPLATEK PO OBRATU', 'POPLATEK PO OBRATU', '%Y', '%Y', '1993', 1, 0, 1.0, 1, NULL, 1.0, 1, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 1, '%Y', '2023-01-01'), (0, 5, 'POPLATEK PO OBRATU', '2023-01-02'), (2, 4, '1993', '1993-10-27'), (3, 4, 'POPLATEK PO OBRATU', '1993-10-27'), (4, 0, 'default2', '2023-01-02'), (5, 10, 'default1', '2023-01-01'), (6, 9, 'default2', '2023-01-01'), (7, 8, '1993', '2023-01-01'), (8, 9, 'POPLATEK PO OBRATU', '2023-01-02'), (9, 8, '1993%', '2023-01-02'), (10, 1, 'default1', '2023-01-01'), (11, 10, 'default1', '1993-10-27'), (12, 11, '1993', '2023-01-02'), (13, 8, 'default1', '2023-01-01'), (14, 12, 'POPLATEK PO OBRATU', '2023-01-01'), (15, 7, 'default2', '1993-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'POPLATEK PO OBRATU', '1993-10-27'), (1, 0, '1993%', '2023-01-01'), (2, 9, '1993', '2023-01-01'), (3, 10, '1993', '2023-01-01'), (4, 2, 'POPLATEK PO OBRATU', '2023-01-02'), (5, 10, 'POPLATEK PO OBRATU', '1993-10-27'), (6, 6, 'default2', '2023-01-01'), (7, 1, 'default1', '1993-10-27'), (8, 4, '%Y', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 3, 3, 'default2'), (1, 8, 12, 'POPLATEK PO OBRATU'), (2, 7, 12, 'default1'), (3, 3, 11, 'default2'), (4, 8, 7, '1993'), (5, 0, 13, 'default2'), (6, 6, 5, '1993'), (7, 2, 7, 'default2'), (8, 8, 8, '%Y'), (9, 5, 6, '1993%'), (10, 2, 5, '1993%'), (11, 0, 2, '1993%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.frequency = 'POPLATEK PO OBRATU' AND STRFTIME('%Y', T1.date) = '1993';

/*
Gold Result:
(0, '1993%', 'default1')
(5, '%Y', 'default1')
*/

-- Prediction Query
SELECT a.account_id, d.A2 AS district_name, d.A3 AS region FROM account AS a JOIN disp AS dp ON a.account_id = dp.account_id JOIN district AS d ON a.district_id = d.district_id WHERE a.date LIKE '1993%' AND a.frequency = 'POPLATEK PO OBRATU';

/*
Prediction Result:
(0, '1993%', 'default1')
(5, '%Y', 'default1')
(0, '1993%', 'default1')
*/