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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (25, 37, 'SVAT31', '1000-02-02');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 37, 'SVAT42', '1000-02-08');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (18, 20, 'SVAT3', '1000-01-04');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (17, 20, 'SVAT3', '1000-01-04');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (21, 37, 'SVAT3', '1000-01-04');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (20, 3, 21, 'SVAT3');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (16, 'SVAT3', 'SVAT3', 'SVAT3', 'SVAT3', 'SVAT3', 'SVAT3', 3, 3, 3, 3, 3, 3, 3, 3, 3);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (37, 'SVAT3', 'SVAT3', 'SVAT3', 'SVAT3', 'SVAT3', 'SVAT3', 3, 3, 3, 3, 3, 3, 3, 3, 3);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (23, 3, '1000-01-04', 3, 3, 3, 'SVAT3');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (22, 3, '1000-01-04', 3, 3, 3, 'SVAT3');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (39, 3, 'SVAT40', 41, 3539, 'SVAT43');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (24, 25, 'SVAT33', 34, 35, 'SVAT36');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (44, 3, '1000-02-15', 'SVAT46', 'SVAT47', 7176, 48, 'SVAT', 'SVAT49', 50);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (26, 3, '1000-02-21', 'SVAT52', NULL, 54, 55, 'SVAT56', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.frequency, T2.k_symbol FROM account AS T1 INNER JOIN "order" AS T2 ON T1.account_id = T2.account_id WHERE T1.account_id = 3 AND T2.amount = 3539;

/*
Gold Result:
('SVAT42', 'SVAT43')
*/

-- Prediction Query
SELECT COUNT(*) AS total_requests, SUM(amount) AS total_debit_amount FROM trans JOIN account ON trans.account_id = account.account_id WHERE trans.account_id = 3 AND trans.k_symbol = 'SVAT';

/*
Prediction Result:
(1, 7176)
*/