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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'nrqrofqy', '2022-09-19');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'bbp02eut', '2022-02-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, '5sw', '2024-01-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, 'hria2ypuzhs', '2023-01-03');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'M', '2020-07-11', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'M', '2021-08-16', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, '7zwau2dwyr', '2022-12-09', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'M', '2020-09-26', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 'M', '2022-04-29', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483648, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483646, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, 1, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, 2, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483642, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483641, 1, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483640, 2, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483639, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483638, 1, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483637, 2, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483636, 1, 2, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483635, 1, 3, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483634, 2, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483633, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483630, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483629, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483628, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483627, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483626, 1, 1, 't3__b404a6');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483625, 1, 1, 't3__b404a6');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483624, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483623, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483622, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483621, 1, 1, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, 4, 4, 'OWNER');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, 5, 5, 'OWNER');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '2024-06-15', 1, -1137908826, 619.836822, 'iie5u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '1996-01-01', 1, -1399556171, 741.842896, '9000t5c4ec');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 1, '1997-01-01', 1, -1833165707, 517.275698, 'nium52zbu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '2024-06-15', 1, -1068298341, 427.383654, 'ryytoo3');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 2, '2024-06-15', 1, 90119032, 958.92567, 'lex');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 1, '2024-06-15', 1, -1097120355, 326.912005, 'd99rljsl0');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 3, '2024-06-15', 1, 1649269347, 598.741024, '5qi2');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 2, '2024-06-15', 1, -705985602, 604.643336, 'x58pz0f8jeg');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '2024-06-15', 1, 1675430660, 339.69384, '9uxj4hwbdvl');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 3, '2024-06-15', 1, -261132974, 795.815869, 'dqwn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 2, '2024-06-15', 1, 555413010, 668.309685, 'hncprjtu0dz');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '2024-06-15', 1, -1742081330, 541.805676, 'n2f3dqv0gcb9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 3, '2024-06-15', 1, 1443629118, 463.845085, 'i');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 2, '2024-06-15', 1, 638024588, 692.775559, 'ck6ah0');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483634, 1, '2024-06-15', 1, -932772113, 351.095514, '7xb72');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2024-06-15', 1, -961217731, 86.816079, 'r');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2024-06-15', 1, 777149609, 753.351134, '6nijjai');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483631, 1, '2024-06-15', 1, -1625552518, 849.655083, 'grgj');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483630, 1, '2024-06-15', 1, 1129658414, 308.482994, 'afgogri');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483629, 1, '2024-06-15', 1, -491938169, 239.245131, 'q4301jh');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483628, 1, '2024-06-15', 1, -1826414375, 544.095565, 'c68x8vacx7');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483627, 1, '2024-06-15', 1, -290314193, 850.85096, '77');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483626, 1, '2024-06-15', 1, 87529806, 752.977863, 'ctdctmfg62g0');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483625, 1, '2024-06-15', 1, -1488156735, 67.250709, 'o22');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483624, 1, '2024-06-15', 1, -1962347906, 298.188866, 'ttg6');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483623, 1, '2024-06-15', 1, 1798111945, 322.910151, '5zi36c4bfkfo');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483622, 1, '2024-06-15', 1, -406331049, 392.567695, 'zjo7wgxd5ysx');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483621, 1, '2024-06-15', 1, 853709925, 297.258735, 'j5');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483620, 1, '2002-12-01', 1, -1405314653, 913.609637, 'lnpim5k5');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483619, 1, '1908-12-31', 1, 1615073310, 628.658254, 'p2r94gth2mna');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483618, 1, '2084-03-01', 1, -1351793914, 462.366429, 'kv8u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '1996-01-01', -1022641847, -1726781632, 171.746906, 'n8c4pgu7v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 5, '1997-01-01', 906324270, 1908028688, 994.117864, 'p6luhvdlttil');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1997' THEN T1.amount ELSE 0 END) - SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END)) AS REAL) * 100 / SUM(CASE WHEN STRFTIME('%Y', T1.date) = '1996' THEN T1.amount ELSE 0 END) FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN disp AS T3 ON T3.account_id = T2.account_id INNER JOIN client AS T4 ON T4.client_id = T3.client_id WHERE T4.gender = 'M' AND T3.type = 'OWNER';

/*
Gold Result:
(-188.62577832761121,)
*/

-- Prediction Query
SELECT ((SELECT SUM(T2.amount) FROM client AS T1 INNER JOIN loan AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T2.date) = '1997') - (SELECT SUM(T2.amount) FROM client AS T1 INNER JOIN loan AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T2.date) = '1996')) * 100.0 / (SELECT SUM(T2.amount) FROM client AS T1 INNER JOIN loan AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T2.date) = '1996') AS "Growth Rate";

/*
Prediction Result:
(-188.62577592976768,)
*/