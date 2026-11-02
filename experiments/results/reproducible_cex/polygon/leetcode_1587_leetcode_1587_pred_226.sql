-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (19, '12');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (18, 19, -663, '1000-01-21');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (13, NULL, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT U.NAME, T.BALANCE FROM (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT HAVING SUM(AMOUNT) > 10000) AS T LEFT JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT;

/*
Prediction Result:
(None, 10001)
*/