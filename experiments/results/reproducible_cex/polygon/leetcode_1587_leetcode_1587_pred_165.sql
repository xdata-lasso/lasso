-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (21, '15');
INSERT INTO "Users" ("account", "name") VALUES (25, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, 21, 10000, '1000-01-23');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (24, 25, 10001, '1000-01-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
*/

-- Prediction Query
WITH T1 AS (SELECT T.TRANS_ID, T.ACCOUNT, T.AMOUNT, T.TRANSACTED_ON, U.NAME FROM TRANSACTIONS AS T LEFT JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT), T2 AS (SELECT NAME, SUM(AMOUNT) AS BALANCE FROM T1 GROUP BY ACCOUNT) SELECT NAME, BALANCE FROM T2 WHERE BALANCE >= 10000;

/*
Prediction Result:
('15', 10000)
(None, 10001)
*/