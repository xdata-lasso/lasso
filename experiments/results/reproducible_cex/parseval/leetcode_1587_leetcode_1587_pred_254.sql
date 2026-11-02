-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("account", "name") VALUES (1, 'u_s_2db7bf');

INSERT INTO "users" ("account", "name") VALUES (2, 'name_2');

-- Inserting into table: transactions --
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483648, 1, -55602865, '2025-06-13');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483647, 1, -921145356, '2024-01-05');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483646, 1, -1022641847, '2021-02-05');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483645, 1, NULL, '2023-04-14');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483644, 1, NULL, '2021-12-04');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483643, 1, NULL, '2022-04-27');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483642, 1, NULL, '2020-06-08');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483641, 1, NULL, '2025-04-30');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483640, 1, NULL, '2022-10-19');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483639, 1, 809183447, '2025-11-03');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483638, 1, NULL, '2023-09-09');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483637, 1, NULL, '2020-12-20');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483636, 1, NULL, '2020-09-26');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483635, 1, NULL, '2025-06-04');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483634, 1, NULL, '2021-05-05');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483633, 1, NULL, '2023-01-06');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (2, 1, 1914020640, '2024-12-12');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483631, 2, 10000, '2024-03-30');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483630, 1, 10000, '2023-08-23');

INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (-2147483629, 1, 1644814318, '2021-03-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('u_s_2db7bf', 2368638337)
*/

-- Prediction Query
SELECT NAME, BALANCE FROM USERS AS U LEFT JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS T ON U.ACCOUNT = T.ACCOUNT WHERE BALANCE >= 10000;

/*
Prediction Result:
('u_s_2db7bf', 2368638337)
('name_2', 10000)
*/