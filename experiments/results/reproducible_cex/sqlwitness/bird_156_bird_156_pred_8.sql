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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'OWNER', 'default2', 'OWNER', 'default1', 'default1', 'OWNER', 0, 2, 2.0, 1, 1.0, 1.0, 2, 1, 0), (2, 'default2', 'OWNER', 'default2', 'default1', 'default2', 'default2', 1, 2, 0.0, 2, 1.0, 1.0, 2, 0, 0), (1, 'default2', 'default1', 'OWNER', 'default1', 'OWNER', 'OWNER', 2, 0, 1.0, 0, 0.0, 2.0, 2, 0, 0), (3, 'OWNER', 'default1', 'OWNER', 'default2', 'OWNER', 'default1', 2, 0, 1.0, 1, NULL, 2.0, 2, 1, 2), (4, 'default2', 'default1', 'OWNER', 'default2', 'OWNER', 'default1', 0, 0, 2.0, 1, 0.0, 1.0, 0, 2, 2), (5, 'default1', 'default1', 'OWNER', 'OWNER', 'OWNER', 'default1', 1, 1, 2.0, 1, NULL, 1.0, 1, 0, 2), (6, 'OWNER', 'OWNER', 'default1', 'default2', 'OWNER', 'default2', 2, 1, 1.0, 0, 1.0, 1.0, 0, NULL, 1), (7, 'OWNER', 'default1', 'default2', 'default2', 'default1', 'default1', 2, 0, 0.0, 0, NULL, 0.0, 1, 1, 1), (8, 'default2', 'default1', 'OWNER', 'default2', 'OWNER', 'default1', 2, 1, 0.0, 2, 2.0, 2.0, 2, 0, 0), (9, 'default2', 'OWNER', 'default2', 'default2', 'default2', 'default2', 2, 1, 0.0, 0, 1.0, 2.0, 0, NULL, 0), (10, 'default2', 'OWNER', 'default1', 'default2', 'default1', 'default1', 1, 0, 2.0, 2, 2.0, 1.0, 1, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 6, 'default2', '2023-01-02'), (2, 7, 'default2', '2023-01-02'), (1, 8, 'default2', '2023-01-01'), (3, 7, 'OWNER', '2023-01-01'), (4, 2, 'default1', '2023-01-01'), (5, 8, 'default1', '2023-01-01'), (6, 2, 'default1', '2023-01-02'), (7, 2, 'OWNER', '2023-01-01'), (8, 4, 'default1', '2023-01-02'), (9, 4, 'OWNER', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 2, 'default1', '2023-01-02'), (0, 6, 'OWNER', '2023-01-02'), (2, 5, 'default1', '2023-01-02'), (3, 0, 'default2', '2023-01-02'), (4, 5, 'OWNER', '2023-01-02'), (5, 9, 'OWNER', '2023-01-01'), (6, 9, 'OWNER', '2023-01-02'), (7, 10, 'default1', '2023-01-02'), (8, 10, 'OWNER', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (2, 2, 'OWNER', 0, 0.0, 'default1'), (0, 2, 'default2', 0, 2.0, 'default1'), (1, 6, 'default2', 2, 0.0, 'default1'), (3, 1, 'default2', 2, 2.0, 'default1'), (4, 6, 'default2', 2, 1.0, 'OWNER'), (5, 0, 'default2', 1, 2.0, 'default2'), (6, 7, 'default1', 2, 0.0, 'OWNER'), (7, 5, 'OWNER', 0, 2.0, 'default1'), (8, 3, 'OWNER', 0, 0.0, 'default2'), (9, 8, 'default2', 1, 2.0, 'default1'), (10, 8, 'default1', 2, 2.0, 'default2'), (11, 3, 'default2', 2, 2.0, 'OWNER'), (12, 5, 'default2', 0, 0.0, 'default1');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 6, '2023-01-01', 0, 0, 2.0, 'OWNER'), (2, 5, '2023-01-01', 1, 0, 1.0, 'default1'), (0, 4, '2023-01-01', 1, 2, 0.0, 'OWNER'), (3, 4, '2023-01-02', 0, 0, 2.0, 'default2'), (4, 6, '2023-01-02', 0, 2, 0.0, 'OWNER');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 7, 4, 'default1'), (1, 1, 0, 'default2'), (2, 3, 6, 'default1'), (3, 2, 1, 'default2'), (4, 5, 8, 'default2'), (5, 1, 0, 'default1'), (6, 0, 1, 'default1'), (7, 4, 7, 'default2'), (8, 1, 5, 'OWNER'), (9, 7, 7, 'OWNER'), (10, 4, 9, 'default2'), (11, 3, 2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.client_id FROM account AS T1 JOIN loan AS T2 ON T1.account_id = T2.account_id JOIN disp AS T4 ON T1.account_id = T4.account_id JOIN client AS T3 ON T4.client_id = T3.client_id ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.loan_id NULLS LAST, T4.disp_id NULLS LAST, T3.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(7,)
*/