-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("account", "name") VALUES (2, 'Allison Hill');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1001, 2, 10001, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Allison Hill', 10001)
*/

-- Prediction Query
SELECT SUM(T.AMOUNT) AS BALANCE, U.NAME FROM TRANSACTIONS AS T CROSS JOIN USERS AS U WHERE T.ACCOUNT = U.ACCOUNT GROUP BY T.ACCOUNT HAVING SUM(T.AMOUNT) > 10000;

/*
Prediction Result:
(10001, 'Allison Hill')
*/