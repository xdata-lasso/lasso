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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (79, 79, 'VYDAJ42', '1000-02-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (56, 79, 'VYDAJ44', '1000-02-15');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (79, 31, 'VYDAJ79', '1000-03-21');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (33, 79, 'VYDAJ79', '1000-03-21');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (32, 79, 'VYDAJ79', '1000-03-21');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (30, 56, 32, 'VYDAJ79');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (31, 56, 33, 'VYDAJ79');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (56, 'VYDAJ94', 'VYDAJ57', 'VYDAJ58', 'VYDAJ59', 'VYDAJ60', 'VYDAJ61', 62, 63, 64, 65, NULL, 67, 68, 69, 70);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (79, 'VYDAJ95', 'VYDAJ80', 'VYDAJ81', 'VYDAJ82', 'VYDAJ83', 'VYDAJ84', 85, 86, 87, 88, NULL, 90, 91, NULL, 93);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (35, 56, '1000-03-21', 79, 79, 79, 'VYDAJ79');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (34, 56, '1000-03-21', 79, 79, 79, 'VYDAJ79');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (37, 56, 'VYDAJ79', 79, 79, 'VYDAJ79');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (48, 56, '1000-02-19', 'VYDAJ', 'VYDAJ50', 51, 52, 'VYDAJ53', 'VYDAJ54', NULL);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (71, 79, '1000-03-14', 'VYDAJ', 'VYDAJ73', 74, 75, 'VYDAJ76', 'VYDAJ77', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.A2 FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ';

/*
Gold Result:
('VYDAJ95',)
*/

-- Prediction Query
SELECT DISTINCT T2.A2 FROM trans AS T1 INNER JOIN district AS T2 ON T1.account_id = T2.district_id WHERE T1.type = 'VYDAJ';

/*
Prediction Result:
('VYDAJ94',)
('VYDAJ95',)
*/