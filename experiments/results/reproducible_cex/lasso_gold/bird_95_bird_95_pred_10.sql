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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1040, 0, 'agreement', '1970-01-01');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1041, 0, 'option', '1970-01-02');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1042, 0, 'decide', '1970-01-03');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1043, 0, 'sense', '1970-01-04');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1044, 'rate', '1974-05-05', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1045, 'science', '1974-05-06', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1046, 'kind', '1974-05-07', 0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1047, 'discussion', '1974-05-08', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.district_id = (SELECT district_id FROM client ORDER BY birth_date DESC, client.client_id NULLS LAST LIMIT 1) ORDER BY T2.A11 DESC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1040,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a JOIN client AS c ON a.account_id = c.client_id JOIN district AS d ON c.district_id = d.district_id WHERE d.A11 = (SELECT MAX(A11) FROM district) ORDER BY c.birth_date DESC, a.account_id NULLS LAST, c.client_id NULLS LAST, d.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/