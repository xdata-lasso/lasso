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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (36, 63, 'Prague61', '1000-03-04');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (35, 80, 'Prague78', '1000-03-21');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (28, 29, 'Prague35', '1000-02-05');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (27, 30, 'Prague35', '1000-02-05');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (32, 63, 'Prague35', '1000-02-05');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (31, 63, 'Prague35', '1000-02-05');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (29, 35, 31, 'Prague35');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (30, 35, 31, 'Prague35');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (80, 'Prague81', 'Prague82', 'Prague83', 'Prague84', 'Prague85', 'Prague86', 87, 88, 89, 90, NULL, 92, 93, NULL, 95);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (63, 'Prague64', 'Prague', 'Prague65', 'Prague66', 'Prague67', 'Prague68', 69, 70, 71, 72, 73, 74, 75, 76, 77);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (34, 35, '1000-02-15', 46, 47, 48, 'Prague49');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (33, 36, '1000-02-20', 51, 52, 53, 'Prague54');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (38, 35, 'Prague35', 35, 35, 'Prague35');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (37, 35, 'Prague35', 35, 35, 'Prague35');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (40, 35, '1000-02-05', 'Prague35', 'Prague35', 35, 35, 'Prague35', 'Prague35', 35);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (39, 35, '1000-02-05', 'Prague35', 'Prague35', 35, 35, 'Prague35', 'Prague35', 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T1.district_id = T3.district_id WHERE T3.A3 = 'Prague';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM account AS a INNER JOIN district AS d ON a.district_id = d.district_id INNER JOIN loan AS l ON a.account_id = l.account_id WHERE d.A3 = 'Prague';

/*
Prediction Result:
(1,)
*/