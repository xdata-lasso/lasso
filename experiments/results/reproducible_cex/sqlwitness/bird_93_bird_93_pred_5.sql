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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'M', 'default2', 'north Bohemia', 'North Bohemia', 'north Bohemia', 'default1', 0, 8001, 8001.0, 1, NULL, 8000.0, 8001, 0, 8001), (7999, 'default1', 'default2', 'default2', 'default1', 'default1', 'North Bohemia', 1, 0, 1.0, 8001, 7999.0, 8001.0, 7999, 0, 7999), (8001, 'North Bohemia', 'north Bohemia', 'North Bohemia', 'north Bohemia', 'M', 'M', 7999, 0, 0.0, 7999, 1.0, 0.0, 7999, 7999, 8000), (8000, 'default1', 'default1', 'default1', 'default1', 'north Bohemia', 'default2', 8001, 1, 1.0, 8001, 1.0, 0.0, 7999, 1, 8001), (0, 'M', 'North Bohemia', 'north Bohemia', 'default2', 'default2', 'north Bohemia', 1, 0, 0.0, 8001, 7999.0, 8000.0, 7999, 8001, 1), (2, 'default2', 'default1', 'default1', 'default1', 'north Bohemia', 'M', 7999, 8000, 8001.0, 0, NULL, 8001.0, 0, 0, 7999), (3, 'North Bohemia', 'M', 'M', 'M', 'North Bohemia', 'default2', 1, 0, 7999.0, 7999, 8001.0, 1.0, 8001, NULL, 0), (4, 'M', 'North Bohemia', 'M', 'North Bohemia', 'north Bohemia', 'North Bohemia', 1, 8000, 7999.0, 1, 1.0, 8000.0, 7999, 8001, 1), (5, 'default2', 'north Bohemia', 'M', 'North Bohemia', 'default1', 'north Bohemia', 8000, 0, 8000.0, 8001, NULL, 0.0, 0, 8000, 8001);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 0, 'M', '2023-01-01'), (8001, 4, 'north Bohemia', '2023-01-01'), (8000, 8000, 'default2', '2023-01-02'), (0, 8000, 'M', '2023-01-02'), (7999, 8001, 'default2', '2023-01-01'), (2, 2, 'north Bohemia', '2023-01-01'), (3, 5, 'default1', '2023-01-02'), (4, 2, 'North Bohemia', '2023-01-01'), (5, 7999, 'North Bohemia', '2023-01-02'), (6, 8001, 'default2', '2023-01-02'), (7, 4, 'default2', '2023-01-02'), (8, 2, 'north Bohemia', '2023-01-02'), (9, 8000, 'north Bohemia', '2023-01-01'), (10, 8001, 'north Bohemia', '2023-01-01'), (11, 2, 'north Bohemia', '2023-01-01'), (12, 4, 'M', '2023-01-01'), (13, 1, 'north Bohemia', '2023-01-02'), (14, 8001, 'default1', '2023-01-02'), (15, 0, 'M', '2023-01-01'), (16, 1, 'default1', '2023-01-02'), (17, 4, 'north Bohemia', '2023-01-01'), (18, 3, 'North Bohemia', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A3 = 'North Bohemia' AND T2.A11 > 8000;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS count FROM client AS c INNER JOIN district AS d ON c.district_id = d.district_id WHERE c.gender = 'M' AND d.A3 = 'north Bohemia' AND d.A11 > 8000;

/*
Prediction Result:
(0,)
*/