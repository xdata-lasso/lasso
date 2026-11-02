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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (99, 'default2', 'default1', 'M', 'default2', 'M', 'POPLATEK TYDNE', 2, 99, 99.0, 1, 101.0, 1.0, 99, 0, 101), (2, 'default1', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'default1', 1, 2, 101.0, 1, 0.0, 1.0, 100, 99, 101), (101, 'default2', 'M', 'POPLATEK TYDNE', 'M', 'M', 'M', 1, 99, 99.0, 0, 2.0, 1.0, 99, 0, 101), (0, 'default2', 'default2', 'default1', 'M', 'M', 'POPLATEK TYDNE', 0, 100, 1.0, 2, 100.0, 2.0, 99, NULL, 1), (100, 'default2', 'default2', 'M', 'M', 'M', 'M', 101, 99, 101.0, 2, 1.0, 1.0, 2, NULL, 0), (1, 'M', 'default2', 'POPLATEK TYDNE', 'POPLATEK TYDNE', 'M', 'M', 101, 0, 0.0, 101, 0.0, 101.0, 100, 0, 1), (3, 'default2', 'M', 'default2', 'POPLATEK TYDNE', 'M', 'default1', 100, 1, 2.0, 0, 99.0, 100.0, 99, 99, 99), (4, 'default1', 'default2', 'POPLATEK TYDNE', 'default2', 'default2', 'M', 100, 101, 99.0, 1, 2.0, 99.0, 100, 2, 2), (5, 'default1', 'default1', 'default1', 'default2', 'POPLATEK TYDNE', 'M', 1, 2, 1.0, 2, 101.0, 100.0, 101, 100, 99);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (100, 5, 'POPLATEK TYDNE', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 101, 'M', '2023-01-02'), (1, 4, 'POPLATEK TYDNE', '2023-01-01'), (99, 99, 'default1', '2023-01-01'), (0, 3, 'M', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (100, 0, 100, 'POPLATEK TYDNE'), (1, 99, 100, 'M'), (0, 99, 100, 'M'), (101, 1, 100, 'M');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (CAST(COUNT(CASE WHEN c.gender = 'M' THEN 1 END) AS REAL) * 100.0 / COUNT(c.client_id)) AS percentage_male FROM client AS c INNER JOIN disp AS d ON c.client_id = d.client_id INNER JOIN account AS a ON d.account_id = a.account_id WHERE a.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(0.0,)
*/