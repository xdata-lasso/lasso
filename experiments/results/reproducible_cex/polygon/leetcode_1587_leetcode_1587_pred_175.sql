-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (14, '11');
INSERT INTO "Users" ("account", "name") VALUES (9, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (13, 14, 10722, '1000-01-20');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (12, 14, -722, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS INNER JOIN USERS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY NAME HAVING BALANCE >= 10000;

/*
Prediction Result:
('11', 10000)
*/