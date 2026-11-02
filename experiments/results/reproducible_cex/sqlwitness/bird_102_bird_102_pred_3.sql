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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (2999, 'default1', 'default2', '1997', '1997', '1997-01-01', 'default2', 3000, 3000, 1.0, 3001, 2999.0, 0.0, 1, 1, 0), (0, '1997-01-01', 'default2', '1997', 'default1', 'default2', 'default1', 0, 2999, 2999.0, 3001, 3000.0, 2999.0, 2999, 0, 1), (3000, 'default1', 'default1', '%Y', '1997', 'default2', '%Y', 3000, 1, 2999.0, 0, 2999.0, 0.0, 3000, 0, 3001), (3001, '1997', '1997-01-01', '%Y', 'default1', '1997', 'default1', 2999, 0, 3001.0, 0, 3001.0, 1.0, 3000, 3000, 3001), (1, 'default1', 'default1', '1997', 'default2', '1997-01-01', 'default2', 2999, 3000, 1.0, 2999, 3001.0, 2999.0, 0, 0, 3000), (2, '1997', '%Y', 'default1', '%Y', 'default1', '1997', 3001, 2999, 1.0, 3000, 3001.0, 1.0, 2999, NULL, 2999), (3, '1997', 'default2', 'default1', '1997-01-01', '1997-01-01', '%Y', 1, 0, 1.0, 3001, NULL, 0.0, 3001, 0, 1), (4, '%Y', 'default1', '1997', 'default1', 'default2', '1997', 0, 3001, 0.0, 3001, 0.0, 3000.0, 2999, 3000, 0), (5, '%Y', '%Y', '1997-01-01', 'default2', '1997', '%Y', 0, 3001, 3001.0, 3001, 2999.0, 3000.0, 0, 3000, 0), (6, '1997-01-01', '%Y', 'default2', '%Y', '1997', 'default1', 3000, 1, 3001.0, 1, 2999.0, 1.0, 2999, 2999, 2999);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2999, 0, '%Y', '1997-01-02'), (0, 3000, '1997-01-01', '2023-01-02'), (1, 4, 'default2', '1996-12-31'), (3000, 3, 'default2', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 2999, '1996-12-31', 'default2', 'default1', 0, 2999, NULL, 'default1', 1), (1, 2999, '2023-01-02', 'default1', '1997-01-01', 3000, 1, '%Y', '1997', 3001), (3000, 1, '1996-12-31', '1997', '1997', 3001, 3000, 'default2', 'default2', 0), (3001, 2999, '2023-01-01', '%Y', 'default1', 3001, 3000, '1997-01-01', NULL, 2999), (2999, 0, '1997-01-01', 'default1', 'default1', 1, 2999, '%Y', '1997-01-01', 1), (2, 0, '1997-01-02', 'default1', NULL, 1, 0, '%Y', '%Y', 2999), (3, 2999, '1997-10-27', 'default1', '1997-01-01', 3001, 0, '1997', 'default1', 0), (4, 3000, '1997-10-27', 'default1', '%Y', 0, 3001, '%Y', '1997', 0), (5, 1, '1997-01-02', 'default1', '1997-01-01', 2999, 2999, 'default1', '1997-01-01', 3001), (6, 2999, '1997-01-02', '%Y', NULL, 1, 1, NULL, NULL, 1), (7, 0, '1996-12-31', 'default2', 'default1', 2999, 3001, 'default1', NULL, 3000), (8, 3000, '2023-01-02', 'default2', '1997-01-01', 2999, 0, 'default2', '1997-01-01', 3001), (9, 0, '2023-01-02', '1997-01-01', 'default2', 1, 3001, '%Y', NULL, NULL), (10, 3000, '1997-01-02', 'default1', '1997-01-01', 3001, 1, 'default1', 'default2', 3001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T2.date) < '1997' AND T1.amount > 3000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT T1.account_id FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date < '1997-01-01' AND T2.balance > 3000;

/*
Prediction Result:
*/