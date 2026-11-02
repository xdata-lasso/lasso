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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (10, 'default2', 'default2', 'default1', 'default1', 'default2', 'default2', 10, 8, 1.0, 10, 9.0, 10.0, 9, 10, 10), (8, 'default2', 'default1', 'default2', 'default2', 'default2', 'default2', 0, 1, 0.0, 0, 1.0, 9.0, 9, 10, 10), (0, 'default1', 'default2', 'default2', 'default1', 'default2', 'default1', 10, 1, 1.0, 8, 1.0, 10.0, 1, 9, 0), (9, 'default2', 'default1', 'default2', 'default2', 'default2', 'default1', 1, 1, 8.0, 9, 0.0, 1.0, 9, 8, 8), (1, 'default1', 'default1', 'default1', 'default1', 'default1', 'default2', 0, 8, 8.0, 0, 8.0, 8.0, 9, 9, 9), (2, 'default2', 'default1', 'default1', 'default1', 'default1', 'default2', 0, 10, 8.0, 0, 8.0, 1.0, 10, 1, 9), (3, 'default2', 'default1', 'default2', 'default1', 'default2', 'default1', 1, 10, 0.0, 10, 1.0, 9.0, 8, 9, 10), (4, 'default2', 'default2', 'default1', 'default1', 'default2', 'default2', 10, 10, 0.0, 10, 0.0, 8.0, 10, 9, 10), (5, 'default2', 'default1', 'default1', 'default2', 'default2', 'default1', 1, 9, 8.0, 0, 8.0, 8.0, 1, NULL, 1), (6, 'default1', 'default2', 'default2', 'default2', 'default1', 'default2', 9, 0, 10.0, 10, 0.0, 0.0, 1, 8, 8);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (10, 10, 'default1', '2023-01-01'), (0, 3, 'default2', '2023-01-02'), (8, 2, 'default1', '2023-01-02'), (1, 6, 'default2', '2023-01-01'), (9, 1, 'default2', '2023-01-01'), (2, 6, 'default2', '2023-01-02'), (3, 9, 'default1', '2023-01-02'), (4, 3, 'default2', '2023-01-02'), (5, 4, 'default2', '2023-01-02'), (6, 1, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 3, 'default2', '2023-01-01'), (10, 3, 'default2', '2023-01-01'), (9, 10, 'default1', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 10, 4, 'default2'), (8, 9, 8, 'default1'), (10, 9, 10, 'default1'), (9, 10, 9, 'default2'), (0, 0, 8, 'default1');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (9, 9, 'default1', '2023-01-01'), (0, 1, 'default2', '2023-01-02'), (10, 9, 'default2', '2023-01-02'), (1, 1, 'default2', '2023-01-01'), (8, 0, 'default2', '2023-01-02'), (2, 8, 'default1', '2023-01-02'), (3, 0, 'default1', '2023-01-02'), (4, 8, 'default1', '2023-01-02'), (5, 0, 'default1', '2023-01-02'), (6, 9, 'default1', '2023-01-01'), (7, 1, 'default1', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.client_id = 9;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT "card"."type" FROM "card" INNER JOIN "disp" ON "card"."disp_id" = "disp"."disp_id" WHERE "disp"."client_id" = 9;

/*
Prediction Result:
('default1',)
('default2',)
*/