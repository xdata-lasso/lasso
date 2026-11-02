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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (-1, 'M', 'south Bohemia', 'default2', 'default1', 'M', 'default2', 1, 99, 2.0, -1, 101.0, 0.0, 100, NULL, 2), (1, 'M', 'default1', 'default2', 'south Bohemia', 'default1', 'default2', -1, -1, -1.0, 2, -1.0, 0.0, 1, 99, 101), (99, 'south Bohemia', 'south Bohemia', 'default1', 'M', 'default1', 'south Bohemia', 99, 101, 100.0, 0, 101.0, -1.0, 2, 0, 100), (2, 'south Bohemia', 'default1', 'M', 'M', 'south Bohemia', 'M', 1, 100, 2.0, 1, 0.0, 101.0, 2, 1, 0), (100, 'M', 'default2', 'default1', 'M', 'default1', 'M', 1, 0, 2.0, 100, 0.0, 99.0, -1, 100, 2), (101, 'default2', 'south Bohemia', 'default2', 'south Bohemia', 'M', 'default1', 0, 0, 101.0, 2, NULL, 1.0, 2, 99, -1), (0, 'south Bohemia', 'default1', 'default2', 'default1', 'M', 'default1', 101, 101, 99.0, 0, 1.0, 2.0, 101, 0, 2), (3, 'M', 'default1', 'M', 'M', 'default1', 'M', 0, 0, 99.0, 2, 0.0, 101.0, 2, 99, 0), (4, 'M', 'default2', 'default1', 'default2', 'M', 'south Bohemia', -1, 1, 101.0, 1, NULL, 100.0, 0, 101, 2), (5, 'south Bohemia', 'default1', 'default2', 'default1', 'south Bohemia', 'M', 101, 100, -1.0, 100, 2.0, -1.0, -1, NULL, 99), (6, 'default2', 'M', 'south Bohemia', 'M', 'default1', 'default2', 100, 0, 99.0, -1, 101.0, 1.0, 101, 0, 0), (7, 'south Bohemia', 'default2', 'M', 'M', 'default1', 'M', 0, -1, 0.0, 1, 0.0, 0.0, 2, 2, 2), (8, 'default1', 'M', 'default1', 'M', 'south Bohemia', 'default2', 101, 0, 99.0, 2, 99.0, -1.0, 0, NULL, -1), (9, 'south Bohemia', 'default1', 'south Bohemia', 'M', 'M', 'south Bohemia', 99, 100, 1.0, 2, 2.0, 0.0, 1, 99, 101), (10, 'default1', 'south Bohemia', 'M', 'default1', 'south Bohemia', 'south Bohemia', -1, 2, -1.0, 101, 1.0, 1.0, 2, -1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (99, 4, 'M', '2023-01-02'), (100, 9, 'default1', '2023-01-01'), (2, 8, 'south Bohemia', '2023-01-02'), (1, 8, 'M', '2023-01-01'), (0, 101, 'default1', '2023-01-01'), (-1, 4, 'M', '2023-01-01'), (101, 5, 'default1', '2023-01-01'), (3, 5, 'south Bohemia', '2023-01-02'), (4, 8, 'M', '2023-01-01'), (5, 5, 'default1', '2023-01-01'), (6, -1, 'M', '2023-01-02'), (7, 9, 'south Bohemia', '2023-01-02'), (8, 0, 'default1', '2023-01-02'), (9, -1, 'south Bohemia', '2023-01-02'), (10, 1, 'default1', '2023-01-01'), (11, 4, 'M', '2023-01-01'), (12, 4, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (-1, 1, 'south Bohemia', '2023-01-02'), (1, 9, 'default2', '2023-01-02'), (0, 0, 'default1', '2023-01-02'), (100, 10, 'south Bohemia', '2023-01-01'), (99, 4, 'south Bohemia', '2023-01-01'), (101, 9, 'default2', '2023-01-02'), (2, 6, 'default2', '2023-01-01'), (3, 3, 'default2', '2023-01-02'), (4, 1, 'M', '2023-01-02'), (5, 4, 'default1', '2023-01-02'), (6, 2, 'default1', '2023-01-02'), (7, 0, 'default2', '2023-01-02'), (8, 99, 'south Bohemia', '2023-01-02'), (9, 7, 'M', '2023-01-01'), (10, -1, 'default1', '2023-01-02'), (11, 1, 'default1', '2023-01-01'), (12, 4, 'default2', '2023-01-01'), (13, 0, 'default1', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF(T2.gender = 'M', 1, 0)) AS REAL) * 100 / COUNT(T2.gender) AS percentage_male_clients FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'south Bohemia' GROUP BY T1.district_id ORDER BY T1.A4 DESC, percentage_male_clients NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/