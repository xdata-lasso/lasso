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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (25, '%Y', '1997-01-01', 'default1', '1997', '%Y', '%Y', 2, 25, 24.0, 0, 1.0, 1.0, 1, 2, 24), (24, 'default2', '1997-01-01', '%Y', 'default1', 'default1', 'default1', 1, 1, 25.0, 0, 2.0, 1.0, 2, 24, 23), (0, 'default1', '1997-01-01', 'default1', 'default2', '1997', 'default1', 2, 1, 1.0, 23, 1.0, 1.0, 25, 24, 2), (2, '%Y', '1997', '1997', 'default2', '1997-01-01', 'default1', 1, 25, 0.0, 1, 2.0, 0.0, 0, 25, 24), (23, '%Y', 'default1', 'default1', 'default2', '1997-01-01', '%Y', 24, 23, 2.0, 23, 24.0, 23.0, 1, 25, 23), (1, 'default2', '%Y', 'default2', 'default2', '%Y', '%Y', 25, 24, 25.0, 2, 0.0, 23.0, 0, 24, 1), (3, 'default1', '1997-01-01', 'default1', 'default2', 'default1', 'default2', 0, 1, 1.0, 23, 24.0, 25.0, 0, NULL, 0), (4, 'default1', '1997-01-01', 'default1', 'default2', '%Y', '1997-01-01', 24, 2, 2.0, 2, 24.0, 23.0, 23, NULL, 25), (5, '1997', 'default2', '%Y', '1997-01-01', '%Y', '%Y', 23, 23, 25.0, 0, 24.0, 1.0, 0, NULL, 23), (6, '%Y', '1997', 'default2', '1997', 'default1', '1997-01-01', 23, 0, 23.0, 23, 25.0, 25.0, 23, 2, 24), (7, 'default2', 'default2', '1997', 'default2', '1997', 'default2', 2, 0, 2.0, 1, 24.0, 23.0, 23, 1, 23), (8, 'default1', '1997', 'default2', 'default1', '1997', 'default1', 2, 23, 1.0, 0, 23.0, 0.0, 24, 23, 2), (9, '%Y', '%Y', 'default2', '1997', 'default1', '1997', 24, 24, 1.0, 23, 2.0, 25.0, 0, 25, 24);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 8, 'default2', '1997-10-27'), (23, 3, 'default1', '1997-10-27'), (1, 5, 'default1', '1997-10-27'), (25, 6, '1997-01-01', '1997-01-02'), (24, 8, '1997-01-01', '2023-01-02'), (0, 7, '1997-01-01', '1996-12-31'), (3, 6, '1997-01-01', '2023-01-01'), (4, 5, '1997', '2023-01-01'), (5, 23, 'default2', '1997-01-01'), (6, 25, '1997', '1997-01-01'), (7, 7, 'default2', '2023-01-02'), (8, 4, '1997', '2023-01-01'), (9, 0, 'default2', '1997-10-27'), (10, 5, 'default2', '2023-01-02'), (11, 1, '1997-01-01', '1997-01-02'), (12, 6, 'default2', '2023-01-01'), (13, 8, 'default2', '2023-01-01'), (14, 8, 'default1', '2023-01-02'), (15, 1, 'default1', '2023-01-02'), (16, 23, '1997-01-01', '1997-01-02'), (17, 2, 'default2', '2023-01-02'), (18, 5, '1997', '1997-01-01'), (19, 4, '1997-01-01', '2023-01-01'), (20, 1, '1997-01-01', '1997-01-01'), (21, 2, '%Y', '1997-01-01'), (22, 5, 'default2', '1997-01-01'), (26, 0, 'default2', '1997-01-02'), (27, 23, '%Y', '2023-01-01'), (28, 0, '%Y', '1997-10-27'), (29, 2, '1997', '1997-10-27');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (24, 26, '%Y', 0, 23.0, '%Y'), (25, 10, '1997', 0, 2.0, 'default2');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 5, '2023-01-01', 25, 24, 2.0, '1997-01-01'), (23, 21, '1997-10-27', 25, 25, 24.0, '1997-01-01'), (1, 11, '1997-01-02', 0, 0, 24.0, '1997'), (24, 28, '1997-10-27', 24, 23, 25.0, '%Y'), (2, 0, '1997-01-01', 23, 25, 0.0, '1997'), (25, 6, '1997-01-01', 2, 0, 23.0, 'default2'), (3, 0, '1997-10-27', 1, 23, 23.0, 'default1'), (4, 28, '2023-01-01', 24, 24, 25.0, 'default1'), (5, 12, '1997-01-02', 2, 0, 25.0, '%Y'), (6, 13, '1997-01-01', 2, 2, 0.0, 'default2'), (7, 10, '1997-01-01', 24, 24, 0.0, 'default1'), (8, 13, '1997-01-02', 24, 25, 2.0, '1997-01-01'), (9, 23, '2023-01-01', 25, 23, 23.0, '1997-01-01'), (10, 11, '1997-01-02', 2, 25, 2.0, 'default1'), (11, 5, '1997-01-02', 24, 1, 0.0, '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 24 AND STRFTIME('%Y', T2.date) < '1997' ORDER BY T1.amount ASC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a JOIN loan AS l ON a.account_id = l.account_id WHERE a.date < '1997-01-01' AND l.duration > 24 AND l.amount = (SELECT MIN(l.amount) AS min_amount FROM loan AS l JOIN (SELECT a.account_id FROM account AS a JOIN (SELECT account_id FROM loan WHERE duration > 24) AS l ON a.account_id = l.account_id WHERE a.date < '1997-01-01') AS filtered_accounts ON l.account_id = filtered_accounts.account_id);

/*
Prediction Result:
*/