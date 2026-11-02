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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (29, 71, 'Prague86', '1000-03-29');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (28, 30, 'F93', '1000-04-05');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (32, 91, 'F71', '1000-03-13');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (31, 91, 'F71', '1000-03-13');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (82, 71, 'F', '1000-03-25');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (88, 71, 'F89', '1000-04-01');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (84, 29, 82, 'F85');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (91, 28, 88, 'Prague92');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (30, 'F41', 'Prague42', 'F43', 'Prague44', 'F45', 'Prague46', 47, 48, 49, 51, NULL, 53, 54, NULL, 56);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (71, 'F57', 'Prague', 'Prague58', 'F59', 'Prague60', 'F61', 62, 63, 64, 65, NULL, 67, 68, NULL, 70);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (34, 29, '1000-03-13', 71, 71, 71, 'F71');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (33, 29, '1000-03-13', 71, 71, 71, 'F71');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (36, 29, 'F71', 71, 71, 'F71');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (71, 29, '1000-03-13', 'F71', 'F71', 71, 71, 'F71', 'F71', 71);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T2.gender = 'F') AS REAL) / COUNT(T2.client_id) * 100 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'Prague';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN "client"."gender" = 'F' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT("client"."client_id") FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "account" ON "disp"."account_id" = "account"."account_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "district"."a3" = 'Prague';

/*
Prediction Result:
(100.0,)
*/