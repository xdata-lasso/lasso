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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (18, 20, 'gold32', '1000-02-02');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (32, 20, 'gold32', '1000-02-02');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (39, 40, 'gold', '1000-02-11');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (34, 35, 'junior', '1000-02-06');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (21, 19, 'gold32', '1000-02-02');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (37, 20, 'gold32', '1000-02-02');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (35, 32, 37, 'junior33');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (40, 32, 37, 'gold38');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (19, 'gold32', 'gold32', 'gold32', 'gold32', 'gold32', 'gold32', 32, 32, 32, 32, 32, 32, 32, 32, 32);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (20, 'gold32', 'gold32', 'gold32', 'gold32', 'gold32', 'gold32', 32, 32, 32, 32, 32, 32, 32, 32, 32);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (23, 18, '1000-02-02', 32, 32, 32, 'gold32');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (22, 32, '1000-02-02', 32, 32, 32, 'gold32');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (25, 18, 'gold32', 32, 32, 'gold32');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (24, 32, 'gold32', 32, 32, 'gold32');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (27, 32, '1000-02-02', 'gold32', 'gold32', 32, 32, 'gold32', 'gold32', 32);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (26, 32, '1000-02-02', 'gold32', 'gold32', 32, 32, 'gold32', 'gold32', 32);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id WHERE T1.type IN ('gold', 'junior');

/*
Gold Result:
(32,)
(32,)
*/

-- Prediction Query
SELECT T1.account_id FROM disp AS T1 INNER JOIN card AS T2 ON T1.disp_id = T2.disp_id WHERE T2.type IN ('gold', 'junior') GROUP BY T1.account_id HAVING COUNT(DISTINCT T2.type) = 2;

/*
Prediction Result:
(32,)
*/