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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, '2rk', '2021-01-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 2, 'qx58pz', '2024-08-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 1, 'f8jegd21vy9u', '2024-02-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 1, 'ph2', '2021-03-22');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, 'p', '2023-01-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'ilbnp', '2023-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't2__192509', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1, 945.642658, 795.366812, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 't2__192509', 'posiie5unw6k', 'fa9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 418417917, -1031969798, 242.260296, 1, 938.694822, 499.570479, 902551284, 2107872094, 882961052);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 145.402595, 1661181156, 180.527064, 27.036693, 1649269347, -1116181514, 1255852738);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '2021-05-27', -1364429300, 60, 998.421621, 'prmd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2021-09-16', -87647544, 60, 353.366837, 'v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 1, '2022-04-21', 1968874827, 60, 345.35543, 'cx5hn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 1, '2021-08-31', -841004020, 60, 415.830002, '79fjgq8');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 4, '2022-02-26', 907682809, 1, 227.766936, 'iie5u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.loan_id, T2.A2, T2.A11 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.duration = 60;

/*
Gold Result:
(-2147483647, 't2__192509', 1)
(-2147483646, 't2__192509', 1)
(-2147483645, 't2__192509', 1)
(1, 't2__192509', 1)
*/

-- Prediction Query
SELECT T1.loan_id, T2.A3 AS district, T2.A11 AS average_salary FROM loan AS T1 INNER JOIN district AS T2 ON T1.account_id = T2.district_id WHERE T1.duration = 60;

/*
Prediction Result:
(-2147483647, '5k5swwqcgs', 1)
(-2147483646, '5k5swwqcgs', 1)
(-2147483645, '5k5swwqcgs', 1)
(1, '5k5swwqcgs', 1)
*/