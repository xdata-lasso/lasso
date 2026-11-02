-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (16, NULL);
INSERT INTO "Users" ("account", "name") VALUES (15, '11');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (14, 15, 10000, '1000-01-22');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (13, 16, 10000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY T.ACCOUNT HAVING BALANCE >= 10000;

/*
Prediction Result:
('11', 10000)
(None, 10000)
*/