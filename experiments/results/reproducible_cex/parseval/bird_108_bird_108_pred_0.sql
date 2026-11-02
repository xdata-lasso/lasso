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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, '0b4', '2024-04-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'j4hwbd', '2023-09-07');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '2022-02-26', 1, 907682809, 227.766936, 'iie5u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2023-08-27', 1, -1179823637, 760.580899, 'rqrofqyp5s');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-1, 3, '2022-09-10', 1, -1025564911, 447.109657, 'f9v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (0, 3, '2022-12-15', 0, 537874887, 698.16972, 'z0f8jegd21vy');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2025-09-14', 1, -1672720816, 92.94508, 'sww');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2021-12-25', 1, 1255343543, 21.129657, '2fxa7ryfd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 1, '2023-02-06', 777149609, 61479715, 130.468488, 'jai');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 1, '2025-08-02', 1360271423, 1583472758, 837.437794, 'gjd8y');

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2024-06-15', 'w6kl', 'a9', 1, 1620389964, '00t5c4ecigc', 'e376nium52', -443340271);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2024-06-15', 'bbp02eut', 'iqa', 1, -314162272, 'ytoo3o9', 'l7', 1178636309);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 1, '2024-06-15', 'ex1', 'ji7zwau2', 1, 364869063, 'q13py', '78d99r', -1362461264);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (-1, 2, '1970-01-01', 'ph2', 'nd', 1, -1052964641, 'qcx5', 'hncprjtu0dz', -1748371085);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (0, 2, '2024-06-15', 'q8', 'n2f3dqv0gcb9', 1, 172461907, 'k3zbily', 'kn6vc', 1784916884);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 1, '2024-05-29', '1afgo', 'ri', -902895762, -197933860, 'xp1q430', 'jh3den8', 195720193);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (6, 1, '2023-10-28', 'c', 'x7afu5w1of77', -1099855564, 87529806, 'ctdctmfg62g0', '5q8qdj', -1139855872);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.amount FROM loan AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id ORDER BY T1.amount DESC, T2.date ASC, T1.loan_id NULLS LAST, T2.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(-1099855564,)
*/

-- Prediction Query
SELECT T4.amount FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.client_id = T3.client_id INNER JOIN trans AS T4 ON T1.account_id = T4.account_id WHERE T1.amount = (SELECT MAX(amount) FROM loan) ORDER BY T4.date ASC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST, T3.client_id NULLS LAST, T4.trans_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/