-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (21, '19');
INSERT INTO "Users" ("account", "name") VALUES (26, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (25, 26, 10001, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (20, 21, NULL, '1000-01-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
*/

-- Prediction Query
SELECT DISTINCT C.NAME, C.BALANCE FROM (SELECT A.NAME, SUM(B.AMOUNT) OVER (PARTITION BY A.NAME) AS BALANCE FROM USERS AS A LEFT JOIN TRANSACTIONS AS B ON A.ACCOUNT = B.ACCOUNT) AS C WHERE C.BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
*/