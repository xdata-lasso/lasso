-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (16, '13');
INSERT INTO "Users" ("account", "name") VALUES (17, '12');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (15, 16, 0, '1000-01-23');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (14, 17, 10000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME, BALANCE FROM (SELECT USERS.ACCOUNT, NAME, SUM(AMOUNT) AS BALANCE FROM USERS LEFT JOIN TRANSACTIONS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY USERS.ACCOUNT) AS NEW_TABLE WHERE BALANCE >= 10000;

/*
Prediction Result:
('12', 10000)
*/