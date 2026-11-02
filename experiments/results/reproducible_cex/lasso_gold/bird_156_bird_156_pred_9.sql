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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1137, 'high', 'available', 'spring', 'early', 'prove', 'hospital', 1141, 1145, 1149.5, 1153, 1157.5, 1161.5, 1165, 1169, 1173);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1138, 'participant', 'answer', 'figure', 'trial', 'they', 'hear', 1158.0, 1164.0, 1170.5, 1176.0, 1182.5, 1188.5, 1194.0, 1200.0, 1206.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1139, 'dark', 'recently', 'base', 'blood', 'his', 'determine', 1175.0, 1183.0, 1191.5, 1199.0, 1207.5, 1215.5, 1223.0, 1231.0, 1239.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1140, 'sea', 'drive', 'top', 'long', 'commercial', 'religious', 1192.0, 1202.0, 1212.5, 1222.0, 1232.5, 1242.5, 1252.0, 1262.0, 1272.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1177, 1137, 'example', '1994-03-02');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1178, 1137, 'science', '1994-03-03');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1179, 1137, 'write', '1994-03-04');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1180, 1137, 'result', '1994-03-05');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1181, 'raise', '1998-07-06', 1137);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1182, 'away', '1998-07-07', 1137);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1183, 'politics', '1998-07-08', 1137);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1184, 'Congress', '1998-07-09', 1137);
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1185, 1181, 1177, 'OWNER_z');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1186, 1181, 1177, 'OWNER_z');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1187, 1181, 1177, 'OWNER_z');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1188, 1181, 1177, 'OWNER_z');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1189, 1177, '1973-11-10', 1193, 1197, 1201.5, 'none');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1190, 1177, '1973-11-11', 1202.0, 1208.0, 1214.5, 'shoulder');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1191, 1177, '1973-11-12', 1211.0, 1219.0, 1227.5, 'election');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1192, 1177, '1973-11-13', 1220.0, 1230.0, 1240.5, 'common');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.client_id FROM client AS c JOIN disp AS d ON c.client_id = d.client_id JOIN account AS a ON d.account_id = a.account_id JOIN loan AS l ON a.account_id = l.account_id ORDER BY l.amount DESC, c.client_id NULLS LAST, d.disp_id NULLS LAST, a.account_id NULLS LAST, l.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1181,)
*/