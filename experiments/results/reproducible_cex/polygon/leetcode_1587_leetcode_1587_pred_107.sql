-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (23, '14');
INSERT INTO "Users" ("account", "name") VALUES (12, '13');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, NULL, 10001, NULL);
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (15, 23, 10001, '1000-01-25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('14', 10001)
*/

-- Prediction Query
SELECT NAME, BALANCE FROM (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS T LEFT JOIN USERS ON T.ACCOUNT = USERS.ACCOUNT WHERE T.BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
('14', 10001)
*/