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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, 't2__8b8989', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 1160656988, -992890117, 710.998147, 1914020640, 795.366812, 378.476082, 1219478689, -1670923962, 700293388);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 't2__8b8989', 'b', 'p6luhvdlttil', 'n', 'rmdp', 'siie', -45536098, 1861536320, 345.718563, 44952191, 768.216462, 83.204633, 1620389964, 546571701, 947159877);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483647, 't2__8b8989', '5c4ec', 'gce', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, 297.722676, -1068298341, 427.383654, 426.853398, 2137741668, -525979501, 1898504886);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'A', 'd2', 'vy9uxj4', 'wb', 'v', 'ph2', 1298861365, 1968874827, 345.35543, -1070063173, 629.317167, 668.309685, 580968159, -1245312912, 1575412235);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (4, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'F', '2023-11-30', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'F', '2022-08-06', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (0, 'F', '2025-02-11', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-1, 'F', '2021-04-03', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'F', '2025-11-03', -2147483647);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'F', '2021-08-16', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 'F', '2024-12-25', -2147483647);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'F', '2025-02-23', -2147483647);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'F', '2023-01-20', -2147483647);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 'F', '2022-09-10', -2147483647);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (3, 'F', '2023-10-06', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'F', '2022-12-15', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, 'F', '2024-02-23', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483635, 'F', '2025-06-26', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483634, 'F', '2022-08-22', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483633, 'F', '2024-05-26', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483632, 'F', '2024-08-06', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483631, 'F', '2020-12-28', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483630, 'F', '2021-08-12', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483629, 'F', '2020-11-04', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (4, 'F', '2021-05-27', -2147483647);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 'F', '2022-01-16', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (5, 't1__3984ad', '2023-05-30', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.A2, COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T1.gender = 'F' GROUP BY T2.district_id, T2.A2 ORDER BY COUNT(T1.client_id) DESC, T2.A2 NULLS LAST LIMIT 10;

/*
Gold Result:
('t2__8b8989', 15)
('t2__8b8989', 6)
('t2__8b8989', 1)
*/

-- Prediction Query
SELECT district.a2, COUNT(client.client_id) AS female_account_holders FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' GROUP BY district.district_id ORDER BY female_account_holders DESC, district.a2 NULLS LAST LIMIT 9;

/*
Prediction Result:
*/