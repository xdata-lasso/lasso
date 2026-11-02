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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'POPLATEK TYDNE', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'bnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'POPLATEK TYDNE', '2023-01-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 'hncprjtu0dz', '2025-11-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, -2147483648, 'POPLATEK TYDNE', '2021-09-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, '8j', '2023-03-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, -2147483648, 'POPLATEK TYDNE', '2023-12-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, 'yzt1afgog', '2023-02-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, -2147483648, 'POPLATEK TYDNE', '2023-06-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, -2147483648, 'f77p', '2024-06-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, -2147483648, 'POPLATEK TYDNE', '2025-11-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, -2147483648, 'u5zi', '2025-03-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483636, -2147483648, 'POPLATEK TYDNE', '2025-06-06');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 3, '1997-01-01', 1, 2087640001, 666.330692, 'p');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 3, '1997-01-01', 2026480202, -1576219117, 75.403642, 'nw6klf');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 3, '1997-01-01', 1, 1419861592, 663.001988, 'ecigce376n');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '1997-01-01', 1313172851, -761141909, 779.28645, '52zbuo4nrq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 3, '1997-01-01', 1, -1031969798, 242.260296, '5bbp0');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '1997-01-01', 743312762, -1822992503, 297.722676, 'qa1');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '1997-01-01', 1, 2137741668, 881.232072, 'too3o9h');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '1997-01-01', 1, 90119032, 958.92567, 'lex');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '1997-01-01', 1775126557, -74849714, 133.223471, 'zwau2dwyr');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 1, '1997-01-01', -1097120355, 244829661, 182.777264, 'l0b4y');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 1, '1997-01-01', -1025564911, -227162283, 164.583726, '9v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '2024-06-15', 1, 537874887, 698.16972, 'z0f8jegd21vy');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '1997-01-01', 1, 1442655647, 479.592965, 'bdvlph');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 1, '1997-01-01', -261132974, -1264842910, 893.16532, 'wnqcx');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2021-01-21', 1, -1255130038, 89.552801, 'dqv0gcb98ozk');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 4, '1997-01-01', 1, -155284187, 892.659478, 'lyr');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483632, 4, '1997-01-01', 1038566008, 32204797, 34.258887, '6ah');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 5, '2021-12-25', 1, 1255343543, 21.129657, '2fxa7ryfd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 2, '1997-01-01', 1, 564390026, 569.30821, 'ijja');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483629, 2, '1997-01-01', -7597509, -1625552518, 849.655083, 'grgj');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (8, 6, '2023-04-01', 1, -1478134144, 15.432127, 'xp1q430');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (9, 6, '1997-01-01', 1, 1923912467, 571.595144, 'jh3den8c68');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483626, 6, '1997-01-01', -683007527, 2035306060, 735.057703, '7afu5w');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (10, 7, '2025-01-22', 1, -1957268147, 51.002063, 'mfg62');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (11, -2147483644, '1997-01-01', 1, -1744557630, 935.463334, 'q8qdjpe1');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483623, -2147483644, '1997-01-01', -1180042408, 199672698, 993.555996, '7cvtjpttg6b');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (12, 8, '2020-03-12', 1, -1776877925, 779.693388, 'oacd07z2zez');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (13, 8, '1997-01-01', 1, 304189298, 108.948237, 'd5ysxc');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483620, 8, '1997-01-01', -405743609, -1935752926, 145.027285, 'i3lq5lnp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1997' AND T2.frequency = 'POPLATEK TYDNE' ORDER BY T1.amount, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(-2147483644,)
*/

-- Prediction Query
SELECT "a"."account_id" FROM "account" AS "a" INNER JOIN "loan" AS "l" ON "a"."account_id" = "l"."account_id" WHERE STRFTIME('%Y', "l"."date") = '1997' AND "a"."frequency" = 'POPLATEK TYDNE' AND "l"."amount" = (SELECT MIN("amount") FROM "loan" AS "l2" WHERE STRFTIME('%Y', "l2"."date") = '1997' AND "l2"."account_id" = "l"."account_id");

/*
Prediction Result:
(1,)
(2,)
(-2147483644,)
*/