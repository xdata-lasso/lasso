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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'wbbp6luhvdlt', '2023-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'vqx58pz0f', '2021-08-12');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'd2', '2024-11-12');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483645, 1, '0gcb98', '2022-06-25');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483644, 1, 'xb72fxa7r', '2024-04-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 1, '5dh', '2025-06-24');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't2__4fe5ca', 't2__dd25e9', '5k5swwqcgs', '9n8', '4', 'gu7v', -1865039888, 1160656988, 268.82475, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 't2__4fe5ca', 't2__dd25e9', 'posiie5unw6k', 'fa9', '00t5c4e', 'cigce376nium', 283598170, 742285925, 21.917736, -747753377, 478.908865, 203.577612, 902887186, -967741825, 775304493);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '7zwau2dwyr', -1021749117, 392822403, 998.887019, -533293970, 520.715697, 541.066766, -977635379, 1661181156, -1372125820);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483648, 1, '2021-05-27', 300001, -1364429300, 998.421621, 'prmd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483647, 1, '2020-04-20', 300001, 1692174491, 495.297639, 'i2rkf');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483646, 2, '2023-10-23', 300001, 233994589, 367.405851, '4hw');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 1, '2020-04-02', 300001, -1929953647, 185.427628, 'h2gn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 2, '2020-08-28', 300001, -1052964641, 209.967034, 'x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 1, '2025-07-02', 300001, 580968159, 210.05299, 'rjtu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 2, '2024-08-30', 300001, -1898531797, 521.610309, 'fjgq8n2f3dq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 1, '2024-07-01', 300001, 1443629118, 463.845085, 'i');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2021-12-23', 300001, 982314585, 279.382219, 'n6v');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2020-05-20', 300001, 1784916884, 508.771546, 'h0f8jswwlq');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 1, '2020-12-21', 300001, 1427161052, 276.61064, '16nijja');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483637, 1, '2022-07-24', 300001, 1449284300, 272.414976, 'd8y');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483636, 1, '2024-05-29', 300000, 1250290042, 100.07927, 'ri');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483635, 1, '2023-06-23', 1, 678047687, 155.845079, 'y');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483634, 1, '2024-01-17', 300001, -106471771, 787.642728, 'jh3den8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id, T2.A2, T2.A3 FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T1.account_id = T3.account_id WHERE T3.amount > 300000;

/*
Gold Result:
(1, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(2, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(2, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(2, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
(1, 't2__4fe5ca', 't2__dd25e9')
*/

-- Prediction Query
SELECT DISTINCT T2.account_id, T4.A2, T4.A3 FROM loan AS T2 JOIN account AS T3 ON T2.account_id = T3.account_id JOIN district AS T4 ON T3.district_id = T4.district_id WHERE T2.amount > 300000;

/*
Prediction Result:
(1, 't2__4fe5ca', 't2__dd25e9')
(2, 't2__4fe5ca', 't2__dd25e9')
*/