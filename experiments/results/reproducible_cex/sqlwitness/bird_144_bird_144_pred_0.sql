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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, '2021', 'default2', 'default2', 'default1', '01', '%m', 0, 1, 1.0, 1, NULL, 0.0, 0, 1, 0), (1, 'default1', 'default2', 'default2', '%Y', 'default2', '%Y', 0, 1, 1.0, 0, NULL, 0.0, 1, 0, 0), (2, 'default1', 'default2', '2021', '%m', '01', '%Y', 1, 0, 0.0, 1, 0.0, 1.0, 1, NULL, 1), (3, 'default2', 'VYBER KARTOU', 'default2', '2021', '01', '%Y', 1, 1, 0.0, 1, NULL, 0.0, 1, NULL, 0), (4, '%m', 'default1', 'VYBER KARTOU', 'default2', 'default1', '%Y', 0, 1, 0.0, 1, 1.0, 0.0, 1, 0, 1), (5, 'default1', '%Y', '2021', 'VYBER KARTOU', 'default2', 'VYBER KARTOU', 0, 0, 0.0, 1, 1.0, 0.0, 1, 1, 0), (6, 'default2', '%m', '%Y', '01', '%m', 'default2', 1, 1, 0.0, 0, NULL, 0.0, 0, 1, 1), (7, 'VYBER KARTOU', 'default1', '%Y', '%m', '2021', '2021', 1, 1, 1.0, 1, NULL, 0.0, 0, 0, 1), (8, 'default2', '%Y', 'VYBER KARTOU', '2021', '01', 'VYBER KARTOU', 0, 0, 1.0, 0, 0.0, 1.0, 1, NULL, 0), (9, 'VYBER KARTOU', 'default2', '%m', '%Y', '%m', 'default2', 1, 1, 0.0, 0, NULL, 0.0, 1, 1, 0), (10, 'default1', '2021', '01', '2021', '%m', 'default2', 1, 0, 1.0, 1, 1.0, 0.0, 0, NULL, 1), (11, 'VYBER KARTOU', '%Y', 'default1', '%m', 'default1', 'default1', 1, 1, 1.0, 0, NULL, 1.0, 1, NULL, 0), (12, 'default2', 'default2', '%m', '2021', '2021', '2021', 0, 1, 0.0, 0, 1.0, 1.0, 0, 1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 5, 'VYBER KARTOU', '2023-01-02'), (0, 2, '2021', '2023-01-01'), (2, 11, 'default1', '2021-10-27'), (3, 3, 'default2', '2023-01-01'), (4, 11, '%m', '2021-10-27'), (5, 9, '2021', '2021-10-27'), (6, 2, '%m', '2026-10-01'), (7, 5, '%m', '2023-01-02'), (8, 12, '%m', '2021-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 6, '01', '2021-10-27'), (1, 7, 'VYBER KARTOU', '2023-01-02'), (2, 4, 'default1', '2021-10-27'), (3, 10, '%Y', '2023-01-02'), (4, 11, '2021', '2021-10-27');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 3, '2023-01-01', '2021', '%m', 0, 1, '%m', '2021', 0), (1, 2, '2021-10-27', 'default2', 'VYBER KARTOU', 1, 1, NULL, 'default2', 1), (2, 2, '2023-01-01', '%m', '%m', 1, 0, '%Y', NULL, 0), (3, 3, '2023-01-01', 'VYBER KARTOU', 'default2', 1, 1, '2021', '2021', 1), (4, 2, '2023-01-01', 'VYBER KARTOU', 'default2', 0, 0, NULL, 'default2', 0), (5, 1, '2023-01-02', '01', 'default2', 1, 0, '%m', 'default2', 0), (6, 3, '2021-10-27', 'VYBER KARTOU', '%Y', 1, 0, NULL, '%m', NULL), (7, 3, '2026-10-01', '2021', '2021', 0, 1, '%m', '01', 0), (8, 0, '2021-10-27', '%m', NULL, 1, 1, '2021', NULL, NULL), (9, 0, '2026-10-01', '%m', '%Y', 1, 1, NULL, '2021', 0), (10, 3, '2026-10-01', '%Y', '%m', 0, 0, NULL, '%Y', 1), (11, 3, '2021-10-27', '%Y', 'default2', 0, 1, 'VYBER KARTOU', 'default2', 0), (12, 4, '2023-01-02', '%Y', 'default2', 1, 1, '%m', 'VYBER KARTOU', 1), (13, 2, '2023-01-02', '%m', 'default2', 1, 0, '2021', 'default1', 1), (14, 0, '2021-10-27', '01', 'default1', 0, 0, NULL, NULL, NULL), (15, 4, '2021-10-27', '%Y', '%Y', 1, 0, '2021', '01', NULL);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 2, 2, '2021'), (1, 0, 4, 'default2'), (2, 2, 0, 'default2'), (3, 2, 1, '%Y'), (4, 3, 2, '%Y'), (5, 3, 3, 'VYBER KARTOU'), (6, 2, 5, 'VYBER KARTOU'), (7, 2, 2, 'default1'), (8, 3, 0, '01'), (9, 0, 2, 'VYBER KARTOU'), (10, 4, 2, '01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 6, '2021', '2023-01-02'), (0, 3, 'VYBER KARTOU', '2023-01-01'), (2, 8, '%Y', '2026-10-01'), (3, 7, 'default2', '2023-01-02'), (4, 0, '01', '2026-10-01'), (5, 7, 'default2', '2023-01-01'), (6, 1, 'default2', '2026-10-01'), (7, 10, '2021', '2023-01-01'), (8, 4, 'default2', '2023-01-02'), (9, 3, '%m', '2026-10-01'), (10, 5, 'VYBER KARTOU', '2021-10-27'), (11, 1, 'default2', '2026-10-01'), (12, 1, 'VYBER KARTOU', '2023-01-02'), (13, 2, '%Y', '2026-10-01'), (14, 0, 'default1', '2021-10-27'), (15, 0, 'VYBER KARTOU', '2023-01-01'), (16, 8, 'default2', '2026-10-01'), (17, 6, '2021', '2021-10-27'), (18, 9, 'default2', '2021-10-27'), (19, 0, '%m', '2021-10-27'), (20, 1, 'default2', '2023-01-01'), (21, 7, '2021', '2026-10-01'), (22, 10, '2021', '2023-01-01'), (23, 4, 'default2', '2023-01-02'), (24, 8, 'default1', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '2021' AND T3.operation = 'VYBER KARTOU';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(T1.amount) FROM trans AS T1 INNER JOIN card AS T2 ON T1.account_id = T2.disp_id WHERE T1.operation = 'VYBER KARTOU' AND STRFTIME('%Y', T1.date) = '2021' AND STRFTIME('%m', T1.date) = '01';

/*
Prediction Result:
(None,)
*/