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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (130, -2147483648, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, '7zw', '2020-03-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'dr', '2024-06-23');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'dposiie5unw', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'fa9', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'e', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, '6nium52zb', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'nrqrofqy', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'eutliqa11r', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 'ex1', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'yu78', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'qi2rkf9v', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, '1vy9uxj4', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'dqwn', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 'cprj', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, '3d', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'gcb98ozk3z', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'yrkn6vck6ah0', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483633, 'wlq7xb', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483632, '7', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483631, '6nijjai5dh', '2024-06-15', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483630, 'sj3ayxp1q430', '2024-06-15', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483648, 1, 130, '00t5c4e');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, 1, 130, '5s5b');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483646, 1, 130, 'p');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, 2, 130, 'ytoo3o9hl7');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, 1, 2, '2dwyrq');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, 2, 130, '9rljsl0b4');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483642, 1, 2, 'x58pz0f8je');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483641, 2, 130, 'bdvlph');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483640, 1, 2, 'x');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 1, 130, '0dz79f');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, 1, 130, 'gq8');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483637, 1, 1, 'grgj');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483636, 1, 1, 'yzt1afgog');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483635, 1, 130, 'jh3den8c68');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%Y', T1.birth_date) FROM client AS T1 INNER JOIN disp AS T3 ON T1.client_id = T3.client_id INNER JOIN account AS T2 ON T3.account_id = T2.account_id WHERE T2.account_id = 130;

/*
Gold Result:
('2024',)
('2024',)
('2024',)
('2024',)
('2024',)
('2024',)
('2024',)
('2024',)
('2024',)
*/

-- Prediction Query
SELECT birth_date FROM client WHERE client_id = (SELECT client_id FROM disp WHERE account_id = 130);

/*
Prediction Result:
('2024-06-15',)
*/