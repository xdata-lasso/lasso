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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'A', 'default2', 'A', 'POPLATEK TYDNE', 2, 2, 1.0, 0, 1.0, 1.0, 0, 1, 1), (2, 'default2', 'A', 'default2', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 1, 2, 1.0, 2, NULL, 0.0, 2, 1, 1), (0, 'POPLATEK TYDNE', 'default2', 'default1', '%Y', 'A', 'POPLATEK TYDNE', 1, 2, 2.0, 1, 2.0, 1.0, 0, 2, 0), (3, 'POPLATEK TYDNE', 'default1', '%Y', 'A', '%Y', 'POPLATEK TYDNE', 1, 1, 2.0, 2, 1.0, 1.0, 2, NULL, 0), (4, '%Y', '%Y', '1997', 'A', '%Y', '%Y', 2, 2, 2.0, 0, 0.0, 1.0, 0, 1, 0), (5, 'A', 'POPLATEK TYDNE', '1997', 'default2', 'default1', 'default2', 1, 2, 1.0, 2, NULL, 2.0, 1, 2, 2), (6, 'default1', 'A', 'default1', 'default2', '1997', 'default1', 0, 2, 1.0, 2, NULL, 1.0, 1, 2, 0), (7, 'A', 'default1', 'A', 'default1', 'A', 'default2', 2, 0, 2.0, 1, NULL, 2.0, 0, 2, 1), (8, 'default2', '%Y', 'A', '1997', 'default1', 'POPLATEK TYDNE', 2, 1, 1.0, 0, 1.0, 0.0, 1, 0, 1), (9, '1997', '1997', 'A', 'POPLATEK TYDNE', 'default1', '%Y', 1, 2, 2.0, 0, 1.0, 1.0, 1, 2, 2), (10, '1997', 'A', 'default2', 'default1', 'POPLATEK TYDNE', '1997', 0, 0, 1.0, 0, NULL, 2.0, 0, 1, 2), (11, 'default2', 'default1', '1997', '%Y', '1997', 'default2', 1, 2, 0.0, 1, 0.0, 2.0, 0, 0, 2), (12, 'A', '1997', 'default1', '%Y', 'default1', 'A', 0, 2, 1.0, 2, 0.0, 2.0, 2, 2, 2), (13, '%Y', 'default2', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'A', '1997', 1, 0, 0.0, 2, 1.0, 1.0, 0, NULL, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 6, 'A', '1997-10-27'), (2, 8, '1997', '2023-01-01'), (1, 6, 'A', '1997-10-27'), (3, 8, 'POPLATEK TYDNE', '2023-01-02'), (4, 13, 'POPLATEK TYDNE', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 2, 'A', 1, 2.0, '1997'), (1, 2, 'POPLATEK TYDNE', 0, 1.0, 'A'), (2, 3, 'default2', 0, 0.0, 'default2'), (3, 0, 'default2', 1, 2.0, 'A'), (4, 0, '1997', 0, 2.0, 'default2'), (5, 2, 'default1', 2, 2.0, 'default2'), (6, 4, 'POPLATEK TYDNE', 0, 0.0, 'A'), (7, 2, 'POPLATEK TYDNE', 1, 2.0, '1997'), (8, 3, 'default1', 1, 2.0, '%Y'), (9, 2, '1997', 0, 2.0, 'POPLATEK TYDNE'), (10, 1, '%Y', 2, 2.0, 'default2'), (11, 3, 'default2', 2, 0.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 4, '1997-10-27', 2, 2, 1.0, 'default1'), (2, 1, '2023-01-01', 1, 2, 2.0, 'POPLATEK TYDNE'), (1, 4, '2023-01-01', 0, 0, 1.0, '1997'), (3, 1, '2023-01-02', 0, 0, 0.0, 'A'), (4, 3, '2023-01-02', 0, 2, 0.0, '1997'), (5, 0, '2023-01-02', 1, 2, 1.0, 'A'), (6, 1, '2023-01-01', 0, 0, 0.0, 'default1'), (7, 3, '1997-10-27', 0, 1, 0.0, 'POPLATEK TYDNE'), (8, 3, '1997-10-27', 0, 0, 1.0, 'default2'), (9, 3, '2023-01-01', 1, 1, 1.0, '%Y'), (10, 3, '1997-10-27', 0, 2, 0.0, 'POPLATEK TYDNE'), (11, 0, '2023-01-01', 2, 2, 1.0, 'POPLATEK TYDNE'), (12, 1, '2023-01-01', 1, 0, 0.0, 'POPLATEK TYDNE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT T2.account_id, T1.amount AS lowest_amount FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.status = 'A' AND STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' AND T1.amount = (SELECT MIN(amount) FROM loan WHERE status = 'A' AND STRFTIME('%Y', date) = '1997');

/*
Prediction Result:
*/