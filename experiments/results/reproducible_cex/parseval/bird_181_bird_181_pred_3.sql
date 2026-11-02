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
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, 1, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483647, 3, 'ytoo3o9hl7', '2024-12-21');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, 1, 'q', '2023-11-15');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483646, 1, 'qcx5', '2021-04-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2, 1, 'rjtu', '2024-08-30');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483643, 3, 'z', '2025-11-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483642, 1, 'gq8', '2022-05-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483641, 3, '3d', '2022-11-06');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483640, 1, 'gcb98oz', '2021-10-23');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483639, 3, 'bilyrkn', '2025-09-09');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (-2147483638, 1, 'k', '2025-09-14');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (4, 1, '5sw', '2024-01-05');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (3, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 673.065986, -1822992503, 297.722676, 138.017996, -1068298341, -314162272, 2137741668);

INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2, 'lex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', -705985602, 537874887, 698.16972, -461695645, 694.765963, 707.476301, 176555546, -1937207087, 1675430660);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (1, 'F', '2022-02-26', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483647, 'F', '2023-10-23', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483646, 'F', '2022-05-10', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483645, 'F', '2021-01-15', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483644, 'F', '2025-01-20', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483643, 'F', '2023-10-23', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483642, 'F', '2025-03-14', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483641, 'F', '2023-10-23', 2);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483640, 'F', '2020-02-22', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483639, 'F', '2021-03-28', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483638, 'F', '2023-02-06', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483637, 'F', '2024-06-23', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483636, 'F', '2024-11-10', 1);

INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2, 't1__9cbf5f', '2025-06-17', 1);

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '2020-07-11', 1, -1137908826, 619.836822, 'iie5u');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-1, 1, '2024-05-17', 1, -792092619, 585.18838, '4hw');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (0, 1, '2020-04-02', 1, -1929953647, 185.427628, 'h2gn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '2024-09-12', 1, -1520489792, 346.706184, 'q7x');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '2020-03-27', 1, 602161869, 814.417862, 'a7ryfd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 4, '2022-12-08', -1981402255, -890215420, 572.766956, '8c4p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.gender = 'F' ORDER BY T3.amount DESC, T1.client_id NULLS LAST, T2.account_id NULLS LAST, T3.loan_id NULLS LAST LIMIT 3;

/*
Gold Result:
(-2147483646,)
(-2147483646,)
(-2147483646,)
*/

-- Prediction Query
SELECT client.client_id FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN account ON disp.account_id = account.account_id INNER JOIN loan ON account.account_id = loan.account_id WHERE client.gender = 'F' ORDER BY loan.amount DESC, client.client_id NULLS LAST, disp.disp_id NULLS LAST, account.account_id NULLS LAST, loan.loan_id NULLS LAST LIMIT 3;

/*
Prediction Result:
*/