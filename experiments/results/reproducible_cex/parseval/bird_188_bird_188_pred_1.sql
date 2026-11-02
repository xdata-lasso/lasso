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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'ilbnp', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, '6klfa9', '2024-07-24');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'oo3o9', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 'hncprjtu0dz', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, '72fxa7ryfd', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, 'sj3ayxp1q430', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, -2147483648, 'v5q8qdj', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, -2147483648, 'wgxd5ysxc', '1996-12-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (9, -2147483648, 'th', '1996-12-31');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 2, '2022-02-26', 907682809, 25, 227.766936, 'iie5u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 3, '2024-09-12', 1, 25, 801.414196, '0t5c4ecigce');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 2, '2021-06-20', -761141909, 25, 779.28645, '52zbuo4nrq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '2023-01-30', 1, 25, 220.906948, 'qy');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 3, '2023-03-15', 902551284, 25, 22.720462, '02eu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '2023-05-04', 1, 25, 186.190286, 'a11ry');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 2, '2022-02-06', 1178636309, 25, 176.308171, 'x14ji7zwau2d');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2024-01-01', 1, 25, 721.918386, 'rq13pyu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2025-11-02', 1, 25, 798.947629, '9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 2, '2021-08-18', -904834265, 25, 419.361606, 'yp5qi2rk');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 1, '2023-10-06', 556727997, 25, 860.770887, '8pz0f8je');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '2020-07-19', 1, 1, 452.27611, 'vy9uxj4');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 3, '2020-04-02', -1929953647, 25, 185.427628, 'h2gn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 1, '2020-08-28', 1, 25, 893.16532, 'wnqcx');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 4, '2021-09-23', 1, 25, 94.390081, 'n2f3dqv0g');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 1, '2020-06-01', 1, 25, 879.800692, '8ozk3zbil');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 4, '2023-02-18', 1, 25, 741.809988, 'n6vck6ah0f');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483631, 3, '2023-03-04', 1, 25, 346.706184, 'q7x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (9, 5, '2024-06-23', 1, 25, 753.351134, '6nijjai');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 1, '2025-08-02', 1, 25, 62.386264, '5o');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (8, 2, '2023-01-20', 1, 25, 100.84577, '8');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483627, 4, '2024-05-29', 1, 25, 308.482994, 'afgogri');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (12, 6, '2021-08-03', 1, 25, 123.184903, 'den8c68x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (10, 1, '2023-10-28', 1, 25, 13.875982, 'x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (11, 5, '2020-02-05', 1, 25, 983.924121, '5w1of7');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483623, 5, '2022-09-26', 1, 25, 398.637058, '72ctdctmfg62');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (15, 7, '2020-10-02', 1, 25, 432.865904, '2278');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (13, 1, '2025-07-18', 1, 25, 993.555996, '7cvtjpttg6b');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (14, 3, '2022-07-20', 1, 25, 322.910151, '5zi36c4bfkfo');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483619, 2, '2020-07-07', 1, 25, 60.937725, '7z2zezj');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (18, 8, '2023-01-12', 1, 25, 728.948186, 'ztdg');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (16, 1, '2021-08-17', 1, 25, 703.796681, '3lq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (17, 8, '2022-01-25', 1, 25, 811.930904, 'im5k');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483615, 8, '2022-10-29', 1, 25, 975.929586, '27p2r');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (21, 9, '2022-03-04', 1, 25, 925.474843, 'ajjl');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (19, 1, '2020-02-18', 1, 25, 462.366429, 'kv8u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (20, 5, '2023-05-06', 1, 25, 585.201826, 'mu2ne578lf');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483611, 6, '2024-03-25', 1, 25, 392.947196, 'zzbe8yvkv');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 24 AND STRFTIME('%Y', T2.date) < '1997' ORDER BY T1.amount ASC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT a.account_id FROM account AS a JOIN loan AS l ON a.account_id = l.account_id WHERE l.duration > 24 AND a.date < '1997-01-01' AND l.amount = (SELECT MIN(amount) FROM loan WHERE duration > 24);

/*
Prediction Result:
*/