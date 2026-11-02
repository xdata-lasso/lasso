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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'purpose', 'dog', 'wait', 'all', 'agreement', 'kind', 1007, 1013, 1019.5, 1025, 1031.5, 1037.5, 1043, 1049, 1055);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'brother', 'chair', 'offer', 'better', 'option', 'discussion', 1024.0, 1032.0, 1040.5, 1048.0, 1056.5, 1064.5, 1072.0, 1080.0, 1088.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1003, 'ago', 'since', 'begin', 'discover', 'decide', 'list', 1041.0, 1051.0, 1061.5, 1071.0, 1081.5, 1091.5, 1101.0, 1111.0, 1121.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1004, 'site', 'blue', 'performance', 'early', 'sense', 'perform', 1058.0, 1070.0, 1082.5, 1094.0, 1106.5, 1118.5, 1130.0, 1142.0, 1154.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1005, 'face', 'require', 'knowledge', 'mouth', 'rate', 'fall', 1075.0, 1089.0, 1103.5, 1117.0, 1131.5, 1145.5, 1159.0, 1173.0, 1187.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1006, 'election', 'sit', 'almost', 'play', 'science', 'table', 1092.0, 1108.0, 1124.5, 1140.0, 1156.5, 1172.5, 1188.0, 1204.0, 1220.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1061, 1001, 'true', '1970-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1062, 1002, 'according', '1970-01-02');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1063, 1003, 'song', '1970-01-03');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1064, 1004, 'sure', '1970-01-04');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1065, 1005, 'collection', '1970-01-05');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1066, 1006, 'save', '1970-01-06');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1067, 'F', '1976-07-07', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1068, 'F', '1976-07-08', 1002);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1069, 'F', '1976-07-09', 1003);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1070, 'F', '1976-07-10', 1004);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1071, 'F', '1976-07-11', 1005);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1072, 'F', '1976-07-12', 1006);
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1073, 1061, '1982-02-13', 1079, 1085, 1091.5, 'grow');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1074, 1062, '1982-02-14', 1088.0, 1096.0, 1104.5, 'clearly');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1075, 1063, '1982-02-15', 1097.0, 1107.0, 1117.5, 'dinner');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1076, 1064, '1982-02-16', 1106.0, 1118.0, 1130.5, 'source');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1077, 1065, '1982-02-17', 1115.0, 1129.0, 1143.5, 'great');
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1078, 1066, '1982-02-18', 1124.0, 1140.0, 1156.5, 'best');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'F' ORDER BY T3.amount DESC, T1.client_id NULLS LAST, T2.account_id NULLS LAST, T3.loan_id NULLS LAST LIMIT 3;

/*
Gold Result:
(1072,)
(1071,)
(1070,)
*/

-- Prediction Query
SELECT client.client_id FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN account ON disp.account_id = account.account_id INNER JOIN loan ON account.account_id = loan.account_id WHERE client.gender = 'F' ORDER BY loan.amount DESC, client.client_id NULLS LAST, disp.disp_id NULLS LAST, account.account_id NULLS LAST, loan.loan_id NULLS LAST LIMIT 3;

/*
Prediction Result:
*/