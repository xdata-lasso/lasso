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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (28, 34, 'OWNER87', '1000-03-30');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (91, 34, 'OWNER89', '1000-04-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (30, 31, 'OWNER99', '1000-04-11');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (29, 31, 'OWNER101', '1000-04-13');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (33, 34, 'south Bohemia44', '1000-02-15');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (35, 61, 'south Bohemia62', '1000-03-05');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (31, 91, 35, 'south Bohemia92');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (32, 91, 35, 'south Bohemia80');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (61, 'south Bohemia46', 'OWNER47', 'south Bohemia48', 'OWNER49', 'south Bohemia50', 'OWNER51', 52, 53, 54, 55, 56, 57, 58, 59, 60);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (34, 'south Bohemia64', 'south Bohemia', 'OWNER65', 'south Bohemia66', 'OWNER67', 'south Bohemia68', 69, 70, 71, 72, 73, 74, 75, 76, 77);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (36, 28, '1000-04-02', 91, 91, 91, 'OWNER91');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (39, 91, 'OWNER91', 91, 91, 'OWNER91');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (91, 28, '1000-04-02', 'OWNER91', 'OWNER91', 91, 91, 'OWNER91', 'OWNER91', 91);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.account_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.client_id = T3.client_id WHERE T1.A3 = 'south Bohemia' AND T3.type <> 'OWNER';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.account_id) FROM account AS T1 LEFT JOIN disp AS T2 ON T1.account_id = T2.account_id LEFT JOIN card AS T3 ON T2.disp_id = T3.disp_id INNER JOIN district AS T4 ON T1.district_id = T4.district_id WHERE T4.A3 = 'south Bohemia' AND T3.disp_id IS NULL;

/*
Prediction Result:
(2,)
*/