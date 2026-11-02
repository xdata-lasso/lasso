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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1331, 'start', 'a', 'after', 'unit', 'education', 'your', 1335, 1339, 1343.5, 1347, 1351.5, 1355.5, 1359, 1363, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1332, 'win', 'place', 'brother', 'theory', 'article', 'bar', 1352.0, 1358.0, 1364.5, 1370.0, 1376.5, 1382.5, 1388.0, 1394.0, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1333, 'nice', 'game', 'woman', 'surface', 'effect', 'bed', 1369.0, 1377.0, 1385.5, 1393.0, 1401.5, 1409.5, 1417.0, 1425.0, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1334, 'why', 'middle', 'him', 'food', 'our', 'sign', 1386.0, 1396.0, 1406.5, 1416.0, 1426.5, 1436.5, 1446.0, 1456.0, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1372, 'no', 'receive', 'evidence', 'land', 'show', 'forget', 1376, 1380, 1384.5, 1388, 1392.5, 1396.5, 1400, 1404, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1373, 'space', 'may', 'news', 'development', 'road', 'inside', 1393.0, 1399.0, 1405.5, 1411.0, 1417.5, 1423.5, 1429.0, 1435.0, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1374, 'car', 'often', 'turn', 'notice', 'deep', 'remain', 1410.0, 1418.0, 1426.5, 1434.0, 1442.5, 1450.5, 1458.0, 1466.0, 1367);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1375, 'career', 'company', 'policy', 'someone', 'sell', 'rate', 1427.0, 1437.0, 1447.5, 1457.0, 1467.5, 1477.5, 1487.0, 1497.0, 1367);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1368, 1331, 'mention', '1973-11-10');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1369, 1331, 'team', '1973-11-11');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1370, 1331, 'authority', '1973-11-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1371, 1331, 'soon', '1973-11-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1408, 1372, 'hour', '1977-04-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1409, 1372, 'left', '1977-04-15');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1410, 1372, 'we', '1977-04-16');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1411, 1372, 'nation', '1977-04-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id GROUP BY T1.A16 ORDER BY T1.A16 DESC, COUNT(T2.account_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT COUNT(account_id) FROM account WHERE district_id = (SELECT district_id FROM district ORDER BY A16 DESC, district.district_id NULLS LAST LIMIT 1);

/*
Prediction Result:
(4,)
*/