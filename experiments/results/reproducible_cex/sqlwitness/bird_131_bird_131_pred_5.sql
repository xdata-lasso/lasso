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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'D', 'default1', 'default1', 'default1', 'default2', 'default1', 0, 0, 0.0, 0, 1.0, 0.0, 1, NULL, 1), (2, 'default1', 'C', 'default2', 'D', 'default2', 'default1', 0, 2, 2.0, 2, 0.0, 1.0, 1, 1, 2), (1, 'default2', 'C', 'D', 'default2', 'default2', 'D', 2, 1, 1.0, 2, 1.0, 1.0, 1, NULL, 1), (3, 'default1', 'default1', 'default2', 'D', 'C', 'D', 1, 1, 1.0, 0, 1.0, 1.0, 0, NULL, 2), (4, 'D', 'default2', 'D', 'default2', 'C', 'default1', 2, 0, 2.0, 2, 2.0, 1.0, 2, 2, 1), (5, 'C', 'D', 'default1', 'D', 'C', 'C', 0, 1, 1.0, 1, 1.0, 1.0, 0, 2, 0), (6, 'default2', 'D', 'D', 'C', 'C', 'default2', 1, 1, 2.0, 0, 2.0, 2.0, 0, 1, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 5, 'D', '2023-01-02'), (0, 5, 'C', '2023-01-02'), (1, 3, 'D', '2023-01-02'), (3, 3, 'default2', '2023-01-02'), (4, 3, 'C', '2023-01-02'), (5, 5, 'C', '2023-01-01'), (6, 1, 'C', '2023-01-02'), (7, 5, 'default2', '2023-01-02'), (8, 6, 'D', '2023-01-01'), (9, 5, 'default1', '2023-01-02'), (10, 2, 'C', '2023-01-02'), (11, 4, 'default2', '2023-01-02'), (12, 0, 'D', '2023-01-01'), (13, 4, 'default1', '2023-01-01'), (14, 4, 'C', '2023-01-02'), (15, 5, 'default2', '2023-01-02'), (16, 0, 'D', '2023-01-01'), (17, 4, 'D', '2023-01-01'), (18, 4, 'C', '2023-01-02'), (19, 4, 'D', '2023-01-01'), (20, 0, 'C', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 19, 'default2', 1, 0.0, 'default2'), (1, 0, 'default2', 1, 0.0, 'default1'), (2, 12, 'D', 0, 1.0, 'D'), (3, 6, 'D', 1, 0.0, 'D'), (4, 3, 'D', 2, 1.0, 'D'), (5, 11, 'C', 0, 1.0, 'D'), (6, 14, 'D', 0, 0.0, 'D'), (7, 2, 'C', 1, 0.0, 'D'), (8, 0, 'D', 0, 1.0, 'D'), (9, 15, 'default1', 0, 1.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 7, '2023-01-02', 0, 2, 2.0, 'C'), (1, 13, '2023-01-02', 0, 0, 1.0, 'default2'), (2, 4, '2023-01-01', 0, 2, 1.0, 'D'), (3, 20, '2023-01-01', 1, 2, 2.0, 'D'), (4, 5, '2023-01-01', 0, 2, 0.0, 'C'), (5, 12, '2023-01-01', 1, 1, 0.0, 'default2'), (6, 14, '2023-01-01', 1, 0, 1.0, 'D'), (7, 1, '2023-01-01', 2, 1, 0.0, 'D'), (8, 9, '2023-01-02', 0, 0, 2.0, 'default2'), (9, 12, '2023-01-01', 1, 2, 0.0, 'default1'), (10, 16, '2023-01-01', 2, 1, 0.0, 'default1'), (11, 10, '2023-01-02', 0, 2, 0.0, 'D'), (12, 7, '2023-01-02', 1, 0, 2.0, 'default2'), (13, 4, '2023-01-01', 1, 2, 0.0, 'D'), (14, 20, '2023-01-01', 0, 0, 0.0, 'C'), (15, 19, '2023-01-01', 0, 1, 1.0, 'default1'), (16, 17, '2023-01-01', 0, 2, 1.0, 'D'), (17, 8, '2023-01-01', 1, 0, 0.0, 'C'), (18, 10, '2023-01-02', 2, 2, 1.0, 'C'), (19, 18, '2023-01-02', 1, 1, 1.0, 'default2'), (20, 17, '2023-01-02', 0, 1, 1.0, 'default2'), (21, 14, '2023-01-02', 2, 1, 0.0, 'default1'), (22, 6, '2023-01-02', 0, 2, 2.0, 'D'), (23, 6, '2023-01-01', 2, 2, 2.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('C',)
*/

-- Prediction Query
SELECT d.A3 AS district_name FROM loan AS l INNER JOIN account AS a ON l.account_id = a.account_id INNER JOIN district AS d ON a.district_id = d.district_id WHERE l.status IN ('C', 'D') GROUP BY d.A3 ORDER BY COUNT(l.loan_id) DESC, district_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/