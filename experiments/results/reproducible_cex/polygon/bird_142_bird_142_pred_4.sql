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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (51, 30, 'SIPO52', '1000-02-23');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (62, 30, 'Pisek63', '1000-03-06');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (32, 33, 'SIPO30', '1000-01-31');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (31, 33, 'SIPO30', '1000-01-31');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (36, 30, 'SIPO30', '1000-01-31');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (35, 30, 'SIPO30', '1000-01-31');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (33, 62, 36, 'SIPO30');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (34, 62, 36, 'SIPO30');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (30, 'Pisek', 'Pisek67', 'SIPO68', 'Pisek69', 'SIPO70', 'Pisek71', 72, 73, 74, 75, 76, 77, 78, 79, 80);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (30, 62, '1000-01-31', 30, 30, 30, 'SIPO30');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (38, 62, 'Pisek83', 84, 85, 'SIPO');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (37, 51, 'SIPO86', 87, 88, 'Pisek89');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (43, 51, '1000-02-14', 'Pisek45', 'SIPO46', 47, 48, 'SIPO', 'Pisek49', 50);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (54, 62, '1000-02-25', 'SIPO56', 'Pisek57', 58, 59, 'SIPO', 'SIPO60', 61);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.k_symbol = 'SIPO' AND T3.A2 = 'Pisek';

/*
Gold Result:
(51,)
(62,)
*/

-- Prediction Query
SELECT T2.account_id FROM district AS T1 JOIN account AS T3 ON T1.district_id = T3.district_id JOIN "order" AS T2 ON T2.account_id = T3.account_id WHERE T2.k_symbol = 'SIPO' AND T1.A2 = 'Pisek';

/*
Prediction Result:
(62,)
*/