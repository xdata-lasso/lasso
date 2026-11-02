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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (13538, 'default1', 'default1', 'default1', 'default1', 'default1', 'default1', 13538, 13540, 13540.0, 1, 13540.0, 13538.0, 13539, 0, 1), (13540, 'default2', 'default2', 'default2', 'default1', 'default2', 'default1', 1, 13539, 1.0, 13538, 13540.0, 13539.0, 1, 13539, 13539), (1, 'default2', 'default1', 'default1', 'default2', 'default2', 'default2', 13540, 1, 13540.0, 0, 13538.0, 0.0, 13540, 13538, 1), (0, 'default1', 'default2', 'default1', 'default1', 'default2', 'default1', 13539, 1, 13539.0, 13539, 13539.0, 1.0, 1, 13539, 13540), (13539, 'default1', 'default1', 'default2', 'default2', 'default1', 'default1', 13538, 1, 13538.0, 13540, 1.0, 13538.0, 13538, 1, 13539), (2, 'default1', 'default1', 'default2', 'default2', 'default2', 'default2', 13539, 13540, 13538.0, 13540, 13540.0, 13539.0, 13538, 13539, 0), (3, 'default2', 'default1', 'default1', 'default2', 'default2', 'default2', 0, 13538, 13539.0, 13540, 0.0, 13539.0, 13540, 13538, 1), (4, 'default1', 'default1', 'default1', 'default1', 'default1', 'default2', 1, 13539, 1.0, 0, 13538.0, 13539.0, 0, 1, 13538);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (13539, 3, 'default2', '2023-01-02'), (1, 13539, 'default1', '2023-01-01'), (13538, 0, 'default2', '2023-01-02'), (13540, 3, 'default2', '2023-01-01'), (0, 4, 'default1', '2023-01-02'), (2, 4, 'default2', '2023-01-02'), (3, 13540, 'default2', '2023-01-01'), (4, 2, 'default1', '2023-01-02'), (5, 13539, 'default1', '2023-01-02'), (6, 4, 'default2', '2023-01-02'), (7, 3, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 13538, 'default2', '2023-01-01'), (13540, 3, 'default2', '2023-01-01'), (0, 4, 'default1', '2023-01-02'), (13539, 13539, 'default1', '2023-01-01'), (13538, 3, 'default1', '2023-01-01'), (2, 1, 'default1', '2023-01-02'), (3, 13539, 'default1', '2023-01-02'), (4, 13538, 'default2', '2023-01-02'), (5, 13538, 'default1', '2023-01-01'), (6, 13538, 'default1', '2023-01-02'), (7, 1, 'default1', '2023-01-02'), (8, 2, 'default2', '2023-01-02'), (9, 13538, 'default1', '2023-01-01'), (10, 13539, 'default2', '2023-01-02'), (11, 13538, 'default1', '2023-01-01'), (12, 13538, 'default2', '2023-01-02'), (13, 13540, 'default2', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (13540, 2, 0, 'default1'), (0, 11, 4, 'default1'), (13539, 2, 5, 'default2'), (13538, 4, 13539, 'default1'), (1, 10, 6, 'default2'), (2, 13538, 3, 'default1'), (3, 13539, 3, 'default1'), (4, 1, 3, 'default1'), (5, 3, 13539, 'default1'), (6, 3, 0, 'default1'), (7, 6, 13538, 'default2'), (8, 13, 6, 'default2'), (9, 13, 7, 'default1'), (10, 6, 6, 'default1'), (11, 3, 7, 'default1'), (12, 5, 13539, 'default1'), (13, 6, 0, 'default2'), (14, 13539, 5, 'default2');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (13540, 10, 'default2', '2023-01-02'), (0, 10, 'default2', '2023-01-01'), (13538, 0, 'default2', '2023-01-02'), (13539, 12, 'default2', '2023-01-01'), (1, 13538, 'default2', '2023-01-01'), (2, 13539, 'default1', '2023-01-01'), (3, 13538, 'default2', '2023-01-01'), (4, 6, 'default2', '2023-01-01'), (5, 2, 'default2', '2023-01-01'), (6, 1, 'default1', '2023-01-02'), (7, 4, 'default2', '2023-01-01'), (8, 1, 'default1', '2023-01-02'), (9, 8, 'default1', '2023-01-01'), (10, 13539, 'default1', '2023-01-02'), (11, 3, 'default2', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM disp AS T1 INNER JOIN client AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T1.disp_id = T3.disp_id WHERE T2.client_id = 13539;

/*
Gold Result:
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT "card"."type" FROM "card" INNER JOIN "disp" ON "card"."disp_id" = "disp"."disp_id" WHERE "disp"."client_id" = 13539;

/*
Prediction Result:
('default2',)
*/