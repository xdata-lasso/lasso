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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'purpose', 'brother', 'begin', 'sense', 'collection', 'PM', 1014, 1027, 1040.5, 1053, 1066.5, 1079.5, 1092, 1105, 1118);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'purpose', 'ago', 'performance', 'rate', 'save', 'everything', 1031.0, 1046.0, 1061.5, 1076.0, 1091.5, 1106.5, 1121.0, 1136.0, 1151.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1003, 'purpose', 'site', 'knowledge', 'science', 'grow', 'surface', 1048.0, 1065.0, 1082.5, 1099.0, 1116.5, 1133.5, 1150.0, 1167.0, 1184.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1004, 'purpose', 'face', 'almost', 'kind', 'clearly', 'animal', 1065.0, 1084.0, 1103.5, 1122.0, 1141.5, 1160.5, 1179.0, 1198.0, 1217.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1005, 'purpose', 'election', 'all', 'discussion', 'dinner', 'show', 1082.0, 1103.0, 1124.5, 1145.0, 1166.5, 1187.5, 1208.0, 1229.0, 1250.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1006, 'purpose', 'dog', 'better', 'list', 'source', 'machine', 1099.0, 1122.0, 1145.5, 1168.0, 1191.5, 1214.5, 1237.0, 1260.0, 1283.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1007, 'purpose', 'chair', 'discover', 'perform', 'great', 'not', 1116.0, 1141.0, 1166.5, 1191.0, 1216.5, 1241.5, 1266.0, 1291.0, 1316.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1008, 'purpose', 'since', 'early', 'fall', 'best', 'capital', 1133.0, 1160.0, 1187.5, 1214.0, 1241.5, 1268.5, 1295.0, 1322.0, 1349.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1009, 'purpose', 'blue', 'mouth', 'table', 'husband', 'win', 1150.0, 1179.0, 1208.5, 1237.0, 1266.5, 1295.5, 1324.0, 1353.0, 1382.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1010, 'purpose', 'require', 'play', 'true', 'bill', 'human', 1167.0, 1198.0, 1229.5, 1260.0, 1291.5, 1322.5, 1353.0, 1384.0, 1415.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1011, 'purpose', 'sit', 'agreement', 'according', 'her', 'bar', 1184.0, 1217.0, 1250.5, 1283.0, 1316.5, 1349.5, 1382.0, 1415.0, 1448.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1012, 'purpose', 'wait', 'option', 'song', 'throw', 'old', 1201.0, 1236.0, 1271.5, 1306.0, 1341.5, 1376.5, 1411.0, 1446.0, 1481.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1013, 'purpose', 'offer', 'decide', 'sure', 'guy', 'finally', 1218.0, 1255.0, 1292.5, 1329.0, 1366.5, 1403.5, 1440.0, 1477.0, 1514.0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1131, 'F', '1970-01-01', 1001);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1132, 'F', '1970-01-02', 1002);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1133, 'F', '1970-01-03', 1003);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1134, 'F', '1970-01-04', 1004);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1135, 'F', '1970-01-05', 1005);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1136, 'F', '1970-01-06', 1006);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1137, 'F', '1970-01-07', 1007);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1138, 'F', '1970-01-08', 1008);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1139, 'F', '1970-01-09', 1009);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1140, 'F', '1970-01-10', 1010);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1141, 'F', '1970-01-11', 1011);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1142, 'F', '1970-01-12', 1012);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1143, 'F', '1970-01-13', 1013);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
('purpose', 1)
*/

-- Prediction Query
SELECT "district"."A2", COUNT("client"."client_id") AS "female_count" FROM "client" INNER JOIN "district" ON "client"."district_id" = "district"."district_id" WHERE "client"."gender" = 'F' GROUP BY "district"."A2" ORDER BY "female_count" DESC, "district"."A2" NULLS LAST, female_count NULLS LAST LIMIT 9;

/*
Prediction Result:
('purpose', 13)
*/