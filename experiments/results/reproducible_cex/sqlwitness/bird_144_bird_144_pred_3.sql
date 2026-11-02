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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '2021', 'default2', '%Y', '2021', '%Y', '2021', 1, 1, 0.0, 1, 1.0, 1.0, 1, 0, 1), (0, '%Y', 'default2', '%Y', 'default2', 'default2', 'default2', 0, 1, 1.0, 0, NULL, 0.0, 1, 1, 1), (2, 'VYBER KARTOU', 'default1', 'VYBER KARTOU', 'VYBER KARTOU', '2021', 'default1', 1, 0, 1.0, 0, NULL, 1.0, 1, 0, 1), (3, 'default1', '%Y', 'default1', 'VYBER KARTOU', '%Y', 'VYBER KARTOU', 0, 1, 1.0, 0, 1.0, 0.0, 0, 0, 1), (4, '2021', '%Y', 'default2', 'VYBER KARTOU', '2021', '2021', 1, 1, 1.0, 0, NULL, 1.0, 1, 0, 0), (5, '2021', '2021', 'VYBER KARTOU', 'default2', 'default2', 'default2', 0, 1, 1.0, 1, 0.0, 1.0, 1, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 3, '%Y', '2021-10-27'), (1, 2, 'VYBER KARTOU', '2023-01-02'), (2, 0, 'default1', '2023-01-01'), (3, 0, 'VYBER KARTOU', '2023-01-02'), (4, 0, '%Y', '2023-01-02'), (5, 3, '2021', '2021-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 4, '2021', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 0, '2023-01-02', 'default1', NULL, 1, 0, 'default2', NULL, NULL), (1, 0, '2021-10-27', 'default2', 'VYBER KARTOU', 0, 0, '2021', 'default2', 0), (2, 0, '2023-01-01', 'default2', 'default1', 1, 1, '2021', '%Y', 1);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 0, 0, '2021'), (0, 0, 5, '2021'), (2, 0, 4, 'default2'), (3, 0, 3, '2021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '2021' AND T3.operation = 'VYBER KARTOU';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '2021' AND operation = 'VYBER KARTOU';

/*
Prediction Result:
(0.0,)
*/