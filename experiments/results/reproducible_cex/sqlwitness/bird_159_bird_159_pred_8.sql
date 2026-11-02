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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (3356, 'VYBER', 'default2', 'default1', 'default2', 'VYBER', 'VYBER', 3356, 3355, 0.0, 3355, 0.0, 3355.0, 3355, 0, 1), (1, 'VYBER', 'default1', 'default2', 'VYBER', 'default1', 'default2', 0, 0, 3355.0, 3356, 3355.0, 0.0, 3355, NULL, 1), (0, 'default1', 'default1', 'default1', 'VYBER', 'default2', 'VYBER', 3357, 3357, 1.0, 3356, 3355.0, 1.0, 3357, NULL, 0), (3357, 'default1', 'VYBER', 'default2', 'default1', 'VYBER', 'default2', 3356, 3355, 1.0, 0, 1.0, 3357.0, 1, 0, 0), (3355, 'VYBER', 'VYBER', 'default2', 'default1', 'VYBER', 'default1', 3357, 0, 3355.0, 3355, 3357.0, 3355.0, 3357, 3356, 3356), (2, 'default1', 'default2', 'default1', 'default1', 'default1', 'VYBER', 3356, 3356, 3356.0, 0, 3355.0, 3355.0, 1, 3355, 3355), (3, 'default2', 'default2', 'default2', 'default2', 'default1', 'default2', 3355, 0, 1.0, 1, 3355.0, 3355.0, 3355, 3355, 0), (4, 'default2', 'default2', 'default1', 'default2', 'VYBER', 'default2', 3356, 0, 1.0, 3356, 3356.0, 3357.0, 3357, 0, 3357);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 0, 'default1', '2023-01-01'), (3357, 0, 'VYBER', '2023-01-01'), (3355, 3, 'default2', '2023-01-02'), (1, 3356, 'default1', '2023-01-01'), (3356, 2, 'default1', '2023-01-01'), (2, 3356, 'default2', '2023-01-02'), (3, 1, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3355, 4, 'VYBER', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3355, 3355, '2023-01-01', 'default2', NULL, 3355, 3356, 'default2', 'VYBER', 1), (3357, 3355, '2023-01-02', 'VYBER', 'default1', 0, 3355, NULL, 'default2', NULL), (1, 3355, '2023-01-02', 'default1', 'VYBER', 3357, 3355, 'default1', NULL, 3356), (3356, 3355, '2023-01-01', 'default1', 'default1', 3357, 1, 'VYBER', 'default2', 3357), (0, 3355, '2023-01-02', 'VYBER', NULL, 3356, 0, 'default1', NULL, 0), (2, 3355, '2023-01-01', 'VYBER', 'default1', 3355, 3357, 'default1', 'default1', NULL), (3, 3355, '2023-01-02', 'default2', NULL, 1, 3356, 'default2', NULL, 0), (4, 3355, '2023-01-02', 'default2', 'default1', 3356, 3357, NULL, 'default2', NULL);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (3355, 3355, 3356, 'default2'), (3357, 3355, 3357, 'default1'), (0, 3355, 1, 'default2'), (3356, 3355, 1, 'default2'), (1, 3355, 3, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.trans_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN trans AS T4 ON T3.account_id = T4.account_id WHERE T1.client_id = 3356 AND T4.operation = 'VYBER';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT operation FROM trans WHERE account_id IN (SELECT account_id FROM disp WHERE client_id = 3356) AND operation = 'VYBER';

/*
Prediction Result:
('VYBER',)
*/