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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 1, 'oo3o9hl72kl', '2020-10-31');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'ah0f8jsww', '2021-12-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 3, 'xb72fxa7r', '2024-04-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 1, '6nijjai5dh', '2025-06-24');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, 'jd', '2024-05-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, 'f', '2021-02-13');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 4, 'tti', '2022-01-16');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, 5, 'tti', '2022-01-16');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 8000, 994.117864, 749.826493, 13244799, -1659388584, 1526238907);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'unw6klfa', '9000t5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 297.722676, 8001, 138.017996, 251.267403, -314162272, 2137741668, -525979501);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', -1529584866, 1196308825, 712.084197, 8000, 452.27611, 434.003102, 233994589, 1442655647, -87647544);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 172461907, 1606439408, 836.121091, -155284187, 892.659478, 138.057338, 982314585, 638024588, -688098735);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 0, 994.117864, 749.826493, 13244799, -1659388584, 1526238907);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 0, 994.117864, 749.826493, 13244799, -1659388584, 1526238907);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'nprmdposii', '2020-11-04', 1);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483648, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, -2147483648, 3, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483642, -2147483648, 3, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483641, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483640, -2147483648, 3, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483639, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483638, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483637, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483636, -2147483648, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483635, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483634, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483633, -2147483648, 1, 't3__609f86');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, -2147483648, 4, 't3__b250d1');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, -2147483648, 5, 'OWNER');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.account_id = T3.account_id WHERE T3.type <> 'OWNER' AND T1.A11 BETWEEN 8000 AND 9000;

/*
Gold Result:
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
('t3__609f86',)
*/

-- Prediction Query
SELECT DISTINCT disp.type FROM disp JOIN account ON disp.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE disp.type <> 'OWNER' AND district.A11 > 8000 AND district.A11 <= 9000;

/*
Prediction Result:
*/