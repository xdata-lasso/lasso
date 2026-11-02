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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (52, 23, 'M49', '1000-02-20');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (56, 23, 'POPLATEK TYDNE', '1000-02-24');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (20, 55, 'M23', '1000-01-24');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (19, 55, 'M23', '1000-01-24');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (22, 18, 'M23', '1000-01-24');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (21, 23, 'POPLATEK TYDNE30', '1000-02-01');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (51, 52, 21, 'M53');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (55, 56, 21, 'M57');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (23, 'M23', 'M23', 'M23', 'M23', 'M23', 'M23', 23, 23, 23, 23, 23, 23, 23, 23, 23);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (18, 'M23', 'M23', 'M23', 'M23', 'M23', 'M23', 23, 23, 23, 23, 23, 23, 23, 23, 23);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (23, 56, '1000-01-24', 23, 23, 23, 'M23');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (23, 52, 'M23', 23, 23, 'M23');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (25, 56, '1000-01-24', 'M23', 'M23', 23, 23, 'M23', 'M23', 23);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (24, 56, '1000-01-24', 'M23', 'M23', 23, 23, 'M23', 'M23', 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN client.gender = 'M' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(*) AS percentage FROM account INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE account.frequency = 'POPLATEK TYDNE';

/*
Prediction Result:
(0.0,)
*/