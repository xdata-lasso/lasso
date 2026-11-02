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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (300000, 'default1', 'default1', 'default1', 'default2', 'default1', 'default2', 300001, 1, 300000.0, 300001, 300000.0, 0.0, 300001, 299999, 300001), (0, 'default2', 'default2', 'default2', 'default2', 'default2', 'default2', 1, 300000, 300000.0, 300000, 299999.0, 0.0, 1, 0, 300000), (1, 'default2', 'default1', 'default1', 'default2', 'default1', 'default1', 300001, 0, 299999.0, 299999, 299999.0, 300000.0, 0, 300001, 300000), (300001, 'default1', 'default1', 'default2', 'default2', 'default2', 'default2', 1, 300001, 0.0, 300000, 300000.0, 300001.0, 0, 0, 299999), (299999, 'default2', 'default2', 'default2', 'default2', 'default2', 'default1', 300001, 0, 0.0, 0, 300000.0, 299999.0, 300001, 300000, 300001), (2, 'default2', 'default2', 'default2', 'default2', 'default1', 'default2', 300000, 0, 0.0, 1, 300001.0, 299999.0, 1, NULL, 1), (3, 'default2', 'default1', 'default1', 'default1', 'default2', 'default1', 0, 1, 1.0, 0, 1.0, 299999.0, 299999, 300000, 1), (4, 'default2', 'default1', 'default2', 'default1', 'default1', 'default1', 299999, 0, 1.0, 299999, 1.0, 1.0, 1, 1, 300001);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 300000, 'default2', '2023-01-01'), (1, 3, 'default1', '2023-01-02'), (300001, 299999, 'default1', '2023-01-01'), (300000, 300000, 'default1', '2023-01-02'), (299999, 2, 'default2', '2023-01-02'), (2, 300000, 'default1', '2023-01-02'), (3, 3, 'default1', '2023-01-02'), (4, 1, 'default1', '2023-01-01'), (5, 4, 'default1', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (300001, 3, '2023-01-02', 300001, 300000, 0.0, 'default2'), (300000, 5, '2023-01-01', 300001, 0, 300000.0, 'default1'), (299999, 300001, '2023-01-02', 1, 300000, 0.0, 'default1'), (0, 1, '2023-01-02', 299999, 299999, 300001.0, 'default2'), (1, 300001, '2023-01-01', 300001, 300000, 0.0, 'default1'), (2, 0, '2023-01-01', 0, 0, 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.amount > 300000;

/*
Gold Result:
(300001, 'default2', 'default2')
(5, 'default2', 'default1')
(3, 'default2', 'default1')
*/

-- Prediction Query
SELECT T1.account_id, T2.A2 AS district, T2.A3 AS region FROM loan AS T1 INNER JOIN district AS T2 ON T1.account_id = T2.district_id WHERE T1.amount > 300000;

/*
Prediction Result:
(300001, 'default1', 'default1')
(3, 'default2', 'default1')
*/