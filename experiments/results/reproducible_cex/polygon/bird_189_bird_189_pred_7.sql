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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (25, 47, 'F42', '1000-02-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (24, 47, 'F44', '1000-02-15');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (47, 27, 'F47', '1000-02-17');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (28, 47, 'F38', '1000-02-09');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (29, 47, 'F', '1000-02-16');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (27, 25, 29, 'F65');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (47, 'F48', 'F49', 'F50', 'F51', 'F52', 'F53', 54, 55, 56, 57, 58, 59, 60, 61, 62);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (26, 'F47', 'F47', 'F47', 'F47', 'F47', 'F47', 47, 47, 47, 47, 47, 47, 47, 47, 47);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (31, 24, '1000-02-17', 47, 47, 47, 'F47');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (30, 24, '1000-02-17', 47, 47, 47, 'F47');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (33, 25, 'F47', 47, 47, 'F47');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (47, 24, '1000-02-17', 'F47', 'F47', 47, 47, 'F47', 'F47', 47);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(24,)
*/

-- Prediction Query
SELECT a.account_id FROM client AS c JOIN district AS d ON c.district_id = d.district_id JOIN disp AS a ON c.client_id = a.client_id WHERE c.gender = 'F' ORDER BY c.birth_date ASC, d.A11 ASC, c.client_id NULLS LAST, d.district_id NULLS LAST, a.disp_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(25,)
*/