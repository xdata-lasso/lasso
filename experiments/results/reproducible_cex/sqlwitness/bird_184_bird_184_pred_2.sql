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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'default1', 'default2', 'default1', 'junior', 'F', 0, 0, 1.0, 0, 0.0, 0.0, 0, NULL, 0), (1, 'junior', 'F', 'default1', 'default2', 'default2', 'default2', 0, 1, 1.0, 1, NULL, 1.0, 0, 0, 0), (2, 'default2', 'F', 'F', 'default1', 'F', 'default2', 0, 1, 0.0, 0, NULL, 1.0, 0, 0, 1), (3, 'junior', 'F', 'default1', 'default1', 'default1', 'F', 1, 0, 1.0, 0, NULL, 0.0, 0, 0, 1), (4, 'junior', 'F', 'F', 'default1', 'default1', 'default2', 1, 1, 1.0, 0, 0.0, 0.0, 1, NULL, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 2, 'F', '2023-01-02'), (1, 2, 'default2', '2023-01-01'), (2, 0, 'default1', '2023-01-01'), (3, 0, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, 'junior', '2023-01-01'), (0, 1, 'junior', '2023-01-02'), (2, 0, 'default1', '2023-01-01'), (3, 0, 'junior', '2023-01-02'), (4, 0, 'default2', '2023-01-01'), (5, 3, 'default2', '2023-01-02'), (6, 0, 'default1', '2023-01-01'), (7, 3, 'default2', '2023-01-02'), (8, 1, 'default2', '2023-01-01'), (9, 3, 'F', '2023-01-02'), (10, 1, 'junior', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 8, 0, 'default2'), (1, 10, 0, 'F'), (2, 6, 1, 'junior'), (3, 9, 1, 'junior'), (4, 7, 1, 'default2'), (5, 2, 2, 'junior'), (6, 1, 1, 'default1'), (7, 3, 3, 'default1'), (8, 9, 1, 'default2'), (9, 1, 1, 'F'), (10, 1, 3, 'F'), (11, 6, 2, 'F'), (12, 0, 0, 'F'), (13, 7, 2, 'junior'), (14, 7, 0, 'default2'), (15, 5, 2, 'F'), (16, 6, 1, 'default1'), (17, 7, 3, 'default2');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 12, 'junior', '2023-01-01'), (0, 1, 'default1', '2023-01-02'), (2, 8, 'junior', '2023-01-01'), (3, 1, 'default1', '2023-01-01'), (4, 16, 'default2', '2023-01-01'), (5, 11, 'junior', '2023-01-02'), (6, 7, 'F', '2023-01-01'), (7, 0, 'default1', '2023-01-01'), (8, 5, 'F', '2023-01-02'), (9, 6, 'default2', '2023-01-01'), (10, 14, 'junior', '2023-01-01'), (11, 9, 'junior', '2023-01-02'), (12, 0, 'default1', '2023-01-02'), (13, 11, 'default1', '2023-01-02'), (14, 9, 'F', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.gender = 'F' AND T3.type = 'junior';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "client"."client_id") FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "card" ON "disp"."disp_id" = "card"."disp_id" WHERE "client"."gender" = 'F' AND "card"."type" = 'junior';

/*
Prediction Result:
(1,)
*/