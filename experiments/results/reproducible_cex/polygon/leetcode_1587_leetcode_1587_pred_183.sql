-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (20, '18');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, 20, -554, '1000-01-18');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (19, 20, 10554, '1000-01-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U CROSS JOIN TRANSACTIONS AS T WHERE U.ACCOUNT = T.ACCOUNT GROUP BY U.ACCOUNT, T.ACCOUNT HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
('18', 10000)
*/