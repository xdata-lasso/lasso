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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'tti', '2022-01-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 0, 'rofqyp5s5b', '2020-04-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, 2, 'cx5hn', '2020-06-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 0, 'rjtu', '2024-08-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 2, 'z', '2025-11-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 0, 'fjgq8n2f3', '2020-08-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 2, 'qv0gcb98ozk', '2025-03-14');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, -1, 'yzt1afgog', '2023-02-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 2, 'tsj', '2025-02-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'y', '2024-01-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, '1q43', '2024-08-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'ilbnp', '2023-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 1, 994.117864, 749.826493, 13244799, -1659388584, 1526238907);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, 'n', 'rmdp', 'siie', 'unw6klfa', '9000t5c4ec', 'gce', -1585009206, -53231346, 816.814398, 1, 396.776796, 676.357279, -1179823637, 1119186446, 781505063);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '02eu', 'liqa1', 'ryytoo3', '9hl7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 998.887019, -533293970, 520.715697, 541.066766, -977635379, 1661181156, -1372125820);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '4', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', -1612443122, -2050247126, 328.40866, 2103044118, 705.754562, 117.631729, 1298861365, 1968874827, -664193365);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-1, 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 'z16ni', 'jai', 1746373317, 1360271423, 488.601669, 1, 781.755052, 868.680978, 1449284300, -977470238, -1478247928);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-1, 'F', '2024-06-15', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (0, 'F', '2024-06-15', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 't1__18540f', '2022-02-26', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id INNER JOIN district AS T4 ON T1.district_id = T4.district_id WHERE T3.gender = 'F' ORDER BY T3.birth_date DESC, T4.A11 ASC, T1.account_id NULLS LAST, T2.disp_id NULLS LAST, T3.client_id NULLS LAST, T4.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/