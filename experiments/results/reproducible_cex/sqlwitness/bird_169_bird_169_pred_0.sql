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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (99, 'default1', 'OWNER', 'default1', '%Y', 'default1', 'default2', -1, 99, 100.0, 1, 0.0, 101.0, 0, 0, 101), (101, 'OWNER', 'default1', '%Y', 'OWNER', 'default1', '1997', 100, 100, -1.0, 0, 99.0, 99.0, 0, 0, 1), (100, '1997', 'M', 'default1', 'OWNER', 'default1', '%Y', 0, 99, 0.0, 1, 101.0, 99.0, 99, 100, 100), (-1, '1997', '%Y', '1996', '%Y', '1996', 'default2', 101, -1, 100.0, 1, 99.0, 1.0, 1, -1, 99), (0, '1997', '%Y', 'default2', 'OWNER', 'M', 'M', 101, 99, -1.0, 0, 1.0, 1.0, 101, -1, 0), (1, '%Y', '1996', '1996', 'M', 'default1', '%Y', 101, -1, 100.0, 99, 100.0, 99.0, -1, NULL, 1), (2, 'OWNER', 'OWNER', '%Y', 'default2', 'OWNER', 'default1', 100, 0, -1.0, 99, 99.0, 1.0, 1, 100, 100), (3, '%Y', '1997', 'default2', 'M', '1996', 'default1', 1, 1, 0.0, 100, 100.0, 100.0, 1, 0, 101), (4, '1997', 'M', '1996', '%Y', '1997', '1997', 101, -1, 99.0, -1, 1.0, -1.0, 101, 100, 100);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 0, '%Y', '1996-10-27'), (100, 0, 'OWNER', '1996-10-27'), (1, 4, '1997', '1996-10-27'), (101, 0, '1997', '2023-01-02'), (-1, 3, 'default2', '2023-01-01'), (99, 99, '%Y', '2023-01-01'), (2, 1, '1997', '2023-01-02'), (3, 101, 'M', '2023-01-01'), (4, 101, 'default2', '2023-01-02'), (5, 1, 'M', '1996-10-27'), (6, 99, 'default1', '1996-10-27'), (7, 3, '%Y', '2023-01-02'), (8, 101, 'M', '1997-10-27'), (9, 1, '%Y', '1997-10-27'), (10, 4, 'M', '1997-10-27'), (11, 1, 'M', '1997-10-27'), (12, 3, 'M', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 3, 'default2', '1997-10-27'), (0, 100, '%Y', '2023-01-02'), (1, 99, 'M', '2023-01-02'), (-1, 1, 'OWNER', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (-1, 100, '2023-01-02', 1, 1, 1.0, '1997'), (101, 100, '1997-10-27', 1, 99, 1.0, '1996'), (0, 100, '2023-01-01', 0, 101, 0.0, 'default1'), (1, 1, '2023-01-01', 0, -1, 100.0, 'default1'), (100, 0, '2023-01-02', 100, -1, 99.0, 'M'), (99, 100, '1996-10-27', 1, -1, 0.0, 'default2'), (2, -1, '1996-10-27', 0, 0, 0.0, 'M');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (101, 0, 10, 'default2'), (99, 1, 100, '1996'), (1, -1, 8, '%Y'), (0, 100, 9, 'M'), (-1, 100, 12, 'default1'), (100, 100, 5, '1997'), (2, 100, 5, '1997'), (3, 100, 4, 'default1'), (4, -1, 0, 'default1'), (5, -1, 10, 'OWNER'), (6, -1, 99, '1997'), (7, 1, 7, '1997'), (8, 0, 8, 'M'), (9, 0, 10, 'OWNER'), (10, 0, 4, 'OWNER'), (11, 100, 3, 'OWNER'), (12, 0, 3, '1996'), (13, 0, 100, '1996'), (14, -1, 0, 'default2'), (15, 100, 6, '%Y'), (16, -1, 5, 'OWNER'), (17, 1, 3, 'default2'), (18, 100, 1, '1997');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ((SELECT SUM(T2.amount) FROM client AS T1 INNER JOIN loan AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T2.date) = '1997') - (SELECT SUM(T2.amount) FROM client AS T1 INNER JOIN loan AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T2.date) = '1996')) * 100.0 / (SELECT SUM(T2.amount) FROM client AS T1 INNER JOIN loan AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T2.date) = '1996') AS "Growth Rate";

/*
Prediction Result:
(None,)
*/