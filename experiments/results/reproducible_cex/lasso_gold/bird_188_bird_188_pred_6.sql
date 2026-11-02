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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1113, 'human', 'themselves', 'training', 'sea', 'drive', 'top', 1117, 1121, 1125.5, 1129, 1133.5, 1137.5, 1141, 1145, 1149);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1114, 'bar', 'production', 'high', 'available', 'spring', 'early', 1134.0, 1140.0, 1146.5, 1152.0, 1158.5, 1164.5, 1170.0, 1176.0, 1182.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1115, 'old', 'present', 'participant', 'answer', 'figure', 'trial', 1151.0, 1159.0, 1167.5, 1175.0, 1183.5, 1191.5, 1199.0, 1207.0, 1215.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1116, 'finally', 'value', 'dark', 'recently', 'base', 'blood', 1168.0, 1178.0, 1188.5, 1198.0, 1208.5, 1218.5, 1228.0, 1238.0, 1248.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1153, 1113, 'long', '1995-12-31');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1154, 1113, 'prove', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1155, 1113, 'they', '1995-12-31');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1156, 1113, 'his', '1996-01-01');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1157, 1153, '1978-09-09', 25, 1057, 1161.5, 'commercial');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1158, 1153, '1978-09-10', 25, 1057, 1174.5, 'hospital');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1159, 1153, '1978-09-11', 25, 1057, 1187.5, 'hear');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1160, 1153, '1978-09-12', 25, 1057, 1200.5, 'determine');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 24 AND STRFTIME('%Y', T2.date) < '1997' ORDER BY T1.amount ASC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1153,)
*/

-- Prediction Query
SELECT t1.account_id FROM account AS t1 INNER JOIN loan AS t2 ON t1.account_id = t2.account_id WHERE t2.duration > 24 AND STRFTIME('%Y', t1.date) < '1997' AND t2.amount = (SELECT MIN(amount) FROM loan WHERE duration > 24 AND account_id IN (SELECT account_id FROM account WHERE STRFTIME('%Y', date) < '1997'));

/*
Prediction Result:
(1153,)
(1153,)
(1153,)
(1153,)
*/