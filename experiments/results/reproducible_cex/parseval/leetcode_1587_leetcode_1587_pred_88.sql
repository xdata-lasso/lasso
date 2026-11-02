-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("account", "name") VALUES (1, 'u_s_0ac3f3');

INSERT INTO "users" ("account", "name") VALUES (3, 'name_2');

-- Inserting into table: transactions --
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483648, 1, 0, '2025-06-17');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483647, 1, 0, '2021-11-08');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483646, 1, 30653, '2025-06-13');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483645, 3, NULL, '2023-03-15');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483644, 3, NULL, '2023-11-15');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483643, 3, 30653, '2024-01-05');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483642, 1, NULL, '2022-12-08');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483641, 1, NULL, '2020-06-07');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483640, 1, NULL, '2021-02-05');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483639, 1, NULL, '2023-04-14');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483638, 1, NULL, '2021-12-04');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483637, 1, 30653, '2022-04-27');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483636, 1, NULL, '2020-06-08');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483635, 1, NULL, '2025-04-30');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483634, 1, 30653, '2022-10-19');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483633, 1, NULL, '2021-02-11');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483632, 1, NULL, '2023-07-13');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483631, 1, NULL, '2025-11-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('u_s_0ac3f3', 91959)
('name_2', 30653)
*/

-- Prediction Query
SELECT NAME, AMOUNT AS BALANCE FROM USERS AS U JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS AMOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T ON U.ACCOUNT = T.ACCOUNT;

/*
Prediction Result:
*/