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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (60, 28, '43', '1000-02-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (68, 28, '65', '1000-03-08');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (30, 67, '28', '1000-01-29');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (29, 67, '28', '1000-01-29');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (32, 28, '72', '1000-03-15');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (31, 28, '74', '1000-03-17');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (63, 68, 32, '64');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (67, 68, 31, '69');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (28, '45', '46', '47', '48', '49', '50', 51, 52, 53, 54, NULL, 56, 57, NULL, 59);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (34, 68, '1000-01-29', 28, 28, 28, '28');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (33, 68, '1000-01-29', 28, 28, 28, '28');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (36, 68, '28', 28, 28, '28');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (35, 68, '28', 28, 28, '28');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (38, 68, '1000-01-29', '28', '28', 28, 28, '28', '28', 28);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (37, 68, '1000-01-29', '28', '28', 28, 28, '28', '28', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client ORDER BY birth_date DESC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(60,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id INNER JOIN district AS T4 ON T3.district_id = T4.district_id ORDER BY T3.birth_date DESC, T4.A11 DESC, T1.account_id NULLS LAST, T2.disp_id NULLS LAST, T3.client_id NULLS LAST, T4.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(68,)
*/