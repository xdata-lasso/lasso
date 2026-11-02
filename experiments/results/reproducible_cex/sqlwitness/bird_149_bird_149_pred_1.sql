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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (9001, 'default1', 'default1', 'OWNER', 'default2', 'default1', 'default2', 7999, 9001, 0.0, 8001, NULL, 9001.0, 1, 8999, 8999);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (8999, 9001, 'default2', '2023-01-01'), (1, 9001, 'OWNER', '2023-01-01'), (8001, 9001, 'default1', '2023-01-01'), (8000, 9001, 'default1', '2023-01-01'), (9001, 9001, 'default2', '2023-01-01'), (0, 9001, 'default1', '2023-01-02'), (7999, 9001, 'default2', '2023-01-02'), (9000, 9001, 'OWNER', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 9001, 'OWNER', '2023-01-01'), (8001, 9001, 'OWNER', '2023-01-01'), (8000, 9001, 'default2', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 0, 8001, 'default2'), (8999, 0, 8999, 'OWNER'), (8000, 0, 9001, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.account_id = T3.account_id WHERE T3.type <> 'OWNER' AND T1.A11 BETWEEN 8000 AND 9000;

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT "disp"."type" FROM "disp" INNER JOIN "account" ON "disp"."account_id" = "account"."account_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "disp"."type" <> 'OWNER' AND "district"."A11" > 8000 AND "district"."A11" <= 9000;

/*
Prediction Result:
('default2',)
*/