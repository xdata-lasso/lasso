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

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, -2147483648, 'ytoo3o9hl7', '2024-12-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'x1', '2025-05-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, -2147483648, '5sw', '2024-01-05');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (5, -2147483648, 'n', '2022-09-14');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3356, 'dposiie5unw', '2025-09-21', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'p', '2024-08-27', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, '16nijjai5dh', '2025-06-24', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'b', '2022-08-24', -2147483648);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'dpos', '2021-06-28', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483648, 3356, 1, 'lfa');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, 2, 1, '2eutliqa11r');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483646, 3356, 3, 'i7z');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483645, 3356, 3, '2dwyrq');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483644, 2, 1, 'yu78');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483643, 3356, 3, 'jsl');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483642, 3356, 3, 'yp5qi2rk');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483641, 2, 1, 'x58pz');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483640, 3356, 3, '8jegd21vy9ux');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483639, 3356, 3, 'wb');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, 3356, 1, 'ph2');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, 3356, 1, 'nd');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483636, 3356, 1, 'x');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483635, 3356, 1, 'ah0f8jsww');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483634, 3356, 1, 'a7ryfd');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483633, 1, 1, 'grgj');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483632, 3356, 1, 't1afgog');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483631, 1, 1, 'itsj3');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483630, 3356, 1, '1q43');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, 3, 4, 'luhvdltti');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (5, 4, 5, 'e5u');

-- Inserting into table: trans --
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (3, 4, '2022-12-08', 'g', 't4__1caa20', -890215420, 1610062532, 'pgu7vfe4', 'hria2ypuzhs', 700293388);

INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (4, 5, '2024-06-15', 'value', NULL, 1, 1, 'value', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T4.trans_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN account AS T3 ON T2.account_id = T3.account_id INNER JOIN trans AS T4 ON T3.account_id = T4.account_id WHERE T1.client_id = 3356 AND T4.operation = 'VYBER';

/*
Gold Result:
(1,)
(2,)
(1,)
(2,)
(1,)
(2,)
(1,)
(2,)
(1,)
(2,)
(1,)
(2,)
(1,)
(2,)
(1,)
(2,)
*/

-- Prediction Query
SELECT trans.* FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN account ON disp.account_id = account.account_id INNER JOIN trans ON account.account_id = trans.account_id WHERE client.client_id = 3356 AND trans.operation = 'VYBER';

/*
Prediction Result:
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
(1, 1, '2024-07-24', '00t5c4ecigc', 'VYBER', 528680845, -1585009206, '52zb', 'uo4nrqrofqy', -1106983592)
(2, 1, '2025-07-02', 'hncprjtu0dz', 'VYBER', -1748371085, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585)
*/