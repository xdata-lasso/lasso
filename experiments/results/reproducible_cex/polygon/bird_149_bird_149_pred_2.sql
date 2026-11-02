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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (30, 51, 'OWNER52', '1000-02-23');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (57, 51, 'POPLATEK MESICNE', '1000-02-28');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (26, 28, 'POPLATEK MESICNE51', '1000-02-21');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (25, 27, 'POPLATEK MESICNE51', '1000-02-21');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (51, 51, 'POPLATEK MESICNE51', '1000-02-21');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (29, 51, 'POPLATEK MESICNE51', '1000-02-21');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (27, 30, 51, 'OWNER');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (28, 30, 51, 'OWNER');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (51, 'POPLATEK MESICNE37', 'OWNER38', 'POPLATEK MESICNE39', 'OWNER40', 'POPLATEK MESICNE41', 'OWNER42', 43, 44, 45, 8000, 46, 47, 48, 49, 50);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (24, 'POPLATEK MESICNE51', 'POPLATEK MESICNE51', 'POPLATEK MESICNE51', 'POPLATEK MESICNE51', 'POPLATEK MESICNE51', 'POPLATEK MESICNE51', 51, 51, 51, 51, 51, 51, 51, 51, 51);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (51, 57, '1000-02-21', 51, 51, 51, 'POPLATEK MESICNE51');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (32, 30, 'POPLATEK MESICNE51', 51, 51, 'POPLATEK MESICNE51');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (31, 30, 'POPLATEK MESICNE51', 51, 51, 'POPLATEK MESICNE51');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.account_id = T3.account_id WHERE T3.type <> 'OWNER' AND T1.A11 BETWEEN 8000 AND 9000;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT account.frequency FROM account INNER JOIN disp ON account.district_id = disp.client_id INNER JOIN district ON disp.client_id = district.district_id WHERE account.frequency = 'POPLATEK MESICNE' AND disp.type = 'OWNER' AND district.A11 BETWEEN 8000 AND 9000;

/*
Prediction Result:
('POPLATEK MESICNE',)
*/