-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (11, '12');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (13, 11, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('12', 10001)
*/

-- Prediction Query
SELECT SUM(AMOUNT) AS BALANCE, U.NAME FROM TRANSACTIONS AS T JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT GROUP BY U.NAME HAVING BALANCE > 10000;

/*
Prediction Result:
(10001, '12')
*/