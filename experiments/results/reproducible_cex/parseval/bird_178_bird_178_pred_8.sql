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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, -2147483648, 'dposiie5unw', '2025-09-21');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (9, 'ilbnp', '2023-01-01', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'e376nium52', '2024-06-13', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, '2dwyrq', '2024-11-10', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, 9, -2147483648, 'lfa');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, 9, -2147483648, '4');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 9, -2147483648, 'nrqrofqy');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, 2, -2147483648, '5bbp0');

-- Inserting into table: card --
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483648, 1, 't3__a6dfee', '2024-07-24');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (2, 1, 't3__a6dfee', '2020-11-01');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (3, 1, 't3__a6dfee', '2020-06-23');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483645, 1, 't3__a6dfee', '2020-03-30');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483644, 3, 't3__a6dfee', '2024-12-15');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483643, 1, 't3__a6dfee', '2023-05-04');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483642, 3, 't3__a6dfee', '2022-10-26');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483641, 1, 't3__a6dfee', '2024-10-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483640, 3, 't3__a6dfee', '2024-03-26');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483639, 3, 't3__a6dfee', '2025-02-11');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483638, 3, 't3__a6dfee', '2021-12-23');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483637, 3, 't3__a6dfee', '2021-06-29');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483636, 1, 't3__a6dfee', '2022-09-28');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483635, 1, 't3__a6dfee', '2025-11-02');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483634, 1, 't3__a6dfee', '2022-01-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.client_id = 9;

/*
Gold Result:
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
('t3__a6dfee',)
*/

-- Prediction Query
SELECT DISTINCT "card"."type" FROM "card" INNER JOIN "disp" ON "card"."disp_id" = "disp"."disp_id" WHERE "disp"."client_id" = 9;

/*
Prediction Result:
('t3__a6dfee',)
*/