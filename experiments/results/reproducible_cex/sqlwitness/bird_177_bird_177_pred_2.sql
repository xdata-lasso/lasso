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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'default2', 'default2', 'default1', 'default1', 'default1', 851, 850, 0.0, 3, 852.0, 851.0, 850, 850, 850), (0, 'default2', 'default2', 'default2', 'default2', 'default1', 'default2', 5, 850, 852.0, 851, 3.0, 852.0, 5, 850, 852), (5, 'default1', 'default1', 'default2', 'default1', 'default2', 'default1', 852, 5, 3.0, 5, 852.0, 852.0, 3, 4, 852), (852, 'default1', 'default1', 'default2', 'default1', 'default2', 'default1', 3, 1, 850.0, 4, 3.0, 1.0, 0, 850, 852), (3, 'default2', 'default1', 'default1', 'default1', 'default1', 'default2', 851, 5, 0.0, 851, 850.0, 3.0, 3, 1, 1), (4, 'default1', 'default1', 'default2', 'default1', 'default2', 'default1', 3, 1, 4.0, 1, NULL, 4.0, 852, 1, 4), (850, 'default1', 'default1', 'default2', 'default1', 'default1', 'default1', 851, 852, 851.0, 850, 1.0, 3.0, 5, 850, 5), (851, 'default1', 'default2', 'default1', 'default1', 'default2', 'default1', 4, 1, 851.0, 0, NULL, 3.0, 4, 0, 1), (2, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1', 3, 851, 1.0, 3, 851.0, 0.0, 1, 852, 1), (6, 'default2', 'default2', 'default1', 'default2', 'default2', 'default2', 3, 0, 850.0, 4, 851.0, 5.0, 3, 850, 851), (7, 'default2', 'default1', 'default1', 'default2', 'default1', 'default1', 852, 5, 851.0, 850, 3.0, 0.0, 3, NULL, 0), (8, 'default1', 'default2', 'default2', 'default2', 'default2', 'default1', 3, 850, 4.0, 850, 0.0, 4.0, 0, 5, 1), (9, 'default2', 'default1', 'default1', 'default1', 'default2', 'default1', 850, 852, 1.0, 3, NULL, 852.0, 850, 4, 1), (10, 'default2', 'default2', 'default2', 'default1', 'default1', 'default2', 0, 3, 4.0, 852, 851.0, 0.0, 5, 5, 852), (11, 'default2', 'default2', 'default2', 'default2', 'default2', 'default2', 851, 850, 3.0, 851, 3.0, 851.0, 1, 852, 4), (12, 'default2', 'default1', 'default2', 'default2', 'default2', 'default2', 0, 851, 3.0, 3, 0.0, 4.0, 0, 5, 851);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 852, 'default1', '2023-01-02'), (852, 11, 'default1', '2023-01-02'), (4, 12, 'default2', '2023-01-02'), (851, 10, 'default2', '2023-01-02'), (0, 8, 'default2', '2023-01-01'), (3, 851, 'default1', '2023-01-01'), (5, 12, 'default1', '2023-01-01'), (850, 851, 'default2', '2023-01-02'), (2, 3, 'default1', '2023-01-02'), (6, 10, 'default1', '2023-01-02'), (7, 4, 'default1', '2023-01-01'), (8, 852, 'default1', '2023-01-02'), (9, 12, 'default2', '2023-01-02'), (10, 11, 'default2', '2023-01-01'), (11, 4, 'default1', '2023-01-01'), (12, 12, 'default1', '2023-01-01'), (13, 3, 'default2', '2023-01-01'), (14, 9, 'default1', '2023-01-02'), (15, 851, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 8, 'default2', '2023-01-02'), (850, 7, 'default2', '2023-01-02'), (852, 11, 'default1', '2023-01-01'), (851, 850, 'default2', '2023-01-01'), (4, 8, 'default2', '2023-01-02'), (5, 12, 'default1', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (5, 5, '2023-01-02', 'default2', 'default1', 1, 852, 'default1', 'default2', 0), (0, 851, '2023-01-02', 'default2', 'default1', 0, 852, 'default1', NULL, 4), (3, 850, '2023-01-01', 'default1', 'default2', 851, 1, 'default2', NULL, 0), (852, 850, '2023-01-02', 'default2', 'default2', 0, 3, 'default1', 'default1', 851), (851, 5, '2023-01-01', 'default1', NULL, 4, 851, NULL, 'default2', 5), (4, 851, '2023-01-02', 'default2', 'default1', 0, 3, 'default2', 'default2', 1), (850, 3, '2023-01-02', 'default1', NULL, 0, 0, NULL, 'default2', 1), (1, 3, '2023-01-01', 'default1', 'default2', 850, 1, 'default2', 'default2', 0), (2, 850, '2023-01-01', 'default1', NULL, 850, 1, NULL, 'default1', 3), (6, 4, '2023-01-01', 'default1', 'default2', 852, 4, 'default2', 'default2', 852), (7, 4, '2023-01-02', 'default1', NULL, 5, 851, 'default1', NULL, 4), (8, 3, '2023-01-02', 'default1', 'default2', 1, 1, 'default2', 'default2', 850), (9, 5, '2023-01-01', 'default1', 'default2', 4, 851, 'default2', 'default1', 3), (10, 4, '2023-01-01', 'default1', NULL, 850, 4, 'default2', NULL, 5), (11, 5, '2023-01-01', 'default1', NULL, 851, 3, NULL, 'default1', NULL), (12, 850, '2023-01-01', 'default2', 'default1', 4, 1, 'default1', NULL, 0), (13, 850, '2023-01-01', 'default2', 'default1', 5, 0, NULL, NULL, 1), (14, 4, '2023-01-01', 'default1', NULL, 4, 0, NULL, NULL, 850), (15, 850, '2023-01-02', 'default2', NULL, 5, 852, NULL, NULL, 851), (16, 4, '2023-01-01', 'default2', 'default1', 3, 852, NULL, 'default1', 852), (17, 850, '2023-01-01', 'default2', NULL, 850, 850, 'default2', NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.balance, T1.gender FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 4 AND T3.trans_id = 851;

/*
Gold Result:
(851, 'default2')
*/

-- Prediction Query
SELECT T1."balance", T3."gender" FROM "trans" AS T1 INNER JOIN "disp" AS T2 ON T1."account_id" = T2."account_id" INNER JOIN "client" AS T3 ON T2."client_id" = T3."client_id" WHERE T2."client_id" = 4 AND T1."trans_id" = 851;

/*
Prediction Result:
*/