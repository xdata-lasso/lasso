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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'north Bohemia', 'default1', 'north Bohemia', 'north Bohemia', 'north Bohemia', 8001, 1, 1.0, 1, 8000.0, 7999.0, 1, 8001, 0), (8000, 'default1', 'default2', 'default1', 'north Bohemia', 'north Bohemia', 'default1', 0, 1, 1.0, 8000, 7999.0, 0.0, 8000, 8000, 8000), (8001, 'default2', 'default1', 'North Bohemia', 'north Bohemia', 'default2', 'default2', 8000, 8001, 1.0, 1, 1.0, 7999.0, 8001, 1, 8001), (1, 'North Bohemia', 'M', 'North Bohemia', 'default2', 'default1', 'north Bohemia', 8001, 7999, 7999.0, 8001, 1.0, 8001.0, 8000, 8001, 0), (7999, 'north Bohemia', 'M', 'North Bohemia', 'default2', 'default2', 'M', 8001, 8001, 8000.0, 8000, 0.0, 1.0, 1, NULL, 1), (2, 'north Bohemia', 'M', 'default2', 'north Bohemia', 'M', 'north Bohemia', 8001, 7999, 8001.0, 7999, 1.0, 8000.0, 0, 1, 8001), (3, 'M', 'default1', 'M', 'default2', 'north Bohemia', 'north Bohemia', 7999, 0, 8000.0, 7999, 1.0, 8000.0, 0, 7999, 8000), (4, 'north Bohemia', 'north Bohemia', 'default1', 'M', 'north Bohemia', 'default1', 0, 8000, 0.0, 8001, 7999.0, 1.0, 7999, 8000, 1), (5, 'M', 'north Bohemia', 'north Bohemia', 'M', 'M', 'default2', 0, 0, 1.0, 0, 1.0, 1.0, 0, 8001, 7999), (6, 'M', 'M', 'default2', 'default2', 'default2', 'default2', 0, 0, 0.0, 0, 1.0, 0.0, 8000, 8001, 8000), (7, 'north Bohemia', 'North Bohemia', 'North Bohemia', 'M', 'default2', 'north Bohemia', 8001, 0, 7999.0, 8001, NULL, 8000.0, 0, 7999, 8001), (8, 'default1', 'default2', 'M', 'North Bohemia', 'default2', 'default1', 0, 7999, 0.0, 8001, 1.0, 8000.0, 0, 8000, 7999), (9, 'default1', 'default2', 'north Bohemia', 'default1', 'default2', 'M', 8000, 0, 1.0, 7999, 8000.0, 0.0, 1, 0, 1), (10, 'M', 'North Bohemia', 'North Bohemia', 'North Bohemia', 'default2', 'default1', 8000, 7999, 8001.0, 8000, 8001.0, 8001.0, 8000, 8000, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (8001, 1, 'M', '2023-01-01'), (0, 10, 'north Bohemia', '2023-01-01'), (8000, 8, 'north Bohemia', '2023-01-02'), (1, 1, 'North Bohemia', '2023-01-01'), (7999, 8001, 'north Bohemia', '2023-01-01'), (2, 7, 'M', '2023-01-02'), (3, 3, 'North Bohemia', '2023-01-01'), (4, 7, 'default2', '2023-01-01'), (5, 1, 'north Bohemia', '2023-01-01'), (6, 2, 'north Bohemia', '2023-01-02'), (7, 10, 'North Bohemia', '2023-01-01'), (8, 8, 'M', '2023-01-01'), (9, 4, 'default2', '2023-01-01'), (10, 6, 'M', '2023-01-01'), (11, 3, 'north Bohemia', '2023-01-02'), (12, 8001, 'North Bohemia', '2023-01-02'), (13, 9, 'M', '2023-01-02'), (14, 8001, 'default1', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A3 = 'North Bohemia' AND T2.A11 > 8000;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT("client"."client_id") FROM "client" INNER JOIN "district" ON "client"."district_id" = "district"."district_id" WHERE "client"."gender" = 'M' AND "district"."a3" = 'north Bohemia' AND "district"."a11" > 8000;

/*
Prediction Result:
(0,)
*/