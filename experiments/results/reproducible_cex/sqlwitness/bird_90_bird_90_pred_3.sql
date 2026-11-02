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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'Prague', 'Prague', 'Prague', 'default1', 'default2', 'default1', 1, 0, 0.0, 0, NULL, 1.0, 1, 1, 1), (0, 'default1', 'Prague', 'default2', 'default2', 'default2', 'default1', 1, 0, 0.0, 0, 1.0, 0.0, 0, 1, 0), (2, 'default1', 'default1', 'default1', 'default1', 'Prague', 'default1', 0, 0, 1.0, 0, NULL, 0.0, 0, 0, 1), (3, 'default2', 'default2', 'default2', 'Prague', 'default1', 'default1', 0, 0, 1.0, 0, 1.0, 0.0, 1, 0, 0), (4, 'Prague', 'Prague', 'Prague', 'Prague', 'Prague', 'Prague', 1, 1, 0.0, 0, NULL, 1.0, 0, NULL, 1), (5, 'Prague', 'default2', 'default2', 'default2', 'default1', 'Prague', 0, 1, 0.0, 0, 1.0, 0.0, 0, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 1, 'default1', '2023-01-01'), (1, 0, 'Prague', '2023-01-02'), (2, 2, 'default2', '2023-01-01'), (3, 4, 'Prague', '2023-01-02'), (4, 0, 'default2', '2023-01-02'), (5, 4, 'default1', '2023-01-02'), (6, 5, 'default1', '2023-01-01'), (7, 1, 'Prague', '2023-01-01'), (8, 1, 'default2', '2023-01-02'), (9, 2, 'default1', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 5, '2023-01-01', 0, 0, 0.0, 'default2'), (0, 9, '2023-01-01', 1, 0, 0.0, 'default2'), (2, 7, '2023-01-01', 1, 0, 1.0, 'Prague'), (3, 8, '2023-01-01', 1, 1, 1.0, 'Prague'), (4, 6, '2023-01-02', 1, 0, 1.0, 'Prague'), (5, 0, '2023-01-02', 0, 0, 0.0, 'default1'), (6, 5, '2023-01-01', 1, 1, 1.0, 'default2'), (7, 8, '2023-01-02', 1, 1, 0.0, 'Prague'), (8, 1, '2023-01-02', 0, 1, 0.0, 'default1'), (9, 4, '2023-01-01', 1, 0, 0.0, 'Prague'), (10, 4, '2023-01-02', 1, 0, 0.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T1.district_id = T3.district_id WHERE T3.A3 = 'Prague';

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(T1.district_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'Prague';

/*
Prediction Result:
(7,)
*/