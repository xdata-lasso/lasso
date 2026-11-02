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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (10001, 'F', 'F', 'default2', 'default2', 'F', 'default2', 2, 99, 100.0, 10001, 9999.0, 2.0, -1, 101, 100), (101, 'F', 'F', 'default1', 'F', 'default1', 'F', 0, 10001, 10001.0, -1, 100.0, 10000.0, -1, 10001, 10000), (1, 'default2', 'default2', 'F', 'F', 'default1', 'default1', 2, 10001, 0.0, 9999, 9999.0, 9999.0, 2, 1, 10000), (99, 'default1', 'default2', 'F', 'default2', 'F', 'F', 10000, 100, 2.0, -1, -1.0, 101.0, 101, NULL, 0), (-1, 'default1', 'F', 'F', 'default2', 'default2', 'default1', 100, 10001, 100.0, 10001, NULL, 9999.0, 99, 10000, 9999), (10000, 'F', 'F', 'default2', 'default2', 'F', 'F', 99, 99, 1.0, 101, 0.0, 2.0, 0, 9999, 10000), (9999, 'F', 'default1', 'default2', 'default1', 'F', 'F', 10001, 0, 9999.0, 10000, 99.0, 100.0, 9999, -1, -1), (0, 'default1', 'F', 'F', 'F', 'default2', 'default2', 9999, 9999, 101.0, 100, 100.0, 10001.0, 0, 10001, 100), (100, 'default2', 'default1', 'default1', 'default1', 'F', 'F', 9999, 99, 0.0, 1, NULL, 10001.0, 10000, 9999, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 99, 'default1', '2023-01-02'), (101, 10001, 'default1', '2023-01-02'), (-1, 0, 'default1', '2023-01-01'), (100, -1, 'F', '2023-01-01'), (10000, 99, 'default1', '2023-01-01'), (1, 99, 'default2', '2023-01-02'), (99, -1, 'F', '2023-01-01'), (9999, 0, 'default1', '2023-01-01'), (10001, 99, 'default2', '2023-01-02'), (2, 0, 'default1', '2023-01-02'), (3, 10001, 'default2', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (99, 10000, 'default2', '2023-01-01'), (9999, 0, 'default1', '2023-01-01'), (0, 10000, 'F', '2023-01-01'), (10000, 10001, 'F', '2023-01-02'), (10001, 10000, 'F', '2023-01-01'), (101, 101, 'default1', '2023-01-02'), (-1, 9999, 'default1', '2023-01-01'), (2, 1, 'F', '2023-01-01'), (100, 9999, 'F', '2023-01-02'), (1, -1, 'default2', '2023-01-02'), (3, 10001, 'default1', '2023-01-02'), (4, 99, 'F', '2023-01-02'), (5, 10000, 'default1', '2023-01-01'), (6, 9999, 'default2', '2023-01-02'), (7, 1, 'default2', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) * 100 / COUNT(T2.client_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A11 > 10000;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "client"."gender" = 'F' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("client"."client_id") FROM "client" INNER JOIN "account" ON "client"."district_id" = "account"."district_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "district"."a11" > 10000;

/*
Prediction Result:
(33.333333333333336,)
*/