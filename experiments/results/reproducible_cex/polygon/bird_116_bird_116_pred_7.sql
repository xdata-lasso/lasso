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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (42, 32, '55', '1000-02-26');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (31, 32, '57', '1000-02-28');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (35, 37, '42', '1000-02-12');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (34, 37, '42', '1000-02-12');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (39, 33, '42', '1000-02-12');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (38, 33, '42', '1000-02-12');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (36, 31, 38, '42');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (37, 31, 38, '42');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (33, '42', '42', '42', '42', '42', '42', 42, 42, 42, 42, 42, 42, 42, 42, 42);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (32, '42', '42', '42', '42', '42', '42', 42, 42, 42, 42, 42, 42, 42, 42, 42);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (41, 31, '1000-02-20', 51, 52, 53, '54');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (40, 42, '1993-07-05', 59, 60, 61, '62');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (44, 42, '42', 42, 42, '42');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (43, 31, '42', 42, 42, '42');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (86, 42, '1993-03-22', '87', '88', 89, 1, '90', '91', 92);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (93, 42, '1000-04-05', '95', '96', 97, 98, '99', '101', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T3.date = '1998-12-27', T3.balance, 0)) - SUM(IIF(T3.date = '1993-03-22', T3.balance, 0))) AS REAL) * 100 / SUM(IIF(T3.date = '1993-03-22', T3.balance, 0)) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN trans AS T3 ON T3.account_id = T2.account_id WHERE T1.date = '1993-07-05';

/*
Gold Result:
(-100.0,)
*/

-- Prediction Query
SELECT (t2.balance - t1.balance) / t1.balance * 100 AS increase_rate FROM trans AS t1 JOIN trans AS t2 ON t1.account_id = t2.account_id JOIN loan AS l ON t1.account_id = l.account_id JOIN client AS c ON l.account_id = c.client_id WHERE l."date" = '1993-07-05' AND t1."date" = '1993-03-22' AND t2."date" = '1998-12-27' ORDER BY l."date", t1.trans_id NULLS LAST, t2.trans_id NULLS LAST, l.loan_id NULLS LAST, c.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/