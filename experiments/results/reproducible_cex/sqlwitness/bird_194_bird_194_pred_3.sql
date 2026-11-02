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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'gold', 'default1', '2025-01-01 00:00:00', '%m-%d', 'gold', 'default1', 0, 1, 1.0, 1, NULL, 1.0, 1, 0, 1), (1, '2025-01-01 00:00:00', 'A', '2025-01-01 00:00:00', 'default2', 'A', 'gold', 0, 0, 0.0, 1, 1.0, 1.0, 1, 0, 0), (2, '2025-01-01 00:00:00', 'gold', 'default1', 'default1', 'default2', 'OWNER', 1, 1, 1.0, 1, 1.0, 1.0, 0, NULL, 0), (3, '2025-01-01 00:00:00', '%Y', 'OWNER', '%Y', 'gold', '%Y', 1, 0, 0.0, 1, 0.0, 1.0, 0, NULL, 1), (4, '%m-%d', '2025-01-01 00:00:00', '2025-01-01 00:00:00', 'default2', '%m-%d', '2025-01-01 00:00:00', 0, 1, 0.0, 0, 1.0, 1.0, 1, 1, 1), (5, '%m-%d', 'A', 'OWNER', '2025-01-01 00:00:00', 'default1', '%Y', 0, 0, 1.0, 1, NULL, 0.0, 1, NULL, 1), (6, 'gold', 'OWNER', '%m-%d', 'OWNER', 'default2', '%m-%d', 1, 1, 0.0, 1, 0.0, 0.0, 1, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 5, 'A', '2023-01-02'), (1, 4, '%m-%d', '2023-01-01'), (2, 4, 'OWNER', '2023-01-01'), (3, 3, '%m-%d', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 4, '%m-%d', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 0, '2023-01-01', 1, 0, 0.0, '%Y'), (0, 0, '2023-01-02', 1, 1, 1.0, '%m-%d');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 0, 1, 'OWNER'), (0, 0, 0, 'OWNER'), (2, 0, 0, 'default2');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 1, 'gold', '2023-01-02'), (0, 2, 'A', '2023-01-02'), (2, 0, 'default1', '2023-01-01'), (3, 0, 'default1', '2025-01-01'), (4, 0, 'OWNER', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T3.birth_date) FROM disp AS T1 INNER JOIN card AS T2 ON T2.disp_id = T1.disp_id INNER JOIN client AS T3 ON T1.client_id = T3.client_id WHERE T2.type = 'gold' AND T1.type = 'OWNER';

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
SELECT DISTINCT T1.client_id, (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.birth_date)) - (STRFTIME('%m-%d', '2025-01-01 00:00:00') < STRFTIME('%m-%d', T1.birth_date)) AS age FROM client AS T1 JOIN disp AS T2 ON T1.client_id = T2.client_id JOIN card AS T3 ON T2.disp_id = T3.disp_id JOIN account AS T4 ON T2.account_id = T4.account_id JOIN loan AS T5 ON T4.account_id = T5.account_id WHERE T3.type = 'gold' AND T5.status = 'A';

/*
Prediction Result:
*/