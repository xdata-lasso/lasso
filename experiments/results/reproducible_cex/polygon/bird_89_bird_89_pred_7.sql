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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (20, 21, 'east Bohemia50', '1000-02-21');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (56, 58, 'POPLATEK PO OBRATU', '1000-02-27');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (56, 22, 'east Bohemia56', '1000-02-26');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (24, 58, 'east Bohemia56', '1000-02-26');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (23, 21, 'east Bohemia56', '1000-02-26');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (22, 56, 23, 'east Bohemia56');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (21, 'east Bohemia35', 'East Bohemia36', 'POPLATEK PO OBRATU37', 'east Bohemia38', 'East Bohemia39', 'POPLATEK PO OBRATU40', 41, 42, 43, 44, NULL, 46, 47, NULL, 49);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (58, 'east Bohemia59', 'east Bohemia', 'East Bohemia60', 'POPLATEK PO OBRATU61', 'east Bohemia62', 'East Bohemia63', 64, 65, 66, 67, NULL, 69, 70, NULL, 72);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (26, 56, '1000-02-26', 56, 56, 56, 'east Bohemia56');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (28, 20, 'east Bohemia56', 56, 56, 'east Bohemia56');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (27, 20, 'east Bohemia56', 56, 56, 'east Bohemia56');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (30, 56, '1000-02-26', 'east Bohemia56', 'east Bohemia56', 56, 56, 'east Bohemia56', 'east Bohemia56', 56);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (29, 56, '1000-02-26', 'east Bohemia56', 'east Bohemia56', 56, 56, 'east Bohemia56', 'east Bohemia56', 56);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.district_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'East Bohemia' AND T2.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT("account"."account_id") FROM "account" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "account"."frequency" = 'POPLATEK PO OBRATU' AND "district"."a3" = 'east Bohemia';

/*
Prediction Result:
(1,)
*/