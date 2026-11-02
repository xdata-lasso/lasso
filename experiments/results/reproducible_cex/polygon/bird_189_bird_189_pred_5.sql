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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (42, 43, 'F87', '1000-03-30');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (41, 44, 'F89', '1000-04-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (46, 93, 'F43', '1000-02-13');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (45, 93, 'F43', '1000-02-13');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (56, 44, 'F', '1000-08-02');
INSERT INTO "client" ("client_id", "district_id", "gender", "birth_date") VALUES (95, 43, 'F', '1000-08-02');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (91, 41, 95, 'F92');
INSERT INTO "disp" ("disp_id", "account_id", "client_id", "type") VALUES (93, 41, 95, 'F94');
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (44, 'F57', 'F58', 'F59', 'F60', 'F61', 'F62', 63, 64, 65, -761, 66, 67, 68, 69, 70);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (43, 'F71', 'F72', 'F73', 'F74', 'F75', 'F76', 77, 78, 79, -814, 80, 81, 82, 83, 84);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (48, 41, '1000-02-13', 43, 43, 43, 'F43');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (47, 41, '1000-02-13', 43, 43, 43, 'F43');
INSERT INTO "order" ("order_id", "account_id", "bank_to", "account_to", "amount", "k_symbol") VALUES (43, 42, 'F43', 43, 43, 'F43');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (50, 42, '1000-02-13', 'F43', 'F43', 43, 43, 'F43', 'F43', 43);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (49, 41, '1000-02-13', 'F43', 'F43', 43, 43, 'F43', 'F43', 43);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(42,)
*/

-- Prediction Query
SELECT disp.account_id FROM disp INNER JOIN client ON disp.client_id = client.client_id INNER JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' AND client.birth_date = (SELECT MIN(birth_date) FROM client WHERE gender = 'F' AND district_id = (SELECT district_id FROM district ORDER BY a11 ASC, district.district_id NULLS LAST LIMIT 1)) AND district.a11 = (SELECT MIN(a11) FROM district);

/*
Prediction Result:
(41,)
(41,)
*/