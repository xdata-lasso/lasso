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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'M', '1996', 'default2', 'default2', 'default1', 'M', -1, 1, 0.0, 101, 100.0, 0.0, -1, 0, 101), (100, 'default2', '1997', 'M', '1996', 'OWNER', 'OWNER', -1, 101, -1.0, 0, 101.0, 101.0, 0, 99, 100), (101, '1997', '1997', 'M', 'OWNER', '1997', '1997', 0, 100, 0.0, -1, 1.0, 99.0, 1, 100, 100), (-1, 'default1', '1996', '%Y', '%Y', '1997', 'default1', 101, -1, 101.0, 1, 99.0, 100.0, 99, 101, 101), (1, 'default2', 'default1', 'M', '1997', 'M', 'default2', 101, -1, 99.0, 100, NULL, -1.0, 99, -1, 99), (99, '1997', 'M', 'default1', 'default2', 'default1', 'default2', 100, -1, 0.0, 1, -1.0, -1.0, 0, NULL, 100);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (-1, 1, 'default2', '1997-10-27'), (1, 101, '1997', '1997-10-27'), (100, 101, 'default2', '2023-01-02'), (99, -1, 'M', '1996-10-27'), (0, 100, 'default1', '1996-10-27'), (101, 0, '1996', '2023-01-01'), (2, 99, '1996', '2023-01-01'), (3, 99, 'default2', '2023-01-02'), (4, 100, 'OWNER', '2023-01-01'), (5, 101, 'default2', '2023-01-02'), (6, 1, 'default2', '1997-10-27'), (7, 99, '1996', '1997-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (99, 0, 'default2', '1996-10-27'), (-1, 99, '1996', '1997-10-27'), (0, 100, '1997', '1996-10-27');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (100, 0, '2023-01-01', 100, 100, 101.0, '%Y'), (1, -1, '1996-10-27', 99, 100, 101.0, 'default2'), (-1, 0, '2023-01-02', -1, -1, 99.0, 'M'), (0, -1, '1996-10-27', 101, 101, -1.0, 'OWNER');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (101, 99, 7, '1997'), (99, -1, 99, 'default1'), (-1, -1, 101, 'default2'), (1, 99, 4, 'default1'), (0, -1, 99, '1997'), (100, 0, 1, '1996'), (2, 99, -1, '1997'), (3, 0, 99, '1997'), (4, 0, -1, '%Y'), (5, 99, 6, '1997');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1997' THEN T3.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1996' THEN T3.amount ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1996' THEN T3.amount ELSE 0 END) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'M';

/*
Prediction Result:
(-100.0,)
*/