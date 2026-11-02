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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'l', '2023-05-26');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'mdpos', '2021-06-28');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, '5u', '2022-06-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, '5s5b', '2020-04-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, 'p', '2023-01-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 6, 'c', '2023-06-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 7, '2mnajjla3o', '2021-11-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, 8, 'yoeyo6l0hdt6', '2020-11-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (9, 9, '5rmkio18', '2023-02-10');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 1.0, 1.0, 1072996612, 13244799, -1659388584);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 1.0, 1.0, 624571013, 1644911394, -1666765085);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 0.0, 0.0, 781505063, 418417917, -1031969798);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'ut', 'iqa', '1ryytoo', 'o9hl72kl', 'x1', 'ji7zwau2', 364869063, -953437896, 433.533777, -1097120355, 326.912005, 798.947629, 244829661, -1362461264, -904834265);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 1581736075, -261132974, 795.815869, -1264842910, 0.0, 0.0, -1052964641, -1245682094, -1660358170);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 564390026, -1259474148, 968.276986, -1483100200, 128.858335, 498.231061, -1625552518, -1738458256, -1714354341);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 'f', -47052816, 645287482, 222.511261, 765724008, 0.0, 0.0, -1099855564, 87529806, -1957268147);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4', -2072838897, -1173368267, 707.057079, 382831862, 60.937725, 413.382111, -406331049, -461418236, -468701684);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, '7wgx', '5', 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143, 1615073310, 628.658254, 1055237066, 0.0, 0.0, 988954859, -1719383707, 1273687251);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, 'mu2ne578lf', 'yz7zzb', '8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 736.632717, 1105964624, 401.500141, 345.578764, -2013213247, 101754718, 628082526);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483636, '9n0jxfofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455, 453340472, 821.485286, 211603887, 0.0, 0.0, -413043724, 761519897, 1504707292);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', -1897615568, 2085299664, 974.58376, 1376887048, 560.916337, 49.319338, 748154000, 1148916014, -1988582944);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, 'mbc3td', 'u6bd0w9603', 'vzxw1rxe9y', 'k7', 'k162n', '55', 2105860871, -141591627, 602.631056, -732999244, 0.0, 0.0, 1654100852, 30861410, -438741674);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '2023-05-30', -1610064545, 429706943, 240.969194, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 2, '2023-11-17', -1399556171, 1038707349, 587.783596, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 1, '2020-07-19', -283454505, 233994589, 367.405851, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 2, '2021-09-16', -87647544, -629784617, 50.647649, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 1, '2022-01-29', 2103044118, -1642259219, 109.083092, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 2, '2022-04-21', 1968874827, -664193365, 250.856497, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 1, '2024-02-11', 722884590, 580968159, 210.05299, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2022-09-19', -988981234, -841004020, 415.830002, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2024-06-09', -1748371085, -1742081330, 541.805676, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 3, '2022-05-01', -211209314, -1056308489, 406.816852, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 3, '2021-03-20', 1382410067, 1631231566, 887.207631, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 3, '2022-06-25', 1606439408, 1443629118, 463.845085, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2020-03-07', -1554531873, 982314585, 279.382219, 't1__fbf24b');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 1, '2021-11-28', 32204797, -1672720816, 92.94508, 't1__fbf24b');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2022-08-27', 882961052, 743312762, 825.231787, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 5, '2021-08-31', -841004020, -361507387, 395.809081, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 6, '2022-04-02', -1784554553, -242584410, 415.494881, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 7, '2023-10-18', -761353513, 362376128, 585.201826, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (8, 8, '2023-07-12', -477129795, -1418927432, 904.57762, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (9, 9, '2021-07-23', 1510892261, 1677948887, 590.734291, 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((T3.A13 - T3.A12) AS REAL) * 100 / T3.A12 FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.status = 'D';

/*
Gold Result:
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(0.0,)
(-32.90663990982778,)
(144.39225748225425,)
(286.6502395828721,)
(578.3681389484101,)
(-13.928108931847177,)
(-91.20736289055527,)
*/

-- Prediction Query
SELECT T2.district_id, (T3.A13 - T3.A12) * 100 / T3.A12 AS unemployment_rate_increment FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T1.status = 'D' AND NOT T3.A12 IS NULL;

/*
Prediction Result:
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(1, 0.0)
(4, -32.90663990982778)
(5, 144.39225748225425)
(6, 286.6502395828721)
(7, 578.3681389484101)
(8, -13.928108931847177)
(9, -91.20736289055527)
*/