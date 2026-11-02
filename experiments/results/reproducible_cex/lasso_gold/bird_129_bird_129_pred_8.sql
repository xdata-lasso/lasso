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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'purpose', 'offer', 'decide', 'sure', 'guy', 'finally', 1014, 1027, 1040.5, 1053, 1066.5, 1079.5, 1092, 1105, 1118);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'brother', 'begin', 'sense', 'collection', 'PM', 'themselves', 1031.0, 1046.0, 1061.5, 1076.0, 1091.5, 1106.5, 1121.0, 1136.0, 1151.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1003, 'ago', 'performance', 'rate', 'save', 'everything', 'production', 1048.0, 1065.0, 1082.5, 1099.0, 1116.5, 1133.5, 1150.0, 1167.0, 1184.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1004, 'site', 'knowledge', 'science', 'grow', 'surface', 'present', 1065.0, 1084.0, 1103.5, 1122.0, 1141.5, 1160.5, 1179.0, 1198.0, 1217.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1005, 'face', 'almost', 'kind', 'clearly', 'animal', 'value', 1082.0, 1103.0, 1124.5, 1145.0, 1166.5, 1187.5, 1208.0, 1229.0, 1250.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1006, 'election', 'all', 'discussion', 'dinner', 'show', 'training', 1099.0, 1122.0, 1145.5, 1168.0, 1191.5, 1214.5, 1237.0, 1260.0, 1283.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1007, 'dog', 'better', 'list', 'source', 'machine', 'high', 1116.0, 1141.0, 1166.5, 1191.0, 1216.5, 1241.5, 1266.0, 1291.0, 1316.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1008, 'chair', 'discover', 'perform', 'great', 'not', 'participant', 1133.0, 1160.0, 1187.5, 1214.0, 1241.5, 1268.5, 1295.0, 1322.0, 1349.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1009, 'since', 'early', 'fall', 'best', 'capital', 'dark', 1150.0, 1179.0, 1208.5, 1237.0, 1266.5, 1295.5, 1324.0, 1353.0, 1382.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1010, 'blue', 'mouth', 'table', 'husband', 'win', 'sea', 1167.0, 1198.0, 1229.5, 1260.0, 1291.5, 1322.5, 1353.0, 1384.0, 1415.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1011, 'require', 'play', 'true', 'bill', 'human', 'available', 1184.0, 1217.0, 1250.5, 1283.0, 1316.5, 1349.5, 1382.0, 1415.0, 1448.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1012, 'sit', 'agreement', 'according', 'her', 'bar', 'answer', 1201.0, 1236.0, 1271.5, 1306.0, 1341.5, 1376.5, 1411.0, 1446.0, 1481.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1013, 'wait', 'option', 'song', 'throw', 'old', 'recently', 1218.0, 1255.0, 1292.5, 1329.0, 1366.5, 1403.5, 1440.0, 1477.0, 1514.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1131, 1001, 'drive', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1132, 1002, 'spring', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1133, 1003, 'figure', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1134, 1004, 'base', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1135, 1005, 'top', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1136, 1006, 'trial', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1137, 1007, 'blood', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1138, 1008, 'long', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1139, 1009, 'prove', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1140, 1010, 'they', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1141, 1011, 'his', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1142, 1012, 'commercial', '1996-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1143, 1013, 'hospital', '1996-01-01');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1144, 1131, '1970-01-01', 'VYDAJ', 'hear', 1157, 1170, 'maintain', 'arrive', 1183);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1145, 1132, '1970-01-02', 'VYDAJ', 'determine', 1170.0, 1185.0, 'hundred', 'drop', 1204.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1146, 1133, '1970-01-03', 'VYDAJ', 'religious', 1183.0, 1200.0, 'expect', 'term', 1225.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1147, 1134, '1970-01-04', 'VYDAJ', 'example', 1196.0, 1215.0, 'wish', 'support', 1246.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1148, 1135, '1970-01-05', 'VYDAJ', 'write', 1209.0, 1230.0, 'push', 'four', 1267.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1149, 1136, '1970-01-06', 'VYDAJ', 'result', 1222.0, 1245.0, 'rise', 'institution', 1288.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1150, 1137, '1970-01-07', 'VYDAJ', 'raise', 1235.0, 1260.0, 'onto', 'executive', 1309.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1151, 1138, '1970-01-08', 'VYDAJ', 'away', 1248.0, 1275.0, 'discuss', 'attorney', 1330.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1152, 1139, '1970-01-09', 'VYDAJ', 'politics', 1261.0, 1290.0, 'reveal', 'development', 1351.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1153, 1140, '1970-01-10', 'VYDAJ', 'Congress', 1274.0, 1305.0, 'garden', 'white', 1372.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1154, 1141, '1970-01-11', 'VYDAJ', 'none', 1287.0, 1320.0, 'threat', 'yes', 1393.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1155, 1142, '1970-01-12', 'VYDAJ', 'shoulder', 1300.0, 1335.0, 'special', 'our', 1414.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1156, 1143, '1970-01-13', 'VYDAJ', 'common', 1313.0, 1350.0, 'stand', 'under', 1435.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'VYDAJ' AND T2.date LIKE '1996-01%' ORDER BY A2 ASC, T1.district_id NULLS LAST, T2.account_id NULLS LAST, T3.trans_id NULLS LAST LIMIT 10;

/*
Gold Result:
(1003,)
(1010,)
(1002,)
(1008,)
(1007,)
(1006,)
(1005,)
(1001,)
(1011,)
(1009,)
*/

-- Prediction Query
SELECT T3.A2 AS district_name, SUM(T1.amount) AS total_withdrawal FROM trans AS T1 JOIN account AS T2 ON T1.account_id = T2.account_id JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.type = 'VYDAJ' AND T1.date LIKE '1996-01%' GROUP BY T3.A2 ORDER BY total_withdrawal DESC, district_name NULLS LAST LIMIT 10;

/*
Prediction Result:
*/