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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, '5s5b', '2020-04-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, 'p', '2023-01-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, 6, 'c', '2023-06-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (7, 7, '7wgx', '2020-07-27');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (8, 9, 'ne578lfv', '2024-03-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (9, 11, '1gwnlas6', '2020-09-24');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 1.0, 1.0, 1072996612, 13244799, -1659388584);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 1.0, 1.0, 624571013, 1644911394, -1666765085);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483644, 'ilbnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, 225.300904, 1119186446, 0.0, 0.0, 781505063, 418417917, -1031969798);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, 'ut', 'iqa', '1ryytoo', 'o9hl72kl', 'x1', 'ji7zwau2', 364869063, -953437896, 433.533777, -1097120355, 326.912005, 798.947629, 244829661, -1362461264, -904834265);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 1581736075, -261132974, 795.815869, -1264842910, 0.0, 0.0, -1052964641, -1245682094, -1660358170);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (6, 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 564390026, -1259474148, 968.276986, -1483100200, 128.858335, 498.231061, -1625552518, -1738458256, -1714354341);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483640, '8', 'yzt1afgogrit', 'sj3ayxp1q430', 'jh3den8', 'c68x8vacx7', 'f', -47052816, 645287482, 222.511261, 765724008, 0.0, 0.0, -1099855564, 87529806, -1957268147);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (7, '5q8qdj', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4', -2072838897, -1173368267, 707.057079, 382831862, 60.937725, 413.382111, -406331049, -461418236, -468701684);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (8, 'value', 'value', 'value', 'value', 'value', 'value', 1, 1, 1.0, 1, NULL, 11797.0, 1, 1, 1);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (9, '0oztd', 'j5', '3lq', '5lnpim5k58qs', '7p2r94gt', '2m', 418247369, -1524425594, 185.260952, 1919033056, 904.028668, 167.474325, -761353513, 362376128, -1311735207);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (10, 'value', 'value', 'value', 'value', 'value', 'value', 1, 1, 1.0, 1, NULL, 11797.0, 1, 1, 1);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (11, 'yvkv42q7sx58', 'b4pmaus3auv', 'krpd', 'wzw', 'chn9mo70', 'a9n0jxfo', -1793230843, -441521858, 969.175862, 1010672881, 399.489794, 221.079558, -2019656607, 375841374, -1449226553);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483634, '2odwcl5amso', 'lwyng', '1', 'j', '9erhizgk1yoe', 'o6l0hdt', -795975227, 1294064538, 361.042997, 778835680, 0.0, 0.0, 1755752040, 1262491793, 450555855);

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

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2020-03-07', -1554531873, 982314585, 279.382219, 't1__52cf02');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2022-08-27', 882961052, 743312762, 825.231787, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 5, '2021-08-31', -841004020, -361507387, 395.809081, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 6, '2022-04-02', -1784554553, -242584410, 415.494881, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 7, '2025-06-15', -526612570, -546516406, 187.71278, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (8, 8, '2024-05-28', 448935289, 458835042, 70.267562, 'D');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (9, 9, '2022-01-19', 1048147204, -1814875250, 349.149444, 'D');
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
(-81.47466657550733,)
(-44.65952289134076,)
*/

-- Prediction Query
SELECT district.A2 AS district_name, ((district.A13 - district.A12) * 100.0 / district.A12) AS unemployment_increment FROM loan INNER JOIN account ON loan.account_id = account.account_id INNER JOIN district ON account.district_id = district.district_id WHERE loan.status = 'D';

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
('ut', 144.39225748225425)
('fjgq8n2f3', 286.6502395828721)
('5q8qdj', 578.3681389484101)
('0oztd', -81.47466657550733)
('yvkv42q7sx58', -44.65952289134076)
*/