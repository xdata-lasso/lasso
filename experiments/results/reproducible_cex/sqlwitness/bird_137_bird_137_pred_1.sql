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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (2, 'default1', 'C', 'D', 'default1', 'default1', 'C', 2, 1, 0.0, 1, NULL, 2.0, 1, 1, 1), (0, 'default1', 'default1', 'D', 'D', 'C', 'C', 0, 2, 2.0, 1, 2.0, 2.0, 1, 1, 1), (1, 'default2', 'default2', 'C', 'D', 'C', 'default2', 2, 1, 1.0, 2, 0.0, 2.0, 0, NULL, 1), (3, 'default2', 'default1', 'default1', 'C', 'C', 'default2', 1, 1, 0.0, 0, 0.0, 2.0, 1, NULL, 2), (4, 'default1', 'C', 'default1', 'D', 'D', 'D', 0, 0, 0.0, 1, 0.0, 0.0, 2, NULL, 2), (5, 'D', 'D', 'default1', 'default1', 'default2', 'C', 0, 2, 1.0, 0, NULL, 1.0, 0, 2, 0), (6, 'default2', 'default2', 'default2', 'default2', 'C', 'C', 0, 0, 2.0, 1, 1.0, 0.0, 1, 2, 1), (7, 'default1', 'default2', 'C', 'default2', 'D', 'default2', 0, 1, 2.0, 0, 2.0, 1.0, 0, 1, 0), (8, 'default1', 'default1', 'default2', 'C', 'D', 'default2', 0, 2, 1.0, 1, 1.0, 1.0, 0, 1, 2), (9, 'C', 'D', 'default1', 'C', 'C', 'C', 1, 1, 1.0, 1, 0.0, 1.0, 0, 2, 0), (10, 'D', 'D', 'default2', 'default2', 'D', 'C', 2, 1, 0.0, 0, NULL, 2.0, 2, 1, 0), (11, 'D', 'D', 'default1', 'default1', 'default1', 'C', 2, 2, 0.0, 1, 2.0, 2.0, 1, 0, 2), (12, 'D', 'default1', 'default1', 'C', 'default1', 'D', 1, 2, 2.0, 2, 2.0, 2.0, 2, 1, 2), (13, 'default2', 'default2', 'D', 'C', 'default1', 'default2', 1, 1, 0.0, 0, 0.0, 0.0, 2, 2, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 13, 'C', '2023-01-01'), (2, 0, 'D', '2023-01-01'), (0, 10, 'default2', '2023-01-01'), (3, 1, 'C', '2023-01-02'), (4, 7, 'D', '2023-01-01'), (5, 3, 'D', '2023-01-02'), (6, 0, 'default1', '2023-01-01'), (7, 1, 'C', '2023-01-02'), (8, 10, 'C', '2023-01-01'), (9, 9, 'C', '2023-01-01'), (10, 7, 'default2', '2023-01-02'), (11, 13, 'C', '2023-01-02'), (12, 7, 'default1', '2023-01-01'), (13, 3, 'default1', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (0, 7, '2023-01-01', 2, 0, 1.0, 'default1'), (1, 0, '2023-01-01', 0, 1, 0.0, 'default2'), (2, 0, '2023-01-02', 0, 1, 1.0, 'default1'), (3, 7, '2023-01-02', 1, 0, 0.0, 'default2'), (4, 0, '2023-01-01', 2, 0, 2.0, 'default1'), (5, 7, '2023-01-01', 2, 0, 1.0, 'D'), (6, 12, '2023-01-01', 2, 0, 1.0, 'C'), (7, 3, '2023-01-02', 0, 2, 1.0, 'default1'), (8, 6, '2023-01-02', 2, 0, 1.0, 'D'), (9, 3, '2023-01-01', 2, 1, 0.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T1.district_id = 1 AND (T3.status = 'C' OR T3.status = 'D');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(account.account_id) FROM account INNER JOIN loan ON account.account_id = loan.account_id WHERE account.district_id = 1 AND loan.status = 'C';

/*
Prediction Result:
(0,)
*/