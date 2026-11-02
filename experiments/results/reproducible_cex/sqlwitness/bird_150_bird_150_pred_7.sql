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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'AB', 'north Bohemia', 'default1', 'default2', 'default2', 1, 0, 0.0, 0, 1.0, 0.0, 0, 1, 1), (1, 'default2', 'default2', 'default2', 'north Bohemia', 'default2', 'default2', 0, 1, 0.0, 0, NULL, 0.0, 1, 1, 1), (2, 'default1', 'default1', 'default1', 'north Bohemia', 'AB', 'default2', 0, 1, 1.0, 1, NULL, 0.0, 0, 0, 1), (3, 'north Bohemia', 'default1', 'AB', 'default2', 'AB', 'AB', 1, 0, 0.0, 0, 0.0, 0.0, 0, 0, 0), (4, 'default1', 'north Bohemia', 'default1', 'AB', 'north Bohemia', 'AB', 1, 1, 0.0, 0, 0.0, 0.0, 1, 1, 0), (5, 'AB', 'default2', 'AB', 'default2', 'default1', 'default2', 1, 0, 1.0, 0, 0.0, 0.0, 1, 0, 0), (6, 'AB', 'default1', 'default1', 'AB', 'north Bohemia', 'AB', 0, 0, 0.0, 0, 1.0, 0.0, 1, 0, 1), (7, 'default1', 'default1', 'AB', 'default1', 'AB', 'AB', 1, 0, 0.0, 0, NULL, 1.0, 1, NULL, 1), (8, 'default2', 'default2', 'default1', 'north Bohemia', 'north Bohemia', 'north Bohemia', 0, 0, 0.0, 0, 0.0, 0.0, 1, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 4, 'north Bohemia', '2023-01-02'), (0, 0, 'default1', '2023-01-02'), (2, 0, 'default1', '2023-01-01'), (3, 5, 'north Bohemia', '2023-01-02'), (4, 3, 'default2', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 2, '2023-01-01', 'north Bohemia', NULL, 1, 0, 'north Bohemia', 'default2', 0), (0, 3, '2023-01-02', 'default1', 'north Bohemia', 0, 1, 'AB', 'north Bohemia', 1), (2, 2, '2023-01-01', 'AB', 'AB', 1, 1, 'north Bohemia', 'north Bohemia', 1), (3, 4, '2023-01-01', 'default1', 'north Bohemia', 1, 1, 'default2', 'default2', 1), (4, 2, '2023-01-02', 'default2', 'AB', 0, 0, 'north Bohemia', 'AB', 1), (5, 1, '2023-01-01', 'default2', 'AB', 0, 0, 'default1', 'default1', 1), (6, 0, '2023-01-01', 'AB', 'default2', 1, 0, 'AB', 'default2', 1), (7, 2, '2023-01-01', 'AB', 'default1', 0, 1, 'AB', 'AB', 1), (8, 2, '2023-01-01', 'AB', 'AB', 0, 1, 'default2', 'default1', NULL), (9, 3, '2023-01-01', 'default2', 'north Bohemia', 0, 1, 'AB', 'default1', 0), (10, 3, '2023-01-02', 'default1', 'AB', 0, 1, NULL, NULL, 1), (11, 1, '2023-01-01', 'default2', 'AB', 0, 1, 'default2', 'AB', 0), (12, 4, '2023-01-01', 'AB', 'north Bohemia', 1, 0, 'default1', NULL, 0), (13, 1, '2023-01-02', 'default2', 'default1', 0, 0, 'AB', 'north Bohemia', NULL), (14, 2, '2023-01-02', 'north Bohemia', 'AB', 0, 0, 'north Bohemia', 'default2', NULL), (15, 1, '2023-01-01', 'default1', 'default1', 0, 0, NULL, 'AB', 0), (16, 3, '2023-01-01', 'default1', 'north Bohemia', 1, 0, NULL, 'north Bohemia', 1), (17, 1, '2023-01-01', 'default2', 'AB', 1, 0, 'default1', 'default2', 1), (18, 0, '2023-01-01', 'north Bohemia', NULL, 0, 0, 'default1', 'north Bohemia', 1), (19, 4, '2023-01-01', 'default1', NULL, 0, 0, 'AB', 'north Bohemia', 1), (20, 0, '2023-01-02', 'AB', 'default1', 1, 0, 'north Bohemia', 'north Bohemia', NULL), (21, 0, '2023-01-01', 'AB', NULL, 0, 0, NULL, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.bank = 'AB' AND T1.A3 = 'north Bohemia';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT a.account_id) FROM district AS d JOIN account AS a ON d.district_id = a.district_id JOIN trans AS t ON a.account_id = t.account_id WHERE d.A3 = 'north Bohemia' AND t.bank = 'AB';

/*
Prediction Result:
(1,)
*/