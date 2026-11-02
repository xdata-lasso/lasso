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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (10, 'default1', 'F', 'F', 'default2', 'default2', 'default1', 0, 10, 8.0, 10, NULL, 9.0, 1, 1, 10), (11, 'F', 'default1', 'F', 'F', 'default1', 'F', 8, 0, 8.0, 10, 1.0, 11.0, 0, 1, 1), (1, 'F', 'F', 'default2', 'F', 'default2', 'default1', 9, 8, 1.0, 11, 8.0, 9.0, 0, 10, 10), (0, 'default2', 'default1', 'default2', 'default1', 'default1', 'F', 9, 8, 11.0, 10, 10.0, 9.0, 8, 9, 11), (9, 'default2', 'default2', 'default1', 'default1', 'default1', 'F', 0, 9, 9.0, 9, 9.0, 9.0, 9, 1, 10), (8, 'default1', 'default2', 'default1', 'default1', 'F', 'default1', 10, 10, 8.0, 0, 0.0, 8.0, 8, 0, 10), (2, 'F', 'F', 'default1', 'F', 'default1', 'default1', 11, 8, 9.0, 11, 11.0, 0.0, 1, 9, 10), (3, 'default2', 'F', 'default1', 'default1', 'default2', 'default1', 0, 1, 9.0, 11, 1.0, 0.0, 11, 8, 11), (4, 'default2', 'default2', 'default1', 'default1', 'default1', 'default2', 8, 0, 1.0, 8, 0.0, 10.0, 9, 10, 8), (5, 'F', 'F', 'default1', 'default2', 'default2', 'F', 0, 10, 10.0, 1, 0.0, 11.0, 1, 10, 9), (6, 'F', 'default1', 'default1', 'F', 'default2', 'default2', 11, 11, 0.0, 0, NULL, 0.0, 9, 10, 11), (7, 'default2', 'default1', 'F', 'F', 'F', 'default1', 9, 1, 1.0, 8, 8.0, 8.0, 9, 0, 11), (12, 'default1', 'default2', 'default1', 'default2', 'default1', 'F', 8, 10, 0.0, 1, 9.0, 0.0, 1, 8, 10), (13, 'F', 'F', 'default1', 'default2', 'default1', 'default1', 11, 0, 10.0, 1, 1.0, 1.0, 1, 9, 8);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (11, 1, 'default2', '2023-01-01'), (1, 9, 'F', '2023-01-01'), (10, 13, 'F', '2023-01-02'), (8, 7, 'default1', '2023-01-01'), (0, 9, 'F', '2023-01-01'), (9, 5, 'F', '2023-01-02'), (2, 2, 'default2', '2023-01-01'), (3, 8, 'F', '2023-01-02'), (4, 9, 'F', '2023-01-02'), (5, 8, 'default1', '2023-01-02'), (6, 3, 'default2', '2023-01-02'), (7, 3, 'F', '2023-01-02'), (12, 6, 'F', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (9, 12, 'default1', '2023-01-02'), (1, 11, 'default1', '2023-01-01'), (10, 0, 'default1', '2023-01-02'), (8, 7, 'F', '2023-01-01'), (11, 5, 'default1', '2023-01-02'), (0, 8, 'F', '2023-01-02'), (2, 11, 'F', '2023-01-01'), (3, 4, 'F', '2023-01-01'), (4, 1, 'F', '2023-01-01'), (5, 13, 'default2', '2023-01-02'), (6, 6, 'F', '2023-01-02'), (7, 10, 'default2', '2023-01-01'), (12, 4, 'F', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (11, 1, 'default2', 10, 10.0, 'default2'), (1, 11, 'default1', 9, 10.0, 'default2'), (0, 7, 'default1', 10, 1.0, 'default1'), (9, 3, 'default1', 0, 11.0, 'default2'), (8, 10, 'default1', 8, 10.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('default2', 3)
('F', 1)
('F', 1)
('F', 1)
('default1', 1)
('default2', 1)
*/

-- Prediction Query
SELECT T1.A2, COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.gender = 'F' GROUP BY T1.A2 ORDER BY COUNT(T2.client_id) DESC, T1.A2 NULLS LAST LIMIT 9;

/*
Prediction Result:
('default2', 4)
('F', 3)
('default1', 1)
*/