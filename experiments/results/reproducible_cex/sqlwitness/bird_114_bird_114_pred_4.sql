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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'Prague', 'default2', 'default1', 'default2', 'Prague', 'Prague', 2, 2, 0.0, 1, 1.0, 1.0, 0, 1, 0), (0, 'default1', 'Prague', 'Prague', 'default2', 'Prague', 'default2', 2, 2, 0.0, 2, 2.0, 2.0, 2, 1, 0), (2, 'default2', 'default1', 'default1', 'Prague', 'Prague', 'default2', 0, 1, 1.0, 1, 0.0, 1.0, 2, 0, 2), (3, 'Prague', 'default2', 'Prague', 'default2', 'default1', 'default2', 2, 0, 1.0, 1, 2.0, 0.0, 1, NULL, 1), (4, 'Prague', 'default1', 'default1', 'Prague', 'default2', 'Prague', 1, 0, 0.0, 2, 2.0, 0.0, 2, 1, 0), (5, 'Prague', 'Prague', 'default1', 'default2', 'default1', 'default2', 1, 0, 1.0, 2, 1.0, 2.0, 0, NULL, 2), (6, 'default1', 'default2', 'Prague', 'default2', 'default2', 'default2', 1, 2, 0.0, 2, 2.0, 2.0, 0, 2, 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'default2', '2023-01-02'), (1, 0, 'default1', '2023-01-01'), (2, 0, 'default1', '2023-01-02'), (3, 6, 'Prague', '2023-01-02'), (4, 4, 'Prague', '2023-01-01'), (5, 0, 'default1', '2023-01-01'), (6, 5, 'Prague', '2023-01-01'), (7, 0, 'Prague', '2023-01-01'), (8, 0, 'default2', '2023-01-01'), (9, 5, 'default2', '2023-01-02'), (10, 3, 'default1', '2023-01-02'), (11, 3, 'default1', '2023-01-02'), (12, 5, 'default2', '2023-01-02'), (13, 5, 'Prague', '2023-01-02'), (14, 4, 'default1', '2023-01-01'), (15, 1, 'Prague', '2023-01-02'), (16, 4, 'default2', '2023-01-01'), (17, 3, 'Prague', '2023-01-01'), (18, 0, 'Prague', '2023-01-01'), (19, 6, 'default2', '2023-01-02'), (20, 4, 'Prague', '2023-01-02'), (21, 3, 'Prague', '2023-01-01'), (22, 6, 'Prague', '2023-01-01'), (23, 5, 'default1', '2023-01-01'), (24, 4, 'default2', '2023-01-01'), (25, 6, 'Prague', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 12, 'Prague', 0, 0.0, 'Prague'), (0, 11, 'default1', 1, 0.0, 'Prague'), (2, 20, 'Prague', 1, 0.0, 'default2'), (3, 9, 'default1', 1, 0.0, 'default1'), (4, 12, 'default1', 0, 0.0, 'Prague'), (5, 11, 'default2', 1, 1.0, 'default2'), (6, 17, 'default1', 2, 2.0, 'default2'), (7, 19, 'default2', 1, 1.0, 'default1'), (8, 13, 'default1', 1, 0.0, 'Prague'), (9, 11, 'default1', 0, 2.0, 'default2'), (10, 4, 'default2', 1, 0.0, 'default2'), (11, 18, 'default2', 2, 2.0, 'Prague'), (12, 4, 'default1', 2, 0.0, 'Prague'), (13, 10, 'default1', 1, 2.0, 'default1'), (14, 19, 'default2', 0, 1.0, 'default1'), (15, 20, 'Prague', 0, 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'Prague' ORDER BY T1.date ASC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT account.account_id FROM account INNER JOIN district ON account.district_id = district.district_id WHERE district.A3 = 'Prague' ORDER BY district.A3 ASC, account.account_id NULLS LAST, district.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0,)
*/