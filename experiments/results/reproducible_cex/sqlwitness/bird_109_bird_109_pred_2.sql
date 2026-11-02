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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'Jesenik', 'default1', 'default2', 'default1', 'default1', 'F', 0, 1, 1.0, 0, NULL, 1.0, 0, 0, 1), (1, 'Jesenik', 'default2', 'Jesenik', 'F', 'default2', 'default2', 1, 0, 1.0, 1, NULL, 1.0, 0, 0, 1), (2, 'default1', 'Jesenik', 'Jesenik', 'default2', 'F', 'default2', 0, 1, 1.0, 1, 0.0, 1.0, 1, NULL, 0), (3, 'F', 'default1', 'F', 'default2', 'Jesenik', 'default2', 0, 0, 1.0, 0, NULL, 1.0, 0, 0, 1), (4, 'default2', 'Jesenik', 'Jesenik', 'default2', 'F', 'Jesenik', 1, 0, 1.0, 0, NULL, 1.0, 0, NULL, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 3, 'default1', '2023-01-01'), (0, 1, 'default2', '2023-01-01'), (2, 3, 'F', '2023-01-01'), (3, 2, 'default2', '2023-01-01'), (4, 1, 'F', '2023-01-02'), (5, 3, 'Jesenik', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'Jesenik', '2023-01-01'), (1, 2, 'Jesenik', '2023-01-01'), (2, 2, 'Jesenik', '2023-01-02'), (3, 0, 'Jesenik', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' AND T2.A2 = 'Jesenik';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "client"."client_id") FROM "client" INNER JOIN "account" ON "client"."district_id" = "account"."district_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "district"."a2" = 'Jesenik' AND "client"."gender" = 'F';

/*
Prediction Result:
(0,)
*/