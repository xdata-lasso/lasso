-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (20, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, 20, -663, '1000-01-18');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (19, 20, 10664, '1000-01-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
*/

-- Prediction Query
SELECT T1.NAME, T2.AMOUNT AS BALANCE FROM USERS AS T1 CROSS JOIN (SELECT SUM(AMOUNT) AS AMOUNT, ACCOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T2 WHERE T1.ACCOUNT = T2.ACCOUNT;

/*
Prediction Result:
*/