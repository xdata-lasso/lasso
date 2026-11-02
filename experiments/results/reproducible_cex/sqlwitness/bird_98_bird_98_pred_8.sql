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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (2, '1997%', '1997', 'default1', '1997%', 'default1', '%Y', 1, 2, 0.0, 2, NULL, 0.0, 0, 0, 1), (1, 'default1', '1997', '1997%', 'POPLATEK TYDNE', '1997', 'POPLATEK TYDNE', 2, 2, 2.0, 0, 1.0, 1.0, 1, 2, 1), (0, 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', '1997%', 'POPLATEK TYDNE', '1997%', 0, 0, 2.0, 0, 0.0, 2.0, 1, 2, 0), (3, 'default2', '1997%', 'default2', '1997', '%Y', 'POPLATEK TYDNE', 1, 0, 2.0, 0, 2.0, 0.0, 2, NULL, 2), (4, '1997', 'default1', 'default1', '1997', 'default2', 'default2', 1, 0, 0.0, 0, 0.0, 0.0, 2, 1, 2), (5, 'POPLATEK TYDNE', '%Y', 'POPLATEK TYDNE', '%Y', '1997%', 'default1', 2, 0, 2.0, 0, 1.0, 2.0, 1, 2, 0), (6, '1997', '%Y', '1997%', 'default1', '1997%', '1997%', 2, 2, 0.0, 2, NULL, 0.0, 0, 1, 0), (7, '1997%', '%Y', '1997', 'default1', '1997%', '%Y', 2, 2, 1.0, 1, 1.0, 2.0, 0, 2, 2), (8, 'default1', '1997', 'POPLATEK TYDNE', 'POPLATEK TYDNE', '1997%', 'default2', 1, 2, 0.0, 0, 2.0, 0.0, 0, NULL, 2), (9, '%Y', '1997%', 'default1', 'default2', '1997', '%Y', 0, 2, 2.0, 1, NULL, 1.0, 0, 0, 0), (10, 'default1', '%Y', '%Y', '1997%', '1997', 'POPLATEK TYDNE', 2, 2, 0.0, 2, NULL, 1.0, 1, 1, 1), (11, '1997%', 'default1', 'POPLATEK TYDNE', 'default1', '1997', 'default1', 0, 1, 0.0, 0, 0.0, 1.0, 1, 2, 0), (12, '1997%', 'default1', '1997%', 'default2', '1997%', '1997%', 2, 2, 1.0, 1, 1.0, 2.0, 0, 1, 0), (13, '1997', '%Y', 'default2', '1997', '1997', '1997%', 2, 2, 0.0, 1, 2.0, 0.0, 1, 1, 1), (14, 'default1', '1997%', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default1', 'POPLATEK TYDNE', 1, 1, 2.0, 2, 1.0, 1.0, 0, 0, 1), (15, '1997', '1997', '1997', '1997', 'default2', 'POPLATEK TYDNE', 2, 1, 2.0, 0, 0.0, 1.0, 1, NULL, 1), (16, 'POPLATEK TYDNE', 'default1', 'default1', '1997%', '%Y', 'default2', 2, 0, 1.0, 0, NULL, 2.0, 1, 2, 0), (17, '1997%', '%Y', '1997%', '1997%', 'POPLATEK TYDNE', 'default2', 2, 2, 1.0, 1, 0.0, 2.0, 1, 0, 1), (18, 'default1', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', '%Y', 2, 2, 0.0, 0, 1.0, 1.0, 0, 1, 2), (19, '1997', 'POPLATEK TYDNE', 'default1', 'default2', '1997%', 'POPLATEK TYDNE', 0, 0, 0.0, 2, 0.0, 0.0, 0, NULL, 1), (20, '1997%', 'default2', 'default2', 'default2', 'POPLATEK TYDNE', 'default1', 1, 0, 2.0, 2, 2.0, 1.0, 1, 0, 0), (21, 'default2', 'default2', '1997%', '%Y', 'POPLATEK TYDNE', '%Y', 0, 0, 2.0, 0, 0.0, 1.0, 2, 2, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 18, '1997', '2023-01-01'), (0, 14, 'default1', '2023-01-01'), (1, 20, 'default1', '1997-10-27'), (3, 5, '1997', '1997-10-27'), (4, 15, 'POPLATEK TYDNE', '2023-01-01'), (5, 2, 'POPLATEK TYDNE', '2023-01-01'), (6, 20, '1997%', '1997-10-27'), (7, 20, 'default2', '2023-01-02'), (8, 5, 'POPLATEK TYDNE', '1997-10-27'), (9, 10, '1997', '2023-01-01'), (10, 2, 'default2', '1997-10-27'), (11, 17, 'POPLATEK TYDNE', '1997-10-27'), (12, 13, '1997%', '1997-10-27'), (13, 1, '%Y', '1997-10-27');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 7, '%Y', 1, 0.0, 'default2'), (1, 7, '%Y', 2, 2.0, '%Y'), (2, 7, '1997%', 2, 0.0, 'default1'), (3, 4, '1997', 0, 2.0, 'POPLATEK TYDNE'), (4, 4, '1997%', 2, 2.0, 'default1');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 1, '2023-01-01', 1, 1, 0.0, '1997'), (2, 8, '2023-01-02', 2, 1, 1.0, '1997%'), (0, 13, '2023-01-02', 0, 0, 0.0, 'POPLATEK TYDNE'), (3, 9, '2023-01-02', 1, 0, 1.0, '%Y'), (4, 3, '1997-10-27', 0, 0, 1.0, '%Y'), (5, 13, '2023-01-01', 0, 0, 2.0, '%Y'), (6, 9, '1997-10-27', 0, 0, 1.0, 'POPLATEK TYDNE'), (7, 1, '2023-01-01', 0, 0, 1.0, 'POPLATEK TYDNE'), (8, 5, '1997-10-27', 2, 1, 1.0, 'POPLATEK TYDNE'), (9, 9, '2023-01-02', 2, 1, 1.0, '%Y'), (10, 11, '2023-01-01', 0, 2, 1.0, 'default2'), (11, 8, '1997-10-27', 0, 2, 0.0, 'POPLATEK TYDNE'), (12, 3, '2023-01-02', 0, 2, 1.0, 'POPLATEK TYDNE'), (13, 8, '1997-10-27', 1, 2, 0.0, '%Y'), (14, 1, '2023-01-02', 2, 1, 2.0, '1997'), (15, 12, '2023-01-02', 0, 0, 1.0, '1997%'), (16, 7, '1997-10-27', 2, 0, 0.0, 'POPLATEK TYDNE'), (17, 11, '2023-01-01', 0, 2, 1.0, '1997%'), (18, 10, '2023-01-01', 1, 0, 1.0, '1997'), (19, 6, '2023-01-02', 2, 0, 2.0, '1997%'), (20, 8, '2023-01-02', 2, 1, 2.0, '1997'), (21, 9, '2023-01-02', 2, 2, 0.0, '%Y'), (22, 6, '2023-01-01', 1, 2, 0.0, 'default1'), (23, 13, '2023-01-02', 1, 1, 1.0, 'POPLATEK TYDNE'), (24, 13, '2023-01-01', 2, 2, 1.0, '%Y'), (25, 7, '2023-01-01', 2, 2, 2.0, '1997%'), (26, 7, '2023-01-02', 1, 2, 0.0, '%Y'), (27, 10, '2023-01-02', 0, 2, 0.0, 'POPLATEK TYDNE'), (28, 4, '2023-01-02', 1, 0, 1.0, 'POPLATEK TYDNE'), (29, 7, '2023-01-01', 0, 2, 1.0, 'default1'), (30, 2, '2023-01-02', 0, 0, 2.0, '1997'), (31, 12, '1997-10-27', 1, 1, 0.0, '1997%'), (32, 8, '2023-01-01', 1, 1, 1.0, 'default2'), (33, 6, '2023-01-01', 2, 1, 2.0, '1997%'), (34, 11, '1997-10-27', 1, 0, 2.0, '1997%'), (35, 7, '1997-10-27', 2, 2, 0.0, 'default2'), (36, 2, '2023-01-02', 1, 0, 2.0, '%Y'), (37, 6, '2023-01-02', 0, 2, 2.0, '1997'), (38, 8, '1997-10-27', 0, 1, 1.0, 'POPLATEK TYDNE'), (39, 5, '1997-10-27', 0, 2, 0.0, 'default1'), (40, 7, '2023-01-02', 2, 0, 2.0, '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a JOIN loan AS l ON a.account_id = l.account_id WHERE l.date LIKE '1997%' AND a.frequency = 'POPLATEK TYDNE' ORDER BY l.amount ASC, a.account_id NULLS LAST, l.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5,)
*/