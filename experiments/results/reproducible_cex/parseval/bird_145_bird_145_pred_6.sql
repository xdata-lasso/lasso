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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, 'p6sto1cj', '2023-04-07');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, -2147483648, 'iztv', '2020-03-12');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, -2147483648, 'fwxqrl', '2020-03-03');

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

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 4, '2024-10-05', 'j', '9erhizgk1yoe', 0, 1483450542, 'o6l0hdt6fu', 'yxuzk', 450555855);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 2, '1998-01-01', 'gwnlas6', 'elboeowii1', 1, -457369423, 'xih6', '2q2xlyoto', 1774679448);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483630, 4, '1998-01-01', 'aawg', 'VYBER KARTOU', 1044710644, 966412849, '0', 'bindz', 2085299664);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 5, '2022-04-25', '5wcgumbc3td', 'u6bd0w9603', -1, -541917667, 'rxe9yfk', 'qk162nh55', 2105860871);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (7, 2, '1998-01-01', 'o', 'vu', 0, 1654100852, 'dza35rmki', '18ri', 1510892261);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483627, 1, '1998-01-01', 'y08ftp6ewt', 'VYBER KARTOU', -1051623642, 2013745856, 'b', 'mzn2mfx', 1243701948);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (8, 6, '2021-04-26', 'knzys7dy', 'yd1jmgjach8', 0, 973811121, 'ta8y3a17v4', 'ygmayq3qdpu', 1595033206);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (9, -2147483648, '1998-01-01', '6rntdqrhm', 'wlic7dn2', 1, 1409697108, 'p490xdmsqt', 'el', -1974774786);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483624, 4, '1998-01-01', 'b9i9f', 'VYBER KARTOU', -788896327, -1541581575, '1quik1yhb08h', 'st1', 2101986789);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (10, 7, '2025-09-21', '4iz7', 'aqqlud8ft', 0, 1183069552, '4qbre6b', 'jeuuwsj8kj', -55270062);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (11, 2, '1998-01-01', 'lvrisu', 'z0kaq', 1, 1388796595, 'g', 'c8s3b7v88k', -622923312);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483621, 2, '1998-01-01', 'b', 'VYBER KARTOU', -1924635316, 313797011, '7nxar50h', 'sjhanzxdpu', 2014610660);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (12, 8, '2023-12-06', '014', '5dqts', -1, -1340460158, '7aqz2o20p', '6dd', 1216978423);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (13, 6, '1998-01-01', 'u6iph', 'k', 0, 658507818, '2gir31vwq5', 'oa2sb3u', 1388661799);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483618, 3, '1998-01-01', 'pavcvwn', 'VYBER KARTOU', 1971816668, -1067465394, 'uirl', 'rpouit63xyf', 1394459557);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(2,)
(2,)
(2,)
(1,)
(1,)
(4,)
(2,)
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.account_id FROM trans AS T1 WHERE T1.amount < (SELECT AVG(amount) FROM trans) AND T1.date LIKE '1998%';

/*
Prediction Result:
(1,)
(2,)
(-2147483648,)
(2,)
(2,)
(2,)
(1,)
(1,)
(4,)
(2,)
(1,)
(1,)
(2,)
(2,)
(-2147483648,)
(2,)
(6,)
*/