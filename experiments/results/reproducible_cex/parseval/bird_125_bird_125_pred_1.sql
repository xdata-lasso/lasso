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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, '5k5swwqcgs', '2021-12-04');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 1.0, 1.0, 1072996612, 13244799, -1659388584);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, '000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 668.928822, 1898504886, 1.0, 1.0, 624571013, 1644911394, -1666765085);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl', 'b4yp5qi', -227162283, 2056419640, 551.785129, 556727997, 860.770887, 774.274643, 1836127587, -1529584866, 1196308825);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'value', 'value', 'value', 'value', 'value', 'value', 1, 1, 1.0, 1, NULL, 11797.0, 1, 1, 1);

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

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2020-03-07', -1554531873, 982314585, 279.382219, 't1__b0bb8c');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2022-04-27', -1980249628, -734455130, 906.21648, 'D');
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
(None,)
*/

-- Prediction Query
SELECT district.A3 AS state, district.A2 AS district_name, (CAST(district.A13 AS REAL) - CAST(district.A12 AS REAL)) / CAST(district.A12 AS REAL) * 100 AS unemployment_rate_increment FROM loan JOIN account ON loan.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE loan.status = 'D';

/*
Prediction Result:
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('9n8', '5k5swwqcgs', 0.0)
('value', 'value', None)
*/