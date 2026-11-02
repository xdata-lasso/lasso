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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (2, 'default1', 'M', 'default1', 'M', 'default2', 'default2', 1, 0, 2.0, 1, 0.0, 1.0, 2, NULL, 2), (1, 'default2', 'default1', 'default2', 'default2', 'M', 'default1', 1, 0, 2.0, 2, 1.0, 1.0, 1, 1, 1), (0, 'default1', 'M', 'default1', 'default2', 'M', 'default2', 1, 0, 1.0, 0, 2.0, 1.0, 2, 2, 1), (3, 'M', 'default1', 'default2', 'default2', 'M', 'default2', 1, 1, 0.0, 1, 1.0, 1.0, 2, 1, 2), (4, 'default2', 'default1', 'default2', 'default2', 'default1', 'M', 2, 1, 2.0, 0, NULL, 2.0, 2, 0, 1), (5, 'default2', 'default2', 'default2', 'default2', 'M', 'default2', 1, 1, 2.0, 1, 1.0, 0.0, 0, 0, 0), (6, 'default1', 'default2', 'default1', 'default1', 'default1', 'M', 2, 2, 0.0, 1, 0.0, 1.0, 2, 0, 1), (7, 'M', 'default2', 'M', 'default2', 'default2', 'M', 1, 0, 2.0, 2, 2.0, 1.0, 2, NULL, 2), (8, 'default2', 'default2', 'M', 'default1', 'default2', 'default2', 1, 0, 1.0, 1, 0.0, 0.0, 0, NULL, 1), (9, 'default1', 'M', 'M', 'M', 'default1', 'default2', 0, 2, 2.0, 0, 1.0, 2.0, 2, 0, 0), (10, 'default2', 'M', 'default1', 'M', 'M', 'M', 2, 1, 2.0, 2, 1.0, 1.0, 0, 0, 1), (11, 'M', 'M', 'default2', 'default1', 'default1', 'default1', 0, 2, 1.0, 2, 2.0, 2.0, 0, NULL, 2), (12, 'default2', 'M', 'M', 'default2', 'M', 'default1', 1, 0, 2.0, 0, 0.0, 2.0, 0, 0, 0), (13, 'default1', 'M', 'default2', 'M', 'M', 'default2', 0, 1, 1.0, 0, 2.0, 2.0, 2, 2, 1), (14, 'default2', 'default1', 'M', 'default1', 'default2', 'default2', 2, 1, 0.0, 0, 2.0, 0.0, 2, 0, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (2, 13, 'M', '2023-01-02'), (1, 12, 'M', '2023-01-01'), (0, 0, 'M', '2023-01-02'), (3, 8, 'M', '2023-01-01'), (4, 7, 'default1', '2023-01-01'), (5, 4, 'M', '2023-01-01'), (6, 9, 'default1', '2023-01-02'), (7, 5, 'M', '2023-01-02'), (8, 14, 'default1', '2023-01-02'), (9, 3, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 3, 'M', '2023-01-01'), (2, 10, 'default1', '2023-01-01'), (0, 3, 'M', '2023-01-01'), (3, 6, 'default1', '2023-01-02'), (4, 1, 'default2', '2023-01-01'), (5, 2, 'default2', '2023-01-01'), (6, 8, 'default1', '2023-01-02'), (7, 4, 'default2', '2023-01-01'), (8, 12, 'M', '2023-01-02'), (9, 12, 'default2', '2023-01-01'), (10, 5, 'M', '2023-01-01'), (11, 0, 'default1', '2023-01-02'), (12, 8, 'default1', '2023-01-01'), (13, 0, 'default2', '2023-01-02'), (14, 4, 'M', '2023-01-02'), (15, 7, 'default2', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 14, 'M', 1, 1.0, 'default1'), (0, 10, 'M', 1, 2.0, 'default2'), (2, 12, 'default1', 2, 0.0, 'M'), (3, 8, 'default1', 1, 2.0, 'M'), (4, 3, 'default1', 1, 2.0, 'M'), (5, 8, 'default2', 2, 1.0, 'default1'), (6, 5, 'default1', 1, 1.0, 'default1'), (7, 13, 'M', 2, 2.0, 'default2'), (8, 10, 'default2', 1, 2.0, 'default1'), (9, 6, 'M', 2, 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A15 = (SELECT T3.A15 FROM district AS T3 ORDER BY T3.A15 DESC, T3.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.gender) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A15 = (SELECT MAX(A15) FROM district WHERE A15 < (SELECT MAX(A15) FROM district)) AND T1.gender = 'M';

/*
Prediction Result:
(0,)
*/