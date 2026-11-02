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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'POPLATEK TYDNE', '%Y', 'POPLATEK TYDNE', 'POPLATEK TYDNE', '1997%', '%Y', 0, 0, 0.0, 1, 1.0, 2.0, 2, 2, 0), (2, 'default2', 'default2', '1997%', 'POPLATEK TYDNE', '1997', '1997%', 0, 1, 2.0, 0, 1.0, 0.0, 0, 2, 1), (0, '1997%', 'default2', '%Y', 'POPLATEK TYDNE', 'default2', '%Y', 2, 0, 0.0, 2, 0.0, 1.0, 0, 1, 1), (3, 'default1', 'default2', '1997', 'default1', '%Y', '1997', 0, 2, 2.0, 0, 2.0, 1.0, 0, 1, 0), (4, 'default1', 'POPLATEK TYDNE', '1997%', 'default1', '%Y', 'default1', 2, 2, 0.0, 2, NULL, 2.0, 2, NULL, 1), (5, 'POPLATEK TYDNE', '1997%', 'default2', '1997', 'default1', '1997', 1, 1, 2.0, 1, 2.0, 1.0, 0, NULL, 2), (6, '1997%', 'POPLATEK TYDNE', 'default1', 'default1', 'default2', '%Y', 0, 1, 1.0, 0, NULL, 2.0, 1, 0, 0), (7, '%Y', 'default1', 'default2', 'POPLATEK TYDNE', '%Y', 'default2', 2, 1, 2.0, 0, 2.0, 0.0, 0, NULL, 1), (8, '1997', 'default1', 'default1', '%Y', 'POPLATEK TYDNE', 'default1', 0, 2, 1.0, 1, 1.0, 2.0, 0, 0, 1), (9, '1997%', 'default2', 'default1', '%Y', 'default2', 'POPLATEK TYDNE', 2, 0, 1.0, 0, NULL, 1.0, 0, NULL, 1), (10, '1997%', '1997%', '%Y', 'default2', 'default2', 'default1', 0, 0, 0.0, 1, 0.0, 1.0, 1, NULL, 2), (11, 'POPLATEK TYDNE', '1997%', 'POPLATEK TYDNE', '1997%', 'default1', 'default1', 2, 2, 1.0, 1, NULL, 1.0, 0, 1, 1), (12, 'POPLATEK TYDNE', '1997', 'default2', '%Y', 'default2', 'POPLATEK TYDNE', 0, 0, 1.0, 0, NULL, 2.0, 1, 0, 1), (13, 'default2', '%Y', 'POPLATEK TYDNE', 'default1', '1997%', 'POPLATEK TYDNE', 0, 0, 2.0, 2, 1.0, 0.0, 2, 0, 2), (14, 'default1', 'POPLATEK TYDNE', '%Y', '1997%', '%Y', '1997', 0, 0, 1.0, 1, NULL, 0.0, 0, NULL, 1), (15, '1997', '%Y', '%Y', 'default1', 'default1', '%Y', 0, 0, 0.0, 1, NULL, 0.0, 2, NULL, 1), (16, '1997%', 'default1', '1997', '%Y', 'default1', '%Y', 0, 0, 2.0, 1, 2.0, 0.0, 2, 2, 2), (17, 'default2', '1997', '1997%', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 2, 0, 0.0, 0, NULL, 0.0, 0, 1, 1), (18, 'default2', 'default2', 'default2', '%Y', '1997%', 'default1', 2, 1, 1.0, 2, 0.0, 0.0, 2, 1, 0), (19, 'default2', 'default1', 'default1', '%Y', 'POPLATEK TYDNE', '1997%', 1, 0, 2.0, 1, 2.0, 0.0, 0, 2, 1), (20, '%Y', '1997', 'default1', '1997%', '1997', '1997%', 2, 0, 2.0, 0, NULL, 2.0, 1, 0, 2), (21, 'default1', '1997', '1997', 'POPLATEK TYDNE', '1997', '1997', 0, 0, 2.0, 1, 0.0, 0.0, 2, 0, 2), (22, 'POPLATEK TYDNE', 'POPLATEK TYDNE', '1997', 'default1', 'default2', 'default2', 2, 2, 1.0, 0, 2.0, 1.0, 1, 1, 1), (23, '%Y', 'default1', 'default1', '1997', '1997', '1997%', 1, 1, 1.0, 2, 1.0, 2.0, 1, 2, 0), (24, 'default2', '1997', '%Y', '%Y', '1997%', 'POPLATEK TYDNE', 0, 1, 0.0, 1, 0.0, 2.0, 0, 0, 1), (25, 'POPLATEK TYDNE', '1997', '%Y', '1997', '1997%', '1997', 1, 2, 0.0, 0, 1.0, 0.0, 2, 0, 0), (26, '1997', '1997', '1997', 'POPLATEK TYDNE', 'default1', '1997', 2, 0, 2.0, 0, 2.0, 0.0, 0, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 24, 'POPLATEK TYDNE', '2023-01-02'), (0, 4, 'POPLATEK TYDNE', '2023-01-01'), (2, 17, '1997', '2023-01-01'), (3, 24, 'default1', '2023-01-02'), (4, 20, 'default1', '2023-01-01'), (5, 18, 'default1', '1997-10-27'), (6, 4, '1997', '1997-10-27'), (7, 11, '%Y', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 5, '1997', 2, 2.0, '%Y'), (1, 5, 'default1', 2, 1.0, '1997%'), (2, 7, '1997%', 0, 0.0, '1997'), (3, 2, '1997%', 0, 2.0, '1997%'), (4, 1, 'POPLATEK TYDNE', 0, 1.0, '%Y'), (5, 4, 'default1', 2, 1.0, '1997'), (6, 3, 'default2', 0, 1.0, '1997');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 1, '2023-01-01', 2, 1, 0.0, 'default2'), (1, 4, '1997-10-27', 0, 2, 1.0, 'default2'), (0, 0, '2023-01-01', 2, 2, 1.0, 'default2'), (3, 6, '1997-10-27', 0, 0, 1.0, '%Y'), (4, 2, '2023-01-01', 1, 1, 2.0, '1997%'), (5, 2, '1997-10-27', 2, 0, 0.0, 'default2'), (6, 7, '1997-10-27', 2, 1, 2.0, 'POPLATEK TYDNE'), (7, 5, '2023-01-01', 1, 1, 1.0, 'default2'), (8, 2, '2023-01-01', 1, 2, 1.0, 'POPLATEK TYDNE'), (9, 6, '1997-10-27', 1, 2, 2.0, 'POPLATEK TYDNE'), (10, 2, '1997-10-27', 0, 2, 1.0, 'default1'), (11, 6, '2023-01-02', 2, 1, 0.0, 'default2'), (12, 5, '1997-10-27', 0, 1, 0.0, '1997%'), (13, 1, '1997-10-27', 2, 1, 2.0, 'default2'), (14, 0, '2023-01-01', 0, 2, 1.0, '1997'), (15, 1, '2023-01-01', 0, 0, 1.0, '1997'), (16, 3, '2023-01-02', 2, 0, 1.0, 'default2'), (17, 2, '2023-01-01', 1, 2, 0.0, '1997%'), (18, 1, '1997-10-27', 2, 2, 1.0, '1997'), (19, 0, '1997-10-27', 2, 2, 2.0, '1997'), (20, 0, '1997-10-27', 2, 1, 1.0, 'default1'), (21, 2, '2023-01-01', 2, 0, 0.0, 'default2'), (22, 4, '2023-01-02', 2, 1, 2.0, '1997%'), (23, 3, '2023-01-02', 0, 0, 0.0, '1997'), (24, 2, '1997-10-27', 1, 2, 2.0, '1997%'), (25, 0, '2023-01-01', 0, 2, 2.0, '%Y'), (26, 2, '2023-01-02', 2, 1, 2.0, '1997');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.date LIKE '1997%' AND T1.frequency = 'POPLATEK TYDNE' ORDER BY T2.amount ASC, T1.account_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/