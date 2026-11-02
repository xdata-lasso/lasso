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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (47, 28, '48', '1000-02-19');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (54, 28, '55', '1000-02-26');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (23, 25, '28', '1000-01-29');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (22, 25, '28', '1000-01-29');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (27, 28, '39', '1000-02-10');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (26, 28, '41', '1000-02-12');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (24, 54, 26, '28');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (25, 54, 26, '28');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (21, '28', '28', '28', '28', '28', '28', 28, 28, 28, 28, 28, 28, 28, 28, 28);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (28, '28', '28', '28', '28', '28', '28', 28, 28, 28, 28, 28, 28, 28, 28, 28);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (43, 47, '1996-01-03', 98832, 44, 45, '46');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (50, 54, '1996-01-01', 98832, 51, 52, '53');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (30, 54, '28', 28, 28, '28');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (29, 54, '28', 28, 28, '28');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (32, 54, '1000-01-29', '28', '28', 28, 28, '28', '28', 28);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (31, 54, '1000-01-29', '28', '28', 28, 28, '28', '28', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.birth_date FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.date = '1996-01-03' AND T1.amount = 98832;

/*
Gold Result:
('1000-02-10',)
('1000-02-12',)
*/

-- Prediction Query
SELECT client.birth_date FROM loan INNER JOIN account ON loan.account_id = account.account_id INNER JOIN client ON account.district_id = client.district_id WHERE loan.amount = 98832 AND loan.date BETWEEN '1996-01-01' AND '1996-12-31';

/*
Prediction Result:
('1000-02-10',)
('1000-02-12',)
('1000-02-10',)
('1000-02-12',)
*/