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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default1', 'OWNER', 'OWNER', 'default2', 'default2', 'POPLATEK TYDNE', 1, 0, 0.0, 1, 1.0, 1.0, 0, 1, 1), (0, 'POPLATEK TYDNE', 'OWNER', 'Owner', 'default1', 'POPLATEK TYDNE', 'default2', 0, 0, 1.0, 0, 0.0, 1.0, 0, 0, 1), (2, 'POPLATEK TYDNE', 'default2', 'Owner', 'POPLATEK TYDNE', 'default2', 'default1', 1, 0, 1.0, 1, NULL, 0.0, 1, 1, 1), (3, 'POPLATEK TYDNE', 'Owner', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 'default2', 1, 1, 1.0, 0, NULL, 0.0, 0, NULL, 1), (4, 'Owner', 'POPLATEK TYDNE', 'default2', 'Owner', 'Owner', 'POPLATEK TYDNE', 1, 1, 0.0, 0, 0.0, 1.0, 1, NULL, 1), (5, 'Owner', 'OWNER', 'default1', 'default1', 'default2', 'default1', 0, 0, 1.0, 0, 0.0, 1.0, 1, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 2, 'Owner', '2023-01-02'), (1, 2, 'OWNER', '2023-01-02'), (2, 3, 'OWNER', '2023-01-01'), (3, 2, 'default2', '2023-01-02'), (4, 5, 'Owner', '2023-01-01'), (5, 3, 'default2', '2023-01-02'), (6, 3, 'POPLATEK TYDNE', '2023-01-01'), (7, 2, 'OWNER', '2023-01-01'), (8, 2, 'Owner', '2023-01-02'), (9, 3, 'OWNER', '2023-01-02'), (10, 2, 'OWNER', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'default2', '2023-01-02'), (0, 3, 'POPLATEK TYDNE', '2023-01-02'), (2, 5, 'default2', '2023-01-02'), (3, 2, 'Owner', '2023-01-01'), (4, 4, 'OWNER', '2023-01-01'), (5, 5, 'OWNER', '2023-01-01'), (6, 0, 'POPLATEK TYDNE', '2023-01-01'), (7, 3, 'OWNER', '2023-01-01'), (8, 1, 'default1', '2023-01-02'), (9, 1, 'OWNER', '2023-01-01'), (10, 1, 'OWNER', '2023-01-02'), (11, 4, 'OWNER', '2023-01-02'), (12, 5, 'default1', '2023-01-01'), (13, 1, 'OWNER', '2023-01-02'), (14, 2, 'Owner', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 2, 6, 'default1'), (0, 3, 1, 'POPLATEK TYDNE'), (2, 1, 4, 'Owner'), (3, 12, 7, 'OWNER'), (4, 4, 8, 'OWNER'), (5, 8, 0, 'default2'), (6, 1, 1, 'Owner'), (7, 0, 1, 'default1'), (8, 6, 8, 'OWNER'), (9, 12, 1, 'POPLATEK TYDNE'), (10, 11, 3, 'POPLATEK TYDNE'), (11, 13, 1, 'POPLATEK TYDNE'), (12, 5, 6, 'POPLATEK TYDNE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T2.type = 'Owner' AND T1.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'OWNER';

/*
Prediction Result:
(1,)
*/