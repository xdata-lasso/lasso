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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (100, 'default1', 'default1', 'default1', 'default1', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 0, 2, 100.0, 101, 1.0, 99.0, 99, NULL, 99), (1, 'default2', 'default2', 'default1', 'POPLATEK TYDNE', 'M', 'POPLATEK TYDNE', 1, 99, 2.0, 100, 101.0, 99.0, 0, 99, 101), (2, 'default2', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default1', 'POPLATEK TYDNE', 'default1', 0, 100, 100.0, 1, 101.0, 2.0, 101, 0, 0), (99, 'POPLATEK TYDNE', 'M', 'default1', 'default1', 'default1', 'default2', 99, 100, 100.0, 101, 1.0, 1.0, 2, 100, 2), (0, 'POPLATEK TYDNE', 'M', 'default2', 'default2', 'default2', 'POPLATEK TYDNE', 0, 0, 99.0, 1, 0.0, 1.0, 100, 0, 101), (101, 'POPLATEK TYDNE', 'default1', 'default2', 'POPLATEK TYDNE', 'default2', 'POPLATEK TYDNE', 99, 100, 1.0, 100, 100.0, 100.0, 1, 2, 2), (3, 'default1', 'default2', 'default1', 'POPLATEK TYDNE', 'default2', 'default1', 0, 101, 99.0, 2, NULL, 2.0, 101, 99, 2), (4, 'default1', 'default1', 'default2', 'default1', 'default1', 'M', 2, 99, 1.0, 100, 100.0, 0.0, 100, 99, 101), (5, 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 'POPLATEK TYDNE', 101, 101, 100.0, 99, 0.0, 2.0, 99, 100, 0), (6, 'default2', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default2', 'POPLATEK TYDNE', 1, 99, 101.0, 1, 2.0, 1.0, 100, 99, 100);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (100, 3, 'POPLATEK TYDNE', '2023-01-01'), (2, 4, 'default2', '2023-01-02'), (1, 99, 'default2', '2023-01-02'), (101, 100, 'default1', '2023-01-02'), (0, 99, 'default1', '2023-01-01'), (99, 100, 'default2', '2023-01-01'), (3, 5, 'default2', '2023-01-01'), (4, 3, 'M', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 101, 'POPLATEK TYDNE', '2023-01-02'), (1, 4, 'default2', '2023-01-02'), (100, 100, 'M', '2023-01-02'), (99, 6, 'default1', '2023-01-02'), (0, 1, 'M', '2023-01-02'), (101, 3, 'POPLATEK TYDNE', '2023-01-01'), (3, 100, 'default1', '2023-01-02'), (4, 100, 'default2', '2023-01-01'), (5, 4, 'M', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (99, 0, 3, 'POPLATEK TYDNE'), (0, 1, 0, 'M'), (2, 100, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN client.gender = 'M' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(*) AS percentage FROM account INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE account.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(None,)
*/