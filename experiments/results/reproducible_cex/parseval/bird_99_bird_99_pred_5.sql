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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'qa1', '2024-10-14');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'dposiie5unw', '2025-09-21', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, -2147483648, 1, 'lfa');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, -2147483648, 1, 'e');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483646, -2147483648, 2, 'bbp02eut');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, -2147483648, 2, '72klex14ji7z');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, -2147483648, 2, 'yrq13p');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, -2147483648, 2, 'yp5qi2rk');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, -2147483648, 1, 'p');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, -2147483648, 1, 'tu0');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483648, 1, 'wwlq7');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, -2147483648, 1, '8c4pgu7vfe');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '1993-01-01', 1, 12, 587.783596, '000t5c4ec');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '1993-01-01', 1, 12, 467.07027, 'nium52zbu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (0, 3, '1993-01-01', 1, 12, 274.580687, 'ytoo3o9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '1993-01-01', 1, 12, 353.163664, 'u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 3, '1993-01-01', 1, 12, 375.832821, '8d99rljsl');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 1, '1993-01-01', 1, 12, 551.785129, 'x58pz');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 1, '1993-01-01', 1, 12, 694.765963, '8jegd21vy9ux');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 1, '1993-01-01', 1, 12, 479.592965, 'bdvlph');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '1993-01-01', 1, 12, 109.083092, 'dqwn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2020-08-25', 401805964, -1485777725, 261.415754, 'n2f3dqv0gcb9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 1, '2022-06-25', 1606439408, 1443629118, 463.845085, 'i');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '1993-01-01', -512640349, 1, 741.809988, 'n6vck6ah0f');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 1, '1904-05-31', -55602865, 12, 486.033807, 'wqcgsk');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE T1.duration > 12 AND STRFTIME('%Y', T2.date) = '1993' ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/