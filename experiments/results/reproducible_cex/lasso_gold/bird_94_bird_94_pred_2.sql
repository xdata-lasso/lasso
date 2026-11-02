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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, 'purpose', 'face', 'since', 'wait', 'knowledge', 'discover', 1004, 1008, 1012.5, 1016, 1020.5, 1024.5, 1028, 1032, 1036);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1001, 'brother', 'election', 'blue', 'offer', 'almost', 'early', 1021.0, 1027.0, 1033.5, 1039.0, 1045.5, 1051.5, 1057.0, 1063.0, 1069.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1002, 'ago', 'dog', 'require', 'begin', 'all', 'mouth', 1038.0, 1046.0, 1054.5, 1062.0, 1070.5, 1078.5, 1086.0, 1094.0, 1102.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1003, 'site', 'chair', 'sit', 'performance', 'better', 'play', 1055.0, 1065.0, 1075.5, 1085.0, 1095.5, 1105.5, 1115.0, 1125.0, 1135.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1040, 'agreement', 'rate', 'list', 'true', 'collection', 'dinner', 1044, 1048, 1052.5, 1056, 1060.5, 1064.5, 1068, 1072, 1076);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1041, 'option', 'science', 'perform', 'according', 'save', 'source', 1061.0, 1067.0, 1073.5, 1079.0, 1085.5, 1091.5, 1097.0, 1103.0, 1109.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1042, 'decide', 'kind', 'fall', 'song', 'grow', 'great', 1078.0, 1086.0, 1094.5, 1102.0, 1110.5, 1118.5, 1126.0, 1134.0, 1142.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1043, 'sense', 'discussion', 'table', 'sure', 'clearly', 'best', 1095.0, 1105.0, 1115.5, 1125.0, 1135.5, 1145.5, 1155.0, 1165.0, 1175.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1080, 0, 'husband', '1970-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1081, 0, 'bill', '1970-01-02');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1082, 0, 'her', '1970-01-03');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1083, 0, 'throw', '1970-01-04');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1084, 'F', '1974-05-05', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1085, 'F', '1974-05-06', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1086, 'F', '1974-05-07', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1087, 'F', '1974-05-08', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, (SELECT MAX(A11) - MIN(A11) FROM district) FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client WHERE gender = 'F' ORDER BY birth_date ASC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1080, 109)
*/

-- Prediction Query
SELECT "account"."account_id", (MAX("district_high"."a11") - MIN("district_low"."a11")) AS "gap" FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "account" ON "disp"."account_id" = "account"."account_id" INNER JOIN "district" AS "district_low" ON "client"."district_id" = "district_low"."district_id" CROSS JOIN "district" AS "district_high" WHERE "client"."gender" = 'F' AND "client"."birth_date" = (SELECT MIN("client"."birth_date") FROM "client" WHERE "client"."gender" = 'F');

/*
Prediction Result:
(None, None)
*/