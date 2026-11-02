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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'purpose', 'face', 'since', 'wait', 'knowledge', 'discover', 1005, 1009, 1013.5, 1017, 1021.5, 1025.5, 1029, 1033, 1037);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'brother', 'election', 'blue', 'offer', 'almost', 'early', 1022.0, 1028.0, 1034.5, 1040.0, 1046.5, 1052.5, 1058.0, 1064.0, 1070.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1003, 'ago', 'dog', 'require', 'begin', 'all', 'mouth', 1039.0, 1047.0, 1055.5, 1063.0, 1071.5, 1079.5, 1087.0, 1095.0, 1103.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1004, 'site', 'chair', 'sit', 'performance', 'better', 'play', 1056.0, 1066.0, 1076.5, 1086.0, 1096.5, 1106.5, 1116.0, 1126.0, 1136.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1041, 1001, 'agreement', '1996-10-21');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1042, 1001, 'option', '1996-10-21');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1043, 1001, 'decide', '1996-10-21');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1044, 1001, 'sense', '1996-10-21');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1045, 1041, '1970-01-01', 'rate', 'list', 1049, 1053, 'true', 'collection', 1057);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1046, 1041, '1970-01-02', 'science', 'perform', 1062.0, 1068.0, 'according', 'save', 1078.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1047, 1041, '1970-01-03', 'kind', 'fall', 1075.0, 1083.0, 'song', 'grow', 1099.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1048, 1041, '1970-01-04', 'discussion', 'table', 1088.0, 1098.0, 'sure', 'clearly', 1120.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T1.date = '1996-10-21' ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1088,)
*/

-- Prediction Query
SELECT MAX("trans"."amount") FROM "trans" INNER JOIN "disp" ON "trans"."account_id" = "disp"."account_id" INNER JOIN "card" ON "disp"."disp_id" = "card"."disp_id" WHERE "card"."issued" = '1996-10-21';

/*
Prediction Result:
(None,)
*/