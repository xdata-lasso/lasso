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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, -2147483648, 'e5u', '2022-06-13');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'ilbnp', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'dpos', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'fa9', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, '00t5c4ecigc', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, '6nium52zb', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'qrofqyp5s5b', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 'ytoo3o9', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'lex', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, '7zwau2dwyr', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 'u78d99r', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'b4yp5qi', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 'vqx58pz0f', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, 'vy9uxj4', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'ph2', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'wnqcx', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483633, 'jtu0d', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483632, 'q8', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483631, 'qv0gcb98ozk', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483630, 'yrk', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483629, 'f8jswwl', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, '5sw', '2024-01-05', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, 1, -2147483648, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, 1, -2147483648, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 1, -2147483648, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483643, -2147483648, 'eutliqa1');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, 4, -2147483648, 't1__ba467c');

-- Inserting into table: card --
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483648, 1, 'gold', '2023-11-17');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483647, 1, 'gold', '2025-05-15');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483646, 1, 'gold', '2022-04-13');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483645, 3, 'gold', '2024-10-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483644, 1, 'gold', '2025-11-03');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483643, 3, 'gold', '2021-08-16');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483642, 1, 'gold', '2025-02-23');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483641, 3, 'gold', '2023-03-31');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483640, 1, 'gold', '2021-11-05');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (2, 1, 'gold', '2021-02-03');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (3, 1, 'gold', '2020-07-19');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483637, 3, 'gold', '2020-07-26');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483636, 3, 'gold', '2020-06-20');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483635, 3, 'gold', '2025-02-11');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483634, 1, 't2__6792c7', '2020-03-07');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483633, 1, 'gold', '2020-05-20');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483632, 1, 't2__6792c7', '2025-09-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483631, 1, 'gold', '2020-03-27');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (4, 4, 't2__6b47e5', '2020-06-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T3.birth_date) FROM disp AS T1 INNER JOIN card AS T2 ON T2.disp_id = T1.disp_id INNER JOIN client AS T3 ON T1.client_id = T3.client_id WHERE T2.type = 'gold' AND T1.type = 'OWNER';

/*
Gold Result:
(1, 1)
(1, 1)
(1, 1)
(1, 1)
(1, 1)
(1, 1)
(1, 1)
(1, 1)
(1, 1)
(1, 1)
*/

-- Prediction Query
SELECT DISTINCT T1.client_id, (STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.birth_date)) - (STRFTIME('%m-%d', '2025-01-01 00:00:00') < STRFTIME('%m-%d', T1.birth_date)) AS age FROM client AS T1 JOIN disp AS T2 ON T1.client_id = T2.client_id JOIN card AS T3 ON T2.disp_id = T3.disp_id JOIN account AS T4 ON T2.account_id = T4.account_id JOIN loan AS T5 ON T4.account_id = T5.account_id WHERE T3.type = 'gold' AND T5.status = 'A';

/*
Prediction Result:
*/