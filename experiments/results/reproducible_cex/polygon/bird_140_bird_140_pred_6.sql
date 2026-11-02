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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (38, 41, 'Pisek39', '1000-02-10');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (20, 21, 'Pisek71', '1000-03-14');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (23, 24, 'Pisek20', '1000-01-21');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (22, 25, 'Pisek20', '1000-01-21');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (27, 21, 'Pisek20', '1000-01-21');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (26, 21, 'Pisek20', '1000-01-21');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (24, 20, 26, 'Pisek20');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (25, 20, 26, 'Pisek20');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (41, 'Pisek', 'Pisek42', 'Pisek43', 'Pisek44', 'Pisek45', 'Pisek46', 47, 48, 49, 50, 51, 52, 53, 54, 55);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (21, 'Pisek56', 'Pisek57', 'Pisek58', 'Pisek59', 'Pisek60', 'Pisek61', 62, 63, 64, 65, NULL, 67, 68, NULL, 70);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (29, 20, '1000-01-21', 20, 20, 20, 'Pisek20');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (28, 20, '1000-01-21', 20, 20, 20, 'Pisek20');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (31, 20, 'Pisek20', 20, 20, 'Pisek20');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (30, 20, 'Pisek20', 20, 20, 'Pisek20');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (33, 20, '1000-01-21', 'Pisek20', 'Pisek20', 20, 20, 'Pisek20', 'Pisek20', 20);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (32, 20, '1000-01-21', 'Pisek20', 'Pisek20', 20, 20, 'Pisek20', 'Pisek20', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A2 = 'Pisek';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM account AS a JOIN district AS d ON a.district_id = d.district_id WHERE d.A2 = 'Pisek';

/*
Prediction Result:
(1,)
*/