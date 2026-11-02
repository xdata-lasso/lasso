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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'cigce376nium', '2025-06-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'zbuo4nrqrof', '2022-11-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, '5k5swwqcgs', '2021-12-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 1, '9n8c4pgu7v', '2020-12-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 1, 'n', '2022-09-14');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'd21vy9uxj4hw', 'd', 'lph2gn', 'q', 'nqcx5h', 'cprj', -841004020, -361507387, 395.809081, 401805964, 154.065416, 261.415754, -1255130038, -1762857309, 806170397);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'M', '1974-01-01', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'M', '1974-01-01', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 'M', '1974-01-01', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'M', '1974-01-01', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483633, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483632, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483631, 't3__8c8530', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483630, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483629, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483628, 't3__8c8530', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483627, 't3__8c8530', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483626, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'M', '1974-01-01', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'M', '1974-01-01', 1);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2022-02-26', 'dposiie5unw', 'klfa9000t', 4001, 1408123494, 'SIPO', '4', 374105386);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 3, '2024-05-15', '5s5b', 'p', 4001, 882961052, 'SIPO', '2eutliqa11r', 2137741668);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 1, '2022-11-06', '0gcb98', 'zk3z', 4001, 1686459626, 'SIPO', 'lyr', 1038566008);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 3, '2022-04-12', '6vck6ah0f8js', 'wlq7xb', 4001, 602161869, 'SIPO', 'xa', 1294666887);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 1, '2024-04-05', 'dr', 'z16nijjai5d', 4001, -1625552518, 'SIPO', 'grgj', -458359144);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 3, '2024-10-27', 'f', 'og', 4001, -946046410, 'SIPO', 'tsj3ayxp1q4', -1538707438);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 1, '2025-03-06', 'e', '8c68', 4001, -683007527, 'SIPO', 'x', -1762140823);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 3, '2025-06-26', '1of77p', 'o72ctdc', 4001, 1303877941, 'SIPO', 'mfg62g0v5q8q', -1488156735);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 1, '2020-10-02', 'io22785', '7cvtjpt', 4001, 453836040, 'SIPO', '6b', -1171104889);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2025-07-13', 'i36c4bf', 'foa', 4001, 382831862, 'SIPO', '0', 76987628);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2024-12-11', 'ezjo7wg', 'd5ysxc', 4001, -405743609, 'SIPO', 'g', -20116244);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 3, '2025-02-22', 'q5l', 'pim5', 4001, -1125548818, 'SIPO', '94gth', 333302050);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 3, '2022-03-04', 'ajjl', '3', 4001, 1803796945, 'SIPO', '8uttmu', -229022515);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 3, '2020-11-10', '78lfvyz7', 'zzbe8yvkv4', 4001, -233617564, 'SIPO', '7sx58b4pma', -929383517);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 3, '2020-02-24', 'vmkrpd', 'wzw', 4001, -55494714, 'SIPO', 'n9', 101754718);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483633, 1, '2025-06-15', 'a9n0jxfofws', 'do2zobb', 4001, -397848196, 'SIPO', '0k32odwcl5a', 292557306);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '2022-07-13', 'lwyng', '1', 4000, 681061317, 'SIPO', 'iz', -499913447);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '2020-10-24', 'o6l0hdt', 'fuqyxuzkb', 4001, -30041412, 't1__3b2938', 'gwnlas6', -2076274980);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483630, 1, '2020-11-13', 'wii1', '5nxih66', 4001, -251205568, 'SIPO', 'xlyotow9', 727608179);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 4, '2024-06-15', 'value', 'value', 4001, 1, NULL, 'value', 1);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 5, '2020-09-26', 'hria2ypu', 'hsrwbbp', 4000, 13244799, 't1__3b2938', 'hvdltt', -1610064545);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 6, '2024-06-15', 'value', 'value', 4000, 1, NULL, 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE STRFTIME('%Y', T3.birth_date) BETWEEN '1974' AND '1976' AND T3.gender = 'M' AND T1.amount > 4000 AND T1.k_symbol = 'SIPO';

/*
Gold Result:
(323,)
*/

-- Prediction Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T1.birth_date) BETWEEN '1974' AND '1976' AND T3.k_symbol = 'SIPO' AND T3.amount > 4000;

/*
Prediction Result:
(0,)
*/