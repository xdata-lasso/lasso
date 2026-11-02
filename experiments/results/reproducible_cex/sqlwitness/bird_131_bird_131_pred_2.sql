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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', 'default1', 'default2', 'D', 'default2', 'default2', 2, 1, 2.0, 0, 1.0, 0.0, 2, 1, 0), (0, 'D', 'C', 'D', 'D', 'default2', 'default1', 2, 1, 1.0, 2, 2.0, 2.0, 2, 2, 1), (2, 'C', 'default2', 'default2', 'default1', 'default1', 'default1', 2, 1, 1.0, 2, 0.0, 1.0, 0, 2, 2), (3, 'D', 'D', 'default1', 'default2', 'default1', 'default1', 1, 2, 2.0, 0, 1.0, 1.0, 1, NULL, 0), (4, 'default1', 'D', 'default1', 'D', 'C', 'C', 0, 1, 0.0, 0, 0.0, 2.0, 2, NULL, 1), (5, 'D', 'default1', 'default1', 'C', 'default2', 'D', 0, 0, 2.0, 0, 2.0, 2.0, 2, 2, 0), (6, 'D', 'default2', 'default2', 'C', 'default1', 'default1', 2, 2, 0.0, 0, 1.0, 0.0, 1, 1, 2), (7, 'default1', 'default1', 'D', 'default2', 'D', 'default2', 2, 2, 1.0, 0, NULL, 2.0, 1, 2, 2), (8, 'default2', 'C', 'D', 'default2', 'default1', 'D', 2, 1, 0.0, 0, 1.0, 2.0, 2, 0, 2), (9, 'C', 'D', 'D', 'C', 'C', 'C', 1, 0, 2.0, 0, 2.0, 0.0, 2, 1, 1), (10, 'default2', 'default2', 'default1', 'C', 'default1', 'default2', 0, 0, 0.0, 2, NULL, 1.0, 2, 2, 0), (11, 'default1', 'D', 'C', 'default2', 'D', 'default1', 2, 2, 0.0, 2, 0.0, 1.0, 2, 1, 1), (12, 'D', 'default2', 'C', 'C', 'C', 'C', 0, 2, 2.0, 0, NULL, 1.0, 1, 1, 2), (13, 'default1', 'D', 'default2', 'D', 'C', 'default1', 0, 0, 1.0, 2, 0.0, 2.0, 1, 0, 1), (14, 'default2', 'default1', 'default2', 'C', 'default2', 'default1', 0, 0, 2.0, 0, 0.0, 0.0, 1, 2, 0), (15, 'C', 'default2', 'default1', 'D', 'default2', 'C', 0, 2, 1.0, 1, 0.0, 1.0, 0, 1, 1), (16, 'C', 'D', 'C', 'default2', 'default2', 'default1', 2, 1, 0.0, 0, 0.0, 0.0, 0, 0, 2), (17, 'C', 'C', 'default1', 'D', 'C', 'default1', 1, 2, 1.0, 1, 0.0, 1.0, 2, 1, 0), (18, 'default2', 'default2', 'default2', 'D', 'D', 'default1', 0, 0, 0.0, 2, 0.0, 0.0, 1, 0, 1), (19, 'D', 'default1', 'C', 'C', 'C', 'default1', 2, 2, 1.0, 1, NULL, 1.0, 0, NULL, 0), (20, 'default1', 'D', 'C', 'default1', 'default2', 'D', 2, 2, 1.0, 2, 0.0, 1.0, 2, 1, 2), (21, 'default1', 'C', 'default1', 'default1', 'default1', 'default1', 0, 0, 0.0, 1, 0.0, 2.0, 1, 1, 1), (22, 'default2', 'C', 'default1', 'D', 'default2', 'D', 1, 1, 2.0, 1, NULL, 2.0, 0, 0, 1), (23, 'D', 'C', 'default2', 'C', 'default2', 'default2', 2, 0, 0.0, 0, NULL, 0.0, 0, 2, 2), (24, 'default1', 'default1', 'C', 'default1', 'C', 'default1', 1, 2, 0.0, 2, 0.0, 2.0, 1, 0, 2), (25, 'default1', 'default1', 'D', 'default1', 'D', 'default2', 1, 0, 2.0, 2, 2.0, 0.0, 1, NULL, 2), (26, 'D', 'D', 'default2', 'default1', 'default1', 'default2', 0, 1, 1.0, 1, NULL, 1.0, 2, 2, 1), (27, 'D', 'default1', 'default1', 'D', 'default2', 'D', 0, 0, 2.0, 2, 2.0, 1.0, 0, 1, 0), (28, 'default1', 'D', 'default2', 'default1', 'C', 'C', 1, 2, 1.0, 1, 1.0, 2.0, 1, 0, 0), (29, 'default1', 'default2', 'default1', 'D', 'default1', 'C', 1, 2, 0.0, 1, NULL, 0.0, 0, 0, 0), (30, 'default1', 'C', 'D', 'C', 'D', 'default1', 0, 2, 2.0, 0, 0.0, 0.0, 0, NULL, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 14, 'default1', '2023-01-02'), (2, 1, 'D', '2023-01-02'), (0, 22, 'default1', '2023-01-02'), (3, 16, 'default2', '2023-01-01'), (4, 22, 'default2', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 0, 'default1', 1, 1.0, 'default2'), (1, 3, 'C', 0, 2.0, 'C'), (2, 0, 'C', 1, 1.0, 'C'), (3, 4, 'default1', 0, 0.0, 'D'), (4, 3, 'default1', 0, 1.0, 'C'), (5, 1, 'D', 0, 1.0, 'D'), (6, 3, 'default1', 0, 0.0, 'default2'), (7, 3, 'C', 0, 1.0, 'default1'), (8, 1, 'default1', 0, 1.0, 'C'), (9, 0, 'C', 0, 0.0, 'D'), (10, 4, 'default2', 0, 2.0, 'C'), (11, 1, 'C', 0, 2.0, 'default2'), (12, 0, 'default2', 1, 2.0, 'default2'), (13, 0, 'D', 1, 0.0, 'D'), (14, 2, 'default1', 1, 2.0, 'C'), (15, 1, 'default1', 0, 1.0, 'default1'), (16, 4, 'C', 0, 0.0, 'C'), (17, 3, 'D', 0, 0.0, 'C'), (18, 1, 'default2', 0, 1.0, 'C'), (19, 2, 'default2', 1, 0.0, 'default2'), (20, 3, 'default1', 2, 2.0, 'D'), (21, 1, 'D', 1, 2.0, 'D'), (22, 0, 'C', 0, 2.0, 'default2'), (23, 4, 'default1', 1, 1.0, 'C'), (24, 3, 'default2', 1, 0.0, 'D'), (25, 2, 'default1', 1, 0.0, 'default1'), (26, 4, 'C', 2, 0.0, 'D'), (27, 3, 'C', 1, 0.0, 'default2'), (28, 4, 'default1', 1, 0.0, 'C'), (29, 4, 'D', 2, 0.0, 'C'), (30, 0, 'default2', 2, 1.0, 'default2'), (31, 2, 'D', 0, 0.0, 'C');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 3, '2023-01-02', 1, 1, 2.0, 'D'), (1, 4, '2023-01-02', 1, 2, 0.0, 'default2'), (0, 0, '2023-01-02', 0, 2, 1.0, 'C'), (3, 2, '2023-01-01', 2, 0, 2.0, 'C'), (4, 0, '2023-01-01', 1, 2, 0.0, 'C'), (5, 4, '2023-01-01', 0, 0, 2.0, 'default1'), (6, 2, '2023-01-01', 2, 0, 0.0, 'D'), (7, 3, '2023-01-02', 2, 1, 0.0, 'C'), (8, 0, '2023-01-02', 0, 1, 0.0, 'default2'), (9, 0, '2023-01-02', 2, 0, 0.0, 'default2'), (10, 1, '2023-01-01', 0, 0, 0.0, 'default1'), (11, 3, '2023-01-01', 0, 0, 0.0, 'C'), (12, 1, '2023-01-01', 2, 0, 2.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT "district"."a3" FROM "loan" INNER JOIN "account" ON "loan"."account_id" = "account"."account_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "loan"."status" IN ('C', 'D') GROUP BY "district"."a3" ORDER BY COUNT("loan"."loan_id") DESC, "district"."a3" NULLS LAST LIMIT 1;

/*
Prediction Result:
('D',)
*/