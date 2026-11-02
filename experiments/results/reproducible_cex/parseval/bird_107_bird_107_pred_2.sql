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
-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 1, 994.117864, 749.826493, 13244799, -1659388584, 1526238907);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 'tti', 'bnp', 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 517.275698, 1, 962.037451, 977.216501, 1155439218, 1313172851, -761141909);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, '52zbuo4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9', 'l7', 1178636309, -1390245819, 763.856372, 1, 745.863768, 913.303855, -74849714, 105869088, -2081315180);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483646, '2dwyrq13pyu7', 'd99rljsl0', '4', 'p5qi2rk', '9v', 'x58pz', -1529584866, 1196308825, 712.084197, 0, 452.27611, 434.003102, 233994589, 1442655647, -87647544);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'bdvlph', 'gndqwnqc', 'x5hncprjtu0', 'z', '9fjgq8n2f', 'dqv0gcb9', 172461907, 1606439408, 836.121091, -155284187, 892.659478, 138.057338, 982314585, 638024588, -688098735);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483643, '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', -7597509, -1625552518, 849.655083, 0, 880.522213, 228.431231, -1738458256, -1714354341, -458359144);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483642, '1afgogritsj', 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', 1303877941, -1284905200, 102.360106, -1, 501.846153, 93.813527, 1870300798, 820970595, 1421303999);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 't2__234dd2', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 't2__234dd2', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-1, 't2__234dd2', '2024-06-15', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (0, 't2__234dd2', '2024-06-15', 3);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 't2__d48a1e', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 't2__d48a1e', '2024-06-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 't2__d48a1e', '2024-06-15', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.gender FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id ORDER BY T1.A11 DESC, T2.birth_date ASC, T1.district_id NULLS LAST, T2.client_id NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__234dd2',)
*/

-- Prediction Query
SELECT T4.gender FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T1.account_id = T3.account_id INNER JOIN client AS T4 ON T3.client_id = T4.client_id ORDER BY T2.A11 DESC, T4.birth_date ASC, T1.account_id NULLS LAST, T2.district_id NULLS LAST, T3.disp_id NULLS LAST, T4.client_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/