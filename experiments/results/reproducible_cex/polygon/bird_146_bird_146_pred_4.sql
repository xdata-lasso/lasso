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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (39, 64, 'F74', '1000-03-17');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (33, 71, 'F72', '1000-03-15');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (34, 66, 'F62', '1000-03-05');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (76, 35, 'OWNER77', '1000-03-20');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (67, 64, 'F', '1000-03-07');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (36, 64, 'OWNER67', '1000-03-09');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (35, 39, 67, 'OWNER');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (66, 33, 67, 'F68');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (64, 'OWNER67', 'OWNER67', 'OWNER67', 'OWNER67', 'OWNER67', 'OWNER67', 67, 67, 67, 67, 67, 67, 67, 67, 67);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (71, 'OWNER67', 'OWNER67', 'OWNER67', 'OWNER67', 'OWNER67', 'OWNER67', 67, 67, 67, 67, 67, 67, 67, 67, 67);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (38, 33, '1000-02-20', 51, 52, 53, 'F54');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (37, 39, '1000-02-25', 56, 57, 58, 'OWNER59');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (41, 33, 'OWNER67', 67, 67, 'OWNER67');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (40, 33, 'OWNER67', 67, 67, 'OWNER67');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (43, 33, '1000-03-09', 'OWNER67', 'OWNER67', 67, 67, 'OWNER67', 'OWNER67', 67);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (42, 39, '1000-03-09', 'OWNER67', 'OWNER67', 67, 67, 'OWNER67', 'OWNER67', 67);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id WHERE T1.gender = 'F';

/*
Gold Result:
(67,)
(67,)
*/

-- Prediction Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id INNER JOIN loan AS T5 ON T3.account_id = T5.account_id WHERE T1.gender = 'F' AND T2.type = 'OWNER';

/*
Prediction Result:
(67,)
*/