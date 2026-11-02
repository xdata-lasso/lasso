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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (300001, 'default1', 'default1', 'default1', 'default1', 'default1', 'default2', 300001, 1, 1.0, 299999, 300000.0, 300000.0, 1, 1, 0), (300000, 'default1', 'default1', 'default1', 'default2', 'default2', 'default1', 299999, 300001, 0.0, 300001, NULL, 300001.0, 1, 1, 300001), (0, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1', 0, 300001, 300000.0, 300000, 300000.0, 300000.0, 1, 1, 0), (1, 'default2', 'default2', 'default2', 'default2', 'default1', 'default2', 1, 0, 0.0, 299999, 300000.0, 1.0, 1, 300000, 300000), (299999, 'default1', 'default2', 'default1', 'default2', 'default2', 'default2', 300000, 300000, 299999.0, 300000, 300001.0, 1.0, 0, 300000, 300000), (2, 'default1', 'default1', 'default2', 'default2', 'default1', 'default2', 299999, 1, 0.0, 299999, 0.0, 0.0, 1, NULL, 300001), (3, 'default1', 'default2', 'default2', 'default2', 'default1', 'default2', 1, 1, 1.0, 1, 300000.0, 300001.0, 0, 0, 1), (4, 'default2', 'default2', 'default1', 'default2', 'default2', 'default2', 0, 1, 0.0, 300000, 300001.0, 1.0, 300001, 1, 0), (5, 'default1', 'default2', 'default2', 'default2', 'default1', 'default2', 300000, 300000, 0.0, 0, 300000.0, 300001.0, 0, 300001, 300000), (6, 'default1', 'default1', 'default2', 'default2', 'default1', 'default2', 299999, 0, 1.0, 300000, 299999.0, 300000.0, 1, 1, 0), (7, 'default1', 'default1', 'default1', 'default1', 'default1', 'default1', 0, 300000, 0.0, 0, 300000.0, 1.0, 300000, 0, 300000), (8, 'default2', 'default2', 'default1', 'default1', 'default1', 'default2', 299999, 300000, 1.0, 0, NULL, 299999.0, 299999, 300001, 300001), (9, 'default2', 'default2', 'default2', 'default2', 'default2', 'default1', 300001, 0, 300001.0, 299999, 1.0, 300000.0, 299999, 300000, 300000), (10, 'default2', 'default2', 'default1', 'default2', 'default2', 'default1', 300001, 300000, 1.0, 1, 300001.0, 1.0, 0, 300001, 300000), (11, 'default2', 'default2', 'default2', 'default1', 'default1', 'default2', 0, 1, 300000.0, 1, 299999.0, 300000.0, 300001, 299999, 299999), (12, 'default1', 'default2', 'default1', 'default1', 'default2', 'default2', 300000, 1, 300000.0, 0, 0.0, 300000.0, 300000, 300001, 1), (13, 'default1', 'default1', 'default2', 'default2', 'default1', 'default2', 0, 0, 1.0, 300000, 0.0, 0.0, 300001, 300000, 1), (14, 'default1', 'default1', 'default2', 'default1', 'default1', 'default1', 300000, 0, 1.0, 1, NULL, 299999.0, 299999, 1, 300001), (15, 'default2', 'default2', 'default2', 'default2', 'default1', 'default2', 299999, 1, 300001.0, 0, NULL, 299999.0, 1, 300001, 1), (16, 'default1', 'default2', 'default2', 'default2', 'default1', 'default2', 300001, 299999, 299999.0, 299999, 1.0, 0.0, 299999, 1, 300000), (17, 'default1', 'default2', 'default1', 'default2', 'default2', 'default2', 0, 300001, 300000.0, 300001, 300000.0, 0.0, 300000, NULL, 299999), (18, 'default2', 'default1', 'default2', 'default2', 'default1', 'default1', 1, 0, 300000.0, 300001, 1.0, 300001.0, 300000, 0, 1), (19, 'default2', 'default1', 'default1', 'default2', 'default1', 'default1', 299999, 1, 0.0, 300000, 300001.0, 0.0, 300000, 1, 0), (20, 'default1', 'default2', 'default1', 'default1', 'default2', 'default1', 300001, 0, 300001.0, 300001, 300001.0, 300001.0, 300000, 300001, 299999), (21, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1', 300000, 299999, 300001.0, 300001, 299999.0, 299999.0, 300001, 1, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 16, 'default1', '2023-01-02'), (300001, 16, 'default2', '2023-01-01'), (300000, 12, 'default1', '2023-01-02'), (299999, 17, 'default2', '2023-01-01'), (1, 8, 'default1', '2023-01-01'), (2, 21, 'default1', '2023-01-02'), (3, 0, 'default1', '2023-01-01'), (4, 8, 'default2', '2023-01-01'), (5, 10, 'default2', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (299999, 1, '2023-01-01', 0, 299999, 1.0, 'default2'), (300000, 1, '2023-01-02', 1, 0, 300000.0, 'default1'), (1, 5, '2023-01-02', 300000, 0, 300001.0, 'default2'), (300001, 4, '2023-01-01', 1, 300000, 0.0, 'default1'), (0, 299999, '2023-01-02', 1, 299999, 300000.0, 'default2'), (2, 4, '2023-01-01', 299999, 300001, 300001.0, 'default1'), (3, 0, '2023-01-01', 299999, 300001, 300001.0, 'default1'), (4, 1, '2023-01-02', 300001, 300001, 300001.0, 'default2'), (5, 3, '2023-01-01', 299999, 299999, 300001.0, 'default1'), (6, 300001, '2023-01-02', 300000, 1, 299999.0, 'default1'), (7, 1, '2023-01-01', 300001, 300001, 300000.0, 'default1'), (8, 1, '2023-01-01', 1, 300000, 300000.0, 'default2'), (9, 300001, '2023-01-02', 299999, 300001, 299999.0, 'default1'), (10, 0, '2023-01-02', 1, 300000, 1.0, 'default1'), (11, 1, '2023-01-02', 299999, 0, 300000.0, 'default2'), (12, 300001, '2023-01-01', 299999, 300000, 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.amount > 300000;

/*
Gold Result:
(1, 'default2', 'default2')
(1, 'default2', 'default2')
*/

-- Prediction Query
SELECT DISTINCT T2.account_id, T4.A2, T4.A3 FROM loan AS T2 JOIN account AS T3 ON T2.account_id = T3.account_id JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T2.amount > 300000;

/*
Prediction Result:
(1, 'default2', 'default2')
*/