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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'OWNER', 'OWNER', 'OWNER', 'default2', 'OWNER', 'USER', 0, 1, 0.0, 1, 0.0, 0.0, 0, 1, 1), (1, 'default2', 'default2', 'USER', 'OWNER', 'USER', 'default2', 1, 0, 0.0, 1, NULL, 0.0, 1, 0, 0), (2, 'OWNER', 'USER', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default1', 1, 1, 0.0, 0, 1.0, 1.0, 0, 0, 0), (3, 'OWNER', 'OWNER', 'OWNER', 'POPLATEK TYDNE', 'USER', 'USER', 1, 1, 0.0, 1, NULL, 0.0, 1, 1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 0, 'default2', '2023-01-02'), (1, 1, 'USER', '2023-01-02'), (2, 1, 'OWNER', '2023-01-02'), (3, 0, 'USER', '2023-01-02'), (4, 2, 'OWNER', '2023-01-02'), (5, 2, 'OWNER', '2023-01-01'), (6, 3, 'POPLATEK TYDNE', '2023-01-02'), (7, 2, 'default1', '2023-01-02'), (8, 2, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 1, 'default1', '2023-01-02'), (1, 2, 'OWNER', '2023-01-02'), (2, 0, 'OWNER', '2023-01-01'), (3, 1, 'default2', '2023-01-02'), (4, 0, 'default2', '2023-01-02'), (5, 3, 'POPLATEK TYDNE', '2023-01-01'), (6, 2, 'default1', '2023-01-02'), (7, 1, 'default2', '2023-01-02'), (8, 3, 'default1', '2023-01-01'), (9, 1, 'POPLATEK TYDNE', '2023-01-02'), (10, 3, 'default2', '2023-01-02'), (11, 3, 'default2', '2023-01-01'), (12, 1, 'USER', '2023-01-01'), (13, 1, 'POPLATEK TYDNE', '2023-01-02'), (14, 1, 'USER', '2023-01-02'), (15, 0, 'POPLATEK TYDNE', '2023-01-02'), (16, 3, 'default2', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 3, 6, 'POPLATEK TYDNE'), (1, 8, 2, 'default2'), (2, 12, 3, 'OWNER'), (3, 9, 7, 'OWNER'), (4, 7, 2, 'OWNER'), (5, 6, 3, 'USER'), (6, 5, 3, 'default1'), (7, 8, 7, 'default1'), (8, 10, 4, 'POPLATEK TYDNE'), (9, 16, 8, 'POPLATEK TYDNE'), (10, 6, 7, 'default1'), (11, 10, 0, 'OWNER'), (12, 8, 2, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T2.account_id = T1.account_id WHERE T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'USER';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id WHERE account.frequency = 'POPLATEK TYDNE' AND disp.type = 'OWNER';

/*
Prediction Result:
(1,)
*/