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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'tti', '2022-01-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 1, 'n', '2022-09-14');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, 1, '8pz0f8je', '2021-02-03');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 1, 'd21vy9uxj4hw', '2020-04-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 1, 'v', '2022-01-29');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, 'h2gn', '2020-08-28');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, 'wnqcx', '2025-07-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 1, 'hncprjtu0dz', '2025-11-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, 'jd', '2024-05-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 1, 't1afgog', '2023-02-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 1, 'tsj', '2025-02-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483637, 1, 'y', '2024-01-17');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483636, 1, '1q43', '2024-08-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483635, 1, 'jh3den8', '2020-07-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483634, 1, '68x8vacx7a', '2021-01-02');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483633, 1, '5w1of7', '2025-10-22');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483632, 1, 'zo72', '2020-06-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483631, 1, 'dctmf', '2021-02-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483630, 1, '2g0v5q8qd', '2021-09-20');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 2, 'lbn', '2022-09-14');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 1, 994.117864, 749.826493, 13244799, -1659388584, 1526238907);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291, -472966518, 488.977171, -921187550, 718.756092, 17.844282, 328305758, -751275471, -1347802441);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-1, 'a11ry', 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, 495.297639, 1, 261.217059, 447.109657, 2056419640, 222415430, 556727997);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (0, 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', 'wlq7xb', '72fxa7ryfd', 564390026, -1259474148, 968.276986, 1, 154.68882, 128.858335, -7597509, -1625552518, -1738458256);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483633, 'F', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 't1__d2b60d', '2023-05-30', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(-2147483647,)
*/

-- Prediction Query
SELECT account.account_id FROM account JOIN disp ON account.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' AND client.birth_date = (SELECT MIN(client.birth_date) FROM client WHERE gender = 'F') AND district.district_id = (SELECT district_id FROM district WHERE A11 = (SELECT MIN(A11) FROM district));

/*
Prediction Result:
*/