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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, -2147483648, 'bnp', '2023-01-01');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'F', '2023-05-30', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'F', '2020-11-04', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'w6kl', '2020-12-06', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 't1__a92fd3', '2021-11-08', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 't1__a92fd3', '2022-04-27', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, 1, -2147483648, 'dpos');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, 1, -2147483648, '0t5c4ecigc');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 2, -2147483648, '6nium52zb');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, 4, -2147483648, 'wwqcg');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, 5, -2147483648, 'pgu7vfe4');

-- Inserting into table: card --
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483648, 1, 'junior', '2021-06-28');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483647, 1, 'junior', '2020-01-23');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483646, 2, 'junior', '2023-08-27');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483645, 1, 'junior', '2022-04-13');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483644, 2, 'junior', '2023-01-30');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483643, 1, 'junior', '2022-11-29');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483642, 2, 'junior', '2025-06-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483641, 1, 'junior', '2020-03-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483640, 2, 'junior', '2024-08-27');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483639, 3, 'junior', '2023-05-04');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (2, 1, 'junior', '2022-10-26');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (3, 1, 'junior', '2020-01-28');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483636, 3, 'junior', '2024-03-30');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483635, 3, 'junior', '2022-07-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483634, 3, 'junior', '2020-10-31');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483633, 1, 'junior', '2021-06-29');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483632, 1, 't3__074eec', '2020-03-04');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483631, 1, 't3__074eec', '2023-07-07');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483630, 1, 't3__074eec', '2020-08-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483629, 1, 'junior', '2023-02-12');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (4, 4, 'junior', '2023-04-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (5, 5, 't3__1cfd3e', '2021-05-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.gender = 'F' AND T3.type = 'junior';

/*
Gold Result:
(17,)
*/

-- Prediction Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN card AS T2 ON T1.client_id = T2.disp_id WHERE T1.gender = 'F' AND T2.type = 'junior';

/*
Prediction Result:
(13,)
*/