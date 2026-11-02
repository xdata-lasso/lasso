-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (22, '21');
INSERT INTO "Users" ("account", "name") VALUES (11, '12');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (14, 22, NULL, '1000-01-21');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (13, 22, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('21', 10001)
*/

-- Prediction Query
SELECT NAME, AMOUNT AS BALANCE FROM USERS AS U JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS AMOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T ON U.ACCOUNT = T.ACCOUNT;

/*
Prediction Result:
('21', 10001)
*/