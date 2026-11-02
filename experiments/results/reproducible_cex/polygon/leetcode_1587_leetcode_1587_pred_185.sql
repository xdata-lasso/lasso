-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (17, '11');
INSERT INTO "Users" ("account", "name") VALUES (21, '19');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (12, 17, 10001, '1000-01-19');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (20, 21, 10000, '1000-01-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('11', 10001)
*/

-- Prediction Query
SELECT X.NAME, X.BALANCE FROM (SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS INNER JOIN TRANSACTIONS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY USERS.ACCOUNT) AS X WHERE BALANCE >= 10000;

/*
Prediction Result:
('11', 10001)
('19', 10000)
*/