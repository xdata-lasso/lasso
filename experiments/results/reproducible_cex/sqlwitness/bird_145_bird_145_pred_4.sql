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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'VYBER KARTOU', 'default1', '%Y', '1998', 'default1', '%Y', 0, 1, 0.0, 1, 0.0, 1.0, 0, 0, 0), (0, 'VYBER KARTOU', '%Y', 'default1', '%Y', 'default2', '1998', 1, 0, 0.0, 0, NULL, 0.0, 0, NULL, 1), (2, '%Y', 'VYBER KARTOU', 'default1', '%Y', '1998', '%Y', 0, 1, 0.0, 1, 0.0, 0.0, 1, NULL, 1), (3, 'VYBER KARTOU', 'default1', 'default2', 'VYBER KARTOU', 'VYBER KARTOU', 'default1', 1, 1, 0.0, 0, NULL, 0.0, 1, 0, 0), (4, 'default1', '%Y', '%Y', 'default1', 'default2', '%Y', 1, 1, 0.0, 1, 0.0, 1.0, 1, 0, 1), (5, '%Y', '%Y', 'default1', '%Y', '1998', '1998', 0, 1, 1.0, 1, 1.0, 1.0, 0, 1, 1), (6, '%Y', '%Y', '1998', '1998', 'default2', 'default1', 1, 0, 0.0, 1, 0.0, 1.0, 1, 1, 0), (7, 'default1', 'default1', 'default1', 'VYBER KARTOU', '%Y', 'default1', 1, 0, 1.0, 1, NULL, 0.0, 0, 1, 1), (8, 'VYBER KARTOU', '1998', 'default1', 'default2', 'default1', '1998', 1, 1, 0.0, 1, NULL, 1.0, 0, NULL, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 5, 'default2', '1998-10-27'), (0, 5, 'default2', '2023-01-02'), (2, 7, '1998', '2023-01-01'), (3, 1, 'default1', '2023-01-01'), (4, 0, '%Y', '2023-01-02'), (5, 1, 'default1', '1998-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 4, 'VYBER KARTOU', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 1, '2023-01-01', 'default1', '1998', 0, 0, '%Y', 'VYBER KARTOU', NULL), (0, 1, '1998-10-27', 'VYBER KARTOU', 'default2', 0, 1, '%Y', NULL, 1), (2, 1, '1998-10-27', 'VYBER KARTOU', NULL, 0, 0, 'VYBER KARTOU', '%Y', 1), (3, 1, '2023-01-02', 'default1', 'default2', 1, 0, '1998', 'VYBER KARTOU', 0), (4, 1, '1998-10-27', 'VYBER KARTOU', 'default1', 1, 1, 'VYBER KARTOU', 'default1', NULL), (5, 1, '2023-01-01', '%Y', 'default1', 0, 0, NULL, 'default1', NULL), (6, 1, '1998-10-27', '1998', 'default1', 0, 0, '%Y', 'default2', 0), (7, 1, '2023-01-01', '%Y', NULL, 0, 1, NULL, '%Y', 1), (8, 1, '1998-10-27', '1998', 'VYBER KARTOU', 0, 1, 'default2', 'VYBER KARTOU', 0), (9, 1, '2023-01-01', 'default1', 'VYBER KARTOU', 1, 0, 'default2', '1998', 0), (10, 1, '2023-01-01', '1998', '1998', 1, 0, 'default2', 'VYBER KARTOU', 0), (11, 1, '2023-01-02', '1998', 'default1', 1, 0, 'VYBER KARTOU', 'default1', 1), (12, 1, '2023-01-02', '1998', NULL, 0, 0, 'VYBER KARTOU', 'default1', NULL), (13, 1, '1998-10-27', '%Y', 'default2', 1, 0, NULL, 'default2', NULL), (14, 1, '2023-01-02', '%Y', 'default1', 1, 1, 'default1', '%Y', 0), (15, 1, '2023-01-01', 'default1', 'default1', 0, 1, '%Y', 'default1', 0), (16, 1, '1998-10-27', 'VYBER KARTOU', 'default1', 1, 1, 'default2', '1998', NULL), (17, 1, '2023-01-01', '1998', 'default2', 1, 0, 'VYBER KARTOU', '%Y', NULL), (18, 1, '1998-10-27', 'default2', 'VYBER KARTOU', 0, 1, '%Y', 'default2', 1);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 1, 3, '1998'), (0, 1, 0, 'default1'), (2, 1, 3, 'VYBER KARTOU'), (3, 1, 0, '1998'), (4, 1, 2, '%Y'), (5, 1, 1, '%Y'), (6, 1, 4, 'VYBER KARTOU'), (7, 1, 2, 'default1'), (8, 1, 2, 'default1'), (9, 1, 4, 'VYBER KARTOU'), (10, 1, 3, '1998'), (11, 1, 2, 'VYBER KARTOU');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 7, '%Y', '2023-01-02'), (0, 9, 'default2', '2023-01-01'), (2, 7, 'default2', '2023-01-01'), (3, 0, 'default1', '1998-10-27'), (4, 3, 'VYBER KARTOU', '2023-01-02'), (5, 10, 'default2', '2023-01-02'), (6, 3, 'default1', '2023-01-02'), (7, 4, 'default2', '2023-01-01'), (8, 8, '%Y', '2023-01-01'), (9, 6, '%Y', '2023-01-02'), (10, 7, 'default1', '2023-01-01'), (11, 5, 'VYBER KARTOU', '2023-01-02'), (12, 6, 'default2', '2023-01-01'), (13, 7, 'default2', '2023-01-01'), (14, 4, '%Y', '2023-01-01'), (15, 0, 'VYBER KARTOU', '1998-10-27'), (16, 0, '%Y', '2023-01-01'), (17, 11, 'default1', '1998-10-27'), (18, 7, 'default2', '1998-10-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT d.client_id FROM trans AS t JOIN disp AS d ON t.account_id = d.account_id JOIN card AS c ON d.disp_id = c.disp_id WHERE t.operation = 'VYBER KARTOU' AND t.amount < CAST((SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998') AS REAL) AND STRFTIME('%Y', t.date) = '1998';

/*
Prediction Result:
(4,)
(2,)
(0,)
(3,)
(1,)
*/