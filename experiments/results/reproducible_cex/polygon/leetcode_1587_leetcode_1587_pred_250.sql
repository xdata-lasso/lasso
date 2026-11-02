-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (23, '14');
INSERT INTO "Users" ("account", "name") VALUES (12, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, NULL, 10001, '1000-01-23');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (15, 23, -228, '1000-01-25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME, BALANCE.BALANCE FROM (SELECT SUM(AMOUNT) AS BALANCE, ACCOUNT FROM TRANSACTIONS GROUP BY ACCOUNT) AS BALANCE LEFT JOIN USERS ON BALANCE.ACCOUNT = USERS.ACCOUNT WHERE BALANCE.BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
*/