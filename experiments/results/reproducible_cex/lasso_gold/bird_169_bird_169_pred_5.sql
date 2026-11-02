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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1310, 'character', 'chair', 'size', 'nothing', 'skin', 'later', 1312, 1314, 1316.5, 1318, 1320.5, 1322.5, 1324, 1326, 1328);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1311, 'evidence', 'employee', 'option', 'everyone', 'pattern', 'water', 1329.0, 1333.0, 1337.5, 1341.0, 1345.5, 1349.5, 1353.0, 1357.0, 1361.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1330, 1310, 'past', '1979-06-16');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1331, 1310, 'inside', '1979-06-17');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1332, 'M', '1981-08-18', 1310);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1333, 'M', '1981-08-19', 1310);
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1334, 1332, 1330, 'OWNER_z');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1335, 1332, 1330, 'OWNER_z');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1336, 1330, '1996-01-01', 1338, 1340, 1342.5, 'certainly');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1337, 1330, '1997-01-01', 1347.0, 1351.0, 1355.5, 'Mr');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1997' THEN T3.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1996' THEN T3.amount ELSE 0 END) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T3.date) = '1996' THEN T3.amount ELSE 0 END) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'M';

/*
Prediction Result:
(0.672645739910314,)
*/