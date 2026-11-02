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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, 1, 'POPLATEK TYDNE', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 1, 'POPLATEK TYDNE', '2022-01-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, 2, 'POPLATEK TYDNE', '2022-06-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 2, 'POPLATEK TYDNE', '2020-04-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 2, 'POPLATEK TYDNE', '2025-04-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 2, 'POPLATEK TYDNE', '2024-04-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, 'POPLATEK TYDNE', '2022-09-10');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 1, 'POPLATEK TYDNE', '2022-12-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, 'POPLATEK TYDNE', '2025-01-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 1, 'POPLATEK TYDNE', '2021-11-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 1, 't2__b91e11', '2023-10-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483637, 1, 't2__b91e11', '2022-12-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'v', '2022-01-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, 'h2gn', '2020-08-28');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'POPLATEK TYDNE', '2022-11-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 1, 'POPLATEK TYDNE', '2025-06-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 1, 'POPLATEK TYDNE', '2025-06-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 1, 'POPLATEK TYDNE', '2023-11-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, 1, 'POPLATEK TYDNE', '2022-12-08');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (9, 1, 'POPLATEK TYDNE', '2021-02-05');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'n', 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', 'gce', -1585009206, -53231346, 816.814398, -443340271, 676.357279, 225.300904, 1119186446, 781505063, 418417917);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'fqyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 998.887019, -533293970, 520.715697, 541.066766, -977635379, 1661181156, -1372125820);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 't1__c9e906', '2021-05-27', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 't1__94dc7a', '2025-07-21', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 't1__94dc7a', '2021-07-18', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 't1__94dc7a', '2023-01-22', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 't1__94dc7a', '2021-01-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'x58pz0f8je', '2021-02-03', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'd21vy9uxj4hw', '2020-04-02', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'M', '2023-11-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'M', '2021-11-08', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (6, 'M', '2023-03-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (7, 'M', '2024-01-05', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (8, 'M', '2020-06-07', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, 'M', '2023-04-14', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T2.frequency = 'POPLATEK TYDNE';

/*
Gold Result:
(46.15384615384615,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "client"."gender" = 'M' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("client"."gender") AS percentage_of_male_clients FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "account" ON "disp"."account_id" = "account"."account_id" WHERE "account"."frequency" = 'POPLATEK TYDNE';

/*
Prediction Result:
(None,)
*/