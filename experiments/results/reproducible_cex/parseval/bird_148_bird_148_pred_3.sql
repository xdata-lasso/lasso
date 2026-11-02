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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, '8d99rljsl', '2024-09-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'yp5qi2rk', '2021-01-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, 'wbbp6luhvdlt', '2023-05-30');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 'Tabor', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'Tabor', 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 590.639932, 280.204907, 781505063, 418417917, -1031969798);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', -453362185, 481163439, 313.384575, 2123196517, 920.013763, 689.091906, 364869063, -953437896, -1097120355);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 't1__ce67c3', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 't1__ce67c3', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'bnp', '2023-01-01', 1);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483648, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483646, -2147483648, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, -2147483648, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483642, -2147483648, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483641, -2147483648, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483638, -2147483648, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483637, -2147483648, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483636, -2147483648, 1, 't3__635a32');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483635, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483634, -2147483648, 1, 't3__635a32');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483633, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, -2147483648, 4, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, -2147483648, 5, 't3__f5df87');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.account_id = T3.account_id WHERE T3.type = 'OWNER' AND T1.A2 = 'Tabor';

/*
Gold Result:
(1,)
(1,)
(3,)
(1,)
(3,)
(1,)
(3,)
(3,)
(3,)
(3,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT T1.account_id FROM account AS T1 JOIN disp AS T2 ON T1.account_id = T2.account_id JOIN client AS T3 ON T2.client_id = T3.client_id WHERE T1.district_id = (SELECT district_id FROM district WHERE A2 = 'Tabor') AND T2.type = 'OWNER';

/*
Prediction Result:
(1,)
(3,)
*/