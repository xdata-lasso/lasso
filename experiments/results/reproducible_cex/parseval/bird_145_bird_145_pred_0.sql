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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, '9uxj4hw', '2020-04-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, '8n2f3', '2020-08-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 'lwyng', '2020-06-27');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, 'z9t', '2020-07-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, '6sto', '2024-11-11');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, -2147483648, 'ztv', '2020-03-12');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, -2147483648, 'p', '2023-08-16');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '1998-01-01', 'fa9', '00t5c4e', 1274489983, -1683203397, 'e376nium52', 'zbuo4nrqrof', 373262291);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, -2147483648, '1998-01-01', '5s5b', 'p', 882961052, 743312762, 'eutliqa11r', 'ytoo3o9', -1666765085);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '1998-01-01', '72klex14ji7z', 'VYBER KARTOU', 1, -2081315180, '2dwyrq13pyu7', 'd99rljsl0', -2031361952);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '1998-01-01', 'p5qi2rk', 'VYBER KARTOU', 1, -705985602, 'x58pz0f8je', 'd2', 1675430660);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 1, '1998-01-01', 'lph2gn', 'q', -664193365, -1070063173, 'x5hncprjtu0', 'z', -1748371085);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 2, '1998-01-01', 'qv0gcb98ozk', 'VYBER KARTOU', 1, -155284187, 'i', 'yrk', 32204797);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, -2147483648, '1998-01-01', 'ah0f8jsww', 'q7x', -541746689, 1294666887, 'fdrz16n', 'jja', -7597509);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 2, '1998-01-01', 'h5ogrgjd8yz', 'VYBER KARTOU', 1, 1250290042, 'og', 'itsj3', -491938169);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 2, '1998-01-01', '4301j', '3d', -1826414375, 357330522, '68x8vacx7a', 'u5', -290314193);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 2, '1998-01-01', 'f77pzo72ctd', 'VYBER KARTOU', 1, 481546706, 'g6', 'g0v5q8qd', 569007824);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483638, 1, '1998-01-01', 'io22785', '7cvtjpt', 453836040, 1467355421, 'ou5z', '36c', 1722106924);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483637, 1, '1998-01-01', 'foa', 'cd07z2zezjo7', 304189298, -542502665, 'ysxcmr0o', 'ztdgj5i3lq5l', 1339733032);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, -2147483648, '1998-01-01', '5k58', 's27p2', 1497321728, -95808609, 'h2mna', 'jla', 1919033056);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '2024-06-15', 'v8u', 'tmu2n', 1, -1817527403, '78lfvyz7zz', 'be8yvkv42q7', -2060082151);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 1, '1998-01-01', 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 'xfo', 'ws', 1719800120);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483633, 1, '1998-01-01', 'o', 'VYBER KARTOU', 1, 1010672881, 'obb0q0k', '2odwcl5a', 292557306);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 2, '1998-01-01', 'j', 'VYBER KARTOU', 211603887, -413043724, 'k1yoeyo6l0h', 't', -795975227);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 4, '2024-05-11', 'uzkb52', 'gwnlas6', 0, -2076274980, 'ow', 'i1z', -564679000);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 1, '1998-01-01', '62q2xlyot', 'ow9oaawg96a', 1, 966412849, '0', 'bindz', 2085299664);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483629, 4, '1998-01-01', '5wcg', 'VYBER KARTOU', -794767771, 989306270, 'tdu6bd0w96', '3vzxw1r', 237552112);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 5, '2020-12-14', '7qk', '162nh55y3d', -1, 440797047, 'vu', '6dza35r', 2072023304);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (7, 5, '1998-01-01', 'o18', 'i2hy0', 0, 168442149, 'tp6ewtqxxn', 'jabymzn2mfx7', -1659775598);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483626, 1, '1998-01-01', '8sh', 'VYBER KARTOU', -63214972, 1106724223, 'ys7dyyd1jmg', 'jach8qta8y3', -2125172723);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (8, 6, '2025-11-15', 'v4ygmayq3qdp', 'uap96rntdqr', 0, -1670945624, 'wlic7dn2', 'p490', -592014051);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (9, -2147483648, '1998-01-01', 'sqtgelcuqb', 'i9f2ccukj', 1, 1046248997, 'uik1y', 'hb08hlst1pq', 1980131681);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483623, 2, '1998-01-01', 'iz78aqql', 'VYBER KARTOU', -753065777, 190510318, 'tb8r9114qbre', '6bjeuuwsj8k', -1486030107);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (10, 7, '2025-06-18', 'pxlvri', 'surz0kaqtncg', -1, 428944759, 's3b7v88kw', 'm', 1633584225);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (11, 1, '1998-01-01', 'h', '6j47n', 0, -556370776, '50hsj', 'an', 1195320303);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483620, 2, '1998-01-01', 'wfwx', 'VYBER KARTOU', -1040088060, -2081798075, '014', '5dqts', -1340460158);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (12, 8, '2025-12-07', 'aqz2o20pj6d', 'dlysu6iphd', 0, 1849928338, '31vwq', '1oa2sb3u', 1388661799);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (13, 3, '1998-01-01', 'pavcvwn', 'qrouirl', 1, 721232773, 'pouit63xyf', 'mjwpp2', -1305057240);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(4,)
(1,)
(2,)
(2,)
*/

-- Prediction Query
SELECT T1.disp_id FROM disp AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T2.operation = 'VYBER KARTOU' AND STRFTIME('%Y', T2.date) = '1998' GROUP BY T1.disp_id HAVING AVG(T2.amount) < (SELECT AVG(amount) FROM trans WHERE operation = 'VYBER KARTOU' AND STRFTIME('%Y', date) = '1998');

/*
Prediction Result:
*/