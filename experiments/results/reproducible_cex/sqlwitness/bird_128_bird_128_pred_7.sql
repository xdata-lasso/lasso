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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (8, 'default2', 'F', 'default2', 'default1', 'F', 'default2', 11, 9, 10.0, 0, 1.0, 0.0, 8, 9, 9), (10, 'default1', 'F', 'default2', 'F', 'F', 'default1', 9, 8, 10.0, 11, 1.0, 10.0, 0, 10, 1), (11, 'default1', 'F', 'default2', 'default2', 'F', 'default2', 10, 10, 1.0, 11, NULL, 11.0, 8, 9, 10), (9, 'default1', 'F', 'default1', 'default2', 'default1', 'default1', 11, 11, 9.0, 1, 8.0, 10.0, 1, 9, 11), (1, 'default2', 'default2', 'F', 'F', 'default1', 'default2', 8, 11, 8.0, 10, 9.0, 8.0, 1, 0, 8), (0, 'default2', 'default1', 'default1', 'default1', 'F', 'F', 0, 1, 8.0, 1, 8.0, 8.0, 1, 1, 11), (2, 'F', 'default2', 'F', 'default2', 'F', 'default2', 8, 11, 10.0, 8, 9.0, 1.0, 1, 0, 10), (3, 'default1', 'default2', 'F', 'default2', 'default2', 'F', 11, 11, 10.0, 8, 9.0, 10.0, 9, NULL, 9), (4, 'default1', 'default2', 'default1', 'default2', 'F', 'F', 10, 8, 10.0, 10, NULL, 9.0, 8, 11, 0), (5, 'default2', 'default2', 'F', 'F', 'F', 'F', 0, 8, 11.0, 11, 8.0, 0.0, 10, 10, 10), (6, 'default2', 'default2', 'default2', 'default1', 'default1', 'default2', 0, 8, 1.0, 1, 1.0, 8.0, 8, 10, 10), (7, 'default1', 'default2', 'default1', 'F', 'F', 'default1', 0, 11, 1.0, 1, 11.0, 8.0, 8, 10, 1), (12, 'default2', 'default1', 'default1', 'default1', 'F', 'default2', 8, 0, 0.0, 1, 9.0, 1.0, 10, 9, 11), (13, 'F', 'default2', 'F', 'default2', 'default2', 'F', 11, 10, 11.0, 8, 9.0, 8.0, 0, 8, 11), (14, 'F', 'default2', 'default1', 'default2', 'F', 'default2', 10, 9, 10.0, 11, 9.0, 11.0, 9, 10, 1), (15, 'F', 'default2', 'default2', 'F', 'default1', 'F', 8, 0, 11.0, 9, 8.0, 1.0, 1, 1, 8), (16, 'F', 'default1', 'default2', 'default1', 'F', 'F', 11, 1, 9.0, 9, 8.0, 8.0, 9, 1, 9), (17, 'F', 'default1', 'default2', 'default1', 'F', 'F', 9, 9, 8.0, 1, 9.0, 1.0, 11, 11, 11);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (8, 16, 'default2', '2023-01-01'), (0, 15, 'F', '2023-01-01'), (9, 2, 'F', '2023-01-01'), (10, 1, 'default2', '2023-01-02'), (1, 14, 'default1', '2023-01-02'), (11, 3, 'default2', '2023-01-02'), (2, 10, 'default1', '2023-01-02'), (3, 15, 'default2', '2023-01-02'), (4, 4, 'default1', '2023-01-01'), (5, 0, 'default1', '2023-01-02'), (6, 2, 'default1', '2023-01-02'), (7, 12, 'default2', '2023-01-02'), (12, 2, 'default1', '2023-01-01'), (13, 4, 'default2', '2023-01-02'), (14, 2, 'default2', '2023-01-01'), (15, 15, 'default2', '2023-01-01'), (16, 1, 'F', '2023-01-02'), (17, 11, 'F', '2023-01-01'), (18, 10, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 4, 'default1', '2023-01-01'), (11, 12, 'default2', '2023-01-01'), (8, 2, 'default2', '2023-01-01'), (1, 4, 'F', '2023-01-01'), (9, 10, 'default1', '2023-01-02'), (10, 4, 'F', '2023-01-01'), (2, 2, 'default2', '2023-01-02'), (3, 3, 'F', '2023-01-01'), (4, 6, 'default1', '2023-01-01'), (5, 13, 'default2', '2023-01-02'), (6, 5, 'F', '2023-01-02'), (7, 10, 'default2', '2023-01-02'), (12, 1, 'default1', '2023-01-02'), (13, 6, 'default1', '2023-01-01'), (14, 15, 'F', '2023-01-02'), (15, 4, 'default2', '2023-01-01'), (16, 12, 'F', '2023-01-01'), (17, 6, 'default2', '2023-01-01'), (18, 2, 'F', '2023-01-02'), (19, 14, 'default2', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (9, 17, 'F', 11, 1.0, 'default1'), (11, 4, 'default1', 0, 10.0, 'default1'), (10, 19, 'default2', 8, 8.0, 'default2'), (8, 1, 'default1', 8, 1.0, 'default2'), (1, 8, 'F', 11, 1.0, 'default1'), (0, 4, 'default1', 10, 9.0, 'F'), (2, 1, 'default1', 9, 11.0, 'default1'), (3, 3, 'default1', 10, 8.0, 'default2'), (4, 18, 'default2', 9, 9.0, 'default2'), (5, 4, 'F', 8, 10.0, 'default2'), (6, 8, 'default2', 1, 8.0, 'default1'), (7, 12, 'default2', 10, 8.0, 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('F', 1)
('F', 1)
('default1', 1)
('default2', 1)
*/

-- Prediction Query
SELECT T1.A2, COUNT(T2.client_id) AS num_female_account_holders FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' GROUP BY T1.A2 ORDER BY num_female_account_holders DESC, T1.A2 NULLS LAST LIMIT 9;

/*
Prediction Result:
('F', 2)
('default1', 1)
('default2', 1)
*/