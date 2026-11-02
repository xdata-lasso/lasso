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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'default2', '1976-01-29', '1976-01-29', 'F', 'default1', 0, 0, 1.0, 1, 1.0, 1.0, 0, 0, 0), (1, 'default1', '1976-01-29', 'F', '1976-01-29', 'default2', 'default2', 1, 1, 1.0, 1, 1.0, 0.0, 0, 0, 0), (2, 'F', 'default2', 'F', 'F', 'F', 'default2', 0, 1, 1.0, 1, 0.0, 0.0, 0, 0, 1), (3, 'default1', '1976-01-29', 'default2', 'default2', 'default2', 'default2', 1, 0, 1.0, 0, 0.0, 0.0, 1, 0, 1), (4, 'F', 'default1', 'F', 'default2', '1976-01-29', 'F', 0, 0, 1.0, 0, NULL, 1.0, 1, 0, 1), (5, '1976-01-29', 'default2', 'default1', 'F', '1976-01-29', 'default1', 1, 0, 1.0, 0, 0.0, 1.0, 0, 0, 1), (6, 'default2', '1976-01-29', 'default2', '1976-01-29', '1976-01-29', 'F', 0, 0, 0.0, 1, 1.0, 0.0, 1, NULL, 1), (7, 'default2', '1976-01-29', 'default2', 'default2', 'default1', 'F', 1, 1, 0.0, 0, 0.0, 0.0, 0, 0, 1), (8, 'default2', '1976-01-29', 'default1', 'default2', 'F', 'F', 0, 1, 0.0, 1, NULL, 0.0, 0, NULL, 1), (9, 'default2', 'default1', 'F', 'default1', 'F', 'default1', 0, 1, 0.0, 0, 1.0, 0.0, 1, 0, 1), (10, 'default1', '1976-01-29', 'F', 'default1', '1976-01-29', 'default1', 1, 0, 0.0, 1, NULL, 0.0, 1, 1, 1), (11, 'default1', 'default1', 'default2', 'F', 'F', 'default1', 0, 1, 1.0, 0, 0.0, 0.0, 1, 0, 0), (12, 'F', 'F', 'default1', 'F', 'default2', 'F', 0, 1, 1.0, 0, NULL, 1.0, 1, 0, 0), (13, 'F', 'default1', 'default2', 'default2', 'default1', 'default2', 1, 0, 1.0, 0, 0.0, 0.0, 0, NULL, 1), (14, 'F', 'default2', 'F', '1976-01-29', 'F', 'default2', 1, 0, 0.0, 1, 0.0, 1.0, 1, NULL, 1), (15, 'default1', 'default1', 'default1', '1976-01-29', 'F', '1976-01-29', 1, 0, 0.0, 0, 0.0, 0.0, 0, 0, 1), (16, 'F', 'F', 'default1', 'default1', 'default2', 'default2', 0, 1, 1.0, 0, 0.0, 0.0, 0, NULL, 1), (17, 'F', 'F', 'F', 'F', 'F', '1976-01-29', 1, 0, 0.0, 0, 0.0, 1.0, 0, 1, 0), (18, '1976-01-29', '1976-01-29', 'default1', 'default1', '1976-01-29', '1976-01-29', 0, 1, 1.0, 0, 1.0, 1.0, 1, NULL, 1), (19, 'default2', 'default2', '1976-01-29', 'default1', 'default2', 'default2', 0, 0, 1.0, 0, 1.0, 0.0, 1, 1, 0), (20, 'F', 'F', 'default1', 'default2', '1976-01-29', 'default2', 1, 1, 0.0, 0, NULL, 0.0, 0, 0, 1), (21, 'default1', 'F', 'default1', 'default1', 'F', 'default1', 0, 1, 1.0, 0, 0.0, 0.0, 1, NULL, 0), (22, 'default2', '1976-01-29', 'default2', 'F', 'default1', 'default2', 1, 1, 0.0, 0, 0.0, 0.0, 0, NULL, 1), (23, 'F', 'F', 'F', 'default1', 'F', 'F', 1, 0, 1.0, 1, NULL, 1.0, 1, NULL, 1), (24, 'F', 'default1', 'default1', 'default2', 'default1', 'default1', 1, 1, 0.0, 1, NULL, 1.0, 0, 1, 0), (25, 'F', '1976-01-29', 'default1', 'F', 'default1', 'default2', 0, 0, 0.0, 1, 1.0, 1.0, 1, 0, 0), (26, 'default2', 'default2', '1976-01-29', '1976-01-29', 'F', 'F', 0, 0, 0.0, 1, NULL, 0.0, 0, 1, 0), (27, 'default1', 'default2', 'F', '1976-01-29', 'F', 'default2', 1, 0, 0.0, 1, NULL, 1.0, 1, NULL, 0), (28, 'default1', 'default2', 'F', 'default2', '1976-01-29', 'default1', 1, 1, 1.0, 0, NULL, 1.0, 1, NULL, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 9, 'default1', '1976-01-28'), (0, 17, '1976-01-29', '2023-01-02'), (2, 18, 'default1', '1976-01-30'), (3, 23, '1976-01-29', '1976-01-28'), (4, 24, 'default2', '1976-01-28'), (5, 4, 'F', '1976-01-29'), (6, 0, 'default1', '1976-01-29'), (7, 17, 'default2', '1976-01-30'), (8, 2, '1976-01-29', '1976-01-30'), (9, 4, 'default1', '2023-01-02'), (10, 12, 'F', '2023-01-02'), (11, 7, 'default2', '2023-01-02'), (12, 2, '1976-01-29', '1976-01-28'), (13, 3, 'default2', '1976-01-30'), (14, 23, 'default1', '1976-01-28'), (15, 18, '1976-01-29', '1976-01-30'), (16, 23, '1976-01-29', '1976-01-28'), (17, 17, 'default1', '2023-01-02'), (18, 9, 'default2', '1976-01-28'), (19, 7, '1976-01-29', '2023-01-01'), (20, 11, 'default2', '1976-01-29'), (21, 3, 'default2', '1976-01-29'), (22, 0, 'default1', '1976-01-30'), (23, 16, 'F', '2023-01-01'), (24, 21, 'F', '1976-01-29'), (25, 15, '1976-01-29', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'default2', '1976-01-30'), (1, 15, '1976-01-29', '1976-01-29'), (2, 17, 'F', '1976-01-29'), (3, 13, '1976-01-29', '1976-01-30'), (4, 11, '1976-01-29', '2023-01-02'), (5, 16, 'default2', '2023-01-02'), (6, 15, 'default1', '1976-01-30'), (7, 23, 'default1', '1976-01-28'), (8, 7, 'F', '1976-01-29'), (9, 4, 'F', '2023-01-02'), (10, 16, 'default2', '2023-01-02'), (11, 21, '1976-01-29', '2023-01-01'), (12, 7, 'F', '1976-01-30'), (13, 8, 'F', '2023-01-02'), (14, 21, '1976-01-29', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 3, 11, 'default1'), (1, 9, 5, 'F'), (2, 4, 2, 'default2'), (3, 5, 14, 'default2'), (4, 1, 18, '1976-01-29');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.A2 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.birth_date = '1976-01-29' AND T2.gender = 'F';

/*
Gold Result:
('F',)
('default1',)
*/

-- Prediction Query
SELECT T3.A2 FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T4 ON T2.account_id = T4.account_id INNER JOIN district AS T3 ON T4.district_id = T3.district_id WHERE T1.gender = 'F' AND T1.birth_date = '1976-01-29';

/*
Prediction Result:
('F',)
*/