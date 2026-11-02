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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'default2', 'default2', 'default1', 'default1', 'Prague', 0, 0, 0.0, 1, 1.0, 0.0, 1, 0, 0), (1, 'Prague', 'default1', 'default2', 'Prague', 'default2', 'default1', 0, 0, 1.0, 1, NULL, 1.0, 1, 1, 1), (2, 'default1', 'Prague', 'Prague', 'default1', 'default2', 'default2', 0, 0, 0.0, 0, 0.0, 0.0, 0, 1, 1), (3, 'default1', 'default2', 'Prague', 'default2', 'Prague', 'default1', 1, 1, 0.0, 1, 1.0, 0.0, 0, NULL, 1), (4, 'Prague', 'Prague', 'Prague', 'default1', 'default1', 'default1', 1, 1, 0.0, 1, 0.0, 0.0, 0, 1, 0), (5, 'default2', 'default1', 'default2', 'Prague', 'default2', 'default2', 0, 0, 0.0, 1, 1.0, 0.0, 1, 0, 0), (6, 'default1', 'Prague', 'Prague', 'default2', 'Prague', 'default1', 1, 0, 0.0, 1, 0.0, 1.0, 0, NULL, 0), (7, 'Prague', 'default1', 'Prague', 'default2', 'Prague', 'Prague', 1, 1, 1.0, 1, 0.0, 0.0, 1, 1, 1), (8, 'default1', 'default1', 'default1', 'default2', 'default1', 'Prague', 0, 0, 1.0, 1, 1.0, 1.0, 1, 0, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 6, 'default1', '2023-01-02'), (1, 4, 'default2', '2023-01-02'), (2, 8, 'default2', '2023-01-02'), (3, 8, 'default2', '2023-01-02'), (4, 5, 'default2', '2023-01-02'), (5, 8, 'Prague', '2023-01-01'), (6, 1, 'default1', '2023-01-01'), (7, 2, 'default2', '2023-01-01'), (8, 5, 'default2', '2023-01-02'), (9, 5, 'default2', '2023-01-01'), (10, 0, 'Prague', '2023-01-01'), (11, 7, 'default1', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 1, '2023-01-02', 1, 0, 0.0, 'default2'), (1, 9, '2023-01-02', 0, 1, 0.0, 'default1'), (2, 6, '2023-01-02', 0, 0, 1.0, 'default1'), (3, 9, '2023-01-02', 1, 0, 0.0, 'default1'), (4, 2, '2023-01-02', 1, 0, 0.0, 'Prague'), (5, 11, '2023-01-02', 0, 0, 1.0, 'Prague'), (6, 10, '2023-01-01', 0, 1, 1.0, 'default2'), (7, 5, '2023-01-01', 0, 1, 1.0, 'default1'), (8, 8, '2023-01-01', 0, 0, 1.0, 'default1'), (9, 11, '2023-01-01', 1, 1, 0.0, 'default2'), (10, 4, '2023-01-01', 0, 0, 0.0, 'default1'), (11, 2, '2023-01-01', 0, 0, 0.0, 'default2'), (12, 5, '2023-01-02', 1, 1, 0.0, 'default1'), (13, 4, '2023-01-02', 1, 1, 1.0, 'Prague'), (14, 6, '2023-01-01', 0, 1, 0.0, 'default2'), (15, 11, '2023-01-01', 1, 0, 1.0, 'Prague'), (16, 1, '2023-01-01', 1, 1, 0.0, 'default1'), (17, 0, '2023-01-01', 1, 1, 0.0, 'default2'), (18, 6, '2023-01-02', 0, 1, 1.0, 'default2'), (19, 2, '2023-01-01', 1, 1, 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T1.district_id = T3.district_id WHERE T3.A3 = 'Prague';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.account_id) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T2.A3 = 'Prague';

/*
Prediction Result:
(2,)
*/