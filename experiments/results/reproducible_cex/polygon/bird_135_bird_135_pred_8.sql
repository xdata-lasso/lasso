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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (27, 40, 'POPLATEK MESICNE', '1000-02-11');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (22, 40, 'POPLATEK MESICNE27', '1000-01-28');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (23, 25, 'VYBER KARTOU58', '1000-03-01');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (29, 40, 'POPLATEK MESICNE27', '1000-01-28');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (28, 40, 'POPLATEK MESICNE27', '1000-01-28');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (25, 27, 28, 'VYBER KARTOU56');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (26, 27, 29, 'POPLATEK MESICNE57');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (40, 'POPLATEK MESICNE27', 'POPLATEK MESICNE27', 'POPLATEK MESICNE27', 'POPLATEK MESICNE27', 'POPLATEK MESICNE27', 'POPLATEK MESICNE27', 27, 27, 27, 27, 27, 27, 27, 27, 27);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (31, 27, '1000-01-28', 27, 27, 27, 'POPLATEK MESICNE27');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (30, 27, '1000-01-28', 27, 27, 27, 'POPLATEK MESICNE27');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (27, 27, 'POPLATEK MESICNE27', 27, 27, 'POPLATEK MESICNE27');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (42, 27, '1000-02-13', 'VYBER KARTOU44', 'VYBER KARTOU', 45, -596, 'VYBER KARTOU46', 'POPLATEK MESICNE47', 48);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (49, 27, '1000-02-20', 'POPLATEK MESICNE51', 'VYBER KARTOU', 52, -663, 'POPLATEK MESICNE53', 'VYBER KARTOU54', 55);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.balance < 0 AND T1.operation = 'VYBER KARTOU' AND T2.frequency = 'POPLATEK MESICNE';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "account"."account_id") FROM "account" INNER JOIN "trans" ON "account"."account_id" = "trans"."account_id" INNER JOIN "disp" ON "account"."account_id" = "disp"."account_id" INNER JOIN "card" ON "disp"."disp_id" = "card"."disp_id" WHERE "trans"."operation" = 'VYBER KARTOU' AND "account"."frequency" = 'POPLATEK MESICNE' AND "trans"."balance" < 0;

/*
Prediction Result:
(1,)
*/