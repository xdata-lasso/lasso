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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'default2', '%Y-%m', '1996-01', 'VYDAJ', 'default2', 9, 9, 1.0, 10, 0.0, 9.0, 11, NULL, 9), (11, 'default1', '1996-01', '%Y-%m', 'default2', 'default2', '1996-01%', 0, 9, 0.0, 1, 11.0, 11.0, 11, 0, 10), (9, 'default1', 'default2', 'default1', 'default2', '1996-01%', '1996-01%', 10, 11, 10.0, 1, 11.0, 9.0, 1, 1, 1), (0, 'default2', 'default1', 'VYDAJ', '%Y-%m', 'default2', 'default1', 9, 11, 9.0, 1, NULL, 9.0, 9, 9, 0), (10, '%Y-%m', '1996-01', '1996-01%', '%Y-%m', 'default1', '%Y-%m', 9, 10, 1.0, 0, 10.0, 10.0, 9, 11, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 10, 'default2', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 10, '1996-01-27', '%Y-%m', '1996-01', 11, 1, 'default1', 'default2', NULL), (9, 10, '1996-01-27', 'VYDAJ', '1996-01%', 11, 1, 'default2', 'VYDAJ', 0), (1, 10, '2023-01-02', 'default2', 'default2', 1, 0, 'default2', '%Y-%m', 10), (11, 10, '1996-01-27', 'VYDAJ', '1996-01', 10, 11, 'default2', '%Y-%m', 10), (10, 10, '1996-01-27', '1996-01%', 'VYDAJ', 0, 1, '1996-01', 'default1', 10), (2, 10, '2023-01-02', 'default1', 'default1', 1, 11, 'VYDAJ', 'VYDAJ', 0), (3, 10, '1996-01-27', '1996-01', 'default2', 9, 0, NULL, 'default2', 1), (4, 10, '1996-01-27', 'default1', '%Y-%m', 10, 9, NULL, '1996-01%', 10), (5, 10, '2023-01-02', '1996-01%', 'VYDAJ', 10, 9, NULL, NULL, NULL), (6, 10, '2023-01-01', '1996-01%', 'VYDAJ', 0, 9, NULL, NULL, 9);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 10, 'VYDAJ', 10, 1.0, '1996-01'), (11, 10, 'VYDAJ', 0, 10.0, '1996-01%'), (0, 10, '1996-01', 10, 9.0, 'VYDAJ'), (9, 10, 'VYDAJ', 9, 10.0, 'default2'), (10, 10, 'default2', 10, 11.0, 'default2'), (2, 10, '1996-01', 11, 1.0, 'default1'), (3, 10, '1996-01', 9, 1.0, '%Y-%m'), (4, 10, 'default1', 11, 10.0, 'default1'), (5, 10, '%Y-%m', 1, 9.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T2.date LIKE '1996-01%' ORDER BY A2 ASC, T1.district_id NULLS LAST, T2.account_id NULLS LAST, T3.trans_id NULLS LAST LIMIT 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT d.a2 AS district_name, SUM(t.amount) AS total_withdrawals FROM trans AS t INNER JOIN account AS a ON t.account_id = a.account_id INNER JOIN district AS d ON a.district_id = d.district_id WHERE t.type = 'VYDAJ' AND STRFTIME('%Y-%m', t.date) = '1996-01' GROUP BY d.a2 ORDER BY total_withdrawals DESC, district_name NULLS LAST LIMIT 10;

/*
Prediction Result:
('%Y-%m', 21)
*/