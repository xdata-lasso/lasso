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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'purpose', 'ago', 'face', 'dog', 'since', 'require', 1003, 1005, 1007.5, 1009, 1011.5, 1013.5, 1015, 1017, 1019);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'brother', 'site', 'election', 'chair', 'blue', 'sit', 1020.0, 1024.0, 1028.5, 1032.0, 1036.5, 1040.5, 1044.0, 1048.0, 1052.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1021, 1001, 'wait', '1970-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1022, 1001, 'offer', '1970-01-02');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1023, 'M', '1972-03-03', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1024, 'M', '1972-03-04', 1001);
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1025, 1023, 1021, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1026, 1023, 1021, 'OWNER');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1027, 1021, '1996-01-01', 1029, 1031, 1033.5, 'begin');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1028, 1021, '1997-01-01', 1038.0, 1042.0, 1046.5, 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(0.8746355685131195,)
*/

-- Prediction Query
SELECT ((SUM(CASE WHEN STRFTIME('%Y', loan.date) = '1997' THEN loan.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', loan.date) = '1996' THEN loan.amount ELSE 0 END)) / SUM(CASE WHEN STRFTIME('%Y', loan.date) = '1996' THEN loan.amount ELSE 0 END)) * 100 AS growth_rate FROM loan INNER JOIN disp ON loan.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE client.gender = 'M' AND STRFTIME('%Y', loan.date) IN ('1996', '1997');

/*
Prediction Result:
(0,)
*/