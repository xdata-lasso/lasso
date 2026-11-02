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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'D', 'default1', 'default1', 'D', 'C', 'C', 0, 2, 1.0, 0, 0.0, 2.0, 0, 0, 2), (1, 'default2', 'default2', 'D', 'D', 'C', 'default1', 0, 1, 1.0, 2, 0.0, 1.0, 2, 1, 0), (2, 'default1', 'default2', 'D', 'D', 'default1', 'C', 1, 0, 1.0, 0, NULL, 2.0, 2, 1, 2), (3, 'C', 'default2', 'default2', 'default2', 'default1', 'default2', 0, 2, 2.0, 2, 2.0, 2.0, 0, 1, 0), (4, 'default1', 'C', 'C', 'C', 'D', 'default2', 0, 1, 2.0, 1, 0.0, 1.0, 2, 0, 0), (5, 'default2', 'default1', 'default1', 'default2', 'default2', 'default2', 1, 1, 2.0, 0, 0.0, 2.0, 0, 0, 0), (6, 'default1', 'C', 'D', 'default1', 'default2', 'D', 2, 0, 2.0, 1, 2.0, 1.0, 2, 0, 2), (7, 'D', 'C', 'D', 'default2', 'D', 'D', 0, 1, 2.0, 0, 1.0, 0.0, 0, 1, 2), (8, 'C', 'default2', 'default2', 'C', 'C', 'default1', 2, 2, 2.0, 2, 2.0, 2.0, 1, 2, 1), (9, 'C', 'default1', 'C', 'default2', 'D', 'D', 1, 0, 2.0, 0, NULL, 1.0, 0, 2, 1), (10, 'default2', 'default1', 'D', 'C', 'default2', 'C', 1, 2, 1.0, 0, NULL, 1.0, 2, 1, 1), (11, 'default1', 'default1', 'default1', 'default2', 'C', 'default2', 1, 1, 1.0, 1, 0.0, 2.0, 2, 0, 2), (12, 'default2', 'C', 'default2', 'default1', 'C', 'default2', 0, 2, 2.0, 0, 0.0, 2.0, 0, 0, 1), (13, 'C', 'default1', 'default2', 'default2', 'default1', 'C', 0, 0, 2.0, 1, 2.0, 2.0, 0, NULL, 0), (14, 'C', 'D', 'default2', 'default1', 'default1', 'D', 2, 1, 1.0, 1, 1.0, 0.0, 1, 0, 0), (15, 'D', 'default1', 'default1', 'default1', 'default1', 'default2', 0, 1, 0.0, 2, 1.0, 1.0, 1, NULL, 0), (16, 'default1', 'default1', 'C', 'C', 'D', 'default2', 1, 2, 0.0, 2, 2.0, 2.0, 0, 1, 0), (17, 'default2', 'default1', 'default2', 'C', 'default2', 'default2', 0, 1, 0.0, 1, 1.0, 0.0, 0, 0, 2), (18, 'D', 'default1', 'D', 'D', 'C', 'C', 2, 1, 2.0, 0, 0.0, 0.0, 1, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 2, 'C', '2023-01-01'), (0, 15, 'default2', '2023-01-02'), (1, 9, 'C', '2023-01-02'), (3, 10, 'D', '2023-01-02'), (4, 8, 'C', '2023-01-02'), (5, 3, 'C', '2023-01-01'), (6, 14, 'D', '2023-01-02'), (7, 6, 'default2', '2023-01-02'), (8, 17, 'default1', '2023-01-02'), (9, 16, 'default1', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 4, 'C', 2, 1.0, 'C'), (2, 3, 'default1', 2, 2.0, 'default2'), (0, 1, 'C', 1, 1.0, 'default1'), (3, 1, 'D', 2, 1.0, 'default2'), (4, 3, 'default1', 0, 0.0, 'default1'), (5, 7, 'default2', 1, 0.0, 'D'), (6, 6, 'C', 2, 1.0, 'D'), (7, 3, 'C', 0, 0.0, 'default1');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 7, '2023-01-02', 2, 1, 1.0, 'D'), (2, 7, '2023-01-01', 1, 2, 0.0, 'C'), (1, 8, '2023-01-01', 2, 2, 2.0, 'C'), (3, 6, '2023-01-01', 2, 1, 2.0, 'default2'), (4, 0, '2023-01-01', 0, 1, 0.0, 'default2'), (5, 8, '2023-01-01', 0, 2, 1.0, 'default2'), (6, 9, '2023-01-01', 1, 1, 2.0, 'C'), (7, 6, '2023-01-01', 2, 2, 1.0, 'default1'), (8, 9, '2023-01-02', 2, 0, 1.0, 'default1'), (9, 1, '2023-01-02', 0, 2, 2.0, 'default2'), (10, 7, '2023-01-02', 1, 1, 0.0, 'default2'), (11, 7, '2023-01-01', 2, 0, 2.0, 'default1'), (12, 7, '2023-01-01', 1, 2, 2.0, 'default1'), (13, 8, '2023-01-02', 2, 0, 2.0, 'D'), (14, 9, '2023-01-01', 1, 0, 1.0, 'D'), (15, 5, '2023-01-01', 0, 1, 2.0, 'D'), (16, 3, '2023-01-01', 1, 0, 0.0, 'default2'), (17, 7, '2023-01-02', 1, 1, 1.0, 'C'), (18, 5, '2023-01-01', 1, 2, 2.0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.A3 FROM district AS T1 JOIN account AS T2 ON T1.district_id = T2.district_id JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T3.status = 'C' GROUP BY T1.A3 ORDER BY COUNT(T3.loan_id) DESC, T1.A3 NULLS LAST LIMIT 1;

/*
Prediction Result:
('C',)
*/