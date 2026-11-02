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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'Prague', 'default2', 'default2', 'F', 'default1', 1, 101, 1.0, 0, 100.0, 100.0, 101, NULL, 100), (2, 'Prague', 'Prague', 'F', 'default1', 'default2', 'F', 1, 2, 1.0, 100, 101.0, 1.0, 1, -1, 2), (100, 'Prague', 'default1', 'default2', 'default2', 'Prague', 'F', 0, 101, 99.0, 101, 0.0, -1.0, -1, NULL, 99), (-1, 'Prague', 'default1', 'F', 'default2', 'default2', 'default1', -1, 2, 101.0, 99, 2.0, 2.0, 99, 99, -1), (1, 'default2', 'Prague', 'default2', 'default1', 'Prague', 'default1', 0, 1, 100.0, 0, NULL, 1.0, 99, 2, 101), (99, 'Prague', 'F', 'Prague', 'default1', 'Prague', 'F', 100, 0, 1.0, -1, -1.0, 101.0, 1, 101, 2);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 2, 'F', '2023-01-02'), (-1, 100, 'default1', '2023-01-01'), (2, 99, 'default1', '2023-01-02'), (99, 1, 'F', '2023-01-02'), (0, 2, 'Prague', '2023-01-02'), (100, 99, 'default1', '2023-01-01'), (101, 0, 'default2', '2023-01-02'), (3, 2, 'default2', '2023-01-02'), (4, 2, 'Prague', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 99, 'default1', '2023-01-02'), (1, 1, 'F', '2023-01-02'), (-1, 0, 'F', '2023-01-01'), (0, 1, 'F', '2023-01-02'), (101, 1, 'F', '2023-01-01'), (99, -1, 'default1', '2023-01-02'), (100, 0, 'default1', '2023-01-02'), (3, 1, 'default2', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (100, 2, -1, 'Prague'), (-1, 0, 101, 'Prague'), (0, 100, 3, 'Prague'), (101, 100, 0, 'Prague'), (1, 0, 100, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) / COUNT(T2.client_id) * 100 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'Prague';

/*
Gold Result:
(33.33333333333333,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T4.A3 = 'Prague';

/*
Prediction Result:
(0.0,)
*/