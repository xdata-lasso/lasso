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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, '4nrq', '2023-01-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'fqyp5s5bbp0', '2024-12-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, '5sw', '2024-01-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, 'nprmdposii', '2020-11-04');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, 'iqa', '2024-10-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, -2147483648, 'p5qi2rkf9v', '2022-12-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, -2147483648, '9fjgq8n2f', '2025-02-11');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (9, -2147483648, 'ai5', '2020-09-12');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '1993-07-05', 2087640001, 907682809, 227.766936, 'iie5u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 3, '1993-07-05', -1822992503, -868774469, 138.017996, 'a11ry');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 2, '1993-07-05', 1661181156, -1372125820, 27.036693, 'p5qi2rk');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '1993-07-05', -1929953647, 1581736075, 439.200238, 'dqwn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 2, '1993-07-05', -688216274, 331812443, 790.551139, 'b');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '1993-07-05', -1496556994, -2115841792, 906.609226, 'h');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 2, '1993-07-05', 1774087382, 1732258051, 516.027628, 'f');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 3, '1993-07-05', -1180042408, 199672698, 993.555996, '7cvtjpttg6b');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 2, '1993-07-05', 2115816682, 76987628, 441.061634, 'zj');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '1993-07-05', 1816660482, -1212676731, 893.960343, '5k58');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '1993-07-05', -1125548818, 1497321728, 555.274052, 'gth2mnaj');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '1993-07-05', 1735561423, 756202403, 762.654945, '8b4pmaus3au');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '1993-07-05', -1552469358, 7342822, 259.245161, 'lyotow');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 1, '1993-07-05', 1933158443, 1295379066, 749.454983, 'w9603vz');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483634, 1, '1993-07-05', -1580984044, 150596046, 600.543738, 'hy08ftp6');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483633, 1, '2024-06-15', -646944990, -1051623642, 361.5356, 'jaby');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483632, 1, '1993-07-05', 899787662, 594760660, 439.465402, 'p490');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '1993-07-05', 906324270, 1908028688, 994.117864, 'p6luhvdlttil');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 5, '1993-07-05', 1884179925, 902551284, 22.720462, '02eu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 6, '1993-07-05', -977635379, 1661181156, 180.527064, '4');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 7, '1993-07-05', -664193365, -1070063173, 629.317167, '5hncprjtu0d');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (8, 8, '1993-07-05', 1294666887, -515895469, 832.28682, 'z16ni');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (9, 9, '1993-07-05', -683007527, 2035306060, 735.057703, '7afu5w');

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483648, 1, '2024-06-15', 'w6kl', 'a9', 1620389964, 1, '00t5c4ecigc', 'e376nium52', -443340271);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483647, 2, '2024-06-15', 'ytoo3o9hl7', 'klex14ji', -453362185, 1, 'au2dwyrq13', 'yu78', 244829661);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483646, 3, '2024-06-15', '9v', 'x58pz', -1529584866, 1, 'd2', 'vy9uxj4', -1612443122);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483645, 2, '2024-06-15', 'cx5hn', 'p', -988981234, 1, 'u0dz7', 'fjgq8n2f3', 806170397);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483644, 3, '2024-06-15', '8ozk3zbil', 'yrkn6vck6ah0', -1520489792, 1, 'wlq7xb', '72fxa7ryfd', 564390026);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483643, 2, '2024-06-15', 'ogrgjd8y', 't1afgog', -946046410, 1, 'tsj3ayxp1q4', '01jh3den', 357330522);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483642, 3, '2024-06-15', '5w1of7', 'pzo72ctdc', 1303877941, 1, 'mfg62g0v5q8q', 'j', -1139855872);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483641, 2, '2024-06-15', 'ou5z', '36c', 1722106924, 1, 'f', 'foa', 382831862);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483640, 3, '2024-06-15', '7wgx', '5', -526612570, 1, 'cmr0oz', 'dgj5i', -176606723);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483639, 1, '2024-06-15', 'la3', 'okv8uttmu2', -1252009958, 1, '78lfvyz7', 'zzbe8yvkv4', -233617564);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2024-06-15', 'mkrpdj', 'wzw5chn9mo70', 628082526, 1, '9n0jxfofwsz', 'o', 1010672881);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2024-06-15', 'obb0q0k', '2odwcl5a', 292557306, 1, 'orlwyngc1dj', '9erhizgk1yoe', 1483450542);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483636, 1, '2024-06-15', 'l0hdt6fuq', 'xuzkb52', -277407746, 1, 'nlas6e', 'lboeowii1z5', 1557188093);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483635, 1, '2024-06-15', 'aawg96aqb0tb', 'indz39tajz', 261633665, 1, '8', '5wcg', -794767771);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483634, 1, '2024-06-15', '1rxe9y', 'k7', -1046720861, 1, '162nh55y3d', 'ohvu06dza3', 1595632888);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483633, 1, '2024-06-15', 'mzn2mfx7h3', 'p6sto1cj', 1728926031, 1, 'knzys7dy', 'yd1jmgjach8', 973811121);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483632, 1, '2024-06-15', '8y3a17v4yg', 'mayq3qdpua', 1291298007, 1, 'tdqr', 'm5', -648564084);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-2147483631, 1, '2024-06-15', 'dmsqtg', 'lc', -1025517017, 1, 'i9f2ccukj', '1quik', 1570917601);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 4, '2022-12-08', 'g', 'k9n8c', -106629402, 1871297066, 'u7vfe4hria2y', 'uzhs', 700293388);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (5, 5, '2025-06-27', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, '6nium52zb', 'uo4nrqrofqy', -1106983592);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 6, '2024-10-14', 'yytoo', 'o9hl72kl', -305670381, -1525670226, '7zwau2dwyr', '13pyu', 176380444);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (7, 7, '2024-02-23', '8pz0f8je', 'd2', 1675430660, -688509700, '9uxj4hwbdvl', 'h2gn', 1968874827);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (8, 8, '2020-08-04', 'qv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 'ah0f8jsww', 'q7x', -541746689);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (9, 9, '2021-05-12', 'ogrgjd8y', 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 357330522);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(IIF(T3.date = '1998-12-27', T3.balance, 0)) - SUM(IIF(T3.date = '1993-03-22', T3.balance, 0))) AS REAL) * 100 / SUM(IIF(T3.date = '1993-03-22', T3.balance, 0)) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN trans AS T3 ON T3.account_id = T2.account_id WHERE T1.date = '1993-07-05';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (t2.balance - t1.balance) / t1.balance * 100 AS increase_rate FROM trans AS t1 JOIN trans AS t2 ON t1.account_id = t2.account_id JOIN loan AS l ON t1.account_id = l.account_id JOIN client AS c ON l.account_id = c.client_id WHERE l."date" = '1993-07-05' AND t1."date" = '1993-03-22' AND t2."date" = '1998-12-27' ORDER BY l."date", t1.trans_id NULLS LAST, t2.trans_id NULLS LAST, l.loan_id NULLS LAST, c.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/