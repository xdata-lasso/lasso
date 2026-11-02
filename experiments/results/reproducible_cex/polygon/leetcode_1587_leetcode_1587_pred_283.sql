-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (11, NULL);
INSERT INTO "Users" ("account", "name") VALUES (21, '22');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (17, 21, 10000, '1000-01-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME AS NAME, BALANCES.BALANCE AS BALANCE FROM (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS BALANCES INNER JOIN USERS ON BALANCES.ACCOUNT = USERS.ACCOUNT WHERE BALANCE >= 10000;

/*
Prediction Result:
('22', 10000)
*/