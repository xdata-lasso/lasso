-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (14, '16');
INSERT INTO "Users" ("account", "name") VALUES (13, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (18, NULL, -1, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (17, 13, 10002, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10002)
*/

-- Prediction Query
WITH STEP1 AS (SELECT A.AMOUNT, B.NAME FROM TRANSACTIONS AS A LEFT JOIN USERS AS B ON A.ACCOUNT = B.ACCOUNT) SELECT NAME, SUM(AMOUNT) AS BALANCE FROM STEP1 GROUP BY NAME HAVING SUM(AMOUNT) > 10000;

/*
Prediction Result:
(None, 10001)
*/