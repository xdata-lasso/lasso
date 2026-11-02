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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default1', 'Prague', 'Prague', 'default2', 'default1', 0, 2, 2.0, 1, 1.0, 0.0, 1, 0, 2), (2, 'Prague', 'default1', 'default1', 'default1', 'default1', 'Prague', 0, 0, 1.0, 2, 0.0, 2.0, 1, 2, 0), (1, 'default2', 'default1', 'Prague', 'Prague', 'default2', 'default2', 2, 2, 0.0, 0, 0.0, 2.0, 1, NULL, 1), (3, 'Prague', 'Prague', 'default2', 'default1', 'Prague', 'default2', 0, 1, 2.0, 0, 1.0, 2.0, 2, 2, 2), (4, 'Prague', 'Prague', 'Prague', 'default2', 'default2', 'default2', 1, 0, 0.0, 0, 1.0, 2.0, 2, 0, 1), (5, 'Prague', 'Prague', 'Prague', 'default1', 'default1', 'Prague', 2, 1, 2.0, 1, 2.0, 1.0, 0, 2, 2), (6, 'default1', 'default2', 'default2', 'Prague', 'default1', 'default1', 0, 2, 2.0, 2, 0.0, 0.0, 1, 0, 0), (7, 'default2', 'default2', 'Prague', 'default2', 'default2', 'default2', 1, 1, 1.0, 2, 0.0, 1.0, 0, 2, 1), (8, 'default1', 'Prague', 'Prague', 'Prague', 'default1', 'default2', 0, 0, 0.0, 1, 0.0, 1.0, 2, 0, 0), (9, 'Prague', 'Prague', 'default2', 'default1', 'default1', 'default2', 0, 0, 2.0, 1, 0.0, 0.0, 0, 1, 2), (10, 'default1', 'default1', 'Prague', 'Prague', 'default2', 'default1', 1, 0, 1.0, 2, 1.0, 2.0, 1, 2, 0), (11, 'default1', 'Prague', 'default2', 'default1', 'default2', 'Prague', 0, 0, 0.0, 1, NULL, 1.0, 1, NULL, 2), (12, 'default1', 'default2', 'default1', 'default1', 'Prague', 'Prague', 0, 1, 2.0, 2, 0.0, 0.0, 2, 2, 0), (13, 'default1', 'default2', 'default1', 'default2', 'Prague', 'default1', 1, 1, 0.0, 1, NULL, 0.0, 0, NULL, 2), (14, 'default1', 'default1', 'Prague', 'Prague', 'default2', 'default1', 0, 0, 0.0, 1, 1.0, 0.0, 1, NULL, 1), (15, 'default2', 'Prague', 'Prague', 'default2', 'default2', 'default2', 0, 1, 2.0, 2, 2.0, 2.0, 1, 2, 1), (16, 'default2', 'Prague', 'default2', 'default2', 'Prague', 'Prague', 1, 1, 1.0, 2, 2.0, 1.0, 0, NULL, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 7, 'default2', '2023-01-01'), (0, 7, 'Prague', '2023-01-02'), (2, 2, 'default1', '2023-01-01'), (3, 7, 'default1', '2023-01-01'), (4, 12, 'default1', '2023-01-02'), (5, 4, 'Prague', '2023-01-02'), (6, 7, 'default2', '2023-01-02'), (7, 16, 'default1', '2023-01-01'), (8, 8, 'default2', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 3, 'default1', 1, 0.0, 'Prague'), (2, 6, 'default2', 0, 2.0, 'default2'), (0, 5, 'Prague', 2, 2.0, 'default1'), (3, 3, 'default1', 2, 2.0, 'Prague'), (4, 3, 'Prague', 2, 1.0, 'Prague'), (5, 4, 'default1', 2, 2.0, 'default2'), (6, 7, 'default2', 2, 2.0, 'default1'), (7, 0, 'default1', 0, 1.0, 'default2'), (8, 1, 'default2', 0, 0.0, 'Prague'), (9, 7, 'Prague', 1, 0.0, 'default1'), (10, 1, 'default2', 1, 0.0, 'default1'), (11, 8, 'default2', 1, 2.0, 'default2'), (12, 8, 'default2', 2, 2.0, 'default1'), (13, 1, 'default1', 1, 2.0, 'default2'), (14, 7, 'default2', 1, 1.0, 'Prague'), (15, 6, 'default1', 1, 2.0, 'Prague'), (16, 4, 'default1', 2, 1.0, 'default2'), (17, 3, 'default1', 1, 0.0, 'default1'), (18, 3, 'default1', 1, 0.0, 'Prague'), (19, 4, 'default2', 1, 1.0, 'Prague'), (20, 4, 'Prague', 0, 2.0, 'Prague'), (21, 6, 'default2', 1, 1.0, 'Prague');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'Prague' ORDER BY T1.date ASC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT account.account_id FROM district INNER JOIN account ON district.district_id = account.district_id WHERE district.a3 = 'Prague' ORDER BY account.date ASC, district.district_id NULLS LAST, account.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(8,)
*/