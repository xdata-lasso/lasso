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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, 1, 'POPLATEK PO OBRATU', '2023-11-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 3, 'POPLATEK PO OBRATU', '2021-12-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, 3, 'POPLATEK PO OBRATU', '2020-10-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 3, 'POPLATEK PO OBRATU', '2024-03-14');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 3, 'POPLATEK PO OBRATU', '2024-10-22');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'POPLATEK PO OBRATU', '2025-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'POPLATEK PO OBRATU', '2021-08-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 1, 'POPLATEK PO OBRATU', '2021-06-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, 't2__ea5d53', '2025-11-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 1, 't2__ea5d53', '2020-07-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 1, 'POPLATEK PO OBRATU', '2025-01-26');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 't2__40f7a9', '2023-11-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, 'POPLATEK PO OBRATU', '2023-11-30');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', 'East Bohemia', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'b', 'East Bohemia', 'p6luhvdlttil', 'n', 'rmdp', 'siie', -45536098, 1861536320, 345.718563, 44952191, 768.216462, 83.204633, 1620389964, 546571701, 947159877);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483645, 'wau2dwy', 't1__765521', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', 't1__765521', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, '5k5swwqcgs', 'East Bohemia', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.district_id) FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'East Bohemia' AND T2.frequency = 'POPLATEK PO OBRATU';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(a.account_id) FROM account AS a JOIN district AS d ON a.district_id = d.district_id WHERE a.frequency = 'POPLATEK PO OBRATU' AND d.A3 = 'east Bohemia';

/*
Prediction Result:
(0,)
*/