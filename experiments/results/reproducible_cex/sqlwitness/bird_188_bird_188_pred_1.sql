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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (23, 'A', 'default2', 'default2', 'A', 'default1', '1997-01-01', 1, 23, 2.0, 0, 23.0, 2.0, 24, 23, 24), (25, 'default2', 'default2', 'default1', 'default2', '1997-01-01', 'default2', 2, 24, 1.0, 0, 2.0, 0.0, 0, 25, 25), (2, 'default2', '1997', '1997-01-01', 'A', 'A', 'default1', 24, 24, 0.0, 25, 2.0, 0.0, 23, 2, 24), (0, 'A', 'A', '1997', 'default1', '1997', 'default1', 25, 0, 25.0, 23, NULL, 1.0, 24, 24, 2), (24, 'A', 'default2', '1997-01-01', '1997', '1997', 'default2', 0, 0, 2.0, 2, NULL, 25.0, 0, 2, 24), (1, '1997', 'A', 'default1', '1997', '%Y', 'default2', 2, 0, 1.0, 23, 0.0, 24.0, 23, NULL, 2), (3, 'default2', 'default1', '1997', '1997', 'default2', 'default2', 25, 0, 2.0, 1, 0.0, 25.0, 0, 25, 1), (4, '1997', '1997', '%Y', 'A', '1997', '1997', 23, 25, 25.0, 23, 23.0, 0.0, 23, 23, 0), (5, '1997-01-01', 'A', '1997', '1997-01-01', 'default1', 'default1', 24, 24, 1.0, 0, 24.0, 25.0, 23, 2, 24), (6, 'default1', 'default1', 'default2', 'default1', '1997', 'default1', 25, 23, 25.0, 25, 25.0, 25.0, 0, 0, 25), (7, '%Y', '1997', 'default1', '1997-01-01', 'default1', 'default2', 25, 25, 0.0, 24, 23.0, 2.0, 2, 2, 1), (8, '1997', '1997-01-01', 'default2', '1997-01-01', 'default1', 'A', 0, 2, 2.0, 24, 0.0, 2.0, 0, 25, 1), (9, 'default2', '1997-01-01', 'default2', 'default2', '1997', 'default2', 0, 25, 25.0, 23, 25.0, 25.0, 2, 2, 0), (10, '%Y', 'default2', '%Y', '%Y', '1997-01-01', '1997', 0, 23, 25.0, 2, 0.0, 2.0, 25, 2, 0), (11, '%Y', 'default2', '1997-01-01', '%Y', 'default1', 'A', 23, 23, 23.0, 25, 1.0, 24.0, 25, 2, 25), (12, '%Y', 'default1', '1997', 'default1', 'default2', 'default2', 24, 24, 24.0, 24, 2.0, 2.0, 25, 25, 23), (13, '1997', '%Y', 'default1', 'default1', 'default1', '1997', 0, 2, 25.0, 23, 23.0, 2.0, 0, 2, 23), (14, '1997', '1997', '%Y', '%Y', 'default2', '%Y', 1, 2, 23.0, 25, 2.0, 1.0, 2, 24, 1), (15, 'default2', 'default1', 'default1', '%Y', '1997', 'default1', 25, 25, 25.0, 24, 24.0, 1.0, 24, 1, 0), (16, 'default1', '1997', 'default2', 'default1', '1997-01-01', '1997-01-01', 1, 24, 2.0, 1, 0.0, 0.0, 23, 1, 2), (17, '%Y', 'default2', 'default2', '1997-01-01', 'default2', 'default1', 0, 1, 2.0, 2, 25.0, 23.0, 23, 2, 25), (18, '%Y', '%Y', 'A', 'A', 'default1', '1997', 2, 25, 24.0, 0, 23.0, 1.0, 1, 2, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 6, '1997-01-01', '1997-10-27'), (25, 25, '1997-01-01', '2023-01-02'), (23, 13, 'A', '1997-01-01'), (2, 17, '%Y', '2023-01-02'), (0, 16, 'A', '1997-10-27'), (24, 8, 'default1', '1997-01-02'), (3, 7, '%Y', '1997-10-27'), (4, 10, 'default1', '1997-01-02'), (5, 7, 'default2', '2023-01-01'), (6, 9, 'default1', '1997-10-27'), (7, 3, 'A', '1996-12-31'), (8, 3, '1997-01-01', '1997-10-27'), (9, 15, 'default1', '2023-01-01'), (10, 17, 'A', '2023-01-02'), (11, 5, '1997', '2023-01-02'), (12, 10, 'default2', '1997-01-01'), (13, 6, '1997-01-01', '2023-01-01'), (14, 5, '1997', '1997-01-01'), (15, 5, 'default1', '1996-12-31'), (16, 7, '1997-01-01', '2023-01-01'), (17, 6, '1997', '1997-10-27'), (18, 15, 'default2', '2023-01-01'), (19, 18, 'default1', '1997-01-02'), (20, 1, '1997', '2023-01-02'), (21, 3, '%Y', '1997-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 16, '1997', 0, 23.0, '1997-01-01'), (1, 0, '%Y', 2, 23.0, 'default1'), (23, 11, '1997-01-01', 1, 0.0, '%Y'), (24, 15, 'default2', 23, 24.0, '1997');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (25, 1, '2023-01-02', 24, 25, 24.0, '1997-01-01'), (1, 25, '1997-01-02', 23, 24, 0.0, 'A'), (24, 0, '2023-01-01', 25, 23, 2.0, '%Y'), (23, 6, '1997-01-01', 23, 25, 1.0, '1997-01-01'), (0, 19, '1997-01-02', 1, 23, 25.0, 'A'), (2, 20, '1997-01-01', 0, 1, 1.0, 'default2'), (3, 2, '1996-12-31', 23, 24, 25.0, 'A'), (4, 7, '2023-01-02', 24, 1, 23.0, 'default2'), (5, 21, '2023-01-01', 23, 2, 2.0, 'default1'), (6, 23, '1997-01-02', 23, 0, 25.0, '1997'), (7, 4, '1997-10-27', 0, 23, 25.0, '1997'), (8, 13, '1997-01-02', 2, 25, 23.0, 'default2'), (9, 9, '1997-01-02', 24, 24, 24.0, 'default2'), (10, 8, '1997-01-02', 24, 24, 23.0, '1997-01-01'), (11, 10, '2023-01-02', 24, 0, 2.0, '1997'), (12, 24, '2023-01-02', 1, 25, 23.0, 'A'), (13, 7, '2023-01-02', 0, 25, 1.0, '1997'), (14, 23, '1997-01-01', 25, 1, 0.0, '1997'), (15, 3, '1997-10-27', 2, 0, 2.0, '1997-01-01'), (16, 17, '2023-01-02', 2, 0, 0.0, '%Y'), (17, 0, '1996-12-31', 25, 23, 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 24 AND STRFTIME('%Y', T2.date) < '1997' ORDER BY T1.amount ASC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT a.account_id FROM loan AS l INNER JOIN account AS a ON l.account_id = a.account_id WHERE l.duration > 24 AND l.status = 'A' AND a.date < '1997-01-01' AND l.amount = (SELECT MIN(amount) FROM loan WHERE duration > 24 AND status = 'A');

/*
Prediction Result:
*/