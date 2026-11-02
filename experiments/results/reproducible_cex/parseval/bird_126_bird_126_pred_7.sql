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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'wbbp6luhvdlt', '1993-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'yrq13p', '1993-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'u78d99r', '1993-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'wbbp6luhvdlt', '1993-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, 'ilbnp', '2000-03-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 6, 'wbbp6luhvdlt', '1993-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 7, 'nrqrofqy', '1993-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, 8, 'yrq13p', '1993-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't1__d7f76e', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 't1__d7f76e', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 517.275698, 1155439218, 805.746877, 322.782838, 283598170, 742285925, -747753377);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'nrqrofqy', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 1178636309, -1390245819, 763.856372, 1055976837, 913.303855, 482.572691, 105869088, -2081315180, 1909986641);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'Decin', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'Decin', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, 'Decin', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 517.275698, 1155439218, 805.746877, 322.782838, 283598170, 742285925, -747753377);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, 'Decin', '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 1178636309, -1390245819, 763.856372, 1055976837, 913.303855, 482.572691, 105869088, -2081315180, 1909986641);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.A2 = 'Decin') AS REAL) * 100 / COUNT(account_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE STRFTIME('%Y', T2.date) = '1993';

/*
Gold Result:
(57.142857142857146,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF(district.a2 = 'Decin' AND STRFTIME('%Y', account.date) = '1993', 1, 0)) AS REAL) * 100 / COUNT(account.account_id) FROM account INNER JOIN district ON account.district_id = district.district_id;

/*
Prediction Result:
(50.0,)
*/