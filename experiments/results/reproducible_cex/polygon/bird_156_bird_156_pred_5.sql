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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (25, 26, 'OWNER31', '1000-02-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (31, 26, 'OWNER31', '1000-02-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (28, 52, 'OWNER31', '1000-02-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (27, 52, 'OWNER31', '1000-02-01');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (48, 44, 'OWNER45', '1000-02-16');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (53, 44, 'OWNER50', '1000-02-21');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (47, 31, 48, 'OWNER49');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (52, 31, 53, 'OWNER54');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (44, 'OWNER31', 'OWNER31', 'OWNER31', 'OWNER31', 'OWNER31', 'OWNER31', 31, 31, 31, 31, 31, 31, 31, 31, 31);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (26, 'OWNER31', 'OWNER31', 'OWNER31', 'OWNER31', 'OWNER31', 'OWNER31', 31, 31, 31, 31, 31, 31, 31, 31, 31);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (30, 25, '1000-02-01', -133, 31, 31, 'OWNER31');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (29, 31, '1000-02-08', -134, 39, 40, 'OWNER41');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (31, 31, 'OWNER31', 31, 31, 'OWNER31');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (32, 31, '1000-02-01', 'OWNER31', 'OWNER31', 31, 31, 'OWNER31', 'OWNER31', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.client_id, c.gender, c.birth_date FROM client AS c INNER JOIN disp AS d ON c.client_id = d.client_id INNER JOIN loan AS l ON d.account_id = l.account_id WHERE l.amount = (SELECT MAX(amount) FROM loan);

/*
Prediction Result:
*/