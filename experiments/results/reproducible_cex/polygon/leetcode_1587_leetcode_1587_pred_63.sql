-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (13, NULL);
INSERT INTO "Users" ("account", "name") VALUES (12, '14');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (17, NULL, 9040, '1000-01-25');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, NULL, 961, '1000-01-26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT U1.NAME, SUM(T1.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T1 LEFT OUTER JOIN USERS AS U1 ON U1.ACCOUNT = T1.ACCOUNT GROUP BY T1.ACCOUNT HAVING SUM(T1.AMOUNT) > 10000;

/*
Prediction Result:
(None, 10001)
*/