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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'POPLATEK MESICNE', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'POPLATEK MESICNE', '2025-06-27');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'w6kl', '2020-12-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, -2147483648, 't1__73105b', '2022-09-10');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, 't1__73105b', '2021-11-08');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, 't1__73105b', '2021-11-08');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (6, -2147483648, 't1__73105b', '2020-06-08');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '1995-01-01', 250001, -1610064545, 22.535764, 'nprmdposii');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 3, '1995-01-01', 250001, 1038707349, 587.783596, '000t5c4ec');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 3, '1995-01-01', 250001, 1149850321, 44.682291, '37');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 3, '1995-01-01', 250001, 1313172851, 322.782838, '52zbuo4nrq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 3, '1995-01-01', 250001, -1031969798, 242.260296, '5bbp0');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '1995-01-01', 250001, -1822992503, 297.722676, 'qa1');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '1995-01-01', 250001, 2074205376, 274.580687, 'ytoo3o9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 1, '1998-01-01', 250001, -1390245819, 763.856372, 'x14ji7zwau2d');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '1995-01-01', 250001, -511185946, 262.105498, '3pyu78d99r');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 1, '1995-01-01', 250000, 1661181156, 180.527064, '4');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 1, '2024-06-15', 1, -1025564911, 447.109657, 'f9v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '1995-01-01', 250001, 537874887, 698.16972, 'z0f8jegd21vy');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '1995-01-01', 250000, -59984348, 345.329712, 'cgsk9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 5, '1970-01-01', 250001, -59984348, 345.329712, 'cgsk9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 6, '1998-01-01', 250000, -106629402, 935.695299, 'u7vfe4hria2y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.date BETWEEN '1995-01-01' AND '1997-12-31' AND T1.frequency = 'POPLATEK MESICNE' AND T2.amount > 250000;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM loan INNER JOIN account ON loan.account_id = account.account_id WHERE loan.date BETWEEN '1995-01-01' AND '1997-12-31' AND loan.amount >= 250000 AND account.frequency = 'POPLATEK MESICNE';

/*
Prediction Result:
(6,)
*/