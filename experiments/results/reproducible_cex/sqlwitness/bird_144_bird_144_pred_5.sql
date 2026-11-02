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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'default1', 'default1', 'VYBER KARTOU', '%Y', 'VYBER KARTOU', 0, 0, 0.0, 0, NULL, 1.0, 0, 0, 0), (0, '1998', '%m', 'default1', '%m', '1998', 'VYBER KARTOU', 0, 0, 0.0, 0, 0.0, 1.0, 1, NULL, 0), (2, '%Y', '%m', '1998', '1998', '1998', 'default1', 1, 1, 1.0, 1, 0.0, 0.0, 1, 1, 1), (3, '%Y', '%Y', '%Y', '%m', '2021', 'default2', 1, 1, 0.0, 1, NULL, 1.0, 1, 1, 1), (4, 'default2', '%Y', 'VYBER KARTOU', '%m', 'default1', 'default1', 1, 0, 0.0, 0, NULL, 0.0, 0, 1, 0), (5, '2021', '1998', '2021', '%Y', '1998', 'default1', 1, 1, 0.0, 1, NULL, 0.0, 1, NULL, 1), (6, 'default1', 'default2', '1998', '%m', '2021', 'default1', 0, 1, 0.0, 1, 0.0, 1.0, 1, 1, 0), (7, '%Y', '%Y', 'VYBER KARTOU', '%m', '%Y', '%m', 1, 1, 0.0, 0, 1.0, 0.0, 0, 0, 0), (8, 'default1', '%m', 'default2', 'default1', 'default1', 'default1', 0, 1, 1.0, 0, NULL, 1.0, 0, NULL, 1), (9, '%Y', 'default1', '2021', 'default1', '1998', '1998', 0, 0, 0.0, 1, 0.0, 0.0, 0, 0, 1), (10, 'default1', '1998', 'default1', '%m', '1998', '1998', 1, 1, 0.0, 0, 1.0, 1.0, 0, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 10, 'default2', '2023-01-02'), (1, 8, '2021', '2023-01-02'), (2, 5, '%Y', '2021-10-27'), (3, 4, '%m', '2023-01-01'), (4, 6, '1998', '2023-01-02'), (5, 8, '1998', '2021-10-27'), (6, 3, '2021', '2023-01-02'), (7, 1, 'default1', '2023-01-01'), (8, 4, 'default2', '2023-01-01'), (9, 7, '%Y', '2023-01-02'), (10, 5, 'default1', '2021-10-27'), (11, 3, '2021', '1998-10-27'), (12, 1, 'VYBER KARTOU', '2023-01-02'), (13, 10, '%m', '2021-10-27'), (14, 9, '2021', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 7, '1998', '2023-01-02'), (1, 10, '%Y', '1998-10-27'), (2, 10, 'default2', '2021-10-27'), (3, 10, 'default2', '2023-01-02'), (4, 1, 'VYBER KARTOU', '1998-10-27'), (5, 1, 'VYBER KARTOU', '2023-01-01'), (6, 10, 'default1', '2023-01-02'), (7, 1, 'default1', '2023-01-02'), (8, 10, '2021', '2023-01-02'), (9, 1, 'default1', '1998-10-27'), (10, 3, '2021', '1998-10-27'), (11, 0, '%Y', '2021-10-27'), (12, 1, '%Y', '1998-10-27'), (13, 10, 'VYBER KARTOU', '1998-10-27'), (14, 7, 'VYBER KARTOU', '2021-10-27'), (15, 8, '%m', '1998-10-27'), (16, 10, '2021', '2023-01-01'), (17, 9, '1998', '1998-10-27');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 0, '2023-01-01', 'default1', '%Y', 1, 0, '%m', 'default1', NULL), (0, 11, '1998-10-27', '%Y', 'default2', 1, 1, 'VYBER KARTOU', '2021', NULL), (2, 17, '2021-10-27', '%Y', 'VYBER KARTOU', 0, 1, NULL, 'default2', 0), (3, 8, '2023-01-01', 'default1', '1998', 0, 0, '%m', '2021', 0), (4, 16, '2021-10-27', '%m', NULL, 1, 0, '%m', '%m', 0), (5, 7, '2023-01-02', '1998', '%m', 1, 1, '2021', '%m', NULL), (6, 5, '2023-01-02', '1998', 'default1', 0, 0, '2021', '%Y', 1);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 0, 3, 'default2'), (1, 0, 12, '%m'), (2, 17, 6, '%Y'), (3, 2, 2, 'VYBER KARTOU'), (4, 17, 2, 'default1'), (5, 16, 0, '2021'), (6, 9, 7, '%m'), (7, 10, 10, 'default1');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 1, 'default2', '2023-01-01'), (0, 5, 'default2', '1998-10-27'), (2, 1, '%Y', '2021-10-27'), (3, 3, 'default1', '2023-01-02'), (4, 1, 'VYBER KARTOU', '2021-10-27'), (5, 0, '1998', '2023-01-02'), (6, 0, '%m', '2023-01-02'), (7, 6, '2021', '2021-10-27'), (8, 1, '2021', '2023-01-02'), (9, 6, '1998', '2021-10-27'), (10, 2, 'default1', '2023-01-02'), (11, 2, 'default2', '2023-01-02'), (12, 4, '1998', '2021-10-27'), (13, 5, '%m', '2023-01-01'), (14, 2, '%m', '2023-01-02'), (15, 2, '%Y', '2023-01-01'), (16, 0, '2021', '2023-01-01'), (17, 3, '1998', '2021-10-27'), (18, 7, 'VYBER KARTOU', '2021-10-27'), (19, 4, '%Y', '2023-01-01'), (20, 3, '2021', '2021-10-27'), (21, 7, 'VYBER KARTOU', '1998-10-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '2021' AND T3.operation = 'VYBER KARTOU';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT AVG(monthly_avg_amount) FROM (SELECT AVG(amount) AS monthly_avg_amount FROM trans WHERE operation = 'VYBER KARTOU' AND STRFTIME('%Y', date) = '1998' GROUP BY STRFTIME('%m', date));

/*
Prediction Result:
(None,)
*/