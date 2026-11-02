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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (-1, 'default1', 'M', 'default2', 'default2', 'POPLATEK TYDNE', 'default1', 100, -1, 1.0, 101, 1.0, 100.0, -1, NULL, -1), (2, 'default1', 'M', 'M', 'M', 'default1', 'default1', 1, 2, 99.0, 99, 99.0, 100.0, 1, -1, -1), (1, 'default2', 'default1', 'M', 'M', 'default2', 'default1', 100, 1, -1.0, 0, NULL, 99.0, -1, 99, 0), (101, 'POPLATEK TYDNE', 'default2', 'POPLATEK TYDNE', 'default2', 'M', 'default1', 1, 1, 101.0, 2, -1.0, -1.0, 100, -1, 0), (100, 'M', 'M', 'M', 'default2', 'POPLATEK TYDNE', 'default2', 100, 100, 1.0, 0, 101.0, 0.0, 0, 1, 100), (99, 'default2', 'default1', 'default2', 'default1', 'default2', 'default1', 99, 99, -1.0, 2, 1.0, 100.0, 100, NULL, -1), (0, 'default2', 'default1', 'M', 'M', 'default2', 'default2', 100, 101, 1.0, 1, 100.0, 0.0, 2, 0, 1), (3, 'POPLATEK TYDNE', 'default1', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default1', 100, 2, 101.0, 101, 99.0, 99.0, 100, 1, 1), (4, 'default2', 'default1', 'default1', 'default2', 'default1', 'default2', 2, 101, 101.0, 100, 101.0, 1.0, -1, 0, 1), (5, 'POPLATEK TYDNE', 'default1', 'default1', 'M', 'M', 'default1', 1, 101, 99.0, 0, 2.0, 99.0, 1, NULL, 99), (6, 'M', 'default1', 'default2', 'M', 'POPLATEK TYDNE', 'default1', 2, 101, 100.0, 99, 0.0, 99.0, -1, 1, 100);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (101, 3, 'POPLATEK TYDNE', '2023-01-01'), (0, 2, 'default1', '2023-01-01'), (100, 2, 'POPLATEK TYDNE', '2023-01-01'), (-1, 99, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 1, 'POPLATEK TYDNE', '2023-01-01'), (101, 101, 'default1', '2023-01-02'), (99, 4, 'default1', '2023-01-02'), (0, 5, 'POPLATEK TYDNE', '2023-01-02'), (-1, 99, 'default1', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (2, 99, 100, 'default1'), (-1, 101, 101, 'default1'), (101, 0, 101, 'M'), (99, 99, 101, 'M'), (1, 100, 0, 'default2'), (100, 0, -1, 'M'), (0, 0, -1, 'default2'), (3, 101, 101, 'POPLATEK TYDNE'), (4, -1, 0, 'default2'), (5, 0, -1, 'POPLATEK TYDNE'), (6, 0, 101, 'default1'), (7, 101, 0, 'POPLATEK TYDNE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.gender = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id WHERE T3.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(0.0,)
*/