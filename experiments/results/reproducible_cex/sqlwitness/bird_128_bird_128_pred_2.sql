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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (8, 'F', 'F', 'default2', 'default2', 'default2', 'default2', 9, 0, 1.0, 0, 11.0, 8.0, 10, 0, 10), (11, 'F', 'F', 'F', 'default2', 'F', 'F', 9, 11, 11.0, 11, 0.0, 9.0, 8, 11, 8), (1, 'F', 'default2', 'default2', 'default1', 'F', 'default1', 10, 10, 0.0, 0, NULL, 9.0, 0, 9, 10), (9, 'default2', 'default1', 'F', 'default1', 'default2', 'default2', 10, 9, 0.0, 10, 1.0, 0.0, 10, NULL, 8), (10, 'default2', 'F', 'default2', 'default1', 'default2', 'default2', 1, 9, 0.0, 11, 0.0, 11.0, 1, 11, 8), (0, 'F', 'F', 'default1', 'default1', 'default2', 'default1', 1, 8, 1.0, 9, 8.0, 10.0, 9, NULL, 11);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 9, 'default2', '2023-01-02'), (11, 9, 'F', '2023-01-02'), (10, 9, 'F', '2023-01-01'), (8, 0, 'default1', '2023-01-01'), (9, 8, 'F', '2023-01-01'), (0, 9, 'default1', '2023-01-01'), (2, 11, 'default1', '2023-01-01'), (3, 1, 'F', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (8, 1, 'F', '2023-01-02'), (0, 9, 'default2', '2023-01-01'), (1, 9, 'default2', '2023-01-02'), (9, 9, 'F', '2023-01-01'), (10, 0, 'default1', '2023-01-02'), (11, 1, 'default2', '2023-01-01'), (2, 1, 'default2', '2023-01-02'), (3, 1, 'default2', '2023-01-02'), (4, 10, 'F', '2023-01-01'), (5, 9, 'F', '2023-01-02'), (6, 9, 'default1', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (8, 11, 'default2', 8, 9.0, 'F'), (11, 1, 'default2', 10, 0.0, 'default1'), (10, 8, 'F', 1, 10.0, 'default2'), (1, 3, 'default2', 1, 11.0, 'default2'), (9, 11, 'F', 0, 9.0, 'default1'), (0, 9, 'F', 10, 10.0, 'default2'), (2, 11, 'default1', 11, 8.0, 'default2'), (3, 5, 'default2', 11, 11.0, 'F'), (4, 9, 'default2', 11, 1.0, 'F'), (5, 0, 'default1', 11, 10.0, 'F'), (6, 6, 'F', 9, 11.0, 'default1'), (7, 9, 'default1', 11, 8.0, 'default2'), (12, 4, 'default1', 1, 8.0, 'default1'), (13, 8, 'default1', 10, 0.0, 'default1'), (14, 3, 'default2', 0, 11.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('default2', 2)
('F', 1)
('F', 1)
*/

-- Prediction Query
SELECT "district"."A2", COUNT("client"."client_id") AS "female_count" FROM "client" INNER JOIN "district" ON "client"."district_id" = "district"."district_id" WHERE "client"."gender" = 'F' GROUP BY "district"."A2" ORDER BY "female_count" DESC, "district"."A2" NULLS LAST, female_count NULLS LAST LIMIT 9;

/*
Prediction Result:
('F', 2)
('default2', 2)
*/