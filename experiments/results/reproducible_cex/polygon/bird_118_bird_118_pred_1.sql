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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (11, 14, 'C0', '1000-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (0, 16, 'C0', '1000-01-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (18, 20, 'C0', '1000-01-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (17, 20, 'C0', '1000-01-01');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (21, 16, 'C0', '1000-01-01');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (19, 0, 21, 'C0');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (20, 0, 21, 'C0');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (14, 'C0', 'C0', 'C0', 'C0', 'C0', 'C0', 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (16, 'C0', 'C0', 'C0', 'C0', 'C0', 'C0', 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (23, 0, '1000-01-29', -463, 29, 30, 'C');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (22, 0, '1000-02-01', 921, 32, 33, 'C34');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (25, 0, 'C0', 0, 0, 'C0');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (24, 0, 'C0', 0, 0, 'C0');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (27, 0, '1000-01-01', 'C0', 'C0', 0, 0, 'C0', 'C0', 0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (26, 0, '1000-01-01', 'C0', 'C0', 0, 0, 'C0', 'C0', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(status = 'C') AS REAL) * 100 / COUNT(amount) FROM loan WHERE amount < 100000;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT CASE WHEN loan.amount < 100000 AND loan.status = 'C' THEN loan.account_id END) AS REAL) * 100.0 / CAST(COUNT(DISTINCT loan.account_id) AS REAL)) AS percentage_of_accounts FROM loan;

/*
Prediction Result:
(100.0,)
*/