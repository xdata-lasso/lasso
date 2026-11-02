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
-- DATASET 1
-- Tests COUNT(T3.account_id) vs COUNT(DISTINCT T3.account_id), and client.district_id vs account.district_id join path
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Ceske Budejovice', 'south Bohemia', '100', '1', '1', '1', 1, 1, 50.0, 9000, 1.0, 1.0, 100, 10, 10);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Prague', 'Prague', '100', '1', '1', '1', 1, 1, 50.0, 9000, 1.0, 1.0, 100, 10, 10);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 2, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1972-01-01', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 101, 10, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 102, 10, 'DISPONENT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.account_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.client_id = T3.client_id WHERE T1.A3 = 'south Bohemia' AND T3.type <> 'OWNER';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "account"."account_id") FROM "account" LEFT JOIN "district" ON "account"."district_id" = "district"."district_id" LEFT JOIN "disp" ON "account"."account_id" = "disp"."account_id" LEFT JOIN "card" ON "disp"."disp_id" = "card"."disp_id" WHERE "district"."a3" = 'south Bohemia' AND "card"."card_id" IS NULL;

/*
Prediction Result:
(0,)
*/