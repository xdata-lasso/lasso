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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (36, 73, '69', '1000-03-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (35, 73, '71', '1000-03-14');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (29, 31, '73', '1000-03-15');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (28, 31, '73', '1000-03-15');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (33, 34, '65', '1000-02-17');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (32, 34, '48', '1000-02-19');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (30, 35, 32, '91');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (31, 36, 32, '92');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (73, '74', '75', '76', '77', '78', '79', 80, 81, 82, 83, NULL, 85, 86, NULL, 88);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (34, '50', '51', '52', '53', '54', '55', 56, 57, 58, 59, NULL, 61, 62, NULL, 64);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (38, 35, '1000-03-15', 73, 73, 73, '73');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (37, 35, '1000-03-15', 73, 73, 73, '73');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (40, 35, '73', 73, 73, '73');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (39, 35, '73', 73, 73, '73');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (42, 35, '1000-03-15', '73', '73', 73, 73, '73', '73', 73);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (41, 35, '1000-03-15', '73', '73', 73, 73, '73', '73', 73);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.gender FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id ORDER BY T1.A11 DESC, T2.birth_date ASC, T1.district_id NULLS LAST, T2.client_id NULLS LAST LIMIT 1;

/*
Gold Result:
('65',)
*/

-- Prediction Query
SELECT T4.gender FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T1.account_id = T3.account_id INNER JOIN client AS T4 ON T3.client_id = T4.client_id ORDER BY T2.A11 DESC, T4.birth_date ASC, T1.account_id NULLS LAST, T2.district_id NULLS LAST, T3.disp_id NULLS LAST, T4.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('48',)
*/