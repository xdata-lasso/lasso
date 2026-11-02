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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1091, 'throw', 'guy', 'PM', 'everything', 'surface', 'animal', 1092, 1093, 1094.5, 1095, 1096.5, 1097.5, 1098, 1099, 1100);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1113, 'human', 'bar', 'old', 'finally', 'themselves', 'production', 1114, 1115, 1116.5, 1117, NULL, 1118.5, 1119, NULL, 1120);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1101, 1091, 'show', '1990-10-21');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1110, 1113, 'win', '1994-03-02');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1102, 'F', '1991-11-22', 1091);
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1103, 1102, 1101, 'machine');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1109, 1102, 1110, 'machine');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1104, 1101, '1992-01-23', 1105, 1106, 1107.5, 'not');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1111, 1110, '1992-01-23', 1105, 1106, 1107.5, 'not');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (1108, 1103, 'capital', '1993-02-01');
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (1112, 1109, 'capital', '1993-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id WHERE T1.gender = 'F';

/*
Gold Result:
(1102,)
(1102,)
*/

-- Prediction Query
SELECT DISTINCT "client"."client_id" FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "card" ON "disp"."disp_id" = "card"."disp_id" INNER JOIN "loan" ON "disp"."account_id" = "loan"."account_id" WHERE "client"."gender" = 'F';

/*
Prediction Result:
(1102,)
*/