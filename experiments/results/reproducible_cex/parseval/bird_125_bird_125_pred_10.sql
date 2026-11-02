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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'mdpos', '2021-06-28');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, '5u', '2022-06-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 6, 'p5qi2rkf9v', '2022-12-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 7, 'fdrz16n', '2021-06-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 8, 'u5zi', '2025-03-18');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, 9, 'h2mna', '2021-08-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (9, 11, '5amsorlwyngc', '2024-10-05');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 1.0, 1.0, 1072996612, 13244799, -1659388584);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 1.0, 1.0, 624571013, 1644911394, -1666765085);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'value', 'value', 'value', 'value', 'value', 'value', 1, 1, 1.0, 1, NULL, 11797.0, 1, 1, 1);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 418417917, -1031969798, 242.260296, 1884179925, 499.570479, 710.141592, 2107872094, 882961052, 743312762);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 145.402595, 1661181156, 0.0, 0.0, -1372125820, -2031361952, 1649269347);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, '8j', 'gd', '1vy9uxj4', 'wb', 'v', 'ph2', 1298861365, 1968874827, 345.35543, -1070063173, 629.317167, 668.309685, 580968159, -1245312912, 1575412235);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, 'jtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', -348113485, 138842628, 282.822068, -639539893, 0.0, 0.0, 1255343543, -541746689, 1294666887);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, '5o', 'rg', 'd8y', 't1afgog', 'itsj3', 'y', -598313376, 1972233925, 917.425128, 804529642, 457.141778, 410.094566, -1538707438, -163600466, -1826414375);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483638, 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', -1180042408, 199672698, 993.555996, -1962347906, 0.0, 0.0, -866772222, -847293924, -2033879835);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', 1816660482, -1212676731, 893.960343, -1300180872, 167.377262, 492.8451, -1125548818, 1497321728, -95808609);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'value', 'value', 'value', 'value', 'value', 'value', 1, 1, 1.0, 1, NULL, 11797.0, 1, 1, 1);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', 'kv42q7', -2060082151, -1122409769, 959.473065, 1849819405, 693.650436, 326.883516, -929383517, -2090240067, -699574669);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', -397848196, -366775518, 457.250518, 575038073, 0.0, 0.0, -1161141730, -613916489, 2061558815);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '2023-05-30', -1610064545, 429706943, 240.969194, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 3, '2023-11-17', -1399556171, 1038707349, 587.783596, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 1, '2020-07-19', -283454505, 233994589, 367.405851, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '2021-09-16', -87647544, -629784617, 50.647649, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 1, '2022-01-29', 2103044118, -1642259219, 109.083092, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 3, '2022-04-21', 1968874827, -664193365, 250.856497, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 1, '2024-02-11', 722884590, 580968159, 210.05299, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2022-09-19', -988981234, -841004020, 415.830002, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2024-06-09', -1748371085, -1742081330, 541.805676, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 3, '2022-05-01', -211209314, -1056308489, 406.816852, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 3, '2021-03-20', 1382410067, 1631231566, 887.207631, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 3, '2022-06-25', 1606439408, 1443629118, 463.845085, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2020-03-07', -1554531873, 982314585, 279.382219, 't1__779265');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2022-02-26', 907682809, 2026480202, 133.007885, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 5, '2024-02-23', 1178000634, 1836127587, 410.133844, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 6, '2021-09-12', -1483100200, -7597509, 651.586084, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 7, '2025-09-22', 1944978593, 1722106924, 17.379583, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (8, 8, '2021-09-30', -1351793914, 1919033056, 904.028668, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (9, 9, '2020-07-19', 453340472, 211603887, 633.999218, 'D');
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
(42.15043159105484,)
(6.196004184325692,)
(-10.291601919612782,)
(194.45164421437366,)
(-52.87489215965836,)
*/

-- Prediction Query
SELECT "district"."a2" AS "district", (("district"."a13" - "district"."a12") / "district"."a12") * 100 AS "unemployment_rate_increment" FROM "loan" INNER JOIN "account" ON "loan"."account_id" = "account"."account_id" INNER JOIN "district" ON "account"."district_id" = "district"."district_id" WHERE "loan"."status" = 'D';

/*
Prediction Result:
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', 0.0)
('5k5swwqcgs', -32.90663990982778)
('5u', 42.15043159105484)
('8j', 6.196004184325692)
('5o', -10.291601919612782)
('foa', 194.45164421437363)
('v8u', -52.87489215965836)
*/