-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (22, '14');
INSERT INTO "Users" ("account", "name") VALUES (12, '13');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, 22, 10001, '1000-01-24');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (15, NULL, -9349, '1000-01-25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('14', 10001)
*/

-- Prediction Query
SELECT DISTINCT NAME, TEMP.BALANCE FROM USERS JOIN (SELECT ACCOUNT, SUM(AMOUNT) OVER (PARTITION BY ACCOUNT) AS BALANCE FROM TRANSACTIONS) AS TEMP ON USERS.ACCOUNT = TEMP.ACCOUNT WHERE TEMP.BALANCE > 10000;

/*
Prediction Result:
('14', 10001)
*/