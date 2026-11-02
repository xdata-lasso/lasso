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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'Prague', 'default1', 'default1', 'default2', 'F', 'default2', -1, 0, 2.0, 101, 0.0, 0.0, 1, 100, 0), (99, 'default1', 'default1', 'default1', 'Prague', 'default2', 'default2', 101, 99, 0.0, 2, 2.0, 100.0, 0, 100, -1), (-1, 'Prague', 'default2', 'default1', 'Prague', 'F', 'default2', 99, 101, 1.0, -1, 99.0, 0.0, 100, 99, 1), (2, 'default1', 'default2', 'Prague', 'Prague', 'F', 'F', 1, -1, -1.0, 0, 0.0, 99.0, 101, NULL, 2), (1, 'F', 'default2', 'default2', 'Prague', 'F', 'default2', 99, 1, 1.0, 2, 101.0, 100.0, 99, 2, 0), (101, 'default1', 'F', 'Prague', 'F', 'Prague', 'default2', 2, 0, 100.0, 2, 101.0, 101.0, 100, 99, 101), (100, 'default2', 'Prague', 'F', 'Prague', 'F', 'default2', 0, 100, 2.0, -1, 1.0, -1.0, 1, 1, 101), (3, 'Prague', 'Prague', 'default1', 'F', 'default1', 'default2', 0, 101, 2.0, 1, 99.0, -1.0, -1, 0, -1), (4, 'Prague', 'F', 'default1', 'F', 'F', 'default2', 100, 100, 101.0, 100, 100.0, 1.0, 101, 99, -1), (5, 'F', 'default2', 'default2', 'F', 'F', 'default2', 0, 99, 2.0, -1, 100.0, 2.0, -1, 1, 99), (6, 'F', 'Prague', 'default1', 'F', 'default1', 'F', 101, 1, -1.0, 100, 0.0, -1.0, 2, 1, 1), (7, 'F', 'F', 'Prague', 'Prague', 'default1', 'default2', 2, 101, 100.0, 0, 0.0, 99.0, -1, 101, 99), (8, 'default2', 'F', 'Prague', 'default1', 'default1', 'default1', 99, 101, 99.0, 101, -1.0, 101.0, 101, 99, 2);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (2, 8, 'Prague', '2023-01-02'), (0, 100, 'F', '2023-01-01'), (-1, 100, 'default1', '2023-01-01'), (1, 3, 'default1', '2023-01-01'), (100, 0, 'F', '2023-01-01'), (101, 2, 'default1', '2023-01-01'), (99, -1, 'Prague', '2023-01-01'), (3, 2, 'F', '2023-01-02'), (4, 7, 'Prague', '2023-01-02'), (5, 6, 'Prague', '2023-01-02'), (6, 99, 'default1', '2023-01-01'), (7, 2, 'Prague', '2023-01-01'), (8, 4, 'Prague', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 99, 'F', '2023-01-01'), (99, 7, 'F', '2023-01-01'), (101, 100, 'Prague', '2023-01-01'), (100, 8, 'F', '2023-01-01'), (2, 4, 'Prague', '2023-01-02'), (-1, 99, 'F', '2023-01-01'), (1, 8, 'default1', '2023-01-01'), (3, 100, 'Prague', '2023-01-01'), (4, 3, 'Prague', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 4, 8, 'Prague'), (2, -1, 7, 'F'), (100, -1, 3, 'F'), (99, 99, 7, 'default1'), (0, 100, 2, 'F'), (-1, 3, 101, 'F'), (101, 3, 8, 'Prague'), (3, 0, 4, 'default1'), (4, 3, 3, 'F'), (5, 101, 99, 'F'), (6, 101, 99, 'default1'), (7, 99, 99, 'default1'), (8, -1, 7, 'default2'), (9, 100, 6, 'default1'), (10, -1, 4, 'default2'), (11, 1, -1, 'default2'), (12, 99, 101, 'Prague');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) / COUNT(T2.client_id) * 100 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'Prague';

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN t1.gender = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM client AS t1 INNER JOIN disp AS t2 ON t1.client_id = t2.client_id INNER JOIN district AS t3 ON t1.district_id = t3.district_id WHERE t3.a3 = 'Prague';

/*
Prediction Result:
(0.0,)
*/