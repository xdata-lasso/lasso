-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (18, NULL);
INSERT INTO "Users" ("account", "name") VALUES (22, '20');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (13, 18, 10000, '1000-01-20');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (21, 22, 10001, '1000-01-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('20', 10001)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U LEFT JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY NAME HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
(None, 10000)
('20', 10001)
*/