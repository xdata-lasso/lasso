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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'C', 'default2', 'C', 'D', 'D', 'default2', 0, 1, 1.0, 1, 2.0, 0.0, 1, 2, 1), (2, 'C', 'default1', 'default1', 'D', 'default2', 'D', 0, 0, 2.0, 1, 0.0, 1.0, 0, 2, 2), (0, 'C', 'C', 'default1', 'C', 'default1', 'default1', 1, 1, 0.0, 1, 1.0, 1.0, 0, 2, 2), (3, 'C', 'default2', 'C', 'C', 'default2', 'default2', 1, 2, 0.0, 1, 2.0, 2.0, 1, 0, 2), (4, 'D', 'D', 'default1', 'default1', 'default2', 'D', 0, 2, 2.0, 1, NULL, 1.0, 0, NULL, 0), (5, 'default2', 'default1', 'default2', 'D', 'default1', 'default1', 1, 1, 2.0, 2, 1.0, 0.0, 1, 1, 0), (6, 'default1', 'D', 'C', 'default1', 'D', 'default2', 1, 2, 1.0, 1, NULL, 2.0, 0, 2, 2), (7, 'default2', 'default1', 'D', 'default1', 'default1', 'default1', 0, 0, 0.0, 1, 2.0, 1.0, 1, 2, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 7, 'C', '2023-01-01'), (0, 4, 'default1', '2023-01-02'), (2, 7, 'C', '2023-01-02'), (3, 5, 'D', '2023-01-01'), (4, 7, 'default2', '2023-01-02'), (5, 5, 'D', '2023-01-01'), (6, 1, 'D', '2023-01-02'), (7, 5, 'D', '2023-01-02'), (8, 1, 'default2', '2023-01-02'), (9, 1, 'default1', '2023-01-02'), (10, 6, 'C', '2023-01-01'), (11, 6, 'default1', '2023-01-02'), (12, 7, 'C', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 4, 'C', 1, 2.0, 'D'), (2, 3, 'default1', 1, 2.0, 'C'), (0, 2, 'C', 2, 0.0, 'D'), (3, 10, 'default1', 2, 1.0, 'D'), (4, 3, 'default1', 0, 0.0, 'C'), (5, 4, 'default1', 2, 1.0, 'C'), (6, 3, 'default2', 0, 0.0, 'default2'), (7, 3, 'C', 2, 1.0, 'default1'), (8, 12, 'D', 0, 1.0, 'C'), (9, 5, 'default2', 0, 1.0, 'D');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 2, '2023-01-02', 1, 0, 2.0, 'default2'), (2, 11, '2023-01-01', 0, 1, 1.0, 'default1'), (0, 10, '2023-01-02', 2, 1, 0.0, 'default1'), (3, 2, '2023-01-02', 1, 0, 1.0, 'D'), (4, 1, '2023-01-01', 2, 0, 0.0, 'default2'), (5, 10, '2023-01-01', 2, 2, 0.0, 'C'), (6, 4, '2023-01-02', 1, 1, 0.0, 'D'), (7, 0, '2023-01-02', 1, 1, 0.0, 'C'), (8, 3, '2023-01-01', 1, 1, 1.0, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('D',)
*/

-- Prediction Query
SELECT d.A3 FROM loan AS l JOIN account AS a ON l.account_id = a.account_id JOIN district AS d ON a.district_id = d.district_id WHERE l.status IN ('C', 'D') GROUP BY d.A3 ORDER BY COUNT(l.loan_id) DESC, d.A3 NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/