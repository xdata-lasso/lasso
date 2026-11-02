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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483648, -2147483648, 'dposiie5unw', '2025-09-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, '9uxj4hw', '2020-04-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, '8n2f3', '2020-08-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 'do2zobb', '2024-07-26');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, '0', '2023-05-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, 'bymzn2mfx7h3', '2025-02-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, -2147483648, '1quik1yhb08h', '2022-01-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, -2147483648, '7nxar50h', '2023-03-22');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '1998-01-01', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 373262291);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, -2147483648, '1998-01-01', '5s5b', 'p', 882961052, 743312762, 'eutliqa11r', 'ytoo3o9', -1666765085);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '1998-01-01', '72klex14ji7z', 'VYBER KARTOU', 1, -2081315180, '2dwyrq13pyu7', 'd99rljsl0', -2031361952);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '1998-01-01', 'p5qi2rk', 'VYBER KARTOU', 1, -705985602, 'x58pz0f8je', 'd2', 1675430660);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 1, '1998-01-01', 'lph2gn', 'q', -664193365, -1070063173, 'x5hncprjtu0', 'z', -1748371085);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 3, '1998-01-01', 'qv0gcb98ozk', 'VYBER KARTOU', 1, -155284187, 'i', 'yrk', 32204797);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, -2147483648, '1998-01-01', 'ah0f8jsww', 'q7x', -541746689, 1294666887, 'fdrz16n', 'jja', -7597509);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 3, '1998-01-01', 'h5ogrgjd8yz', 'VYBER KARTOU', 1, 1250290042, 'og', 'itsj3', -491938169);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 3, '1998-01-01', '4301j', '3d', -1826414375, 357330522, '68x8vacx7a', 'u5', -290314193);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 3, '1998-01-01', 'f77pzo72ctd', 'VYBER KARTOU', 1, 481546706, 'g6', 'g0v5q8qd', 569007824);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 1, '1998-01-01', 'io22785', '7cvtjpt', 453836040, 1467355421, 'ou5z', '36c', 1722106924);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '1998-01-01', 'foa', 'cd07z2zezjo7', 304189298, -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 1339733032);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, -2147483648, '1998-01-01', '5k58', 's27p2', 1497321728, -95808609, 'h2mna', 'jla', 1919033056);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 2, '1998-01-01', 'tmu2ne578l', 'vy', -451030047, -2052653308, 'yvkv42q7s', '58b4pm', 1849819405);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 1, '1998-01-01', 'us3auvmkrpdj', 'VYBER KARTOU', 1, 1105964624, 'w5chn9m', 'o705a9n0jxfo', -1793230843);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 4, '2022-12-01', '0k32odwcl5a', 'msorlwyngc', 0, -323362455, 'j9erhizgk1', 'yoeyo6l0hdt6', 1435223075);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 2, '1998-01-01', 'yxuzk', '5', 1, -206528034, 'wn', 'as6', -2076274980);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '1998-01-01', 'wii1', 'VYBER KARTOU', -457369423, 1557188093, 'xih662q2xly', 'otow9oaawg', 1044710644);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 5, '2020-03-19', 'indz39tajz', 'td8n5wcgu', 0, -1275298282, '3', 'tdu6bd0w96', -379749892);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (7, 4, '1998-01-01', 'vzxw1rxe9yf', '7qk', 1, 643589729, 'h55y', 'dohvu06d', -438741674);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483628, 3, '1998-01-01', 'rmkio18r', 'VYBER KARTOU', 431832073, 1510892261, 'y0', '8ftp6ewtqx', 2013745856);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (8, 6, '2022-09-22', '6sto1cj8sh5k', 'zys7', -1, 1487347213, 'yd1jmgj', 'c', 973811121);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (9, 4, '1998-01-01', 'a8y3a', '7v4ygma', 0, -499203870, 'qdpuap96', 'ntdqr', -1670945624);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483625, 3, '1998-01-01', 'wlic7dn2np', 'VYBER KARTOU', -384749431, -934098178, 'gelcu', 'qb9i9f2ccu', -1414362698);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (10, 7, '2023-03-17', 't1pqomiztvb6', '4iz7', 0, 195316816, 'qlud8', 'tb', 192271618);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (11, 6, '1998-01-01', '4qbre6b', 'jeuuwsj8kj', 1, -55270062, 'xlvr', 'sur', -459075802);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483622, 2, '1998-01-01', 'q', 'VYBER KARTOU', 1388796595, -881085433, '7', 'v88kwdmdbd', -1629148699);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (12, 8, '2021-08-25', 'an', 'xdpunmw', 0, -1782325492, 'qrlawk', '14r5dqt', 1298113538);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (13, 3, '1998-01-01', '97', 'aqz2o20pj6d', 1, 1928920679, 'ysu', 'iphdku2gi', 1113005977);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483619, 7, '1998-01-01', 'vwq51oa', 'VYBER KARTOU', 1813968674, 1907670428, '3', 'oi1pav', 1206923461);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(3,)
(3,)
(3,)
(1,)
(1,)
(3,)
(1,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT disp.client_id FROM disp INNER JOIN trans ON disp.account_id = trans.account_id WHERE STRFTIME('%Y', trans.date) = '1998' AND trans.operation = 'VYBER KARTOU' AND trans.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998' AND operation = 'VYBER KARTOU');

/*
Prediction Result:
*/