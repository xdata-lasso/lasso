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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (2, 'default1', 'default1', 'default2', 'default2', 'F', 'default2', -1, 10001, 10000.0, 100, NULL, 9999.0, 10000, 99, 101), (101, 'F', 'default2', 'default2', 'default2', 'F', 'default1', 2, 0, 9999.0, 10001, 10000.0, 2.0, 1, 10001, -1), (1, 'default1', 'default1', 'F', 'default1', 'F', 'default2', 2, 10000, 9999.0, -1, 99.0, 10000.0, 99, 100, 99), (0, 'default2', 'default2', 'default1', 'default2', 'default2', 'default1', 9999, 10001, 10000.0, -1, 10000.0, 2.0, 1, NULL, -1), (10000, 'F', 'F', 'default2', 'F', 'F', 'default1', 10001, 2, 2.0, 1, 100.0, 0.0, 10000, 1, -1), (10001, 'default2', 'F', 'default2', 'F', 'default2', 'default2', 100, -1, 9999.0, 0, -1.0, 100.0, 10000, 101, 9999), (-1, 'default2', 'default2', 'F', 'default1', 'F', 'F', -1, 100, 1.0, 2, -1.0, 99.0, 100, 10000, 0), (9999, 'default1', 'default1', 'default2', 'default1', 'F', 'F', 10001, 99, 2.0, 10001, 1.0, 99.0, -1, 0, 10000), (100, 'default2', 'F', 'default2', 'default2', 'default2', 'F', 99, 10001, 101.0, 9999, 10000.0, 1.0, 0, 100, 100), (99, 'default2', 'default2', 'default2', 'F', 'F', 'default2', 10000, -1, 1.0, 99, 99.0, -1.0, 99, 99, 99), (3, 'F', 'F', 'default1', 'F', 'default1', 'default2', -1, 9999, -1.0, 100, 99.0, 9999.0, 0, 9999, 99), (4, 'F', 'default2', 'default2', 'default1', 'default2', 'F', 100, 0, 99.0, 1, 0.0, 10001.0, 99, 101, 101), (5, 'default1', 'default1', 'default2', 'default2', 'F', 'default1', 99, 101, 101.0, 9999, NULL, 10000.0, 10000, 9999, 9999), (6, 'F', 'default1', 'default1', 'F', 'default1', 'default1', 0, 9999, 101.0, -1, NULL, 99.0, 10000, 9999, -1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (10000, 10001, 'default1', '2023-01-01'), (9999, 5, 'default1', '2023-01-01'), (1, 6, 'F', '2023-01-01'), (100, 101, 'default1', '2023-01-01'), (0, 10001, 'F', '2023-01-02'), (-1, 1, 'default2', '2023-01-01'), (101, -1, 'default1', '2023-01-02'), (10001, 10000, 'default2', '2023-01-01'), (99, 4, 'F', '2023-01-01'), (2, 99, 'default1', '2023-01-02'), (3, 5, 'default1', '2023-01-01'), (4, 1, 'default2', '2023-01-02'), (5, 1, 'default1', '2023-01-02'), (6, 2, 'default2', '2023-01-02'), (7, 0, 'F', '2023-01-01'), (8, 9999, 'default1', '2023-01-02'), (9, 2, 'F', '2023-01-02'), (10, 5, 'default2', '2023-01-02'), (11, 0, 'default2', '2023-01-02'), (12, 5, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 2, 'default1', '2023-01-01'), (99, 1, 'F', '2023-01-02'), (100, 100, 'F', '2023-01-01'), (-1, 2, 'default2', '2023-01-02'), (10001, 4, 'F', '2023-01-01'), (10000, 9999, 'default2', '2023-01-01'), (101, 99, 'default1', '2023-01-02'), (2, 10001, 'F', '2023-01-02'), (0, 10001, 'F', '2023-01-02'), (9999, 99, 'default1', '2023-01-02'), (3, 99, 'default1', '2023-01-02'), (4, 5, 'F', '2023-01-02'), (5, 99, 'default1', '2023-01-02'), (6, 1, 'F', '2023-01-02'), (7, 9999, 'F', '2023-01-02'), (8, 2, 'default2', '2023-01-02'), (9, 3, 'default1', '2023-01-02'), (10, 9999, 'default1', '2023-01-02'), (11, 3, 'default2', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 99, -1, 'F'), (-1, 10, 101, 'F'), (9999, 100, 99, 'F'), (1, 101, 10000, 'default2'), (100, 10001, 7, 'default2'), (10001, 11, 99, 'default2'), (10000, 100, -1, 'default2'), (99, 5, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) * 100 / COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A11 > 10000;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN c.gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS women_percentage FROM district AS d JOIN client AS c ON d.district_id = c.district_id JOIN disp AS disp ON c.client_id = disp.client_id JOIN account AS a ON disp.account_id = a.account_id WHERE d.A11 > 10000;

/*
Prediction Result:
(None,)
*/