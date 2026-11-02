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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (101, 'OWNER', '1997', 'default1', '1997', 'default2', 'default1', 99, -1, 1.0, 0, -1.0, 100.0, 0, 100, 1), (99, 'M', 'default2', 'default2', '1997', 'default1', '1997', 0, -1, 99.0, 99, 0.0, -1.0, -1, 100, 1), (-1, 'OWNER', 'OWNER', '1996', 'OWNER', '1997', '%Y', 100, 0, -1.0, 0, 1.0, -1.0, 0, 0, 99), (1, '1996', 'M', 'OWNER', '%Y', '1996', '%Y', -1, 101, 101.0, 0, 99.0, 99.0, 99, 101, 99), (100, '1997', '%Y', '1996', '1996', '1996', 'OWNER', 1, 1, -1.0, 101, 100.0, 100.0, -1, 100, -1), (0, '%Y', 'default2', '%Y', 'OWNER', 'default2', 'default2', -1, 101, -1.0, 1, -1.0, 101.0, 99, 0, 0), (2, '1997', 'default2', 'default1', '%Y', '%Y', '1997', 100, 100, -1.0, 1, 1.0, 0.0, 0, NULL, 99), (3, 'default1', 'default1', 'default1', '%Y', '1996', '1997', 1, 101, 101.0, 99, 101.0, 100.0, -1, 100, 1), (4, 'default1', 'OWNER', 'default2', '1997', 'default2', 'M', 1, 100, 0.0, 1, 99.0, 0.0, 0, 1, 100), (5, 'M', 'default2', '1996', 'default1', '%Y', '1996', 0, 100, 0.0, 1, -1.0, 100.0, 1, -1, 100), (6, 'default1', 'M', 'default1', '1997', 'default1', '1997', 101, 1, -1.0, 1, 99.0, 0.0, 1, 100, 99), (7, 'default2', 'default2', '1997', 'OWNER', 'default2', '1996', 101, 101, 99.0, 101, 99.0, 0.0, -1, 100, 0), (8, 'default1', '1996', 'default2', 'default2', 'OWNER', '1997', -1, -1, 1.0, 101, 0.0, -1.0, 0, NULL, 99), (9, 'OWNER', 'OWNER', '1996', '1996', '1997', 'OWNER', -1, 101, 0.0, 1, 0.0, 1.0, 100, -1, 101), (10, '%Y', 'M', 'OWNER', '1997', '1997', 'M', 99, 0, 101.0, 0, NULL, 0.0, 99, NULL, 0), (11, 'default2', 'default1', 'M', 'default1', 'OWNER', '%Y', -1, -1, 101.0, 101, 0.0, -1.0, 101, 100, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (101, 0, 'M', '2023-01-02'), (100, 9, 'M', '2023-01-02'), (1, 1, 'OWNER', '2023-01-01'), (-1, 9, 'default2', '1996-10-27'), (0, 0, '%Y', '1997-10-27'), (99, 2, 'M', '2023-01-02'), (2, 8, 'M', '1997-10-27'), (3, 11, '%Y', '2023-01-01'), (4, 101, 'default1', '1996-10-27'), (5, 3, 'default2', '2023-01-01'), (6, 3, 'OWNER', '2023-01-01'), (7, 11, '1996', '1997-10-27'), (8, -1, '%Y', '1996-10-27'), (9, 9, 'default2', '2023-01-01'), (10, 9, '1996', '1997-10-27'), (11, 7, '1996', '2023-01-02'), (12, 9, 'default1', '2023-01-01'), (13, 99, '1997', '1997-10-27'), (14, 100, 'M', '1997-10-27'), (15, 10, 'M', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (-1, 0, 'M', '1996-10-27'), (0, 6, 'OWNER', '2023-01-02'), (101, 101, '%Y', '1996-10-27'), (1, 11, 'default1', '1996-10-27');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (100, 0, '1997-10-27', -1, 99, -1.0, '1997'), (101, 1, '1997-10-27', 99, 100, 101.0, 'default1'), (99, 0, '1997-10-27', 100, -1, 1.0, '1997'), (0, 101, '1997-10-27', 99, 101, 100.0, 'OWNER'), (-1, 0, '1996-10-27', 100, 100, 100.0, '1996'), (1, 1, '1997-10-27', -1, 0, -1.0, '1997'), (2, 101, '2023-01-02', 101, 1, 100.0, 'default1'), (3, 0, '1996-10-27', 100, 101, 101.0, 'M'), (4, 1, '2023-01-01', 0, -1, 99.0, 'default2'), (5, 101, '1996-10-27', -1, -1, 100.0, '1996'), (6, 1, '2023-01-02', 1, 100, 1.0, '1997'), (7, 0, '1997-10-27', -1, 0, 100.0, '1997'), (8, 0, '2023-01-02', 99, -1, 101.0, 'default2'), (9, 101, '1997-10-27', 0, 0, 101.0, '1997'), (10, 1, '2023-01-01', 100, 101, 99.0, 'M'), (11, 0, '2023-01-02', 99, 1, 1.0, '1996'), (12, 101, '2023-01-01', 0, 100, -1.0, 'M');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 1, 3, 'OWNER'), (100, 101, 101, 'default2'), (101, 101, 11, '%Y'), (-1, -1, 11, 'OWNER'), (1, 101, 11, '1997'), (99, -1, 99, 'M'), (2, 1, 14, 'default1'), (3, 0, 15, 'OWNER'), (4, -1, 5, 'default2'), (5, 1, 0, '1997'), (6, 101, 8, '1996'), (7, 0, 12, '%Y'), (8, 0, 6, 'default2'), (9, 101, 11, '%Y'), (10, -1, 7, '1997'), (11, 1, 10, 'OWNER'), (12, -1, 5, 'M'), (13, -1, 4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(-51.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN STRFTIME('%Y', T1."date") = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1."date") = '1996' THEN T1.amount ELSE 0 END) AS REAL) * 100) / SUM(CASE WHEN STRFTIME('%Y', T1."date") = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id WHERE T3.gender = 'M';

/*
Prediction Result:
(48.24120603015076,)
*/