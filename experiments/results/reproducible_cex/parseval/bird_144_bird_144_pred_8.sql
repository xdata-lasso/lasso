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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'sl0', '2020-04-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'x58pz', '2024-08-06');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'dposiie5unw', '2025-09-21', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, -2147483648, 1, 'lfa');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483648, 1, '2eutliqa11r');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, -2147483648, 1, 'oo3o9');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, -2147483648, 1, 'a2y');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, -2147483648, 1, 'b');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (6, -2147483648, 1, '52zbuo4nrq');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (7, -2147483648, 1, '02eutliqa11r');

-- Inserting into table: card --
INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483648, 1, '9000t5c4ec', '2021-06-11');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483647, 2, 'l7', '2024-12-21');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483646, 1, 'p5qi2rk', '2021-01-15');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483645, 2, 'hncprjtu0dz', '2025-11-06');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483644, 1, 'ah0f8jsww', '2021-12-25');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483643, 2, 'i', '2025-08-02');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483642, 1, '1afgogritsj', '2025-02-02');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483641, 2, 'x', '2025-10-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483640, 1, 'v5q8qdj', '2022-08-18');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (2, 1, '5zi36c', '2025-06-06');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (3, 1, 'f', '2021-11-12');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483637, 3, 'sxcmr0o', '2024-07-19');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483636, 3, 'vy', '2024-05-28');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483635, 3, 'fofwsz', '2020-08-14');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483634, 3, 'o6l0hdt', '2025-09-04');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (-2147483633, 1, 'ow', '2021-06-16');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (4, 4, 'uzhs', '2023-01-03');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (5, 5, 'p6luhvdlttil', '2020-04-02');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (6, 6, 'rofqyp5s5b', '2020-04-03');

INSERT INTO "card" ("card_id", "disp_id", "type", "issued") VALUES (7, 7, 'ytoo3o9', '2021-04-03');

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2021-01-01', 'gce376nium52', 'VYBER KARTOU', 1, -443340271, 'uo4nrqrofqy', '5s5b', 2107872094);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 1, '2021-01-01', 'lex', 'VYBER KARTOU', 1, 1775126557, 'ji7zwau2', 'dwyrq13pyu78', 244829661);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 3, '2021-01-01', 'f8jegd21vy9u', 'VYBER KARTOU', 1, 1442655647, 'hwbdvlph', 'gndqwnqc', 555413010);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 1, '2021-01-01', 'fjgq8n2f3', 'VYBER KARTOU', 1, 806170397, 'qv0gcb98ozk', 'zbilyrkn', -688098735);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 3, '2021-01-01', '7xb72', 'VYBER KARTOU', 1, 1350414441, 'a7ryfd', 'z16ni', 2011234363);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 1, '2021-01-01', 'h', 'VYBER KARTOU', 1, 1583472758, 'rg', 'd8y', 1129658414);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 3, '2021-01-01', 'y', 'VYBER KARTOU', 1, -598313376, 'q4301jh', 'den8c68x', 1774087382);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 1, '2021-01-01', 'f', 'VYBER KARTOU', 1, -47052816, '1of77pzo72c', 'dctmf', 7929158);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 3, '2021-01-01', '1i', 'VYBER KARTOU', 1, 1897687032, '278507cv', 'jpttg', -2033879835);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2021-01-01', 'oa', 'VYBER KARTOU', 1, 382831862, '0', '7z2zezjo7wg', 1248858185);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 1, '2021-01-01', 'dgj5i', 'VYBER KARTOU', 1, -176606723, '5lnpi', '5k58', -1125548818);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '2021-01-01', '4gth2mnaj', 'VYBER KARTOU', 1, -1478011227, '3', 'okv8uttmu2', -1252009958);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 1, '2021-01-01', 'zzbe8yvkv', 'VYBER KARTOU', 1, 318331233, 'q7sx58b4', 'pmaus3auvmkr', 609771851);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '2021-01-01', 'wzw', 'VYBER KARTOU', 1, -55494714, 'n9', 'o705', 238533676);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 1, '2021-01-01', '2zob', 'VYBER KARTOU', 1, -2019656607, '0k32o', 'w', 440115543);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483633, 1, '2021-01-01', 'sorlwyngc1', 'VYBER KARTOU', 1, 681061317, 'iz', 'k1', 955267863);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '2021-01-01', 'uq', 'VYBER KARTOU', 1, 1294064538, 'uzkb52', 'gwnlas6', -2076274980);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '2024-06-15', 'z5nxih6', '2q2xlyoto', 1, 1774679448, 'oaawg96aq', '0', -850941333);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2021-01-01', '5k5swwqcgs', 't3__c2654b', 247012447, -1980249628, 'gu7v', 'e4', 1160656988);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2021-01-01', 'value', NULL, 1, 1, 'value', 'value', 1);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 1, '2084-03-29', 'nprmdposii', 'VYBER KARTOU', -1823627488, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 1, '2020-03-31', 'value', NULL, 1, 1, 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T3.amount) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '2021' AND T3.operation = 'VYBER KARTOU';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(monthly_avg_amount) FROM (SELECT AVG(amount) AS monthly_avg_amount FROM trans WHERE operation = 'VYBER KARTOU' AND STRFTIME('%Y', date) = '1998' GROUP BY STRFTIME('%m', date));

/*
Prediction Result:
(None,)
*/