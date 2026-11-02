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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'USER', 'default1', 'USER', 'POPLATEK TYDNE', 'OWNER', 'POPLATEK TYDNE', 0, 0, 1.0, 1, 1.0, 0.0, 0, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 0, 'USER', '2023-01-02'), (1, 0, 'default2', '2023-01-01'), (2, 0, 'USER', '2023-01-01'), (3, 0, 'POPLATEK TYDNE', '2023-01-01'), (4, 0, 'default2', '2023-01-01'), (5, 0, 'USER', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'USER', '2023-01-01'), (1, 0, 'default2', '2023-01-01'), (2, 0, 'default2', '2023-01-02'), (3, 0, 'USER', '2023-01-02'), (4, 0, 'USER', '2023-01-02'), (5, 0, 'POPLATEK TYDNE', '2023-01-02'), (6, 0, 'OWNER', '2023-01-01'), (7, 0, 'POPLATEK TYDNE', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 7, 2, 'default2'), (1, 4, 4, 'OWNER'), (2, 5, 1, 'USER'), (3, 0, 2, 'POPLATEK TYDNE'), (4, 1, 0, 'USER'), (5, 6, 1, 'default1'), (6, 1, 1, 'default2'), (7, 7, 1, 'POPLATEK TYDNE'), (8, 4, 3, 'POPLATEK TYDNE'), (9, 5, 1, 'POPLATEK TYDNE'), (10, 1, 3, 'USER'), (11, 3, 1, 'POPLATEK TYDNE'), (12, 7, 2, 'USER'), (13, 5, 2, 'USER'), (14, 4, 5, 'OWNER'), (15, 2, 2, 'OWNER'), (16, 1, 0, 'default2'), (17, 3, 0, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T2.account_id = T1.account_id WHERE T1.frequency = 'POPLATEK TYDNE' AND T2.type = 'USER';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "client"."client_id") FROM "account" INNER JOIN "disp" ON "account"."account_id" = "disp"."account_id" INNER JOIN "client" ON "disp"."client_id" = "client"."client_id" WHERE "account"."frequency" = 'POPLATEK TYDNE' AND "disp"."type" = 'OWNER';

/*
Prediction Result:
(0,)
*/