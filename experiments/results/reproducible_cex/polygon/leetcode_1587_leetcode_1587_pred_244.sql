-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (12, NULL);
INSERT INTO "Users" ("account", "name") VALUES (11, '13');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, 12, 10000, '1000-01-22');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (15, 11, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('13', 10001)
*/

-- Prediction Query
SELECT B.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS AS A JOIN USERS AS B ON A.ACCOUNT = B.ACCOUNT GROUP BY B.NAME HAVING SUM(AMOUNT) >= 10000;

/*
Prediction Result:
(None, 10000)
('13', 10001)
*/