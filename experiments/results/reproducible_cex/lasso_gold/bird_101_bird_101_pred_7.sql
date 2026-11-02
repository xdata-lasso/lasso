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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1317, 'notice', 'why', 'middle', 'him', 'food', 'our', 1321, 1325, 1329.5, 1333, 1337.5, 1341.5, 1345, 1349, 1353);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1318, 'start', 'a', 'after', 'unit', 'education', 'your', 1338.0, 1344.0, 1350.5, 1356.0, 1362.5, 1368.5, 1374.0, 1380.0, 1386.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1319, 'win', 'place', 'brother', 'theory', 'article', 'bar', 1355.0, 1363.0, 1371.5, 1379.0, 1387.5, 1395.5, 1403.0, 1411.0, 1419.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1320, 'nice', 'game', 'woman', 'surface', 'effect', 'bed', 1372.0, 1382.0, 1392.5, 1402.0, 1412.5, 1422.5, 1432.0, 1442.0, 1452.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1357, 1317, 'sign', '1991-11-22');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1358, 1317, 'mention', '1991-11-23');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1359, 1317, 'team', '1991-11-24');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1360, 1317, 'authority', '1991-11-25');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1361, 1357, '1995-', 'soon', 'career', 1365, 1369, 'company', 'policy', 1373);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1362, 1357, '1995-', 'no', 'receive', 1378.0, 1384.0, 'evidence', 'land', 1394.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1363, 1357, '1995-', 'space', 'may', 1391.0, 1399.0, 'news', 'development', 1415.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1364, 1357, '1995-', 'car', 'often', 1404.0, 1414.0, 'turn', 'someone', 1436.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM trans WHERE STRFTIME('%Y', date) = '1995' ORDER BY date ASC, trans.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT account_id FROM trans WHERE "date" LIKE '1995%' ORDER BY "date" ASC, trans.trans_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1357,)
*/