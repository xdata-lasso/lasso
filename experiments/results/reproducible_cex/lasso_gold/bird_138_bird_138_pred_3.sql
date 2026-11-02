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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'purpose', 'dog', 'wait', 'all', 'agreement', 'kind', 1007, 1013, 1019.5, 1025, 1031.5, 1037.5, 1043, 0, 1049);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'brother', 'chair', 'offer', 'better', 'option', 'discussion', 1024.0, 1032.0, 1040.5, 1048.0, 1056.5, 1064.5, 1072.0, 0, 1082.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1003, 'ago', 'since', 'begin', 'discover', 'decide', 'list', 1041.0, 1051.0, 1061.5, 1071.0, 1081.5, 1091.5, 1101.0, 0, 1115.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1004, 'site', 'blue', 'performance', 'early', 'sense', 'perform', 1058.0, 1070.0, 1082.5, 1094.0, 1106.5, 1118.5, 1130.0, 0, 1148.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1005, 'face', 'require', 'knowledge', 'mouth', 'rate', 'fall', 1075.0, 1089.0, 1103.5, 1117.0, 1131.5, 1145.5, 1159.0, 0, 1181.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1006, 'election', 'sit', 'almost', 'play', 'science', 'table', 1092.0, 1108.0, 1124.5, 1140.0, 1156.5, 1172.5, 1188.0, 0, 1214.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1055, 'true', 'grow', 'husband', 'everything', 'capital', 'themselves', 1061, 1067, 1073.5, 1079, 1085.5, 1091.5, 1097, 0, 1103);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1056, 'according', 'clearly', 'bill', 'surface', 'win', 'production', 1078.0, 1086.0, 1094.5, 1102.0, 1110.5, 1118.5, 1126.0, 0, 1136.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1057, 'song', 'dinner', 'her', 'animal', 'human', 'present', 1095.0, 1105.0, 1115.5, 1125.0, 1135.5, 1145.5, 1155.0, 0, 1169.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1058, 'sure', 'source', 'throw', 'show', 'bar', 'value', 1112.0, 1124.0, 1136.5, 1148.0, 1160.5, 1172.5, 1184.0, 0, 1202.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1059, 'collection', 'great', 'guy', 'machine', 'old', 'training', 1129.0, 1143.0, 1157.5, 1171.0, 1185.5, 1199.5, 1213.0, 0, 1235.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1060, 'save', 'best', 'PM', 'not', 'finally', 'high', 1146.0, 1162.0, 1178.5, 1194.0, 1210.5, 1226.5, 1242.0, 0, 1268.0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1109, 'M', '1970-01-01', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1110, 'M', '1970-01-02', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1111, 'M', '1970-01-03', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1112, 'M', '1970-01-04', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1113, 'M', '1970-01-05', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1114, 'M', '1970-01-06', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'M' AND T2.A15 = (SELECT T3.A15 FROM district AS T3 ORDER BY T3.A15 DESC, T3.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client AS T2 WHERE T2.gender = 'M' AND T2.district_id = (SELECT T1.district_id FROM district AS T1 WHERE NOT T1.A15 IS NULL ORDER BY T1.A15 DESC, T1.district_id NULLS LAST LIMIT 1 OFFSET 1);

/*
Prediction Result:
(0,)
*/