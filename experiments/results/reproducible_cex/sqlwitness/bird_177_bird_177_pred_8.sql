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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (851, 'default2', 'default1', 'default1', 'default2', 'default2', 'default1', 1, 852, 3.0, 850, 4.0, 850.0, 852, NULL, 852);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (4, 851, 'default2', '2023-01-02'), (853, 851, 'default2', '2023-01-01'), (3, 851, 'default1', '2023-01-01'), (850, 851, 'default1', '2023-01-02'), (851, 851, 'default1', '2023-01-02'), (852, 851, 'default2', '2023-01-02'), (0, 851, 'default2', '2023-01-02'), (5, 851, 'default2', '2023-01-02'), (1, 851, 'default2', '2023-01-01'), (2, 851, 'default1', '2023-01-02'), (6, 851, 'default1', '2023-01-01'), (7, 851, 'default1', '2023-01-02'), (8, 851, 'default1', '2023-01-01'), (9, 851, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (5, 851, 'default2', '2023-01-01'), (852, 851, 'default2', '2023-01-01'), (1, 851, 'default2', '2023-01-02'), (4, 851, 'default2', '2023-01-02'), (3, 851, 'default2', '2023-01-02'), (853, 851, 'default2', '2023-01-02'), (0, 851, 'default2', '2023-01-02'), (850, 851, 'default1', '2023-01-02'), (851, 851, 'default1', '2023-01-02'), (2, 851, 'default1', '2023-01-01'), (6, 851, 'default2', '2023-01-02'), (7, 851, 'default2', '2023-01-02'), (8, 851, 'default1', '2023-01-01'), (9, 851, 'default1', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (4, 8, '2023-01-01', 'default1', 'default1', 853, 851, 'default2', 'default2', 0), (851, 852, '2023-01-02', 'default1', 'default1', 0, 852, 'default1', 'default2', 851);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (851, 9, 8, 'default1'), (852, 8, 851, 'default1'), (1, 9, 7, 'default1'), (850, 5, 7, 'default2'), (4, 852, 851, 'default1'), (3, 8, 9, 'default2'), (5, 6, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(852, 'default2')
*/

-- Prediction Query
SELECT T1.amount, T4.gender FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T2.account_id = T3.account_id INNER JOIN client AS T4 ON T3.client_id = T4.client_id WHERE T1.trans_id = 852 AND T2.district_id IN (SELECT district_id FROM client WHERE client_id = 4) AND T4.client_id = 4;

/*
Prediction Result:
*/