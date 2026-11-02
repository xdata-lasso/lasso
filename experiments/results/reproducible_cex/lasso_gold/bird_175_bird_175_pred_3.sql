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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1232, 'support', 'four', 'institution', 'executive', 'attorney', 'development', 1233, 1234, 1235.5, 1236, 1237.5, 1238.5, 1239, 1240, 1241);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1258, 'money', 'individual', 'usually', 'who', 'question', 'low', 1259, 1260, 1261.5, 1262, 1263.5, 1264.5, 1265, 1266, 1267);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1271, 'chair', 'employee', 'size', 'option', 'nothing', 'everyone', 1272, 1273, 1274.5, 1275, NULL, 1276.5, 1277, NULL, 1278);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1242, 1232, 'POPLATEK PO OBRATU', '1975-02-12');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1268, 1258, 'POPLATEK PO OBRATU', '1979-06-16');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1243, 'white', '1976-03-13', 1232);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1269, 'character', '1980-07-17', 1258);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1256, 'evidence', '1981-08-18', 1271);
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1244, 1243, 1242, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1257, 1256, 1242, 'OWNER');
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1270, 1269, 1268, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE T2.type = 'OWNER' AND T1.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT account.account_id) FROM account JOIN disp ON account.account_id = disp.account_id WHERE disp.type = 'OWNER' AND account.frequency = 'POPLATEK PO OBRATU';

/*
Prediction Result:
(2,)
*/