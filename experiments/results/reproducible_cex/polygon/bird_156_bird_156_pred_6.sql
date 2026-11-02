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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (20, 50, 'OWNER25', '1000-01-26');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (25, 50, 'OWNER25', '1000-01-26');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (22, 47, 'OWNER25', '1000-01-26');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (21, 47, 'OWNER25', '1000-01-26');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (48, 44, 'OWNER45', '1000-02-16');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (54, 50, 'OWNER51', '1000-02-22');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (47, 25, 48, 'OWNER49');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (53, 25, 54, 'OWNER');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (44, 'OWNER25', 'OWNER25', 'OWNER25', 'OWNER25', 'OWNER25', 'OWNER25', 25, 25, 25, 25, 25, 25, 25, 25, 25);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (50, 'OWNER25', 'OWNER25', 'OWNER25', 'OWNER25', 'OWNER25', 'OWNER25', 25, 25, 25, 25, 25, 25, 25, 25, 25);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (24, 25, '1000-02-02', 33, 34, 35, 'OWNER36');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (23, 25, '1000-02-07', 38, 39, 40, 'OWNER41');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (27, 25, 'OWNER25', 25, 25, 'OWNER25');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (26, 20, 'OWNER25', 25, 25, 'OWNER25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
(54,)
*/

-- Prediction Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id ORDER BY T3.amount DESC, T1.client_id NULLS LAST, T2.disp_id NULLS LAST, T3.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(48,)
*/