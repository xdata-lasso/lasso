-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (13, '14');
INSERT INTO "Users" ("account", "name") VALUES (25, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (15, NULL, 21, '1000-01-23');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (24, 25, 578, '1000-01-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
WITH TB AS (SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T JOIN USERS AS U USING (ACCOUNT) GROUP BY T.ACCOUNT) SELECT * FROM TB WHERE BALANCE > 10000;

/*
Prediction Result:
*/