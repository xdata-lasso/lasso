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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (28, 29, 'M29', '1000-01-30');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (27, 29, 'M29', '1000-01-30');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (31, 33, 'M29', '1000-01-30');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (30, 33, 'M29', '1000-01-30');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (45, 29, 'M', '1000-02-16');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (34, 29, 'M62', '1000-03-05');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (32, 27, 34, 'M29');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (33, 27, 34, 'M29');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (29, 'M47', 'M48', 'M49', 'M50', 'M51', 'M52', 53, 54, 55, 56, 57, 58, 59, 60, 61);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (36, 27, '1000-01-30', 29, 29, 29, 'M29');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (35, 27, '1000-01-30', 29, 29, 29, 'M29');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (38, 27, 'M29', 29, 29, 'M29');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (37, 27, 'M29', 29, 29, 'M29');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (40, 27, '1000-01-30', 'M29', 'M29', 29, 29, 'M29', 'M29', 29);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (39, 28, '1000-01-30', 'M29', 'M29', 29, 29, 'M29', 'M29', 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A15 = (SELECT T3.A15 FROM district AS T3 ORDER BY T3.A15 DESC, T3.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client AS c JOIN district AS d ON c.district_id = d.district_id WHERE c.gender = 'M' AND d.district_id IN (SELECT district_id FROM district ORDER BY A15 DESC, district.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Prediction Result:
(0,)
*/