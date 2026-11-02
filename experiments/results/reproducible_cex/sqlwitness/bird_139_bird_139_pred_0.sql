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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'DISPONENT', 'default1', 'gold', 'disponent', 'default2', 'gold', 1, 0, 1.0, 1, 1.0, 1.0, 1, 1, 1), (1, 'DISPONENT', 'default2', 'DISPONENT', 'default2', 'disponent', 'disponent', 1, 1, 1.0, 0, 0.0, 0.0, 0, NULL, 1), (2, 'disponent', 'DISPONENT', 'default1', 'DISPONENT', 'default2', 'DISPONENT', 0, 1, 0.0, 0, 0.0, 0.0, 0, NULL, 1), (3, 'default2', 'default1', 'gold', 'default2', 'disponent', 'gold', 0, 1, 1.0, 1, NULL, 1.0, 0, 0, 0), (4, 'default1', 'default2', 'gold', 'disponent', 'default1', 'DISPONENT', 1, 0, 0.0, 0, 0.0, 1.0, 0, 0, 0), (5, 'disponent', 'DISPONENT', 'default2', 'gold', 'DISPONENT', 'DISPONENT', 1, 1, 0.0, 1, 0.0, 1.0, 0, 1, 0), (6, 'default1', 'disponent', 'default2', 'default1', 'DISPONENT', 'default2', 1, 0, 1.0, 0, 1.0, 1.0, 0, 1, 1), (7, 'DISPONENT', 'gold', 'default1', 'DISPONENT', 'default1', 'disponent', 1, 1, 1.0, 0, NULL, 0.0, 1, NULL, 0), (8, 'DISPONENT', 'default1', 'default1', 'default2', 'default2', 'DISPONENT', 1, 0, 1.0, 0, 1.0, 1.0, 1, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 1, 'default2', '2023-01-02'), (1, 6, 'DISPONENT', '2023-01-01'), (2, 2, 'DISPONENT', '2023-01-01'), (3, 6, 'default1', '2023-01-02'), (4, 5, 'gold', '2023-01-02'), (5, 7, 'default1', '2023-01-02'), (6, 1, 'default2', '2023-01-01'), (7, 5, 'gold', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'gold', '2023-01-02'), (0, 3, 'gold', '2023-01-02'), (2, 8, 'gold', '2023-01-02'), (3, 8, 'default1', '2023-01-01'), (4, 0, 'DISPONENT', '2023-01-01'), (5, 0, 'disponent', '2023-01-02'), (6, 6, 'disponent', '2023-01-02'), (7, 7, 'default2', '2023-01-02'), (8, 4, 'gold', '2023-01-01'), (9, 6, 'gold', '2023-01-01'), (10, 6, 'default1', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 4, 5, 'default1'), (0, 0, 7, 'gold'), (2, 1, 4, 'default1'), (3, 8, 4, 'DISPONENT'), (4, 7, 5, 'disponent'), (5, 7, 3, 'disponent'), (6, 8, 4, 'disponent'), (7, 10, 3, 'gold');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (0, 7, 'disponent', '2023-01-02'), (1, 7, 'disponent', '2023-01-01'), (2, 2, 'disponent', '2023-01-02'), (3, 0, 'default1', '2023-01-01'), (4, 3, 'default2', '2023-01-02'), (5, 5, 'default2', '2023-01-01'), (6, 6, 'gold', '2023-01-02'), (7, 1, 'gold', '2023-01-02'), (8, 2, 'gold', '2023-01-02'), (9, 6, 'DISPONENT', '2023-01-01'), (10, 5, 'disponent', '2023-01-01'), (11, 3, 'default1', '2023-01-02'), (12, 5, 'disponent', '2023-01-02'), (13, 1, 'gold', '2023-01-01'), (14, 3, 'disponent', '2023-01-01'), (15, 4, 'gold', '2023-01-01'), (16, 2, 'default1', '2023-01-02'), (17, 1, 'gold', '2023-01-01'), (18, 5, 'default2', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.card_id) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id WHERE T1.type = 'gold' AND T2.type = 'DISPONENT';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.card_id) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id WHERE T1.type = 'gold' AND T2.type = 'disponent';

/*
Prediction Result:
(2,)
*/