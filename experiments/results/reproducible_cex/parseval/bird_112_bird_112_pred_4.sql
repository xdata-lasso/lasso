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
-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't1__db657f', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 't1__db657f', 'wbbp6luhvdlt', 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 1038707349, 1419861592, 663.001988, 374105386, 950.466571, 796.740316, -1683203397, 528680845, -1585009206);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 't1__db657f', '52zb', 'uo4nrqrofqy', '5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 937.856955, 645.419272, 1644911394, -1666765085, 1178636309);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'F', '1976-01-29', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'F', '1976-01-29', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'F', '1976-01-29', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'F', '1976-01-29', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'F', '1976-01-29', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'F', '1976-01-29', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'F', '1976-01-29', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'F', '1976-01-29', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 't2__4f508b', '1976-01-29', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 't2__4f508b', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 't2__4f508b', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, 'F', '1976-01-29', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.A2 FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T2.birth_date = '1976-01-29' AND T2.gender = 'F';

/*
Gold Result:
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
('t1__db657f',)
*/

-- Prediction Query
SELECT T3.A2 FROM client AS T1 JOIN disp AS T2 ON T1.client_id = T2.client_id JOIN account AS T4 ON T2.account_id = T4.account_id JOIN district AS T3 ON T4.district_id = T3.district_id WHERE T1.gender = 'F' AND T1.birth_date = '1976-01-29';

/*
Prediction Result:
*/