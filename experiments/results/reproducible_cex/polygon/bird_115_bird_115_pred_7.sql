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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (25, 26, 'south Bohemia56', '1000-02-26');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (24, 56, 'south Bohemia56', '1000-02-26');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (56, 28, 'south Bohemia56', '1000-02-26');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (50, 56, 'M51', '1000-02-22');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (53, 56, 'south Bohemia54', '1000-02-25');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (28, 24, 53, 'south Bohemia56');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (26, 'M37', 'south Bohemia', 'south Bohemia-184', 'south Bohemia38', 'M39', 'south Bohemia40', 41, 42, 43, 44, 45, 46, 47, NULL, 49);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (56, 'M57', 'south Bohemia', 'south Bohemia-444', 'south Bohemia58', 'M59', 'south Bohemia60', 61, 62, 63, 64, NULL, 66, 67, NULL, 69);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (56, 25, '1000-02-26', 56, 56, 56, 'south Bohemia56');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (30, 24, 'south Bohemia56', 56, 56, 'south Bohemia56');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (29, 24, 'south Bohemia56', 56, 56, 'south Bohemia56');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (32, 24, '1000-02-26', 'south Bohemia56', 'south Bohemia56', 56, 56, 'south Bohemia56', 'south Bohemia56', 56);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (31, 24, '1000-02-26', 'south Bohemia56', 'south Bohemia56', 56, 56, 'south Bohemia56', 'south Bohemia56', 56);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(CASE WHEN client.gender = 'M' THEN 1 END) AS REAL) * 100) / COUNT(*) AS percentage_male_clients FROM client INNER JOIN district ON client.district_id = district.district_id WHERE district.A3 = 'south Bohemia' AND district.A4 = (SELECT MAX(A4) FROM district WHERE A3 = 'south Bohemia');

/*
Prediction Result:
(0.0,)
*/