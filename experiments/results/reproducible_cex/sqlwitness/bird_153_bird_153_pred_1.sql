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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'OWNER', 'OWNER', 'default1', 'classic', 'default2', 'default2', 0, 0, 0.0, 0, NULL, 1.0, 0, 1, 1), (1, 'default2', 'default1', 'OWNER', 'classic', 'default1', 'default2', 0, 0, 1.0, 1, 1.0, 0.0, 1, 1, 0), (2, 'OWNER', 'classic', 'default2', 'default2', 'default2', 'OWNER', 1, 0, 0.0, 0, 1.0, 0.0, 0, 1, 0), (3, 'default1', 'default1', 'default2', 'default1', 'classic', 'default2', 1, 0, 0.0, 1, 1.0, 0.0, 0, NULL, 0), (4, 'OWNER', 'OWNER', 'default1', 'default1', 'default1', 'OWNER', 0, 0, 0.0, 1, 0.0, 0.0, 0, 1, 1), (5, 'Owner', 'OWNER', 'classic', 'Owner', 'OWNER', 'Owner', 1, 0, 1.0, 0, 1.0, 0.0, 1, 0, 1), (6, 'classic', 'classic', 'default2', 'default1', 'default2', 'OWNER', 0, 1, 0.0, 0, 1.0, 1.0, 1, 0, 0), (7, 'classic', 'Owner', 'OWNER', 'default1', 'Owner', 'classic', 1, 0, 1.0, 1, 1.0, 1.0, 0, 0, 0), (8, 'Owner', 'OWNER', 'default2', 'default1', 'classic', 'OWNER', 0, 1, 0.0, 0, NULL, 1.0, 1, 1, 0), (9, 'default1', 'default1', 'default1', 'Owner', 'Owner', 'default1', 1, 0, 0.0, 0, 0.0, 0.0, 1, 1, 1), (10, 'default1', 'default1', 'default1', 'classic', 'classic', 'Owner', 0, 1, 1.0, 0, NULL, 0.0, 0, 0, 0), (11, 'OWNER', 'OWNER', 'default2', 'OWNER', 'default1', 'Owner', 0, 1, 0.0, 1, 1.0, 0.0, 0, NULL, 1), (12, 'default1', 'default2', 'Owner', 'classic', 'default1', 'OWNER', 0, 0, 0.0, 1, 1.0, 1.0, 0, NULL, 1), (13, 'default2', 'classic', 'Owner', 'classic', 'Owner', 'OWNER', 1, 1, 1.0, 1, NULL, 0.0, 1, 1, 1), (14, 'default1', 'OWNER', 'default2', 'classic', 'classic', 'Owner', 1, 1, 0.0, 0, NULL, 1.0, 1, 1, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 7, 'default1', '2023-01-01'), (0, 12, 'OWNER', '2023-01-01'), (2, 7, 'Owner', '2023-01-01'), (3, 0, 'classic', '2023-01-02'), (4, 8, 'classic', '2023-01-02'), (5, 13, 'classic', '2023-01-02'), (6, 8, 'Owner', '2023-01-02'), (7, 2, 'classic', '2023-01-01'), (8, 12, 'OWNER', '2023-01-01'), (9, 10, 'classic', '2023-01-02'), (10, 10, 'default1', '2023-01-02'), (11, 11, 'OWNER', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 10, 'Owner', '2023-01-01'), (1, 10, 'classic', '2023-01-01'), (2, 8, 'OWNER', '2023-01-02'), (3, 14, 'default2', '2023-01-01'), (4, 1, 'default2', '2023-01-01'), (5, 1, 'Owner', '2023-01-01'), (6, 9, 'OWNER', '2023-01-01'), (7, 4, 'default1', '2023-01-01'), (8, 2, 'classic', '2023-01-02'), (9, 1, 'default1', '2023-01-01'), (10, 6, 'default2', '2023-01-02'), (11, 12, 'default2', '2023-01-01'), (12, 10, 'default2', '2023-01-01'), (13, 12, 'default1', '2023-01-02'), (14, 7, 'classic', '2023-01-01'), (15, 0, 'classic', '2023-01-01'), (16, 4, 'default2', '2023-01-01'), (17, 9, 'OWNER', '2023-01-01'), (18, 12, 'classic', '2023-01-01'), (19, 3, 'classic', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 8, 6, 'default2'), (1, 17, 0, 'Owner'), (2, 19, 5, 'default2'), (3, 11, 7, 'classic'), (4, 0, 1, 'Owner'), (5, 8, 4, 'default1');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (0, 5, 'Owner', '2023-01-02'), (1, 4, 'classic', '2023-01-01'), (2, 1, 'classic', '2023-01-01'), (3, 2, 'Owner', '2023-01-01'), (4, 3, 'Owner', '2023-01-02'), (5, 1, 'default1', '2023-01-02'), (6, 3, 'classic', '2023-01-02'), (7, 0, 'OWNER', '2023-01-01'), (8, 4, 'OWNER', '2023-01-02'), (9, 5, 'default2', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.card_id) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id WHERE T1.type = 'classic' AND T2.type = 'Owner';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM card AS c INNER JOIN disp AS d ON c.disp_id = d.disp_id WHERE c.type = 'classic' AND d.type = 'OWNER';

/*
Prediction Result:
(0,)
*/