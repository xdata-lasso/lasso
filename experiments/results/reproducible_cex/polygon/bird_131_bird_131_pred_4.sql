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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (31, 43, 'D41', '1000-02-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (32, 60, 'C58', '1000-03-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (43, 27, 'D43', '1000-02-13');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (28, 43, 'D43', '1000-02-13');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (27, 32, 28, 'D43');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (43, 'C44', 'C86', 'D45', 'C46', 'D47', 'C48', 49, 50, 51, 52, 53, 54, 55, 56, 57);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (60, 'D61', 'C62', 'D63', 'C64', 'D65', 'C66', 67, 68, 69, 70, 71, 72, 73, 74, 75);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (30, 31, '1000-03-20', 79, 80, 81, 'C');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (29, 32, '1000-03-24', 83, 84, 85, 'D');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (34, 32, 'D43', 43, 43, 'D43');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (33, 32, 'D43', 43, 43, 'D43');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (35, 32, '1000-02-13', 'D43', 'D43', 43, 43, 'D43', 'D43', 43);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.status IN ('C', 'D') GROUP BY T2.A3 ORDER BY SUM(T3.amount) DESC, T2.A3 NULLS LAST LIMIT 1;

/*
Gold Result:
('C62',)
*/

-- Prediction Query
SELECT T1.A3 FROM district AS T1 JOIN account AS T2 ON T1.district_id = T2.district_id JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T3.status = 'C' GROUP BY T1.A3 ORDER BY COUNT(T3.loan_id) DESC, T1.A3 NULLS LAST LIMIT 1;

/*
Prediction Result:
('C86',)
*/