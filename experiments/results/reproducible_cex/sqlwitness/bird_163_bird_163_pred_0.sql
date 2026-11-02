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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default2', 'default2', 'A', 'default2', 'A', 0, 2, 0.0, 1, 2.0, 2.0, 1, 1, 2), (1, 'default2', 'default2', 'A', 'default2', 'A', 'default2', 1, 2, 2.0, 0, 1.0, 0.0, 2, 2, 2), (2, 'A', 'A', 'default1', 'A', 'default2', 'default1', 2, 2, 1.0, 2, 1.0, 1.0, 2, 2, 2), (3, 'A', 'default2', 'default1', 'A', 'default2', 'default2', 1, 0, 0.0, 2, NULL, 1.0, 2, 0, 1), (4, 'default1', 'default1', 'default2', 'default1', 'A', 'default2', 2, 1, 0.0, 1, NULL, 1.0, 1, 2, 1), (5, 'default1', 'A', 'A', 'default2', 'A', 'default1', 1, 1, 2.0, 1, 0.0, 1.0, 1, NULL, 2), (6, 'default1', 'default2', 'A', 'default1', 'default1', 'default2', 0, 2, 0.0, 0, 2.0, 0.0, 0, 2, 1), (7, 'default1', 'default2', 'default1', 'default2', 'default1', 'default1', 1, 1, 0.0, 0, 1.0, 0.0, 0, 2, 0), (8, 'default1', 'default1', 'A', 'default2', 'A', 'default1', 0, 0, 1.0, 1, 2.0, 1.0, 2, 1, 0), (9, 'default2', 'default2', 'default2', 'default2', 'default2', 'A', 0, 0, 2.0, 0, 1.0, 2.0, 1, 2, 1), (10, 'default1', 'default2', 'default1', 'default2', 'default2', 'default2', 0, 1, 2.0, 2, 2.0, 0.0, 2, 0, 1), (11, 'default1', 'default2', 'A', 'default1', 'default1', 'default1', 2, 1, 1.0, 0, NULL, 2.0, 0, 0, 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 1, 'A', '2023-01-01'), (0, 1, 'default2', '2023-01-01'), (1, 7, 'A', '2023-01-01'), (3, 8, 'A', '2023-01-02'), (4, 9, 'default2', '2023-01-02'), (5, 4, 'default2', '2023-01-02'), (6, 8, 'A', '2023-01-01'), (7, 4, 'default1', '2023-01-02'), (8, 10, 'default1', '2023-01-02'), (9, 4, 'A', '2023-01-02'), (10, 9, 'A', '2023-01-02'), (11, 5, 'default1', '2023-01-01'), (12, 5, 'default1', '2023-01-01'), (13, 1, 'default1', '2023-01-02'), (14, 3, 'default1', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (2, 3, 'A', 1, 1.0, 'A'), (0, 13, 'A', 2, 1.0, 'default2'), (1, 4, 'default1', 1, 2.0, 'default2');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 13, '2023-01-01', 1, 0, 2.0, 'A'), (1, 6, '2023-01-01', 0, 2, 1.0, 'A'), (0, 2, '2023-01-02', 2, 2, 0.0, 'default1'), (3, 1, '2023-01-01', 0, 0, 0.0, 'A'), (4, 0, '2023-01-02', 0, 2, 0.0, 'default1'), (5, 12, '2023-01-01', 1, 1, 1.0, 'A'), (6, 12, '2023-01-01', 0, 0, 2.0, 'default1'), (7, 1, '2023-01-01', 2, 0, 1.0, 'A'), (8, 5, '2023-01-01', 0, 1, 0.0, 'default2'), (9, 12, '2023-01-02', 1, 0, 2.0, 'default1'), (10, 7, '2023-01-02', 0, 0, 2.0, 'A'), (11, 13, '2023-01-02', 2, 0, 1.0, 'default2'), (12, 10, '2023-01-02', 2, 2, 0.0, 'default2'), (13, 10, '2023-01-01', 1, 0, 2.0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T3.status = 'A' GROUP BY T1.district_id ORDER BY COUNT(T2.account_id) DESC, T1.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT T.district_id FROM (SELECT T1.district_id, COUNT(DISTINCT T2.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.status = 'A' GROUP BY T1.district_id ORDER BY COUNT(DISTINCT T2.account_id) DESC, T1.district_id NULLS LAST LIMIT 1) AS t;

/*
Prediction Result:
(1,)
*/