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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'default2', 'default1', 'default2', 'default1', 'default1', 0, 0, 1.0, 1, 1.0, 0.0, 0, 0, 0), (0, 'default1', 'F', 'Jesenik', 'default2', 'default1', 'Jesenik', 0, 1, 0.0, 0, 0.0, 0.0, 0, NULL, 0), (2, 'default2', 'F', 'default2', 'Jesenik', 'Jesenik', 'Jesenik', 0, 0, 0.0, 0, NULL, 0.0, 0, NULL, 0), (3, 'F', 'Jesenik', 'default2', 'default2', 'default1', 'default2', 0, 0, 1.0, 1, NULL, 0.0, 0, 0, 1), (4, 'default1', 'Jesenik', 'F', 'Jesenik', 'F', 'F', 1, 0, 0.0, 1, 1.0, 1.0, 0, NULL, 1), (5, 'default1', 'F', 'default1', 'default2', 'Jesenik', 'default1', 1, 1, 1.0, 1, NULL, 1.0, 0, NULL, 0), (6, 'default2', 'default1', 'Jesenik', 'F', 'F', 'Jesenik', 0, 0, 1.0, 0, 0.0, 0.0, 0, NULL, 1), (7, 'Jesenik', 'Jesenik', 'default1', 'default1', 'Jesenik', 'default1', 0, 1, 1.0, 1, NULL, 0.0, 1, 0, 1), (8, 'Jesenik', 'Jesenik', 'default2', 'default1', 'default2', 'default1', 1, 1, 1.0, 1, 0.0, 0.0, 0, 1, 0), (9, 'F', 'Jesenik', 'default1', 'F', 'Jesenik', 'F', 0, 1, 1.0, 1, NULL, 1.0, 0, 1, 1), (10, 'F', 'F', 'default2', 'Jesenik', 'default2', 'Jesenik', 0, 0, 1.0, 0, 1.0, 1.0, 0, 0, 1), (11, 'F', 'F', 'default2', 'Jesenik', 'F', 'F', 1, 1, 1.0, 0, 0.0, 0.0, 1, NULL, 1), (12, 'F', 'F', 'default2', 'Jesenik', 'default2', 'default2', 0, 1, 1.0, 0, 1.0, 0.0, 0, 0, 0), (13, 'default1', 'Jesenik', 'default1', 'default2', 'default1', 'default2', 0, 0, 1.0, 0, 0.0, 0.0, 0, 1, 0), (14, 'F', 'F', 'default1', 'F', 'F', 'default1', 0, 0, 0.0, 1, 1.0, 1.0, 0, 1, 1), (15, 'default1', 'Jesenik', 'default2', 'Jesenik', 'default1', 'Jesenik', 0, 0, 0.0, 0, 1.0, 1.0, 0, 0, 0), (16, 'Jesenik', 'default2', 'default1', 'F', 'default2', 'F', 0, 1, 1.0, 0, 1.0, 1.0, 1, NULL, 1), (17, 'default2', 'default2', 'default2', 'F', 'F', 'default1', 0, 1, 0.0, 1, NULL, 0.0, 0, NULL, 1), (18, 'default2', 'default1', 'F', 'Jesenik', 'F', 'Jesenik', 0, 0, 1.0, 1, 0.0, 1.0, 0, 1, 1), (19, 'default2', 'F', 'default1', 'Jesenik', 'Jesenik', 'default1', 0, 1, 0.0, 1, 1.0, 1.0, 0, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 9, 'Jesenik', '2023-01-01'), (1, 15, 'F', '2023-01-02'), (2, 3, 'default1', '2023-01-02'), (3, 11, 'default2', '2023-01-01'), (4, 15, 'default2', '2023-01-01'), (5, 3, 'Jesenik', '2023-01-02'), (6, 17, 'default1', '2023-01-01'), (7, 4, 'default2', '2023-01-01'), (8, 4, 'F', '2023-01-02'), (9, 0, 'Jesenik', '2023-01-01'), (10, 15, 'default1', '2023-01-02'), (11, 0, 'Jesenik', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 13, 'default2', '2023-01-02'), (0, 7, 'default1', '2023-01-01'), (2, 12, 'Jesenik', '2023-01-02'), (3, 2, 'Jesenik', '2023-01-01'), (4, 15, 'default2', '2023-01-02'), (5, 9, 'F', '2023-01-01'), (6, 9, 'F', '2023-01-01'), (7, 9, 'default1', '2023-01-01'), (8, 16, 'default2', '2023-01-02'), (9, 10, 'default2', '2023-01-02'), (10, 19, 'F', '2023-01-01'), (11, 13, 'F', '2023-01-02'), (12, 4, 'default2', '2023-01-01'), (13, 19, 'default1', '2023-01-02'), (14, 5, 'default1', '2023-01-02'), (15, 9, 'Jesenik', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 12, 4, 'default2'), (0, 3, 0, 'F'), (2, 12, 0, 'default2'), (3, 3, 10, 'Jesenik'), (4, 11, 6, 'F'), (5, 8, 8, 'F'), (6, 1, 7, 'default1'), (7, 10, 4, 'default1'), (8, 15, 3, 'default2'), (9, 0, 10, 'default2'), (10, 11, 3, 'default1'), (11, 14, 6, 'F'), (12, 6, 4, 'default1'), (13, 9, 5, 'F'), (14, 1, 6, 'F'), (15, 4, 8, 'default2'), (16, 13, 10, 'Jesenik'), (17, 4, 6, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' AND T2.A2 = 'Jesenik';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T1.gender = 'F' AND T4.A2 = 'Jesenik';

/*
Prediction Result:
(1,)
*/