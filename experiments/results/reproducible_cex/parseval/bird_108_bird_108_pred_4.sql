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
-- Inserting into table: account --
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'x1', '2025-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'dwyrq13pyu78', '2020-07-21');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '2022-02-26', 1, 907682809, 227.766936, 'iie5u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2023-08-27', 1, -1179823637, 760.580899, 'rqrofqyp5s');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 3, '2021-08-16', 1, 105869088, 353.163664, 'u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '2023-10-23', 1, 233994589, 367.405851, '4hw');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 3, '2024-08-30', 1, -1898531797, 521.610309, 'fjgq8n2f3dq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2023-10-23', 1, -1454058168, 395.957566, 'i');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2021-12-23', 1, 982314585, 279.382219, 'n6v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 1, '2020-05-20', 1784916884, 37673509, 591.134092, 'h0f8jswwlq7x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 1, '2020-03-27', 602161869, 1350414441, 987.646344, '7');

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2024-06-15', 'w6kl', 'a9', 1, 1620389964, '00t5c4ecigc', 'e376nium52', -443340271);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '2024-06-15', 'bbp02eut', 'iqa', 1, -314162272, 'ytoo3o9', 'l7', 1178636309);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (0, 2, '1970-01-01', '9rljsl0b4', 'p5qi2rk', 1, -705985602, 'x58pz0f8je', 'd2', 1675430660);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 2, '1970-01-02', 'd', 'lph2gn', 1, 1968874827, 'nqcx5h', 'cprj', -841004020);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 1, '2023-02-05', 'fdrz16n', 'jja', -7597509, -1625552518, 'grgj', '8', -458359144);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 1, '2024-10-27', 'f', 'og', -946046410, -902895762, 'ayxp1q43', '1jh3den', 357330522);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM loan AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id ORDER BY T1.amount DESC, T2.date ASC, T1.loan_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(-7597509,)
*/

-- Prediction Query
SELECT T4.amount FROM client AS T1 JOIN disp AS T2 ON T1.client_id = T2.client_id JOIN loan AS T3 ON T2.account_id = T3.account_id JOIN trans AS T4 ON T3.account_id = T4.account_id WHERE T3.amount = (SELECT MAX(amount) FROM loan) ORDER BY T4.date ASC, T1.client_id NULLS LAST, T2.disp_id NULLS LAST, T3.loan_id NULLS LAST, T4.trans_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/