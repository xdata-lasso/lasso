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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'M', '%Y', '%Y', 'M', 'OWNER', 1, 99, 100.0, 1, NULL, 99.0, 100, NULL, 101), (99, '1996', 'default2', '1996', '%Y', '1997', '1996', 101, -1, 0.0, -1, 101.0, 99.0, 99, 101, 101), (0, '1996', 'default1', 'default2', '1997', '1996', '%Y', 0, 101, 0.0, 1, 1.0, -1.0, 99, -1, 0), (-1, 'default1', 'M', 'M', 'M', 'default1', 'default2', 100, 0, 101.0, 1, NULL, -1.0, 1, NULL, 99), (100, '1996', 'M', '1996', 'M', 'M', 'default2', 1, 101, 99.0, 101, 0.0, 99.0, 1, 101, 1), (101, 'default2', 'M', 'OWNER', 'OWNER', '1997', 'OWNER', 99, 100, 101.0, 0, 100.0, 99.0, 100, 1, -1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 1, 'default1', '1996-10-27'), (0, 101, 'M', '1997-10-27'), (101, -1, 'default1', '2023-01-01'), (-1, 101, 'default2', '2023-01-02'), (100, 101, 'M', '2023-01-01'), (99, 100, 'OWNER', '1996-10-27'), (2, 101, '1997', '1996-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, 'default2', '2023-01-01'), (101, 1, '%Y', '1997-10-27'), (100, 101, 'default2', '2023-01-02'), (-1, 1, 'default2', '1996-10-27'), (0, 101, '%Y', '1997-10-27');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (99, 1, '1997-10-27', 101, 0, 0.0, '%Y'), (0, 100, '1996-10-27', 1, -1, 100.0, 'OWNER'), (-1, 1, '2023-01-01', 0, 0, 101.0, '1997'), (101, 101, '1996-10-27', 99, -1, 99.0, 'OWNER'), (1, 0, '1996-10-27', 99, 99, 101.0, '%Y'), (100, 0, '2023-01-02', 101, 99, 101.0, '1997'), (2, -1, '1997-10-27', 100, 1, 99.0, 'M');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (-1, -1, 2, 'OWNER'), (0, 100, 100, 'default2'), (100, 1, 100, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN STRFTIME('%Y', loan."date") = '1997' THEN loan."amount" ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', loan."date") = '1996' THEN loan."amount" ELSE 0 END)) * 100.0 / SUM(CASE WHEN STRFTIME('%Y', loan."date") = '1996' THEN loan."amount" ELSE 0 END) AS growth_rate FROM loan INNER JOIN disp ON loan."account_id" = disp."account_id" INNER JOIN client ON disp."client_id" = client."client_id" WHERE client."gender" = 'M';

/*
Prediction Result:
(10000.0,)
*/